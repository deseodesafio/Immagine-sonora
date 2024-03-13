import java.io.FilenameFilter;
import java.util.Map;
import java.util.Calendar;
import java.time.Instant;
import processing.pdf.*;
String[] filenames;
String fullPath;
PFont myFont;

int personID =1;
String listener = " ";
float sketchHeight ;
float sketchWidth;

int n_days = 364;
int yearToDraw = 2022;
int dayTimeCount = 4;
int currentTimeUnit = 1;
// 1,2 = weeks, 3,4 = months, 5,6 = quarters, 7,8 = seasons, 9,0 = years

int saveCount = 2022;
boolean recording = false;

int n_weeks;
int n_quarters;
int n_months = ceil((float)n_days-4 / 30);
int monthIndex = (n_months - 1) % 12;
int n_seasons;

int legendeWidth;
int legendeHeight;
float legH; 
int legW;
String[] monthNames = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
String[] dayNames = {"Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri" };
int fontSize;

float offset;
int bttnW;
int yPosBttn;

// CMYK Colors Arrays
int[] cmyk1 = { #6f2c91, #fff9ae, #d6e031, #a578b5 }; 
int[] cmyk2 = { #27793d, #fff9ae, #d6e031, #00b5ad }; 
int[] cmyk3 = { #2e3192, #ffe600, #fcc718, #00b8e8 }; 
int[] cmyk4 = { #6f2c91, #ffe600, #f099c1, #ee303c };
int[] cmyk5 = { #802a25, #ade0ee, #f099c1, #ee3d8b }; 
int[] cmyk6 = { #2e3192, #f099c1, #a578b5, #00b5ad }; 

// button fil color
int weekColor =  #6f2c91;
int monthColor;
int quarterColor;
int seasonColor;
int yearColor;

Map<Integer, HashMap<Integer, Float[]>> listeningPerDaytimeOfYear = new HashMap<Integer, HashMap<Integer, Float[]>>();

void setup()
{ fullScreen();
  
  fullPath = dataPath("") + "\\"+ personID +"\\";
  filenames = loadFilenames(fullPath);
  calculateListeningPerDaytimeOfYear();

  myFont = createFont("ABCHelveestiPlusVariableEdu.ttf", 20);
  textFont (myFont);
}

void draw()
{
  background (000);
  sketchHeight = height-offset;
  sketchWidth = width;
  legH = height/10;
  legW = width/9;
  fontSize = legW/7;

  offset = fontSize*1.9;
  offset  = height/13;

  int[] fillColor= cmyk1;
  weekColor = #000000;
  weekColor = monthColor = quarterColor = seasonColor = yearColor;
  
  if (personID >= 1 && personID <= 5 || personID == 21) {
    fillColor = cmyk1;
    listener = "Lückenhörer";
  } else if (personID >= 6 && personID <= 10) {
    fillColor = cmyk4 ;
    listener = "Taktloser";
  } else if (personID >= 11 && personID <= 15) {
    fillColor = cmyk3 ;
    listener = "Gewohnheitstier";
  } else if (personID >= 16 && personID <= 17) {
    fillColor = cmyk6 ;
    listener = "Saisonhörer";
  } else if (personID >= 19 && personID <= 21) {
    fillColor = cmyk5 ;
    listener = "Morgenmelodiker";
  } else if (personID >= 22 && personID <= 24 || personID == 18) {
    fillColor = cmyk2 ;
    listener = "Nachtwandler";
  }

  if (n_days <= 182) 
  { n_seasons = 1;
  } else { n_seasons = 2;}
  
  if (n_days <= 91) 
  { n_quarters = 1;
  } else if (n_days <= 182) 
  { n_quarters = 2;
  } else if (n_days <= 273)
  { n_quarters = 3;
  } else { n_quarters = 4;
  }
  
  

  if (currentTimeUnit == 1) 
  { 
    drawWeeks(fillColor, 7, yearToDraw, n_days, legW/2, offset); 
    legendeRows(legW/2, sketchHeight, #f1f1f1, 7, offset);
    weekColor =  #6f2c91;
    monthColor = quarterColor = seasonColor = yearColor = #000000;
  } else if (currentTimeUnit == 2)
  {
    drawWeeksHori (fillColor, 7, yearToDraw, n_days, offset + legH-offset); 
    legendeColumns(sketchWidth, legH, 7);
    weekColor =  #6f2c91;
    monthColor = quarterColor = seasonColor = yearColor = #000000;
  } else if (currentTimeUnit == 3)
  {
    drawMonths(fillColor, 31, yearToDraw, n_days, legH ); 
    legendeColumns( sketchWidth, legH, 12);
    monthColor = #6f2c91;
    weekColor = quarterColor = seasonColor = yearColor = #000000;
  } else if (currentTimeUnit == 4)
  {
    drawMonthsHori(fillColor, 31, yearToDraw, n_days, legW/2, offset); 
    legendeRows(legW/2, sketchHeight, #f1f1f1, 12, offset);
    monthColor = #6f2c91;
    weekColor = quarterColor = seasonColor = yearColor = #000000;
  } else if (currentTimeUnit == 5)
  {
    drawMonths(fillColor, 91, yearToDraw, n_days, legH); 
    legendeColumns( sketchWidth, legH, n_quarters);
    quarterColor = #6f2c91;
    weekColor = monthColor = seasonColor = yearColor = #000000;
  } else if (currentTimeUnit == 6)
  {
    drawMonthsHori (fillColor, 91, yearToDraw, n_days, legW, offset); 
    legendeRows(legW, sketchHeight, #f1f1f1, n_quarters, offset);
    quarterColor =  #6f2c91;
    weekColor = monthColor = seasonColor = yearColor = #000000;
  } else if (currentTimeUnit == 7)
  {
    drawMonths (fillColor, 182, yearToDraw, n_days, offset);
    legendeColumns( sketchWidth, offset+legH/4, n_seasons);
    weekColor = monthColor = quarterColor = yearColor = #000000;
  } else if (currentTimeUnit == 8)
  { drawMonthsHori (fillColor, 182, yearToDraw, n_days, legW/3*2, offset); 
    legendeRows(legW/3*2, sketchHeight, #f1f1f1, n_seasons, offset);
    yearColor = #6f2c91;
    weekColor = monthColor = quarterColor = yearColor = #000000;
    
  } else if (currentTimeUnit == 9)
  { drawWeeksHori(fillColor, 1, yearToDraw, n_days, offset); 
    legendeColumns( sketchWidth,  offset, 1);
    yearColor = #6f2c91;
    weekColor = monthColor = quarterColor = seasonColor = #000000;
    
  } else if (currentTimeUnit == 0)
  { 
    drawWeeks(fillColor, 1, yearToDraw, n_days, 0, offset); 
    legendeColumns( sketchWidth,  offset, 1);
    weekColor = monthColor = quarterColor = seasonColor =  #000000;
    yearColor = #6f2c91;
  }
 
  offsetButtons(listener);
  
  if (recording)
  {
    saveFrame ("overview_years/"+personID+"/frame_####.tiff");
  }
  
}


void mousePressed() {
   bttnW = width/10;
   
  if (isInsideButton(1, 0, 0, bttnW*2, (int)offset))
   { currentTimeUnit = 2;
     yearToDraw = 2023;
     n_days = 364;
   }
   
   
   if (isInsideButton(3, bttnW*6.3, 0, bttnW*1.2, offset))
   { currentTimeUnit = 3;
   } else if (isInsideButton(4, bttnW*7.8, 0, bttnW*1.2, offset))
   { currentTimeUnit = 5;
   } else if (isInsideButton(2, bttnW* 9.2, 0, bttnW*1.2, offset))
   { currentTimeUnit = 9;
   }
  

 if (mouseX > bttnW * 4 && mouseX < bttnW * 6 && mouseY > 0 && mouseY < offset )
  { currentTimeUnit = 2;
  }
   
}
  
  
void keyPressed()
{
  if (key == 's' || key == 'S')
  {
    save("overview_years/"+ personID +"/" + saveCount++ + ".png");
    println("Image saved as .tiff");
  }

  if (key == 'r' || key == 'R')
  {
    recording = !recording;
  }


  if (key == '1') {
    currentTimeUnit = 1;
  } else if (key == '2') {
    currentTimeUnit = 2;
  } else if (key == '3') {
    currentTimeUnit = 3;
  } else if (key == '4') {
    currentTimeUnit = 4;
  } else if (key == '5') {
    currentTimeUnit = 5;
  } else if (key == '6') {
    currentTimeUnit = 6;
  } else if (key == '7') {
    currentTimeUnit = 7;
  } else if (key == '8') {
    currentTimeUnit = 8;
  } else if (key == '9') {
    currentTimeUnit = 9;
  } else if (key == '0') {
    currentTimeUnit = 0;
  }

  if (keyCode == UP) { 
    n_days += 7;
  } else if (keyCode == DOWN) { 
    n_days -= 7;
  }

  if (keyCode == RIGHT) { 
    yearToDraw++;
  } else if (keyCode == LEFT) { 
    yearToDraw--;
  }
}



String[] loadFilenames(String path)
{
  File folder = new File(path);
  FilenameFilter filenameFilter = new FilenameFilter()
  {
    public boolean accept(File dir, String name)
    {
      return name.toLowerCase().endsWith(".json"); 
    }
  };
  return folder.list(filenameFilter);
}

boolean isInsideButton(int id, float x, float y, float w, float h)
{ return mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h;
}

void offsetButtons(String listener)
{ fill(#ffffff);
  rect(0, 0, width, offset);
  int yPosBttn = fontSize+fontSize/4;
  int bttnW = width/10;
  
  n_weeks = n_days/7;
  fill(000);
  strokeWeight(1);
  
  text(listener, 15, yPosBttn);
  text("← " + yearToDraw +" →", bttnW*2, yPosBttn);
  text("↓ " + n_days +" ↑", bttnW*3.5, yPosBttn );
  fill(weekColor);
  text(n_weeks +" Weeks ", bttnW*5, yPosBttn );
  fill(monthColor);
  text(" Months ", bttnW*6.5, yPosBttn);
  fill(quarterColor);
  text(" Quarters " , bttnW*8,yPosBttn);
  fill(yearColor);
  text ("Year",  bttnW*9.5, yPosBttn);
  
  fill(000);
  textSize(fontSize/2);
  text ("listening personality", 15, yPosBttn * 1.7);
  text ("current year", bttnW * 2, yPosBttn * 1.7);
  text ("amount of days +/- 7", bttnW * 3.5, yPosBttn*1.7);
  text ("visualized in", bttnW*5, yPosBttn * 1.7);
  textSize(fontSize*0.66);
  
  
  if (mouseX > 15 && mouseX < bttnW * 1.5 && mouseY > 0 && mouseY < offset )
  { fill( #ee303c ); 
    textSize(fontSize);
    text(listener, 15, yPosBttn);
  }
  if (mouseX > bttnW * 4 && mouseX < bttnW * 6 && mouseY > 0 && mouseY < offset )
  { fill( #ee303c ); 
    textSize(fontSize);
    text(n_weeks +" Weeks ", bttnW*5, yPosBttn);
  } else if (mouseX > bttnW*6.5 && mouseX < bttnW*8 && mouseY > 0 && mouseY < offset )
  { fill( #ee303c ); 
    textSize(fontSize);
    text(" Months ", bttnW*6.5, yPosBttn);
  } else if (mouseX > bttnW*8 && mouseX < bttnW*9.5 && mouseY > 0 && mouseY < offset )
  { fill( #ee303c ); 
    textSize(fontSize);
    text(" Quarters " , bttnW*8,yPosBttn);
  } else if (mouseX > bttnW*9.5 && mouseX < bttnW*10 && mouseY > 0 && mouseY < offset )
  { fill( #ee303c ); 
    textSize(fontSize);
    text("Year",  bttnW*9.5, yPosBttn);
  }
  
}


void legendeRows(int legendeWidth, float legendeHeight, int rectColor, int numRows, float offset)
{
  fill(rectColor);
  rect(0, offset, legendeWidth, legendeHeight );
  textSize(fontSize*0.66);
  fill(000);
  float yText = legendeHeight/numRows;
  int xText = 15;

  for (int i=0; i<numRows; i++)
  {
    int quNum = i+1;
    float yT = yText*quNum+offset-10 ;
    if (currentTimeUnit == 1)
    {
      if (yearToDraw == 2022)
      {
        text(dayNames[i], xText, yT);
      } else if (yearToDraw == 2023 || yearToDraw == 2017 || yearToDraw == 2012 )
      {
        text( dayNames[i+1], xText, yT);
      } else if (yearToDraw == 2021 || yearToDraw == 2016 )
      {
        text( dayNames[i+6], xText, yT);
      } else if (yearToDraw == 2020 || yearToDraw == 2014 )
      {
        text( dayNames[i+4], xText, yT);
      } else if (yearToDraw == 2019 || yearToDraw == 2013 )
      {
        text( dayNames[i+3], xText, yT);
      } else if (yearToDraw == 2018)
      {
        text( dayNames[i+2], xText, yT);
      } else if (yearToDraw == 2015)
      {
        text( dayNames[i+5], xText, yT);
      }
    } else if (currentTimeUnit == 4)
    {
      float yPosTMonths = yText*i+yText*2-10;
      text(monthNames[i], xText, yPosTMonths);
    } else if (currentTimeUnit == 6)
    {
      text("Quarter " + quNum, xText, yT);
    } else if (currentTimeUnit == 8)
    { text("Season " + quNum, xText, yT);
    }
  }
  textSize(fontSize);
}


void legendeColumns(float legendeWidth, float legendeHeight, int numColumns) 
{
  fill(#ffffff);
  rect(0, 0, legendeWidth, legendeHeight );
  fill(000);
  textSize(fontSize*0.66);
  float yText = legendeHeight-5;
  float xText = legendeWidth/numColumns;
  
  for (int i=0; i<numColumns; i++)
  {
    float xPosT = xText*i+5;
    int num = i+1;
    if (currentTimeUnit == 2)
    {
      if (yearToDraw == 2022)
      {
        text( dayNames[i], xPosT, yText);
      } else if (yearToDraw == 2023 || yearToDraw == 2017 || yearToDraw == 2012 )
      {
        text( dayNames[i+1], xPosT, yText);
      } else if (yearToDraw == 2021 || yearToDraw == 2016 )
      {
        text( dayNames[i+6], xPosT, yText);
      } else if (yearToDraw == 2020 || yearToDraw == 2014 )
      {
        text( dayNames[i+4], xPosT, yText);
      } else if (yearToDraw == 2019 || yearToDraw == 2013 )
      {
        text( dayNames[i+3], xPosT, yText);
      } else if (yearToDraw == 2018)
      {
        text( dayNames[i+2], xPosT, yText);
      } else if (yearToDraw == 2015)
      {
        text( dayNames[i+5], xPosT, yText);
      }
    } else if (currentTimeUnit == 3)
    {
      text(monthNames[i], xText*i+5, yText);
    } else if (currentTimeUnit == 5)
    {
      text("Quarter " + num, xPosT, yText);
    } else if (currentTimeUnit == 7)
    {
      text("Season " + num, xPosT, yText);
    } 
  }
  textSize(fontSize);
}


void calculateListeningPerDaytimeOfYear()
{ for (int i=0; i<filenames.length; i++ )
  { JSONArray json = loadJSONArray(fullPath + filenames[i]);
    for (int j=0; j<json.size(); j++)
    {
      JSONObject track = json.getJSONObject(j);
      String ts = track.getString("ts");
      int ms_played = track.getInt("ms_played");
      Float min_played = ms_played/1000/60f;

      String[] dateTime = ts.split("T");
      String[] time = dateTime[1].split(":");
      Integer hour = parseInt(time[0]); 

      String[] date = dateTime[0].split("-"); 
      Integer year =  parseInt(date[0]);
      Integer month = parseInt(date[1]);
      Integer day =   parseInt(date[2]);

      Instant instant = Instant.parse(ts);
      Calendar calendar = Calendar.getInstance(); 
      calendar.setTimeInMillis(instant.toEpochMilli());

      int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
      int dayNumber = (7 + dayOfWeek - 2) % 7; 
      Integer dayOfYear = calendar.get(Calendar.DAY_OF_YEAR) - 1;
      
      Float[] tmpMinCount;
      HashMap<Integer, Float[]> innerMap; 
      if (!listeningPerDaytimeOfYear.containsKey(year))
      {
        listeningPerDaytimeOfYear.put(year, new HashMap<>());
      }
      innerMap = listeningPerDaytimeOfYear.get(year);
      if (!innerMap.containsKey(dayOfYear))
      { Float[] tmpdayTime = new Float[dayTimeCount];
        for (int k = 0; k<dayTimeCount; k++)
        { tmpdayTime [k]= 0f;
        }

        innerMap.put(dayOfYear, tmpdayTime);
      }
      tmpMinCount = innerMap.get(dayOfYear) ;

      int dayTimeIndex =  (int) map(hour, 0, 24, 0, dayTimeCount);
      tmpMinCount[dayTimeIndex] += min_played ;
      innerMap.put(dayOfYear, tmpMinCount);
    }
  }
}


void drawMonths (int[] fillcolor, int numRows, int yearToDraw, int n_days, float legendeHeight )
{ 
  sketchHeight = height - legendeHeight;
  sketchWidth = width;
  
  double divisionResult = (double) n_days / numRows;
  int numColumns = (int) Math.ceil(divisionResult);
  float columnWidth = (float) sketchWidth/ numColumns;
  float rowHeight = (float) sketchHeight / numRows;
  for (Map.Entry<Integer, HashMap<Integer, Float[]>> entry : listeningPerDaytimeOfYear.entrySet())
  {
    int year = entry.getKey();
    if (year == yearToDraw )
    {
      HashMap<Integer, Float[]> innerMap =  entry.getValue();
      for (Map.Entry<Integer, Float[]> innerEntry : innerMap.entrySet())
      {
        int dayOfYear = innerEntry.getKey();
        Float[] min_played = innerEntry.getValue();
        float min_playedSum = 0;

        if (dayOfYear < n_days)
        { for (int i = 0; i< min_played.length; i++)
          { min_playedSum += min_played[i];
          }
          float sum_prop = 0;

          for (int i = 0; i< min_played.length; i++)
          {
            int column = dayOfYear/numRows;
            int row = dayOfYear % numRows;
            fill (fillcolor[i]);
            float proportion = min_played[i]/min_playedSum;

            float xPos = column * columnWidth;
            float yPos = row * rowHeight+ legendeHeight;
            float rWidth = proportion * columnWidth;

            rect ( xPos+sum_prop, yPos, rWidth, rowHeight);
            sum_prop += rWidth; 
          }
        }
      }
    }
  }
}

void drawMonthsHori (int[] fillcolor, int numColumns, int yearToDraw, int n_days, int legW, float offset )
{
  sketchHeight = height - offset;
  sketchWidth = width - legW;
  double divisionResult = (double) n_days / numColumns;
  int numRows = (int) Math.ceil(divisionResult);
  float columnWidth = (float) sketchWidth / numColumns;
  float rowHeight = (float) sketchHeight / numRows;

  for (Map.Entry<Integer, HashMap<Integer, Float[]>> entry : listeningPerDaytimeOfYear.entrySet())
  {
    int year = entry.getKey();
    if (year == yearToDraw )
    {
      HashMap<Integer, Float[]> innerMap =  entry.getValue();
      for (Map.Entry<Integer, Float[]> innerEntry : innerMap.entrySet())
      {
        int dayOfYear = innerEntry.getKey();
        Float[] min_played = innerEntry.getValue();
        float min_playedSum = 0;

        if (dayOfYear < n_days)
        {
          for (int i = 0; i< min_played.length; i++)
          {
            min_playedSum += min_played[i];
          }
          float sum_prop = 0;

          for (int i = 0; i< min_played.length; i++)
          {
            int column  = dayOfYear % numColumns;
            int row = dayOfYear/numColumns;
            fill (fillcolor[i]);
            float proportion = min_played[i]/min_playedSum;

            float xPos = column * columnWidth + legW;
            float yPos = row * rowHeight + offset;
            float rHeight = proportion * rowHeight;

            rect ( xPos, yPos + sum_prop, columnWidth, proportion * rowHeight);
            sum_prop += rHeight;
          }
        }
      }
    }
  }
}

void drawWeeks (int[] fillcolor, int numRows, int yearToDraw, int n_days, int legW, float offset ) 
{
  sketchHeight = height - offset;
  sketchWidth = width - legW;
  double divisionResult = (double) n_days / numRows;
  int numColumns = (int) Math.ceil(divisionResult);
  float columnWidth = (float) sketchWidth / numColumns;
  float rowHeight = (float) sketchHeight / numRows;

  for (Map.Entry<Integer, HashMap<Integer, Float[]>> entry : listeningPerDaytimeOfYear.entrySet())
  {
    int year = entry.getKey();
    if (year == yearToDraw )
    {
      HashMap<Integer, Float[]> innerMap =  entry.getValue();
      for (Map.Entry<Integer, Float[]> innerEntry : innerMap.entrySet())
      {
        int dayOfYear = innerEntry.getKey();
        Float[] min_played = innerEntry.getValue();
        float min_playedSum = 0;

        if (dayOfYear < n_days)
        { for (int i = 0; i< min_played.length; i++)
          { min_playedSum += min_played[i];
          }
          float sum_prop = 0;
          for (int i = 0; i< min_played.length; i++)
          {
            int column = dayOfYear/numRows;
            int row = dayOfYear % numRows;
            fill (fillcolor[i]);
            float proportion = min_played[i]/min_playedSum;
            
            float xPos = column * columnWidth + legW ;
            float yPos = row * rowHeight + offset;
            float rHeight = proportion * rowHeight;
            rect (xPos, yPos+sum_prop, columnWidth, rHeight);
            sum_prop +=  rHeight;
          }
        }
      }
    }
  }
}

void drawWeeksHori (int[] fillcolor, int numColumns, int yearToDraw, int n_days, float legendeHeight ) 
{ double divisionResult = (double) n_days / numColumns;
  int numRows = (int) Math.ceil(divisionResult);
  float columnWidth = (float) width / numColumns;
  float rowHeight = (float) (height - legendeHeight)/ numRows;
  for (Map.Entry<Integer, HashMap<Integer, Float[]>> entry : listeningPerDaytimeOfYear.entrySet())
  { int year = entry.getKey(); 
    if (year == yearToDraw )
    {
      HashMap<Integer, Float[]> innerMap =  entry.getValue();
      for (Map.Entry<Integer, Float[]> innerEntry : innerMap.entrySet())
      {
        int dayOfYear = innerEntry.getKey();
        Float[] min_played = innerEntry.getValue();
        float min_playedSum = 0;

        if (dayOfYear < n_days)
        { for (int i = 0; i< min_played.length; i++)
          {
            min_playedSum += min_played[i];
          }
          float sum_prop = 0;
          for (int i = 0; i< min_played.length; i++)
          { int column  = dayOfYear % numColumns;
            int row = dayOfYear/numColumns;

            float proportion = min_played[i]/min_playedSum;
            float xPos = column * columnWidth;
            float yPos = row * rowHeight +legendeHeight;
            float ellipseWidth = proportion * columnWidth;
            float rectWidth = columnWidth * proportion;
            float adjXPos = columnWidth * proportion/2;
            fill (fillcolor[i]);
            rect ( xPos +sum_prop, yPos, rectWidth, rowHeight );
            sum_prop += rectWidth;            
          }
        }
      }
    }
  }
}
