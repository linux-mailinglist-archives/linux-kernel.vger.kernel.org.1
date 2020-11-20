Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A9A2BA5AB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKTJPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:15:01 -0500
Received: from mail-co1nam11on2068.outbound.protection.outlook.com ([40.107.220.68]:23777
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725797AbgKTJO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:14:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oefJi8oSaaU3dW0ODg8MhvVFppmtPkMflOCTKbtedjlhXV5MKT+w3BEU9pSrWN7wsPML0/FwON+Rq1oGicdwQnVWZSE4BrJQmmJXis9gpvnKkqu2gcBVd2u9EnkDqMaMG+P1uOl3ffbMz/z+qvHu7ncs0Zxi+XeaLM4gFCFPzUCGHEz648n5R9ocyaLD99ohQTQiur7YAWWg1wr21SR79TI/MN39gPYKsH5nxVsHPoTVd8Lo11U03Wxg4fb45om6E9Vn+sK2Xcsoj8XYJtezXwEX0DnKdC02IQGr5C1G3Mdh1sXzkuaRmLTLVa6Zl8veXvUHhHBKsFdYoy0vZn+5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UmVdSnxsKvTUYHKd91Xg0p2Yj/N/U1cQLta6jRA6lY=;
 b=TXX5U5x9RQMpUZsnjhi8EyC9r5i+drToodizP79/1OJXtToGbb862DBpdlO5MhZAVoU+EL9V1QUl6BQNLA7h+0LtrQdaYCbXbW2LwOs4JRfJ7dK39wCrXcTPMF8RlIoU7pQUSR6sIoyvDR8UDHTlEqTyTrXKk2sFSBA1TDpIygUQtwnAg/+aLtI5x+tKAF/SXePeYxWX8FeXWMjF5SO99PPW4J/sZBmvrUiAgFdCiFGXW++bIoJbzdj/GnpTZXIQ6Hdkenvb2mGxSMARt6Vsh4tV5KCNEixdpDt5JfSMAguY3BQOopgdbVvxoRZ/2mH4sksFLsKM6H1rwEWp6OuvDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UmVdSnxsKvTUYHKd91Xg0p2Yj/N/U1cQLta6jRA6lY=;
 b=ZQDeyB++YQi1gGw+KzCMI5ZSP45Jky+9u2cUPuI0RyuYb3MbKAPJue0z8QTa4LxpDiN29Fe/DXFxd9uNn+8s9sFTPmrpWa8AZcAMg4CRjKvRjVxhq8dAMsC8hYCc5pOwXmJOGV93uPNcef9RBxR/S/robRlJqf3TPKHhPGWM+x8=
Received: from DM3PR12CA0079.namprd12.prod.outlook.com (2603:10b6:0:57::23) by
 BY5PR02MB6552.namprd02.prod.outlook.com (2603:10b6:a03:1d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Fri, 20 Nov
 2020 09:14:56 +0000
Received: from CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::3a) by DM3PR12CA0079.outlook.office365.com
 (2603:10b6:0:57::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 09:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT025.mail.protection.outlook.com (10.152.75.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 09:14:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 20 Nov 2020 01:14:55 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 20 Nov 2020 01:14:54 -0800
Envelope-to: manish.narani@xilinx.com,
 tejas.patel@xilinx.com,
 rajan.vaja@xilinx.com,
 michal.simek@xilinx.com,
 wendy.liang@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org
Received: from [172.30.17.109] (port=35818)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kg2VK-0002yS-MN; Fri, 20 Nov 2020 01:14:54 -0800
Subject: Re: [PATCH] firmware: xlnx-zynqmp: fix compilation warning
To:     Wendy Liang <wendy.liang@xilinx.com>, <michal.simek@xilinx.com>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <tejas.patel@xilinx.com>, <manish.narani@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1605738706-375-1-git-send-email-wendy.liang@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <f6719d16-9539-1046-28f4-7f9e82b8c6d1@xilinx.com>
Date:   Fri, 20 Nov 2020 10:14:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1605738706-375-1-git-send-email-wendy.liang@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 018d8952-cf65-4a77-6824-08d88d34bf38
X-MS-TrafficTypeDiagnostic: BY5PR02MB6552:
X-Microsoft-Antispam-PRVS: <BY5PR02MB655256018088E1538573794EC6FF0@BY5PR02MB6552.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xs4saVrZUKomIASX1Ppq/mtZzPSORxGDfXWXwMUm2sEegD1V+0itv7no1lO6HW0qpXmB+snYEBkizKW+M7gdX0HAASuG++B117DNcmt0/aRCV1j5pDIcPPjN6TCW8Kw+6qj92w1lM1ntwmApeCNxMsRLpaPP7a82PMoR4pcmRISpIEN00mIO6iV1jpPMy4uw8eT0jelL40SD0K+LTlQCnn4A5O/uBqxWz791t0MBxQXTKCdO9oJ23fierev0qxPY5JHkRKy+eWhysOmbYQqMBFYLxao2npFmBZv/ZalbAe5duLuER96fQyADCGqnkrSY6gkcPvCHQ4TpPjKYAmmpu81NT6MR0PvzL/SnLWnns4QJ2y4uMIHjhanJHJ9cwjmItTJOubaiWSRVIXYNccI7s75zR2ebEWLFOYrrZGlmXYd7lPT6C2ONuklxYkX1qhPWx13AAH48mitDqV9Y92T5YA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(46966005)(83380400001)(5660300002)(70206006)(8936002)(36756003)(336012)(6636002)(426003)(2616005)(82310400003)(70586007)(110136005)(44832011)(186003)(26005)(54906003)(478600001)(2906002)(4326008)(31696002)(316002)(36906005)(7636003)(47076004)(82740400003)(8676002)(9786002)(356005)(31686004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 09:14:55.8246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 018d8952-cf65-4a77-6824-08d88d34bf38
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6552
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18. 11. 20 23:31, Wendy Liang wrote:
> Fix compilation warning when ZYNQMP_FIRMWARE is not defined.
> 
> include/linux/firmware/xlnx-zynqmp.h: In function
> 'zynqmp_pm_get_eemi_ops':
>  include/linux/firmware/xlnx-zynqmp.h:363:9: error: implicit
>  declaration of function 'ERR_PTR'
>  [-Werror=implicit-function-declaration]
>      363 |  return ERR_PTR(-ENODEV);
> 
> include/linux/firmware/xlnx-zynqmp.h:363:18: note: each undeclared
> identifier is reported only once for each function it appears in
>    include/linux/firmware/xlnx-zynqmp.h: In function
> 'zynqmp_pm_get_api_version':
>    include/linux/firmware/xlnx-zynqmp.h:367:10: error: 'ENODEV'
> undeclared (first use in this function)
>      367 |  return -ENODEV;
>          |          ^~~~~~

Are these issues caused by your AI driver?
If not, can you please point me to .config which reports this issue?

> 
> Signed-off-by: Wendy Liang <wendy.liang@xilinx.com>
> ---
>  include/linux/firmware/xlnx-zynqmp.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 5968df8..7b6f9fc 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -13,6 +13,10 @@
>  #ifndef __FIRMWARE_ZYNQMP_H__
>  #define __FIRMWARE_ZYNQMP_H__
>  
> +#if !IS_REACHABLE(CONFIG_ZYNQMP_FIRMWARE)

I don't think there is a real need to have this ifdef around.
You can just ignore it and keep just below line.

> +#include <linux/err.h>
> +#endif
> +
>  #define ZYNQMP_PM_VERSION_MAJOR	1
>  #define ZYNQMP_PM_VERSION_MINOR	0
>  
> 


Thanks,
Michal
