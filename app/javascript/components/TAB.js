import React from 'react';
import { Tab, Tabs, TabList, TabPanel } from 'react-tabs';
import 'react-tabs/style/react-tabs.css';
 
export const TABs = () => {
    return (
        <Tabs>
            <TabList>
                <Tab>最近の投稿</Tab>
                <Tab>人気の問題</Tab>
            </TabList>
            <TabPanel>
                <h2>最近の投稿です</h2>
            </TabPanel>
            <TabPanel>
                <h2>人気の問題です</h2>
            </TabPanel>
        </Tabs>
    )
}
  
export default TABs