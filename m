Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E512CA212
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730875AbgLAME4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 07:04:56 -0500
Received: from mail-bn8nam12on2053.outbound.protection.outlook.com ([40.107.237.53]:51552
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730865AbgLAME4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 07:04:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hu4H5FjFHnBKIzm+7SVbxGvcMNFtt2KWw9q1MH8jcjCeFyrH9YIn1b8wkbnOoWtG0vTvCg87wJDWyWFlps6/gAuOpll+NcCIy9jg81u3NzMCGF220vjoeWO1ioN60+XowLqCXXHwp135rKf3h/IC/Yfhx1aMdXRbQ1ZF++Gvy9a9CPPD+5uP6Q6oosJdjfxegOfvV8HhEfAZaLjnT0h/yviyGe2K0in2Y7RLokDT9ABOQUDNq1FRoHS6HZ82keUnmxQ7VfH5sDDAClUtgYLDqsvXHQN5Q+L3NojeGsTuXMP+IcFO4s32Yf40KnMkWjEBX5LuVzUtBY2JFNHkt2H7zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEsiiCYU1z608q7jgzEPmyUiWrjP+TuIJ8sS8M9sLH8=;
 b=aWF4u+VYpb3PwvMkBPBUsV/mSy+aPtAuRO8oypNjExtz8yr/xDaSmYQvh30ZxQ06R3Xrjlzc8DdHmJDd0Z7AxYbH3H6IwdKaYpOLylvgBTh3QfpYK3uFQvByMZzamPe/D66Ocr7+kDoUQkqYnGQyNGzLklwcl+Bwhtvp+FeYcfyczIw5JeGhmehvACwKFVoC59iqslTgILqyQx4xM4DvM8RFOKdH3hFQ7zalfbcOahJs0CUCuDFWSUu43JvKArPcldurr2fxvmzrvlJ4KIhNsXTy1GcJwyJiZhb/t5pdnLUwnuk8CyfVlM9q3AQDduYsQMWIZ5GESPnE4fXceYrS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEsiiCYU1z608q7jgzEPmyUiWrjP+TuIJ8sS8M9sLH8=;
 b=f5eEaa8hWXdKThG58uIo6EYWzg5rREMBeyDW5696M9q9LUWSFK1RZ9zzDf5P+ICcGlyZtjim2wz4A1X8gKTFCgmEk+uZBKUNBjX2rW4k31bIxkSx90hIrJW56BAmU6z6KlrAlMDnHgoEVpxO1YhGyUXOTe7k1hEIG9X5rxpQ3TM=
Received: from BL0PR01CA0011.prod.exchangelabs.com (2603:10b6:208:71::24) by
 CH2PR02MB6215.namprd02.prod.outlook.com (2603:10b6:610:c::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Tue, 1 Dec 2020 12:04:03 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:71:cafe::b4) by BL0PR01CA0011.outlook.office365.com
 (2603:10b6:208:71::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Tue, 1 Dec 2020 12:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3611.27 via Frontend Transport; Tue, 1 Dec 2020 12:04:02 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 1 Dec 2020 04:04:02 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 1 Dec 2020 04:04:02 -0800
Envelope-to: manish.narani@xilinx.com,
 tejas.patel@xilinx.com,
 rajan.vaja@xilinx.com,
 michal.simek@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 gregkh@linuxfoundation.org,
 zou_wei@huawei.com
Received: from [172.30.17.109] (port=40420)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1kk4O2-0003UG-3o; Tue, 01 Dec 2020 04:04:02 -0800
Subject: Re: [PATCH -next v2] firmware: xilinx: Mark pm_api_features_map with
 static keyword
To:     Zou Wei <zou_wei@huawei.com>, <michal.simek@xilinx.com>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <jolly.shah@xilinx.com>, <tejas.patel@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1606823513-121578-1-git-send-email-zou_wei@huawei.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <65ea30eb-2595-4af8-09c2-6d352b9be509@xilinx.com>
Date:   Tue, 1 Dec 2020 13:03:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606823513-121578-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58d3ed86-b15f-4857-3beb-08d895f131f9
X-MS-TrafficTypeDiagnostic: CH2PR02MB6215:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6215CC1A3D029906AD7C85C7C6F40@CH2PR02MB6215.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJG6eLrE94TocL5jh8cRfZEKU3JNxMhcunSIVT3naTlmRz33H9qxKO1I4eUDshGqbE4K2XrNQ9GAWTrRWED7tvgWJis+Yk4hU1qzBSrVgrbScwXhozCkWa04YaS2eIjYnnTJgxHX5vdeEo3cyPp3K0OjwK7E7IFym8CwzVAne8Ra+ulqlBY0j6+lXUvKWgSm35DNMSMtOlRqki+LeUrJt/aF2Np8Dl8YtI3vDenJ3H+m2INXdqtoVS0rUWF23SFSCzslWHii6laLJxvh/v/qot4sNZ9YVZbm0tnf+BGa3ERrn5zEQPhPekzF51k/Hag0zqF3OZ34utLLWQd9BWiLUROof4VBaxQ3wbD1Wec1HMxQReZP9GEoebHTlD3lTDUaI+tPsoxwuuncGqnY2moHaeoz0IOAK0xaYmWVvRG7R5QqxCkHHFOeoTzQepiHtYzEIVJ4LRb7J+DjXLm5puTsqQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(46966005)(31686004)(36906005)(2906002)(31696002)(2616005)(110136005)(426003)(44832011)(316002)(36756003)(26005)(8676002)(6666004)(54906003)(478600001)(336012)(9786002)(5660300002)(70206006)(6636002)(47076004)(186003)(82740400003)(83380400001)(8936002)(82310400003)(4326008)(356005)(7636003)(70586007)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2020 12:04:02.9590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d3ed86-b15f-4857-3beb-08d895f131f9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6215
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01. 12. 20 12:51, Zou Wei wrote:
> Fix the following sparse warning:
> 
> drivers/firmware/xilinx/zynqmp.c:32:1: warning: symbol 'pm_api_features_map' was not declared. Should it be static?
> 
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index d08ac82..fd95ede 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -29,7 +29,7 @@
>  #define PM_API_FEATURE_CHECK_MAX_ORDER  7
>  
>  static bool feature_check_enabled;
> -DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
> +static DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
>  
>  /**
>   * struct pm_api_feature_data - PM API Feature data
> 

The patch is good but I am missing fixed tag to get it to LTS.
When you add it please add my
Reviewed-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
