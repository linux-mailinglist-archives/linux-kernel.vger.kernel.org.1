Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7D2C0064
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 08:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgKWG6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 01:58:30 -0500
Received: from mail-eopbgr770070.outbound.protection.outlook.com ([40.107.77.70]:4678
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726921AbgKWG63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 01:58:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCpYH/aNfWR0tT3lA1iZZSm/mHIce6CRU7dFzYF1DG5N3oqa2NGhUB/NggsFZ/wOpKlAReIN+Fx0M0nVNMlkmiM1P6IpJzGBGOLYotVGvQz8DXxOsCLPr5RxbdITYLatB8lB6eWopGQk6eCGv4mUYNJkym0vIjCgoyjC183Oj09Fufetn7E1EjoVtTX9IVsAZPFZPjl8iR9CkwT6MT6KsEqBZ/3zuKUIk2wZpKxmwTvrgT5f7itfiiHa0f53A2E+P8AXD9cZff9BYwZ7jL6NSzjZl1FhG/zFexo093tfKiPWQxLUsYU8QCG9FThKtjGNRH+MklwBSiPWiBuygNZPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hCa3w+86M2neeZmpBcwBpd2hDK11wPgxqQHDC4ORYI=;
 b=ScQjGuT4IGQcZseAAKpVzuefIyDh3DkoYs/6VSTg4UJZdl47vSGCdv70dU1TdQ7Uw0KDs2t5j+PvZBwC5/BIe1tnTly+f6QsTAfCszvQQIMoUr9Bij4+l3ZwrSVJh5vt13KAxMao8/oQvP/qUGBpIvH12iIaXM2NTC6pXadjLcw6CcuWXuhHyFX6ZY6UyI2eFt0EXWaKJ/Wofse9HC3G7O9/7apEq4kP1yBmG1ZOVN70aJa9Cw2p34cmEVPum61wfVmOmJTW/9cfuvh/VTdP816DfkOAXTmGZBs5jPXAEW2hvaqSYqZSSaoIBoMvA/4Hw545y/O4CRRxaIeos14mAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6hCa3w+86M2neeZmpBcwBpd2hDK11wPgxqQHDC4ORYI=;
 b=nD44+0kIEzPmcca7JCj4DbSxkLSwEZyYKgPyzRtj6O0UD2HGeeRiFt/fupn32AqwhQ9QcvS7BTCcDhmdhGbBwQaOEPjF0SLph9URvi7i1yAGyaqlkoJR/PTmpqa/QkoYTgtIYPMN53f75xwncmekxvDItq9qewUfC8TZcQto4Vo=
Received: from MN2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:208:1a0::23)
 by BL0PR02MB5604.namprd02.prod.outlook.com (2603:10b6:208:8e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Mon, 23 Nov
 2020 06:58:25 +0000
Received: from BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:1a0:cafe::9b) by MN2PR07CA0013.outlook.office365.com
 (2603:10b6:208:1a0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Mon, 23 Nov 2020 06:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT008.mail.protection.outlook.com (10.152.76.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Mon, 23 Nov 2020 06:58:25 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 22 Nov 2020 22:58:24 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 22 Nov 2020 22:58:24 -0800
Envelope-to: manish.narani@xilinx.com,
 tejas.patel@xilinx.com,
 rajan.vaja@xilinx.com,
 michal.simek@xilinx.com,
 wendy.liang@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org
Received: from [172.30.17.109] (port=38758)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kh5ns-0003GS-BH; Sun, 22 Nov 2020 22:58:24 -0800
Subject: Re: [PATCH] firmware: xlnx-zynqmp: fix compilation warning
To:     Wendy Liang <wendy.liang@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <tejas.patel@xilinx.com>, <manish.narani@xilinx.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1605738706-375-1-git-send-email-wendy.liang@xilinx.com>
 <f6719d16-9539-1046-28f4-7f9e82b8c6d1@xilinx.com>
 <20201121070940.GA27301@wendy.liang@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <67c09e3a-738a-2758-5a62-a5f15261feb9@xilinx.com>
Date:   Mon, 23 Nov 2020 07:58:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201121070940.GA27301@wendy.liang@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 467e85d9-b82e-4962-dd45-08d88f7d2ca0
X-MS-TrafficTypeDiagnostic: BL0PR02MB5604:
X-Microsoft-Antispam-PRVS: <BL0PR02MB56040D9D2EED76B8CC167721C6FC0@BL0PR02MB5604.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K7vQysjOiXCmcG+k2ty+ZK/sniMSTEtmuWeNKSTpj82o052Xa7vYeBZzghj/MBg/xPPZTOq9r/ECx6hhZtF14/oRvM42Ej1ikI8uylFUi0X0NiAl/ADpcDLe38ESEpNFzNo/mfhW6AwKaYFMKLfwYVr6XrN74gF9PBNO4yH9VxEbgiy2jtk2QJYW5GG2Z5I89fNrzBgthf7IYKhzeXC3bDxVqwdN+BZOykmWWMU8E1Ar75MxKP6fkFlyOVIO5pH5v2ASxLZKnIV4Gelsm/7gR9rp8W9bBnuJjCwEQ9V36vweo0ZiaUc4bWr3/LHCsujGE36ckm+r0oAyrxUAyCXcd8ofv6uGiBpG6KFgjUXJvRtHMH+WiDfGV2XgBOg9oxMHJRoYAeViwrLMV4bQ7fBK7xxlyl/4Hday/wlv4bNXNEeGOOMi5VzCAj5eL/f+rMAnZQDBeOGgdRim+nKUcm3jOQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(39850400004)(136003)(376002)(346002)(46966005)(70586007)(9786002)(478600001)(8936002)(70206006)(4326008)(83380400001)(110136005)(44832011)(31696002)(8676002)(186003)(54906003)(47076004)(316002)(82740400003)(2616005)(426003)(336012)(5660300002)(7636003)(82310400003)(2906002)(26005)(36756003)(31686004)(6666004)(356005)(36906005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2020 06:58:25.3929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 467e85d9-b82e-4962-dd45-08d88f7d2ca0
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5604
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21. 11. 20 8:09, Wendy Liang wrote:
> On Fri, Nov 20, 2020 at 10:14:52AM +0100, Michal Simek wrote:
>>
>>
>> On 18. 11. 20 23:31, Wendy Liang wrote:
>>> Fix compilation warning when ZYNQMP_FIRMWARE is not defined.
>>>
>>> include/linux/firmware/xlnx-zynqmp.h: In function
>>> 'zynqmp_pm_get_eemi_ops':
>>>  include/linux/firmware/xlnx-zynqmp.h:363:9: error: implicit
>>>  declaration of function 'ERR_PTR'
>>>  [-Werror=implicit-function-declaration]
>>>      363 |  return ERR_PTR(-ENODEV);
>>>
>>> include/linux/firmware/xlnx-zynqmp.h:363:18: note: each undeclared
>>> identifier is reported only once for each function it appears in
>>>    include/linux/firmware/xlnx-zynqmp.h: In function
>>> 'zynqmp_pm_get_api_version':
>>>    include/linux/firmware/xlnx-zynqmp.h:367:10: error: 'ENODEV'
>>> undeclared (first use in this function)
>>>      367 |  return -ENODEV;
>>>          |          ^~~~~~
>>
>> Are these issues caused by your AI driver?
>> If not, can you please point me to .config which reports this issue?
> It is from testbot, the ZYNQMP_FIMRWARE is not set.
> The AI engine driver c file includes the firmware/xlnx-zynqmp.h. The file
> doesn't include linux/err.h before including this xlnx-zynqmp.h file.
> However, the AI engine driver includes other header which includes
> linux/err.h.
> 
> It is good to include the linux/err.h explicitly too in the AI engine
> file. But for the firmware/xlnx-zynqmp.h it will be better to include
> linux/err.h as it is using it.
> 
>>
>>>
>>> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
>>> ---
>>>  include/linux/firmware/xlnx-zynqmp.h | 4 ++++
>>>  1 file changed, 4 insertions(+)
>>>
>>> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
>>> index 5968df8..7b6f9fc 100644
>>> --- a/include/linux/firmware/xlnx-zynqmp.h
>>> +++ b/include/linux/firmware/xlnx-zynqmp.h
>>> @@ -13,6 +13,10 @@
>>>  #ifndef __FIRMWARE_ZYNQMP_H__
>>>  #define __FIRMWARE_ZYNQMP_H__
>>>  
>>> +#if !IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)
>>
>> I don't think there is a real need to have this ifdef around.
>> You can just ignore it and keep just below line.
> [Wendy] if ZYNQMP_FIRMWARE is defined, this header doesn't need
> linux/err.h shall we only include linux/err.h when it is required?

Again I have no problem to include it but please remove that #if/#endif
and include it all the time.

Thanks,
Michal

