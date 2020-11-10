Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42602AD317
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 11:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732059AbgKJKEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 05:04:39 -0500
Received: from mail-eopbgr760041.outbound.protection.outlook.com ([40.107.76.41]:24173
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727698AbgKJKEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 05:04:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRE3pRlfurEPh77JJLUc2A7IPa6DyTGgeyT1YmTsV8YbMlXYm1uVqAx/hGjk2rmrZhFpPtGBnMOQy5bi80VQQQHYyXvleFnEwkaHqhzpTXBV+wGhg81E9YPU3rsvwviwA7iyt6qeRv7TNBtyv6A5FW5t16DGBxcT71GWy9i/VOnXrcDqUmftk9Q0wHq/GkBiKIe9/u9x9hzVk9wweqS1g0gyy7LyH6XlgRKGFsFfIYg7+VOlo9BqIYoA1lK6h675pFVylS8Kg3qSUGhU/wEU4SSm/Of6z6NW+03b+VEsYdsUAyFSR+Wyfj03253oSNK+bj2IiT0BlLG4oRgBAdpThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edlVt8XClrNuNpQ3HYTDkZtqd4K8bz4gIsaPDNKVTJY=;
 b=T4JshIBVuRUFZtPXwXCFSyqbpL3OT+BCnin5lwtmuUi4QBDE+O5fTGv/xdf2PdWe0UgZvJudG5lIcoUo8Q8zKBYJq7gkuisGpHL1U1q7cyq4HW6XwceB5+oSCEKo0X9nuq+OUYXYy5jkrnsElpVL/TT9LUTvn4CB4wYBZ0oldYzm3dydHA6VF3ibq94sMQq8vZ5ZNEDnzB/Ap+xekcCDUlRGe2eBqTUpPs7kcs0p4aizUn9mWRZ2Au6CR0azvxdhmKB9YuDcX/xJBb5aT/IQ6SWZBaq3m+meaNi+m/99r7O4S+1EPkeVXh3C09gTmCRHlaKvfOw9jrMbY1ph79qHYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=huawei.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=edlVt8XClrNuNpQ3HYTDkZtqd4K8bz4gIsaPDNKVTJY=;
 b=ZY2wqVwpNUQwnLe1tO8ExW9hsn1n97VKbHUZpN3om8toCAKvkhYMtccxLTZHQgvwSDN84Jri4LsJW08MFOR666IgHRD3s5GVdnaHSVWm1o1uf0sNkaWRDWeXcrTLRrvkHV0TlpkBME20gxjhQcKaZG9kAXqdHTA7md2CK6gQ/nY=
Received: from BL1PR13CA0124.namprd13.prod.outlook.com (2603:10b6:208:2bb::9)
 by BL0PR02MB4801.namprd02.prod.outlook.com (2603:10b6:208:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Tue, 10 Nov
 2020 10:04:27 +0000
Received: from BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bb:cafe::bf) by BL1PR13CA0124.outlook.office365.com
 (2603:10b6:208:2bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.13 via Frontend
 Transport; Tue, 10 Nov 2020 10:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT027.mail.protection.outlook.com (10.152.77.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.17 via Frontend Transport; Tue, 10 Nov 2020 10:04:27 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 10 Nov 2020 02:04:26 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 10 Nov 2020 02:04:26 -0800
Envelope-to: michal.simek@xilinx.com,
 zhangxiaoxu5@huawei.com,
 yi.zhang@huawei.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 tglx@linutronix.de,
 daniel.lezcano@linaro.org,
 yukuai3@huawei.com
Received: from [172.30.17.110] (port=56846)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kcQVl-0003mh-Qf; Tue, 10 Nov 2020 02:04:26 -0800
Subject: Re: [PATCH] "clocksource/drivers/cadence_ttc: fix memory leak in
 ttc_setup_clockevent()
To:     Yu Kuai <yukuai3@huawei.com>, <michal.simek@xilinx.com>,
        <daniel.lezcano@linaro.org>, <tglx@linutronix.de>,
        <soren.brinkmann@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yi.zhang@huawei.com>,
        <zhangxiaoxu5@huawei.com>
References: <20201110011508.2482821-1-yukuai3@huawei.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <1ff2a871-849e-cbac-b731-8104da213637@xilinx.com>
Date:   Tue, 10 Nov 2020 11:04:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
MIME-Version: 1.0
In-Reply-To: <20201110011508.2482821-1-yukuai3@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 76fc4090-2894-46ac-a9f8-08d88560025b
X-MS-TrafficTypeDiagnostic: BL0PR02MB4801:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4801D67E81D345388EB73DB2C6E90@BL0PR02MB4801.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6/AyPagYrFgiwXeY62ofMsf7qlNinU4p8DFTMNgw7gasGv7l8w4OOa5bKb+SCRV9cUD/RAqCQ7pSZmNHORe3Us1G22UHZ+y+tGzODKJt8xpal3UWM1Uj9vCISXkD5MeBsfUpaNq5F5u54VcP1c80yjieSyAolFCHB5KLXpKTHkqOodjKeZaVySzmiNlNceL7znhq0zj3IL+IKeM4WlRfkAGqje1ZLWGmcCFPU4ZFkopEnUWcYekkWuF9V+WijGDJg6kIQu1oSln8tEUt4zP1ic2hXPJ8NChd6oDIqwJptLVisQR6aDqI44/jlcUflAGKXPclvn1IQEV3z0MHHmmbqZtm9xvNfl/xlQ9Z/qkwiKRpIT3dXNb5uqeTaK+6d7X9aLeiVW/vYFhxl5kpvPW7U8PsP84XGnUujD5fouZKoar/2De8CbJ6ok7bV4dxenic
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(46966005)(36906005)(70206006)(2906002)(8676002)(36756003)(70586007)(6666004)(316002)(2616005)(82310400003)(4326008)(83380400001)(31696002)(336012)(426003)(8936002)(26005)(6636002)(110136005)(54906003)(82740400003)(9786002)(44832011)(7636003)(478600001)(5660300002)(4744005)(47076004)(356005)(186003)(31686004)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2020 10:04:27.4432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fc4090-2894-46ac-a9f8-08d88560025b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4801
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10. 11. 20 2:15, Yu Kuai wrote:
> If clk_notifier_register() failed, ttc_setup_clockevent() will return
> without freeing 'ttcce', which will leak memory.
> 
> Fixes: 70504f311d4b ("clocksource/drivers/cadence_ttc: Convert init function to return error")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/clocksource/timer-cadence-ttc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clocksource/timer-cadence-ttc.c b/drivers/clocksource/timer-cadence-ttc.c
> index 80e960602030..32b9560ce408 100644
> --- a/drivers/clocksource/timer-cadence-ttc.c
> +++ b/drivers/clocksource/timer-cadence-ttc.c
> @@ -426,6 +426,7 @@ static int __init ttc_setup_clockevent(struct clk *clk,
>  				    &ttcce->ttc.clk_rate_change_nb);
>  	if (err) {
>  		pr_warn("Unable to register clock notifier.\n");
> +		kfree(ttcce);
>  		return err;
>  	}
>  
> 

Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
