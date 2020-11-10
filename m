Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4E52AD32B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgKJKHX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:07:23 -0500
Received: from mail-eopbgr750072.outbound.protection.outlook.com ([40.107.75.72]:55269
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727654AbgKJKHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:07:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hkg9UywHk8QhFEb/Ol2JYRSEBHMqOYZ1It3pkZJDUGYd32+7nlu9Lm+xzPXmUH1X/7FBBqiPOkeNuZ3kLJXJnQkXBhqas2vT/yWMx/CLdpt6HztS61/ByV7mwMrVhCrsIavZfOKC6AAQJDitFtgcs+s/99ZRWsRTLVnCuAZJ/vrcXFUuXnbFLPhuPxZfjWINUrIykGryXqkTqaT8zYJjeVT2de0pvsGildLquMRWJ6YaPQamjFpJju91x4kdPA4BAvoZHdI5gv8UJ7Otvv4BxW/fvHfeMsLZ5UM1jZfbhyPhPAz7S/5WKsrA46Oh/HP2SOUi6O543wTZox4qaCCW6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIra3QkiK1QGLVsW9cgbxhmTRhLH3GfDUTI3/e2J51k=;
 b=b3gQ8V5b2Jl8WbwkTKeCe28GilYhNB/3zPO76hZVlaDRBCK0IRLmIkt3CglyhDxrGbQt3UTO9YAtv44YKhJwMrnAp8OI5oc5XwYlU3baF62DBMnFWFkGVs8ae6yN206cxjf1U1uA/C5Ojse6Ykw2udySg8Eu6U+8pOOS5Qp+Gp/VQujp0mgIbpy/LRdNeEBnN7OuMgTHgdoZzTcAd13j1JIuavetaKuTgM+LwnFFysIKlIeUhcxPPsYHn8FnqgwKXVrvbWc5W+8sugjiXDwCb3H5FLb/8cNhinvLN/CJaqeU5lOCboLZ5xnkduP6tU0z7KXYXSMEkiZxCjp6UYr6pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=huawei.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IIra3QkiK1QGLVsW9cgbxhmTRhLH3GfDUTI3/e2J51k=;
 b=rxnmLxFNpfaCVYAndyTEIZS9MmaEkRDlO6l+cc51C5b5LVGDwQ4oYUV47iT0x14mHtllreMseaiS3XA4ocX0XDOSXdD2I8obiP7mDRF12MpSALo1LOUsXOgl9YfFmX4Pd5rwSf7G+3nMP/rWKSRvrHhWzE3ADD4l7Ff/K71OauA=
Received: from MN2PR22CA0024.namprd22.prod.outlook.com (2603:10b6:208:238::29)
 by CY4PR0201MB3396.namprd02.prod.outlook.com (2603:10b6:910:8e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Tue, 10 Nov
 2020 10:07:17 +0000
Received: from BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:238:cafe::d) by MN2PR22CA0024.outlook.office365.com
 (2603:10b6:208:238::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Tue, 10 Nov 2020 10:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT003.mail.protection.outlook.com (10.152.76.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.17 via Frontend Transport; Tue, 10 Nov 2020 10:07:17 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 10 Nov 2020 02:07:15 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 10 Nov 2020 02:07:15 -0800
Envelope-to: michal.simek@xilinx.com,
 zhangxiaoxu5@huawei.com,
 yi.zhang@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 tglx@linutronix.de,
 daniel.lezcano@linaro.org,
 yukuai3@huawei.com
Received: from [172.30.17.110] (port=57096)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kcQYV-0004B2-5f; Tue, 10 Nov 2020 02:07:15 -0800
Subject: Re: [PATCH] "clocksource/drivers/cadence_ttc: fix memory leak in
 ttc_setup_clockevent()
To:     Michal Simek <michal.simek@xilinx.com>,
        Yu Kuai <yukuai3@huawei.com>, <daniel.lezcano@linaro.org>,
        <tglx@linutronix.de>, <soren.brinkmann@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
References: <20201110011508.2482821-1-yukuai3@huawei.com>
 <1ff2a871-849e-cbac-b731-8104da213637@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <b3170c38-086a-5d6d-80dd-5424c53ed336@xilinx.com>
Date:   Tue, 10 Nov 2020 11:07:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <1ff2a871-849e-cbac-b731-8104da213637@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05804618-975b-4087-d65f-08d885606774
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3396:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB33967688988FBC99618D3D91C6E90@CY4PR0201MB3396.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sj0HdzUBJWbLq76g66qgbr0+bdgjVFp2LFez0HKIvQl7oiONoMZvQf/cJ2TreIwGjEMEdslYgxcxhjkBviN+99eszOLO6aXUy5kd1DyI2Ja+6DEIYLoUQMsjK740xntp0J+QluGBskn/V94tMTeIOgEwmenJp8yRdU+JBrqhHMk3YqS9JeMaW0Jt1ymFdSVbvxo9kOsR0ussAkp9FjFTcfLdLpp6G51zw99XrKMfrMcWbww/ieSCLG2F721cbGrKXzTkJ2IaH3/eaUIwnl5MkfQDeSGbWbp/fZElHOfsLksaIeSxG4tVcx6Rj71y09CXwtKEPThxSprLbyxNU8WNKDPP5mAq5qg6mtyT0sF3k460DjYAWaVxQDYvC6ZZUf0zSJl1nvlekyTUU+k65XVCT0kb16dQ/ZPGTZ+cRqMNBU8bBQhK31kyur9Q8q/zTbEb
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(83380400001)(8676002)(70586007)(2616005)(336012)(8936002)(2906002)(426003)(82310400003)(36756003)(4326008)(6666004)(7636003)(82740400003)(44832011)(36906005)(54906003)(6636002)(356005)(110136005)(26005)(478600001)(31686004)(47076004)(186003)(9786002)(5660300002)(31696002)(316002)(70206006)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 10:07:17.0577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05804618-975b-4087-d65f-08d885606774
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3396
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10. 11. 20 11:04, Michal Simek wrote:
> 
> 
> On 10. 11. 20 2:15, Yu Kuai wrote:
>> If clk_notifier_register() failed, ttc_setup_clockevent() will return
>> without freeing 'ttcce', which will leak memory.
>>
>> Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>  drivers/clocksource/timer-cadence-ttc.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
>> index 80e960602030..32b9560ce408 100644
>> --- a/drivers/clocksource/timer-cadence-ttc.c
>> +++ b/drivers/clocksource/timer-cadence-ttc.c
>> @@ -426,6 +426,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
>>  				    &ttcce->ttc.clk_rate_change_nb);
>>  	if (err) {
>>  		pr_warn("Unable to register clock notifier.\n");
>> +		kfree(ttcce);
>>  		return err;
>>  	}
>>  
>>
> 
> Reviewed-by: Michal Simek <michal.simek@xilinx.com>

One thing I have noticed. Please fix your subject. Remove " from it.

Thanks,
Michal

