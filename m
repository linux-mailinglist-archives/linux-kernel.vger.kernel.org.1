Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211662C2699
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 13:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387739AbgKXMzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 07:55:08 -0500
Received: from mail-dm6nam11on2044.outbound.protection.outlook.com ([40.107.223.44]:9664
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733265AbgKXMzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 07:55:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EFI0hlnWejIRNY4Gb9O8C3SMXpB64HmZ0uWRisYGqMGRGT7etYIfXCiMqX45/P7j2dlRvNYyvMEfT2baR68WWoKb1fawKi4X9JxAe/R5LKpg8HLkNO64aXhlqeI+Ey5rc8c5MyKqwoyiqjiS8tmN3Ln4wrMooxerx0PCoTPxdDxaMCtb70xOdEmpeu1m19urmcJ/2J3YDihl6ubcOvq5c6sjSC1UyLEMjH4TKV0LuudvdNXgbJMeBVU0nbYeDD14W04KNSfSziB/U6UQxEVV3mehd9IltKVAlRVR7yShkZPBSno9oY5p76i7Mey4io3Kfq/im91a56kMjwMQBu9Ljg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FmyxgyI9PUVged0BRKzv36X5AuBPkVBeffH4eEJULs=;
 b=YuefeiXX4sec66ez87K5OR3pVoqNoO3eWCr+qWECrgsm0gS0sIZ82/pPTTVFeVGqsXbJgBGafy9LNDE3m98H/UgAbeU+IiKdOJkiN2sdjuKtUx2A8poV/l+TMnvhRVhhHREtLHtdUzm/Gv5d4BHjixd+5uGS+R8Kno3csEfTma8DK9hyUanI+cOAcel7NDwNJd4M7g2TDr4+s7AxEcprCTA9FC8Lw3qM0/TNLiq37sOogRh3E798dQTPn1vabWsXjpjbAJ2bPpQNO76XxzcLCPP4WA4bUETTktRX9lUfaF3qaOxqtdbVVtqWYXYJGhRbE74V81Y7IR35s0dykRxcnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FmyxgyI9PUVged0BRKzv36X5AuBPkVBeffH4eEJULs=;
 b=g51YQ7BiA72dEsfLqPzUj4V43roAVFElQApl+Th3zMik2REi4yDDHryueLLVQpnCEwYfpCCKPG2LHsq4bWfEKlsyB2YyOpcQE4JemOEFbSAuwQyqaRNyYNSvBUAPoo9so+U9+PYd+n76o0w4Kn7zGH/uHjWN4fR1cnyiQ911rNU=
Received: from BL0PR02CA0070.namprd02.prod.outlook.com (2603:10b6:207:3d::47)
 by BN7PR02MB5283.namprd02.prod.outlook.com (2603:10b6:408:30::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.28; Tue, 24 Nov
 2020 12:54:57 +0000
Received: from BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3d:cafe::da) by BL0PR02CA0070.outlook.office365.com
 (2603:10b6:207:3d::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21 via Frontend
 Transport; Tue, 24 Nov 2020 12:54:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT014.mail.protection.outlook.com (10.152.76.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3589.20 via Frontend Transport; Tue, 24 Nov 2020 12:54:57 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 24 Nov 2020 04:54:52 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Tue, 24 Nov 2020 04:54:52 -0800
Envelope-to: ravi.patel@xilinx.com,
 amit.sunil.dhamne@xilinx.com,
 michal.simek@xilinx.com,
 rajan.vaja@xilinx.com,
 TEJASP@xilinx.com,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 arnd@arndb.de
Received: from [172.30.17.109] (port=51718)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1khXqN-00039A-PQ; Tue, 24 Nov 2020 04:54:52 -0800
From:   Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] firmware: xilinx: Use hash-table for api feature check
To:     Rajan Vaja <rajan.vaja@xilinx.com>, <michal.simek@xilinx.com>,
        "Arnd Bergmann" <arnd@arndb.de>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <TEJASP@xilinx.com>,
        Amit Sunil Dhamne <amit.sunil.dhamne@xilinx.com>,
        "Ravi Patel" <ravi.patel@xilinx.com>
References: <1606197161-25976-1-git-send-email-rajan.vaja@xilinx.com>
Message-ID: <d63804a2-1880-70c3-841d-e824ec7942f7@xilinx.com>
Date:   Tue, 24 Nov 2020 13:54:48 +0100
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
X-MS-Office365-Filtering-Correlation-Id: 1d40db1c-bd8e-456c-7918-08d8907825b7
X-MS-TrafficTypeDiagnostic: BN7PR02MB5283:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5283F32766105B4C18523D71C6FB0@BN7PR02MB5283.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WupuVOds8lLgHNG4JKwP/wphs4EdvlV9SZ8mDuatid/Hy3Ni+s4YRTdd5WvLNAplClQ3LJanZXJYkxhzFwN/nXbmrqmodLkA/xe92A8pgMFWfrMMMBtpB5k0xxZC7jpsgK/NEkooQLjONRGsIXcHk/ZuC9WYnRuPBS0l52BkS7Msusg1XeolwdsDS3pVM9mL9CC/XRZVYC6ZvR2d140S5zJJHt4LSsN6b/ReNyd0cNxM42UN11nCeod2jlfmMZTpdwRoP67JxlCZJw6vnHhO6ic/FpjN+duoo5qtxbXLWn4jIji1ZppjOV3+wbyBGTDFL4IWkVC/YVcFoGNhM7WoExMWeW+JabIfVcb/XsVGQquQgnWW1qJdH6YtwYS/HOUxdM+9j8CM9n4ksUWAOWws3gXGTPSojCKphaXxN21e3R690fpxaqDnDFZX/GjYCdnLgWp84huIRiyKtjNYSk8+0A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39860400002)(376002)(46966005)(44832011)(2906002)(5660300002)(107886003)(82740400003)(110136005)(36906005)(82310400003)(54906003)(70586007)(316002)(2616005)(70206006)(47076004)(9786002)(31696002)(186003)(6666004)(31686004)(8676002)(4326008)(26005)(8936002)(83380400001)(7636003)(336012)(36756003)(426003)(478600001)(356005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 12:54:57.4772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d40db1c-bd8e-456c-7918-08d8907825b7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5283
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

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

Some lines should be added.

Cc: stable <stable@vger.kernel.org>
Fixes: f3217d6f2f7a ("firmware: xilinx: fix out-of-bounds access")

Tested-by: Michal Simek <michal.simek@xilinx.com>

Arnd: do you see any issue with this?
I found that your origin patch was taken by Greg and pushed to any
5.10-rc version which caused panic on Xilinx Versal. That's why I would
like to get this patch to v5.10 if possible.

Thanks,
Michal



