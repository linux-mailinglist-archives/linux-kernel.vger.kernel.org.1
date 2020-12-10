Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332BE2D5D37
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 15:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387918AbgLJOLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 09:11:01 -0500
Received: from mail-mw2nam10on2054.outbound.protection.outlook.com ([40.107.94.54]:3041
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387919AbgLJOK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 09:10:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH7GZ3O0dqqA8x2Be7zoV41+0o2kn1Blvrj/XHkld86+BCnyfPlYUd4CswbTi9e6kVcwK51w5eWV7EV6W8pJuBmZkNLPASD3YLx8nYi/7y+nufR/STRSwjl+/MJFyvW1xv55T2z6/ZIIgmQCzoxFQpfw3EwFZf+OXBjItjPAJiXN8VPIZaMufIa9Ix8040OR67Qc/Y7UPlxsvw/xzShiZOvyTbO1JTV35IPXSG0SKFjCV6Ilf4Uqq5it+F/c337MGKdi57FOOevlUqJMtOceC4RopkmhjsoM8QJ51q+e+jQDFM31aOVVEqR3qteYgPckEqZls6utFUclnE+QxMiMdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJLTqh2DaguogHRGlM1j8Gu9J6d3rseeOHYVDLwGxCs=;
 b=VMHBxF7okfZVc/VXyVZfwdhXieV2WFW99XQQqrEsTgOFigG1O+mqUGGv4RLnSKTToPswsCyUbKAR1iaRCi7ieDzLfWX9uJjUDtYR6NeaUJwtAf1Dsa68VHFaRr9N58seqD2aZQ+eWILmwYuIpKmDSDdusQqfm+qJJskNt/130TasYudRXUwgE5hGtTF64I1hMU2e1MjTqq3bKkTJbtsHzV5V+r5XSmhqACSxf6cjRq5Mt+R37ux7HdwB79OUvr+2SPElfNTD695vqJTs2wtpsKm/30d12VC9uI5xJu1la2CJI/KbqyDAKIjB2OoEK4gYeOX37EoUctgpYE8WAr4N0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJLTqh2DaguogHRGlM1j8Gu9J6d3rseeOHYVDLwGxCs=;
 b=nH4lBs24fgNPF0fUw/O7GnkQI+Z+5KvPwXJ4fROuZR/w5aSaea3PLCJjJ23eyBI4GJKGaUJG6J8kG/WAQY6edfbVCSapRz8AP/+mf/3/JgmFzpMKMUDgme2M/xXnTXW/wp72YCbglXGYeMb41J5abvaOPBT7rPNWDJY/yXM+VfY=
Received: from CY4PR13CA0017.namprd13.prod.outlook.com (2603:10b6:903:32::27)
 by BYAPR02MB5255.namprd02.prod.outlook.com (2603:10b6:a03:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.23; Thu, 10 Dec
 2020 14:09:35 +0000
Received: from CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:32:cafe::86) by CY4PR13CA0017.outlook.office365.com
 (2603:10b6:903:32::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend
 Transport; Thu, 10 Dec 2020 14:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT009.mail.protection.outlook.com (10.152.75.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3654.12 via Frontend Transport; Thu, 10 Dec 2020 14:09:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Thu, 10 Dec 2020 06:09:34 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Thu, 10 Dec 2020 06:09:34 -0800
Envelope-to: michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 will@kernel.org,
 catalin.marinas@arm.com,
 quanyang.wang@windriver.com
Received: from [172.30.17.109] (port=44396)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1knMdR-0005A4-OW; Thu, 10 Dec 2020 06:09:34 -0800
Subject: Re: [PATCH] arm64: defconfig: enable clock driver for ZynqMP
 platforms
To:     <quanyang.wang@windriver.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201209021416.1017790-1-quanyang.wang@windriver.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <177b4056-af6d-fc1e-1d09-d9190d6228cf@xilinx.com>
Date:   Thu, 10 Dec 2020 15:09:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201209021416.1017790-1-quanyang.wang@windriver.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccc31b20-6a11-4a47-ddf4-08d89d15390a
X-MS-TrafficTypeDiagnostic: BYAPR02MB5255:
X-Microsoft-Antispam-PRVS: <BYAPR02MB525536D4C904297C990DD55EC6CB0@BYAPR02MB5255.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8Mo+8f2+36dZc4KgFBZGAYXw0mOJowCR3MJmes3N/CQad+ERqM8ypDC+x2YB2bW2IZ15kvu+8q5dwMXSgKBi9Khi/JNVM4XCRZRZ61l3n/8KFEuy+m+oA6PTGJhSIfHvfH2cULnu5IljBaKVHqitMC9dXBwml21TpMr4MXC42BYQRmdkxcyNKKUfjK07b3ofIJZxCt2Son0KBv99veamIgUVJKyjwMSJycPQKtNZYPjrIWmkCaBuR6zD6CH3+b0IDy7I3Geb977r/n9IqIQNcvCEgWeY6OUVR1k62bb6wi4ErsmOD/kvsrN5BVwN2EZwPIlnp15ZFbhqGz4HtbUXGZG2FktGTw897VF7+yx+w3/tYmY/3Eiam0WKW5KI9C2ooqoumzwsEtsNhHUTKu0/ioI0bqt/xrwAqncQdseqBexXlPRyEyTkPsxIM4jOPrI1xE9aXuJHXGBzuhkkuZ0Fg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(46966005)(4326008)(6666004)(7636003)(5660300002)(8676002)(8936002)(36756003)(82310400003)(356005)(44832011)(110136005)(186003)(36906005)(83380400001)(26005)(2616005)(47076004)(2906002)(70206006)(31696002)(426003)(31686004)(508600001)(9786002)(70586007)(54906003)(336012)(4744005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2020 14:09:34.9163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccc31b20-6a11-4a47-ddf4-08d89d15390a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT009.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5255
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09. 12. 20 3:14, quanyang.wang@windriver.com wrote:
> From: Quanyang Wang <quanyang.wang@windriver.com>
> 
> The Zynqmp Ultrascale clock controller generates clocks for peripherals
> by default. So enable this clock driver for ZynqMP platforms.
> 
> Signed-off-by: Quanyang Wang <quanyang.wang@windriver.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5cfe3cf6f2ac..95b5a963917e 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -872,6 +872,7 @@ CONFIG_COMMON_CLK_FSL_SAI=y
>  CONFIG_COMMON_CLK_S2MPS11=y
>  CONFIG_COMMON_CLK_PWM=y
>  CONFIG_COMMON_CLK_VC5=y
> +CONFIG_COMMON_CLK_ZYNQMP=y
>  CONFIG_COMMON_CLK_BD718XX=m
>  CONFIG_CLK_RASPBERRYPI=m
>  CONFIG_CLK_IMX8MM=y
> 

Position based on savedefconfig should be different but there are a lot
of issues like this that's why
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
