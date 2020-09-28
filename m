Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3AF27A697
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 06:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgI1Ekj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 00:40:39 -0400
Received: from mx0a-00154904.pphosted.com ([148.163.133.20]:9490 "EHLO
        mx0a-00154904.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbgI1Ekj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 00:40:39 -0400
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
        by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S4WBNw004491
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:40:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=smtpout1;
 bh=TxXwByPvQqrKog77tzisD1pIbKV2xgT5oAHWMFylCJI=;
 b=edsD95oVViugCRJO/xqtzNI0PqYy9B+OpSQc4imVZDG9Tzza3OFZo+zaXHg4T6ePScWF
 LpHeKEvlCyl/iIZemWgSDBM/z3S3PhS3dwAVHS/xpolhCxj2ID04f+W1CgJWpZK/e5J/
 PCcD+K2p2CBbsHcgVv2Igw4DKQLaeXRtWBr1NK3X+uxUT0rk9IUdQ5phARR2dPuSWNkS
 Oidz/hKiU8yfmG0RDoWphay8GcCCYp7IoD2k18fLZBWrSNQrzPe1KwwMss8Ktii1I/Gt
 2XuMUkW/2m+odVbdeVDA36/DNCl0vw8skrWDvAiHTa5IIT2eNNG0yAm+Y7Sqr4xOUtLi XA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
        by mx0a-00154904.pphosted.com with ESMTP id 33t0sxb2w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:40:38 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08S4dZIn087193
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:40:37 -0400
Received: from ausxippc101.us.dell.com (ausxippc101.us.dell.com [143.166.85.207])
        by mx0a-00154901.pphosted.com with ESMTP id 33u81u0k67-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 00:40:37 -0400
X-LoopCount0: from 10.173.37.130
X-PREM-Routing: D-Outbound
X-IronPort-AV: E=Sophos;i="5.77,312,1596517200"; 
   d="scan'208";a="1434187425"
From:   Mario Limonciello <mario.limonciello@dell.com>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org
Cc:     linux-kernel@vger.kernel.org, darcari@redhat.com,
        Yijun.Shen@dell.com, Perry.Yuan@dell.com,
        Mario Limonciello <mario.limonciello@dell.com>
Subject: [PATCH 2/3] e1000e: Add Dell's Comet Lake systems into s0ix heuristics
Date:   Sun, 27 Sep 2020 23:40:23 -0500
Message-Id: <20200928044024.7595-3-mario.limonciello@dell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928044024.7595-1-mario.limonciello@dell.com>
References: <20200928044024.7595-1-mario.limonciello@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-28_03:2020-09-24,2020-09-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280037
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009280036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dell's Comet Lake Latitude and Precision systems containing i219LM are
properly configured and should use the s0ix flows.

Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
---
 drivers/net/ethernet/intel/Kconfig        |  1 +
 drivers/net/ethernet/intel/e1000e/param.c | 80 ++++++++++++++++++++++-
 2 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 5aa86318ed3e..280af47d74d2 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -58,6 +58,7 @@ config E1000
 config E1000E
 	tristate "Intel(R) PRO/1000 PCI-Express Gigabit Ethernet support"
 	depends on PCI && (!SPARC32 || BROKEN)
+	depends on DMI
 	select CRC32
 	imply PTP_1588_CLOCK
 	help
diff --git a/drivers/net/ethernet/intel/e1000e/param.c b/drivers/net/ethernet/intel/e1000e/param.c
index e66b222c824b..58e6718c4f75 100644
--- a/drivers/net/ethernet/intel/e1000e/param.c
+++ b/drivers/net/ethernet/intel/e1000e/param.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /* Copyright(c) 1999 - 2018 Intel Corporation. */
 
+#include <linux/dmi.h>
 #include <linux/netdevice.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -201,6 +202,80 @@ static const struct e1000e_me_supported me_supported[] = {
 	{0}
 };
 
+static const struct dmi_system_id s0ix_supported_systems[] = {
+	{
+		/* Dell Latitude 5310 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "099F"),
+		},
+	},
+	{
+		/* Dell Latitude 5410 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09A0"),
+		},
+	},
+	{
+		/* Dell Latitude 5410 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C9"),
+		},
+	},
+	{
+		/* Dell Latitude 5510 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09A1"),
+		},
+	},
+	{
+		/* Dell Precision 3550 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09A2"),
+		},
+	},
+	{
+		/* Dell Latitude 5411 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C0"),
+		},
+	},
+	{
+		/* Dell Latitude 5511 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C1"),
+		},
+	},
+	{
+		/* Dell Precision 3551 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C2"),
+		},
+	},
+	{
+		/* Dell Precision 7550 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C3"),
+		},
+	},
+	{
+		/* Dell Precision 7750 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+			DMI_MATCH(DMI_PRODUCT_SKU, "09C4"),
+		},
+	},
+	{ }
+};
+
 static bool e1000e_check_me(u16 device_id)
 {
 	struct e1000e_me_supported *id;
@@ -599,8 +674,11 @@ void e1000e_check_options(struct e1000_adapter *adapter)
 		}
 
 		if (enabled == S0IX_HEURISTICS) {
+			/* check for allowlist of systems */
+			if (dmi_check_system(s0ix_supported_systems))
+				enabled = S0IX_FORCE_ON;
 			/* default to off for ME configurations */
-			if (e1000e_check_me(hw->adapter->pdev->device))
+			else if (e1000e_check_me(hw->adapter->pdev->device))
 				enabled = S0IX_FORCE_OFF;
 		}
 
-- 
2.25.1

