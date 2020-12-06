import React from 'react';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import 'react-tabs/style/react-tabs.css';
 
export const TABs = () => {
    return (
        <Tabs>
            <TabList>
                <Tab>Tab1</Tab>
                <Tab>Tab2</Tab>
            </TabList>
            <TabPanel>
                <h2>タブ1</h2>
            </TabPanel>
            <TabPanel>
                <h2>タブ2</h2>
            </TabPanel>
        </Tabs>
    )
}
  
export default TABs