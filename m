Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A06232D2B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 13:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbgLHMnM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 07:43:12 -0500
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:43241
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729187AbgLHMnL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 07:43:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEydEG3MXyxVfp4DSdfGbYNZU0ViFmb7WnjxnoLc1sJuqo51sxH2l1S3tai2w/cPXk0o54E8UKewPmZfMHzWCIuOUq2tI3LHRZaiesebezfpKo7nsLXLE901sxLvEA3gPdZtz5yehgnqgv0OQbjRzWSwEYex1CHMKRSmpsTh9kzqlQgEU4g2ItsBInUV/KzjSBPXqFlR9vFh/zmjGKrgpJwB7DOtdo9wdykqCBGOTx/EJ1Ih6KBpqw/nLKDkjjryuQWLDFuzL/1Leinjz2RXE9TAHq51pg5wzvA4Oea4npDUjlcAqMi3br3igcpLWrBtfr6BySo7TVHxpDa5N6IWqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ST1iTD9FPGueL+LIJKIOXLLBrvv1chsnqQf6FqgsmQ=;
 b=J2LRW+rdWY5HJQBoXnzMYuYtwDEl7Jpm7zpUapVRLKkBO2kFA+X/aR6GI5oKB3N+gxOwf8/DSJbqKmKWdZUlAO/V5Byu7Rd1XYDDNVORADMz6tgI0T/BqbifcplHN1ja1VrppQWAQM9IIHGN5y8Fcn8pKp9b4vLkX98/9vpXmriO24HqwjrPM79TgItXPmIoc/eJ4uP6JaD7yZYP3an3C65zLsfySeBINk8UVH72xC2law7lY3YozWTbmoTVoffmGIp4unzEYIigVJK52TdHbP5lKAYmqhrEW1AjrDe6otNru6f2HnHKwXKrtuHcqYulPCM1JDUNkNfxjeOk3Ze/8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ST1iTD9FPGueL+LIJKIOXLLBrvv1chsnqQf6FqgsmQ=;
 b=TOc6+jRRawrjdrQaMGoga8D+opd09MNnlD1bv0Vd4y1ONseC4YpVRKZMRr32XdMmhK5jd+LnXiGbAf5MQpCb71e1WW44V4iLkBCwABNpQaJkeoR4u7F2cmiyEyColtYInxVCtIx8RLXRjofHwWgXxYLxHRzpHCPclv+EwktER+A=
Received: from CY4PR18CA0037.namprd18.prod.outlook.com (2603:10b6:903:9a::23)
 by CY4PR0201MB3572.namprd02.prod.outlook.com (2603:10b6:910:8c::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.21; Tue, 8 Dec
 2020 12:42:18 +0000
Received: from CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:9a:cafe::61) by CY4PR18CA0037.outlook.office365.com
 (2603:10b6:903:9a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 8 Dec 2020 12:42:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT030.mail.protection.outlook.com (10.152.75.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3632.21 via Frontend Transport; Tue, 8 Dec 2020 12:42:18 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 8 Dec 2020 04:42:18 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 8 Dec 2020 04:42:18 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-clk@vger.kernel.org,
 sboyd@kernel.org,
 mturquette@baylibre.com,
 quanyang.wang@windriver.com
Received: from [172.30.17.109] (port=43702)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kmcJt-0001dS-VW; Tue, 08 Dec 2020 04:42:18 -0800
Subject: Re: [PATCH] clk: zynqmp: enable COMMON_CLK_ZYNQMP for ARCH_ZYNQMP
 automatically
To:     <quanyang.wang@windriver.com>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <michal.simek@xilinx.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201208123508.998073-1-quanyang.wang@windriver.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <0a0d16a7-0d49-3a89-76a1-141758b138e7@xilinx.com>
Date:   Tue, 8 Dec 2020 13:42:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201208123508.998073-1-quanyang.wang@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca24bfc4-124c-44ad-5d25-08d89b76b32c
X-MS-TrafficTypeDiagnostic: CY4PR0201MB3572:
X-Microsoft-Antispam-PRVS: <CY4PR0201MB3572E6655D81BEAC9437182EC6CD0@CY4PR0201MB3572.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhZ1YE+7QKuYseBMcfvTsxY3EkkM/ERiQz+7vUoNx+R8p+1zX+ubEI5x+Ubooy3bQei5C0ptfwHY+FMg7X4iUADLMbcrxsGlCjpU4My2ohzUvm1pcxT9KuR2gsx7K6a9SbKcZ9AfY9aNhKNlkuQGNix4+5++KV3hpYAesq1j1H4H7hETF4JlZ2cBOKKCvlvw5mzrz4f8VsLm2EJSvM6f8nAzdvtP9csg4J5bKI6aV2XPB23Ns3FElhZQr4CKEbF0W6dKk8j67EJBZO7WFU6pLjV30ZMQbFaQEIFDONPPLjG1TIGiICPregOCaenbzLODRHH95Nq8FJN00zDNiT9pJ6KDPmUR2v+oPTMEKrGACNbJpEXQv6y5A7ktm92/x6Eiy5AWADDt0+HeDvYqyDZZd+fU1/gFcEEuDBqCt8ymKzkY0a4FbwM5vU4pOnbojMUfN7TbhaPzdgXJCWcQr3Y/KA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39860400002)(376002)(346002)(46966005)(356005)(4326008)(7636003)(26005)(8676002)(31696002)(8936002)(70586007)(70206006)(9786002)(31686004)(82310400003)(186003)(83380400001)(426003)(5660300002)(110136005)(36756003)(54906003)(47076004)(6666004)(316002)(478600001)(82740400003)(2616005)(44832011)(36906005)(2906002)(336012)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 12:42:18.6780
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca24bfc4-124c-44ad-5d25-08d89b76b32c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0201MB3572
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08. 12. 20 13:35, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> The Zynqmp Ultrascale clock controller generates clocks for peripherals,
> so we need to enable it when ARCH_ZYNQMP is selected.
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  drivers/clk/zynqmp/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/zynqmp/Kconfig b/drivers/clk/zynqmp/Kconfig
> index 17086059be8b..a8aa58bbb790 100644
> --- a/drivers/clk/zynqmp/Kconfig
> +++ b/drivers/clk/zynqmp/Kconfig
> @@ -4,6 +4,7 @@ config COMMON_CLK_ZYNQMP
>  	bool "Support for Xilinx ZynqMP Ultrascale+ clock controllers"
>  	depends on ARCH_ZYNQMP || COMPILE_TEST
>  	depends on ZYNQMP_FIRMWARE
> +	default ARCH_ZYNQMP

This is not right. If you look 2 lines above.

>  	help
>  	  Support for the Zynqmp Ultrascale clock controller.
>  	  It has a dependency on the PMU firmware.
> 

And we were talking about enabling this driver in defconfig. Not via
Kconfig. This fragment was designed in a way that this clock controller
doesn't need to be used. It is our default but if you want to use for
example fixed clock you also can.
This enables space for being able to use for example different firmware.

Thanks,
Michal
