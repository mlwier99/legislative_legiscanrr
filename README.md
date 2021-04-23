# legislative_legiscanrr

UNDER CONSTRUCTION

Description: 

Home OS: Arch 

Developer: RStudio (minor alterations in Mousepad/.txt editor) 

File Structure: 
  - suggested working directory for project: ./home/[profile]/Native Environment Data/
  - suggested path for scripts: ./Scripts
  - generated path and folders: ./Documents
  - generated path and folders: ./Tribe Directories
  - generated path and folders: ./Tribe Directories/[each tribe looped through] 
  - generated path and folders: ./Tribe Directories/[each tribe looped through]/PDFs 
  
Key Packages:  
  - google, googlesearch 
  - os 
  - csv
  - fnmatch 
  - requests 
  - time 
  - random
  - errno 
  - datetime 
  - ast 
  - pdfkit 
  
Goal: Search google for links on Native American tribe policy regarding climate change. 
Included files: 
  1) DirSearchPrint.py
    - combines each tribe from Federal and State Recognized Tribes (2020; found at National Conference of State Legislators website) with one of three search terms, then retreives the first ten results for each tribe-term. 
    - if it doesn't already exist, will create  ./Tribe Directories folder. 
    - during the loop, for each tribe that has been run, the code generates two additional folders: ./Tribe Directories/[each tribe]; and ./Tribeies/[each tribe]/PDFs. 
        * NOTE 1: If these folders already exist, does not write over them. 
        * NOTE 2: If the code is re-run, it's suggested that the tribe's folder is deleted or renamed manually.
    - in each ./Tribe Directories/[each tribe], a .txt file is created ([tribe name]_links.txt). This file will print a series of links, numbered, for the three different searc Directorh terms. 
        * NOTE: These .txt files are append-only, so if the code is re-run, make sure to delete or rename the .txt for the tribe that's being re-run (or the entire Tribe Directories folder). Otherwise, you'll have more than one section for each search-term.
    - in the same loop as the list of links and the .txt file, the link will be saved. When the link is .pdf, .xlsx, .docx, etc, the same file extension will be on the saved copy of the link. If .html or unspecified, the link is printed/saved a .pdf. 
        * NOTE 1: These are saved in ./Tribe Directories/[each tribe]/PDFs. The sub-folder name is due to the fact that a majority of the saved files are in .pdf format. 
        * NOTE 2: occassionally, this area of the process takes a long time. In many instances, it's necessary to crtl+c a tribe. If crtl+c is used once, then the loop moves on to the next tribe. This is suggested. Using crtl+c more than once on the same loop iteraction causes the entire code to stop running. If this happens, find the recent tribe sub-directory and delete it to prevent multiple entries for the same search-term in the .txt file. 
  2) PDF List for Tribes.py
    - creates a ./Documents folder if it does not already exist (this folder will be in the same location as ./Tribe Directories. 
    - creates ./Documents/List of Saved Links for Each Tribe.csv  
    - in ./Documents/List of Saved Links for Each Tribe.csv, follownig variables are recorded: 
      * each tribe that has a folder in ./Tribe Directories
      * the number of total files for each of those tribes 
      * the number of saved documents/downloaded links for each of the search terms (theoretically 30, but not every link is able to be saved) 
      * the name of the directory where the saved/downloaded links are contained
     - this code WILL overwrite an existing ./Documents/List of Saved Links for Each Tribe.csv, so if you want to compare current to previous, I suggest manually renaming your existing file. 
  3) TribeList.txt
    - list of the tribes (590) that I ran through the script. The tribes should already be in python-list format.  
        
General notes: 
  - It's suggested that you run this through the terminal ('./[script location]/DirSearchPrint.py' and './[script location/PDF List for Tribes.py'). 
  - Some of the tribe names include unicode characters. Keep this in mind and make replacements when/if desired. 
  - Make sure to check the ./Tribe Directories/[each tribe] names occassionally. At one point, tribe names in the list were merged together, likely due to a missing comma between list items in the tribe name list. It should be fixed now, but it's something to keep an eye out for. 
<!--  - Rather than deleting tribe sub-folders when I rerun a tribe, I rename folders--example, ./Tribe Directories  ./Tribe Direcotires_Feb when I rerun all the tribes in March, etc. I tend to zip the old folders to save space. --> 
 
 
 Started January 2021
