Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF222BA566
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgKTJCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:02:24 -0500
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:37344
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726420AbgKTJCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:02:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOq1COHvTBm6ZmhZKZ51C58WziwfbMmWL1nkiBjfhopVa8r2FI750pQXO7ibBnq+4OpvEIu6Mne7LLl0bRatfMc1ipl+DSajoGm2hucSI9CtAFanjjGTSkHXZhQ/cAWauwUx7IyNdKTV3PcfzCGNIoxkn6mW5mWSlA8NvRGNOk8jYdOlxb5HKKOdwuo/zOnMh1HVbaxCV/DnFgEzgyHDSCE78Cu41NildKOv41cI2wz51LHEC29P5rnqkpv4IbcriJPGk+i7a4KwgLbDyH+sEb9+kfOMAnm2lI8/pr3hHgwYVOEyvai2WFx/J2w+8P+tydZ/99mIfxDfUWfzoOBoTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7W5QpT31FVVyA7i82O/NRAj2/Oih5vvV7fjLbsU/Go=;
 b=WnLvv7mAPnG9417RWERsRFL6mLT1dnvZV2AvyurytxZBWMtKiHwIyCmgCXKnPlbcMa135YHo6se72NEodXrmrHoryvtDJyYdz3e/8GVICxBNqnVHtWmXh8cJqw/xFUxn9FBKYTtubcnzn9RRXavnMheThKbxFTYnPdhYMn+9cRJdAjB/ZKSL/6le2G4eDFapv6GZqu6ppQOyqC/h+uB2QVK53gXpqQoojx0Kkv/MoG7lQGL7d+fJiM+iX9a3HiQtEERftHYOB3tL5aSRsvPRoKLN90SLgSFcnFhnUfxQx6Wi3yldNTE0K5zUyH420/qoXVfMKOOTUgrZoqCCAKTw0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/7W5QpT31FVVyA7i82O/NRAj2/Oih5vvV7fjLbsU/Go=;
 b=qFqG1+PYLQj0YB1VrSZKvNN/nWp/d2MQ0FudagI1lUTv517LJa3WvKpBcBB8Mv+0+axIwd9s6ku/vYamsChb3Hucpg9tAsTtC55DxxVq0GRIzqAmVXWxjHDnpi01kRf1QucGR7H4G+XMnfwXi4oh4d8NiManZdBAyKp+RAXoL5Y=
Received: from MN2PR10CA0003.namprd10.prod.outlook.com (2603:10b6:208:120::16)
 by MN2PR02MB6160.namprd02.prod.outlook.com (2603:10b6:208:1b5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.25; Fri, 20 Nov
 2020 09:02:19 +0000
Received: from BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:120:cafe::6e) by MN2PR10CA0003.outlook.office365.com
 (2603:10b6:208:120::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Fri, 20 Nov 2020 09:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT052.mail.protection.outlook.com (10.152.77.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Fri, 20 Nov 2020 09:02:18 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Fri, 20 Nov 2020 01:01:55 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Fri, 20 Nov 2020 01:01:55 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 ravi.patel@xilinx.com,
 rajan.vaja@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org
Received: from [172.30.17.109] (port=34388)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kg2Ik-0002Af-Qx; Fri, 20 Nov 2020 01:01:55 -0800
Subject: Re: [PATCH] firmware: xilinx: Fix SD DLL node reset issue
To:     Manish Narani <manish.narani@xilinx.com>,
        <michal.simek@xilinx.com>, <rajan.vaja@xilinx.com>,
        <gregkh@linuxfoundation.org>, <ravi.patel@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>
References: <1605534744-15649-1-git-send-email-manish.narani@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <50b20ee9-506d-be89-5bd2-50008601c864@xilinx.com>
Date:   Fri, 20 Nov 2020 10:01:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1605534744-15649-1-git-send-email-manish.narani@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd35181-4eab-4067-9390-08d88d32fc29
X-MS-TrafficTypeDiagnostic: MN2PR02MB6160:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6160550D9E429B1CA61462F1C6FF0@MN2PR02MB6160.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g6boLv7WC48gWC8JSLNGTtpRTONjv6Pl9O/THM7L//Cl2aAEJVhr7D5syRw94cKKNcn2+eFI5m+7qUJ4n6pRshh1XLmQK7RrFLiGim3hV/lH/MXGfLgbXJMvj0QBtKMqS+wHbv33pMQF8ujoTp2VbcZMBBv3780dvPn9ZrQpoDSxB2IR5+M6OnDxkvBP9QrVc5JptHT3y/TxdDunZQAK2DgMZntnn1lnXArabpvfF9waIpqX7DJtmAK4iyuaFiWe0+hgbPqh+xIBKW9WM5zRBgXiE1x3vOU0vHu80qtKxcFqHWE6rPyZbI1nSTf6l3hmtc/Jqy/+S0eeD5DHvwmYHMwObO0KAvWt8w2fDIGQPli3fewfOzxvVuhjfYe62iUmzb7HpkMYK3iTTm28qhRyYwZa06zyT5ae0ulxzEKZqBs9TN3ftXHuZhd9SRGXqKYl5G4c0Z83P0US5D+JqDR0tA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(46966005)(107886003)(44832011)(36756003)(31686004)(2906002)(4326008)(336012)(6666004)(8936002)(82310400003)(36906005)(316002)(186003)(8676002)(83380400001)(31696002)(26005)(54906003)(110136005)(70586007)(70206006)(4744005)(47076004)(82740400003)(356005)(6636002)(7636003)(9786002)(2616005)(426003)(478600001)(5660300002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2020 09:02:18.9980
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd35181-4eab-4067-9390-08d88d32fc29
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6160
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16. 11. 20 14:52, Manish Narani wrote:
> Fix the SD DLL node reset issue where incorrect node is being referenced
> instead of SD DLL node.
> 
> Fixes: 426c8d85df7a ("firmware: xilinx: Use APIs instead of IOCTLs")
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 8d1ff2454e2e..7696bd24f182 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -612,7 +612,7 @@ EXPORT_SYMBOL_GPL(zynqmp_pm_set_sd_tapdelay);
>   */
>  int zynqmp_pm_sd_dll_reset(u32 node_id, u32 type)
>  {
> -	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SET_SD_TAPDELAY,
> +	return zynqmp_pm_invoke_fn(PM_IOCTL, node_id, IOCTL_SD_DLL_RESET,
>  				   type, 0, NULL);
>  }
>  EXPORT_SYMBOL_GPL(zynqmp_pm_sd_dll_reset);
> 

Applied.
M
