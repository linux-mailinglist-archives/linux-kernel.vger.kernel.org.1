Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F05C526960A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgINUHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 16:07:35 -0400
Received: from mail-dm6nam10on2051.outbound.protection.outlook.com ([40.107.93.51]:10369
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgINUH1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 16:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dfQ3ZlNK57KcX7IMk1UFbI2WJLj6QemYl5nXNjfevnmDCAcve8ZxT3ZAsIkHSyUWe8XLHftCAyF61ge4Oyodb1F9kwGQLbUC1m2KMhl9Yx2dFbp/fpk/W7YPzY7lSJTYqjgzIun5ghM+cGdnHX23FaSTgyPH+NCo50MykdFMJlz6aw8B+YLP6CwzwEYUO9hYn3IaU//2kxiEb0oaebers/tBNu5r4vZfFgbWrJHrdzg7WYWIzPmH5gDrijEtiAYUY5ZbULqDfo7752AUYCeovkEf1eYtWKhk3auQYXr/sOFdde4yV2dOSzxfdfPghhQmbSJ4RaqkN6f3jFxqwsuZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pT68a0tB5Mgosyuh3j2uymPxA/LZrENiFw5Du0OLcXg=;
 b=Nyo03ACLEdo2lhGyudnQ7jq3VqFZKIaXgzjl+yRyY+ojxZ5CEslEIUh/AUSjQXELU4hbznFJSj+Yf0u7Scx4Ci5G/Zuzh3RauFdBRvj+/hL7t+fdU1xEKf7y6QTKvj3uqUJH1QD6ukUJ78ZJdYoYQhX6M4leJYiX9l3Vni8wCoYnpDhrdujmJrzmdv4iyB+uXSNMArvHFGd5kWYmj4XyEp594j3iyYpFXyFj80BjYIx9hOIimKivvZPHNP6u3q6YxozSGpRs2qjgo2FJEfVbEP08TPXDHm6Mi7yH0SALkgrjJIuOmEh1m5iXyASyRRbqwd3S3wPOhMdf5OBEb61jzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pT68a0tB5Mgosyuh3j2uymPxA/LZrENiFw5Du0OLcXg=;
 b=TTKilA3N1cMSORpreI5Wp8t8aB9WE8pioQE9wXLmVJhtPdGZGrmAIE3EKPLuoUv0ipCPN52sCfesPKjxNMo1CqCoMM/an0XmjtiAZpIFFZETODHvsdGNCv/AaGfalhy1Wg3zUOYIkSv6mk0PTTWaytMpK6XfvGWI4HH+w7OEVS0=
Authentication-Results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1494.namprd12.prod.outlook.com (2603:10b6:910:f::22)
 by CY4PR1201MB0168.namprd12.prod.outlook.com (2603:10b6:910:1d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 20:07:23 +0000
Received: from CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::9067:e60d:5698:51d8]) by CY4PR12MB1494.namprd12.prod.outlook.com
 ([fe80::9067:e60d:5698:51d8%12]) with mapi id 15.20.3370.019; Mon, 14 Sep
 2020 20:07:23 +0000
From:   Wei Huang <wei.huang2@amd.com>
To:     linux@roeck-us.net
Cc:     jdelvare@suse.com, clemens@ladisch.de, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, wei.huang2@amd.com
Subject: [PATCH 1/1] hwmon: (k10temp) Add support for Zen3 CPUs
Date:   Mon, 14 Sep 2020 15:07:15 -0500
Message-Id: <20200914200715.1997757-1-wei.huang2@amd.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0041.namprd08.prod.outlook.com
 (2603:10b6:5:1e0::15) To CY4PR12MB1494.namprd12.prod.outlook.com
 (2603:10b6:910:f::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from weiserver.amd.com (165.204.77.1) by DM6PR08CA0041.namprd08.prod.outlook.com (2603:10b6:5:1e0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Mon, 14 Sep 2020 20:07:21 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 717dbf1e-4541-482c-c76e-08d858e9cab9
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0168:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0168678C60907EF1DE08107DCF230@CY4PR1201MB0168.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jF7ligxqpVnZgO4EhLCMXfMHh7OmR0pEW38tVOmEGPAOG5eU7XV27GV6pPXqREirLb3tl30IfkkR8yx2B6bxl/6Ws8/3sAgRbPVT5Fxq5ZSzrTC3pEo9HZAizUVmVmMAmqAE6cQcIZDsI8UZcZ4pULTd09qc7g7j6QJ5R3rzI82S4A+G8lrHozz+u4IEqItqoJgN+cAvy3wuQc79pAG+Q3dusL1kruLJvi9+4CfnNqlJEwtIBFEcwTHjaWmY+u9iMiaqQOWtWKqW/FXCPYYt3cZVaTktr7E/cMul65wB4W8sTQvJ5gCvukCjsNWGupD4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR12MB1494.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(8676002)(36756003)(316002)(2906002)(4326008)(8936002)(6666004)(5660300002)(186003)(66946007)(7696005)(52116002)(2616005)(86362001)(6486002)(16526019)(66476007)(956004)(66556008)(26005)(478600001)(1076003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: bsRoUwOPAdhC3Zdp/oGeAU8TF+MbY6nE2xRFQTgxUaFIau8rfEM5tLq70HijWd7wH1RLN1RxNf4Sl8xWYsouhn8FstNAkAhppVm0YXfYvE17Dx2d2qHwas5Cm453ANQq9D1tF1PNSctb0fCcOGftigWw6mjn5+iQwG6TkPnLpp2aVIaZObjq3mmPhMXtc8Nu3iqrSyV/QoUHsF1AC37Ya3jUyidfrM37xhg1fmLN1OtH/IPJD4Nile5WEIJtiKGUliOznXUGCl3Ejx/nrFMD2zZWi+MRds9UFYZH2O3/w8oWv4YyFRVF+ujqZFWHvDRD23AIlaMQfmVSjl5YLCzM1HvVwUqT1YwVfv6kmxVsTpTzTuntyGJnP+nxh1F+603WNoKwldflRykJ6vIzpyDP04kutF0WOX93m5ETpLVOgEpWLdrpND0PU1H1N5Rbt+fAq03u5PV4Z3c77qXoClpB9+JGGED6L/PamSZXZPa8yJWwlakR/oymUCSaRFJMxXgQ3wtg3l1d2W+/nT+fsrGykbQmLzp7qHNGtFHKxa/9hGQVsw1kqkhBS+V1c1jdoVs42GhaDQ6iOSoFjjSL/Q4BcbN0pcgNLsblybn8gGkwocoorDTWtkpTrta0IIt1Iu5zkkgZWzK9sHW38181QVkYVQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 717dbf1e-4541-482c-c76e-08d858e9cab9
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1494.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 20:07:23.0494
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PycXT7UjGyYNrqHZ2E4HFq8RHU+DKWLgXP7eN2RNZ1OjS3jkmWa6KkllkJ4d6hd6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0168
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zen3 thermal info is supported via a new PCI device ID. Also the voltage
telemetry registers and the current factors need to be defined. k10temp
driver then searches for CPU family 0x19 and configures k10temp_data
accordingly.

Signed-off-by: Wei Huang <wei.huang2@amd.com>
---
 drivers/hwmon/k10temp.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 49e8ebf8da32..a250481b5a97 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -95,6 +95,13 @@ static DEFINE_MUTEX(nb_smu_ind_mutex);
 #define F17H_M31H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
 #define F17H_M31H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/
 
+/* F19h thermal registers through SMN */
+#define F19H_M01_SVI_TEL_PLANE0			(ZEN_SVI_BASE + 0x14)
+#define F19H_M01_SVI_TEL_PLANE1			(ZEN_SVI_BASE + 0x10)
+
+#define F19H_M01H_CFACTOR_ICORE			1000000	/* 1A / LSB	*/
+#define F19H_M01H_CFACTOR_ISOC			310000	/* 0.31A / LSB	*/
+
 struct k10temp_data {
 	struct pci_dev *pdev;
 	void (*read_htcreg)(struct pci_dev *pdev, u32 *regval);
@@ -527,6 +534,22 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 			k10temp_get_ccd_support(pdev, data, 8);
 			break;
 		}
+	} else if (boot_cpu_data.x86 == 0x19) {
+		data->temp_adjust_mask = ZEN_CUR_TEMP_RANGE_SEL_MASK;
+		data->read_tempreg = read_tempreg_nb_zen;
+		data->show_temp |= BIT(TDIE_BIT);
+		data->is_zen = true;
+
+		switch (boot_cpu_data.x86_model) {
+		case 0x0 ... 0x1:	/* Zen3 */
+			data->show_current = true;
+			data->svi_addr[0] = F19H_M01_SVI_TEL_PLANE0;
+			data->svi_addr[1] = F19H_M01_SVI_TEL_PLANE1;
+			data->cfactor[0] = F19H_M01H_CFACTOR_ICORE;
+			data->cfactor[1] = F19H_M01H_CFACTOR_ISOC;
+			k10temp_get_ccd_support(pdev, data, 8);
+			break;
+		}
 	} else {
 		data->read_htcreg = read_htcreg_pci;
 		data->read_tempreg = read_tempreg_pci;
@@ -564,6 +587,7 @@ static const struct pci_device_id k10temp_id_table[] = {
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M30H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F3) },
 	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
 	{ PCI_VDEVICE(HYGON, PCI_DEVICE_ID_AMD_17H_DF_F3) },
 	{}
 };
-- 
2.24.1

