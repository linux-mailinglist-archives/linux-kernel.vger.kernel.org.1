Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 875F62C296F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 15:25:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388900AbgKXOZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 09:25:22 -0500
Received: from mail-eopbgr750050.outbound.protection.outlook.com ([40.107.75.50]:52454
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388703AbgKXOZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 09:25:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PJ6iU2xDenxzPSuPxGFwx9B0XjvxqUtu9nI86pSnHS3tXa0QgILhEs5cLrz4SXLc5PqlupAfkC2QX1Cy93Id/8hlBMdLXhUrp+4Ue6tHDqhB60CikkRD+a8v0xQp4KSUqROvYGaNs2I3jCroyxbm6MWzxO9lBMI01jP4y9ws4SsK93UjgPGX6rTHb6AA62UxM+j22m+QVYT7Nt1hevpDzdV+ojWTtTkyKlgpsUzF35SifeQy6aZvjK1xMbFrUAMT+mjFzCyeDLG7kmq2yMgGxULNkLg+utJpXx1McGXAelOu15PhbSLADnaOq2ks6eEIIG9V/W+yhCnFlFgt/UC74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu8lZOI9jEZQ/Esk3TfWjJXUEpfcJOF2yGlOZJbMPiY=;
 b=RDki0jiYFE1NPLpAhhKFYE+pM1/Rg6N1NfBWAaa6/lX3jBi7257Qp44WyP7zFMvyD8XMKrFs8k0aAP/gpDK/uJbXu14tV8DStdyCm0Foj7KORD9I5EU20TKGLOXd1bs5IswvvQNgIQsmoczereVE+FupFBXpvzlmB4PPSIS5pKCG7W5CpAdx3T6sfKW1aMH4kAtL1SUkIkvLquSMAV0IU3eis4oVtkgFc/kZafnTNN/u20N7DhpW/ZqkQ6il8PGtS5XLCC/F7FymtkuM/vXcUQwdhtUfd2RNE3awHl4lurbjyEK67GlTMiAnqA85EyfG+fAQSg4JaYrfXAssv/Pwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lu8lZOI9jEZQ/Esk3TfWjJXUEpfcJOF2yGlOZJbMPiY=;
 b=UOhetylGOqdAikNbXgt+8lDSxh6Bv8exfeXCWOh91y6SZ6PcxQHJf57Q76+YH4OpfSQKECq0Pk2Fm8uUVk1RaXBb44JJobdvCMS9nkn3BmQO4Q3g9gH4gK7ihtLoObyhEbZjToduFxGRUNsz3KdEy3To3ieqGJeHBZoTOKKEdBU=
Received: from SN4PR0501CA0057.namprd05.prod.outlook.com
 (2603:10b6:803:41::34) by BN6PR02MB2755.namprd02.prod.outlook.com
 (2603:10b6:404:fb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20; Tue, 24 Nov
 2020 14:25:17 +0000
Received: from SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:41:cafe::39) by SN4PR0501CA0057.outlook.office365.com
 (2603:10b6:803:41::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.13 via Frontend
 Transport; Tue, 24 Nov 2020 14:25:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT046.mail.protection.outlook.com (10.152.72.191) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 14:25:17 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 24 Nov 2020 06:25:15 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 24 Nov 2020 06:25:15 -0800
Envelope-to: ravi.patel@xilinx.com,
 amit.sunil.dhamne@xilinx.com,
 michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 TEJASP@xilinx.com,
 arnd@arndb.de,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [172.30.17.109] (port=59504)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1khZFq-0001Yx-MR; Tue, 24 Nov 2020 06:25:15 -0800
Subject: Re: [PATCH] firmware: xilinx: Use hash-table for api feature check
To:     Rajan Vaja <rajan.vaja@xilinx.com>, <michal.simek@xilinx.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <TEJASP@xilinx.com>,
        <arnd@arndb.de>, Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        Ravi Patel <ravi.patel@xilinx.com>
References: <1606197161-25976-1-git-send-email-rajan.vaja@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <69c290b6-a63b-11a1-90f3-c3685d733ee8@xilinx.com>
Date:   Tue, 24 Nov 2020 15:25:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1606197161-25976-1-git-send-email-rajan.vaja@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ffc20909-2666-45ea-823f-08d89084c446
X-MS-TrafficTypeDiagnostic: BN6PR02MB2755:
X-Microsoft-Antispam-PRVS: <BN6PR02MB27559A034DCF0E74278A26B8C6FB0@BN6PR02MB2755.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J6zy93oyMj2jJeOekr+rTTgRRVx8MX+NZcos8sJgGnPcbVNMfurRuT8/RahgAyR96zKnSejljK0XO1ehLPFYh993/71IUc1Ma4ejIiCQkoviUwg5FFCNov0VzpLWzmlnrivOSMY4z8QSrC5sntpYNcoa+nLUzlutlEVF9FIsBWwN1CgdQ2PJao46qBdX1xz3NQ0Cg2WNA0vEWDkUcDUYKZXwbOe1KNBNAPKWou8LpthNr3gLzJujDfrPWyHmQnJYGH8yHVjQmCamzbtvgRTuOLWBqJU/hvJl+jc38hGIiEb/Hp+doxWp6VZUBAgiujucpJIRm33+j+UxwNxbNQrdF6HMg3h5fmBJvzBfbmtb60tZu6ggkGaG4gAgj+yBzKr937cgsX8R0IvR/1O46+EwzH5DwhAdMr4VNjkKt6o7tY6bNU/dTkeyGCBCp+aIWEM8BTj0cHriU0R8+/NapC3CIA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(136003)(396003)(39860400002)(46966005)(82740400003)(44832011)(316002)(36906005)(107886003)(70206006)(70586007)(110136005)(336012)(2616005)(54906003)(7636003)(31686004)(6666004)(9786002)(5660300002)(83380400001)(36756003)(186003)(82310400003)(47076004)(4326008)(31696002)(478600001)(8936002)(426003)(26005)(356005)(2906002)(8676002)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 14:25:17.5153
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc20909-2666-45ea-823f-08d89084c446
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT046.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2755
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24. 11. 20 6:52, Rajan Vaja wrote:
> From: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> 
> Currently array of fix length PM_API_MAX is used to cache
> the pm_api version (valid or invalid). However ATF based
> PM APIs values are much higher then PM_API_MAX.
> So to include ATF based PM APIs also, use hash-table to
> store the pm_api version status.
> 
> Signed-off-by: Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Ravi Patel <ravi.patel@xilinx.com>
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 63 ++++++++++++++++++++++++++++--------
>  include/linux/firmware/xlnx-zynqmp.h |  4 ---
>  2 files changed, 49 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index efb8a66..349ab39 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -20,12 +20,28 @@
>  #include <linux/of_platform.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/hashtable.h>
>  
>  #include <linux/firmware/xlnx-zynqmp.h>
>  #include "zynqmp-debug.h"
>  
> +/* Max HashMap Order for PM API feature check (1<<7 = 128) */
> +#define PM_API_FEATURE_CHECK_MAX_ORDER  7
> +
>  static bool feature_check_enabled;
> -static u32 zynqmp_pm_features[PM_API_MAX];
> +DEFINE_HASHTABLE(pm_api_features_map, PM_API_FEATURE_CHECK_MAX_ORDER);
> +
> +/**
> + * struct pm_api_feature_data - PM API Feature data
> + * @pm_api_id:		PM API Id, used as key to index into hashmap
> + * @feature_status:	status of PM API feature: valid, invalid
> + * @hentry:		hlist_node that hooks this entry into hashtable
> + */
> +struct pm_api_feature_data {
> +	u32 pm_api_id;
> +	int feature_status;
> +	struct hlist_node hentry;
> +};
>  
>  static const struct mfd_cell firmware_devs[] = {
>  	{
> @@ -142,29 +158,37 @@ static int zynqmp_pm_feature(u32 api_id)
>  	int ret;
>  	u32 ret_payload[PAYLOAD_ARG_CNT];
>  	u64 smc_arg[2];
> +	struct pm_api_feature_data *feature_data;
>  
>  	if (!feature_check_enabled)
>  		return 0;
>  
> -	/* Return value if feature is already checked */
> -	if (api_id > ARRAY_SIZE(zynqmp_pm_features))
> -		return PM_FEATURE_INVALID;
> +	/* Check for existing entry in hash table for given api */
> +	hash_for_each_possible(pm_api_features_map, feature_data, hentry,
> +			       api_id) {
> +		if (feature_data->pm_api_id == api_id)
> +			return feature_data->feature_status;
> +	}
>  
> -	if (zynqmp_pm_features[api_id] != PM_FEATURE_UNCHECKED)
> -		return zynqmp_pm_features[api_id];
> +	/* Add new entry if not present */
> +	feature_data = kmalloc(sizeof(*feature_data), GFP_KERNEL);
> +	if (!feature_data)
> +		return -ENOMEM;
>  
> +	feature_data->pm_api_id = api_id;
>  	smc_arg[0] = PM_SIP_SVC | PM_FEATURE_CHECK;
>  	smc_arg[1] = api_id;
>  
>  	ret = do_fw_call(smc_arg[0], smc_arg[1], 0, ret_payload);
> -	if (ret) {
> -		zynqmp_pm_features[api_id] = PM_FEATURE_INVALID;
> -		return PM_FEATURE_INVALID;
> -	}
> +	if (ret)
> +		ret = -EOPNOTSUPP;
> +	else
> +		ret = ret_payload[1];
>  
> -	zynqmp_pm_features[api_id] = ret_payload[1];
> +	feature_data->feature_status = ret;
> +	hash_add(pm_api_features_map, &feature_data->hentry, api_id);
>  
> -	return zynqmp_pm_features[api_id];
> +	return ret;
>  }
>  
>  /**
> @@ -200,9 +224,12 @@ int zynqmp_pm_invoke_fn(u32 pm_api_id, u32 arg0, u32 arg1,
>  	 * Make sure to stay in x0 register
>  	 */
>  	u64 smc_arg[4];
> +	int ret;
>  
> -	if (zynqmp_pm_feature(pm_api_id) == PM_FEATURE_INVALID)
> -		return -ENOTSUPP;
> +	/* Check if feature is supported or not */
> +	ret = zynqmp_pm_feature(pm_api_id);
> +	if (ret < 0)
> +		return ret;
>  
>  	smc_arg[0] = PM_SIP_SVC | pm_api_id;
>  	smc_arg[1] = ((u64)arg1 << 32) | arg0;
> @@ -1252,9 +1279,17 @@ static int zynqmp_firmware_probe(struct platform_device *pdev)
>  
>  static int zynqmp_firmware_remove(struct platform_device *pdev)
>  {
> +	struct pm_api_feature_data *feature_data;
> +	int i;
> +
>  	mfd_remove_devices(&pdev->dev);
>  	zynqmp_pm_api_debugfs_exit();
>  
> +	hash_for_each(pm_api_features_map, i, feature_data, hentry) {
> +		hash_del(&feature_data->hentry);
> +		kfree(feature_data);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/firmware/xlnx-zynqmp.h b/include/linux/firmware/xlnx-zynqmp.h
> index 5968df8..41a1bab 100644
> --- a/include/linux/firmware/xlnx-zynqmp.h
> +++ b/include/linux/firmware/xlnx-zynqmp.h
> @@ -50,10 +50,6 @@
>  #define	ZYNQMP_PM_CAPABILITY_WAKEUP	0x4U
>  #define	ZYNQMP_PM_CAPABILITY_UNUSABLE	0x8U
>  
> -/* Feature check status */
> -#define PM_FEATURE_INVALID		-1
> -#define PM_FEATURE_UNCHECKED		0
> -
>  /*
>   * Firmware FPGA Manager flags
>   * XILINX_ZYNQMP_PM_FPGA_FULL:	FPGA full reconfiguration
> 

Applied.
M
