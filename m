Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A282218A47
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 16:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgGHOiP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Jul 2020 10:38:15 -0400
Received: from mail-oln040092004045.outbound.protection.outlook.com ([40.92.4.45]:2631
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729809AbgGHOiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:38:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjL7eAy5rtTX1hbZ6aVKavIccRN4e0fdwv2OB4n4cbBI82G1rNQhqWUJ8jRCWx7PHTlAPJGrdp4HhgPouQx5Z7VwsizqzLatlLq37cTj3Ia4a+ELCzHnqP/Wr6X+Idt+7ph80OFN9d6jvAwvP3rgL9cHZiTl9ThucknLRb4dkc1HGnyQzaOnNz7dSw7VvHcQ7PnVN7cNDCt8Jle9wm13mmfWYHCQbr5T0sHWfe7jKdxID6WLk5gDki1hHhCdTsAMJP3RBNwAyPFPm6Y5TiYIflXqTheIcRxCha7KNDeEgYQUqrM+iomZP3gAOpQRcooCq6Mj004khxF6wFpOY26CUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaHRm3SQu7r6IiTX5pbcpU1Ab7NYTlK24+BBMC6M8ps=;
 b=ap2v5rqbcoyoBYsfvYT+C+IWvJMxhUItVkmg73PTv79DRyPBTk2c0hBAW3juTemb6aJY1JZYljuvp623GugVvcjUG+3q3RRPmA+td5BfJbivdQdTmRNnwFpi3BDI8dYuXrfjx5P26Z4zuykEi/GmjR6VZKKGY3NaqzPLFVaL3L2yaj9o7+f6y6hL/JQYYZJ4TaoaL33pBWvzVCvCWc/ejw4/+ixC37uYx/807VlCfLslnfvkndM9GdJ2bTV9070mCco+lOhKDCBSLHSyqR8YyV5nn0q86XPOMoXOJBXt7bWdKoPbs2sAY6dhc4GyNehzgKN45PPelVnMb2qExulW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
 (10.152.76.54) by BL2NAM02HT062.eop-nam02.prod.protection.outlook.com
 (10.152.77.39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21; Wed, 8 Jul
 2020 14:38:11 +0000
Received: from DM5PR1001MB2172.namprd10.prod.outlook.com
 (2a01:111:e400:7e46::45) by BL2NAM02FT029.mail.protection.outlook.com
 (2a01:111:e400:7e46::356) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Wed, 8 Jul 2020 14:38:11 +0000
Received: from DM5PR1001MB2172.namprd10.prod.outlook.com
 ([fe80::5079:8544:1e43:7574]) by DM5PR1001MB2172.namprd10.prod.outlook.com
 ([fe80::5079:8544:1e43:7574%7]) with mapi id 15.20.3174.022; Wed, 8 Jul 2020
 14:38:11 +0000
From:   Anne Johnson <Leemarsden123@hotmail.co.uk>
Subject: 
Thread-Index: AQHWVTVnqludwHGDckCKsPU0Hhp99w==
Date:   Wed, 8 Jul 2020 14:38:11 +0000
Message-ID: <DM5PR1001MB217205D0404F8A6704E4B25BAC670@DM5PR1001MB2172.namprd10.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:D8F347C131778BEAAFF0863093C32FA864EF3BC4939D1AE0157248799DAFB473;UpperCasedChecksum:9BF17F8539E27C3591C9990A344302D0DA47D7598BF2DF4798D0624C51CECB2F;SizeAsReceived:7712;Count:39
x-tmn:  [crLkPEflzvZmnHkwpPs4BQvB1yaa930e]
x-ms-publictraffictype: Email
x-incomingheadercount: 39
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 688e7300-ff7a-4b53-b8d7-08d8234c8a58
x-ms-exchange-slblob-mailprops: 7B6i23oPIUiumUjOcoBWQ1+b+bn3OP0sIti6tbdP9eV24kgD6gOC/V3E5gAsCCvJyp8zxZicrCZVctuk8HDq7Wdzfojes9Y0FIhFmhN2eVtqaVstTdBgx+j/v7mxFVqGILMVnMil389DqoGwWOFSK1U64ZmIA+uZD/suEvmDpHwuUQFjaAOHTKMX3V6ylECTaAII1wgiylwJT8qMIe1GWMwym+qZTLjw6H/GM6O3d4XdMcqJ0S0DnFrEI4azCfp/GsWOBLR8YMFmr37y+lbpEU8rzCDzkDXizwAs/EFZI2UXKrJ7EhW1A4OS34NcX8dI3voG66hthQPJHBX3Nn42bXjB6Tbql6xtjfffkHCqfTnV0q7oYtXBlT8CfFEqHVHo7AEW3gmqqSqFoBXlA5baAONQ4T/HjMuUqKLVEcCTFBzAOZD+OV2okPWac7LWjoUae8A0pVu9+a0JobxMVazV+ZWOlCatlX9bfLhs8Hhg3qyAu1uo7X5F+awPIJye9O3VZXvxflGmkYC6yt3B5tz7xXm1RzxTwx+WsW258v9Wc5QsueuB9RUrqSQFFpENBn0kEpkhifY4GuCgA6NQ0jOXCNkfgLCkrZI82MOsPR7GzmT7C8Fx/hfAAA==
x-ms-traffictypediagnostic: BL2NAM02HT062:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HLu1VNhTMRImevqOuTVTCB9cTay82y9PsdhvlXIIYOvFWACUHG+Hyzu1QM5Zm6UbooN/ya6PJlySb59GdWKiO0tv6bsulTavsvhoylbBGwWPAP58VZESjkxufHiWO8yXMXx0krqpcBa8AaXtSZN66neznz/uQDbG05iW+KEPUzK8+zCJKO24nS5r+IoGYv9UJOK6qNAGwg42dgHfmF5f0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:0;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1001MB2172.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:;DIR:OUT;SFP:1901;
x-ms-exchange-antispam-messagedata: 88dqbQu+6KbdpoJMVbPyPFXDr8Fh92KVFEwSUBuzCWYuVcbXairiKQ4sz+nwzJW64geldM1AdaM/ZuaTE5rZSuho0I0QkXSfI0PWuhw75GNg2ggYNX5eoozTMclgwdlIsW3PvV3pco2YvOpG9GG1jg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 688e7300-ff7a-4b53-b8d7-08d8234c8a58
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 14:38:11.8062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2NAM02HT062
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Dear Friend,

I'm sorry but happy to inform you about my success in getting those funds transferred under the cooperation of a new partner from Paraguay though I tried my best to involve you in the business but God decided the whole situations. Presently I’m in Paraguay for investment projects with my own share of the total sum. Meanwhile, I didn't forget your past efforts and attempts to assist me in transferring those funds despite with bank of Africa.

Now contact my secretary in Burkina Faso his name is Mr.Mike Moore on his e-mail address below (Mr.MikeMoore@post.com)  Ask him to send you the total sum of $500.000,00 which I kept for your compensation for all the past efforts and attempts to assist me in this matter. 

I appreciated your efforts at that time very much. So feel free and get in touched with my secretary Mr.Mike Moore and instruct him where to send the amount to you. Please do let me know immediately you receive it so that we can share the joy after all the sufferness at that time.

In the moment, I’m very busy here because of the investment projects which I and the new partner are having at hand, finally, remember that I had forwarded instruction to the secretary on your behalf to receive that money, so feel free to get in touch with him.He will send the amount to you without any delay.

 Regards,

Anne JOHNSON
