Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6F02802D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 17:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732475AbgJAPeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 11:34:16 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:24116 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731917AbgJAPeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 11:34:16 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 091FLNLe002767;
        Thu, 1 Oct 2020 10:34:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=tkOxnWofODio6Kcr6lj76jfpDRx7wOPbDz2wDTpm7Rc=;
 b=U6njCcc8ykFnRrUP+es3Thi3Q+LvLUzOh+5HOS+GDu6hh7mqPCkiGqfrrvSQ3WwHaOsu
 VByQkVCZm0ZVpVMY7OetdoWtrT6zFlbB2+Sk4AYCM8CRxtMv+KeGr697mpUs37ufJluN
 cmj0SGxWHt5SkhM0eYQlQmSbwv1EToi5wG4/GaiB4o5CfxB19CzC4eKaI1OU1F5bcJU5
 zIzJ97CSk57D6qzhYPUkmRkG8xKTdfLmHhu597OhINx/VJ+N+Ws9Yd4qDxuf8R8PhJ0Q
 kvFgZaBe3fjObGKEUfY8N3+vMEFdzsZiIE/qfC8W56AhO+RBRipI85NP6U70pMM5+WYT Cg== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
        by mx0b-001ae601.pphosted.com with ESMTP id 33t22p7c7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Oct 2020 10:34:14 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 1 Oct 2020
 16:34:13 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 1 Oct 2020 16:34:13 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 520692C4;
        Thu,  1 Oct 2020 15:34:13 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH 2/2] mfd: madera: Add special errata reset handling for cs47l15
Date:   Thu, 1 Oct 2020 16:34:13 +0100
Message-ID: <20201001153413.22948-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201001153413.22948-1-ckeepax@opensource.cirrus.com>
References: <20201001153413.22948-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999
 impostorscore=0 suspectscore=1 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010010132
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An errata exists for cs47l15 where the reset must be handled
differently and removed before DCVDD is applied. A soft reset is used
for situations where a reset is required to reset state. This does
however, make this part unsuitable for DCVDD supplies with a rise time
greater than 2mS.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 drivers/mfd/madera-core.c       | 25 ++++++++++++++++++++-----
 include/linux/mfd/madera/core.h |  1 +
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index a9c6f0833f327..a2abc0094def7 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -38,6 +38,9 @@
 #define MADERA_RESET_MIN_US	2000
 #define MADERA_RESET_MAX_US	3000
 
+#define ERRATA_DCVDD_MIN_US	10000
+#define ERRATA_DCVDD_MAX_US	15000
+
 static const char * const madera_core_supplies[] = {
 	"AVDD",
 	"DBVDD1",
@@ -291,7 +294,8 @@ static int __maybe_unused madera_runtime_resume(struct device *dev)
 
 	dev_dbg(dev, "Leaving sleep mode\n");
 
-	madera_enable_hard_reset(madera);
+	if (!madera->reset_errata)
+		madera_enable_hard_reset(madera);
 
 	ret = regulator_enable(madera->dcvdd);
 	if (ret) {
@@ -302,9 +306,12 @@ static int __maybe_unused madera_runtime_resume(struct device *dev)
 	regcache_cache_only(madera->regmap, false);
 	regcache_cache_only(madera->regmap_32bit, false);
 
-	madera_disable_hard_reset(madera);
+	if (madera->reset_errata)
+		usleep_range(ERRATA_DCVDD_MIN_US, ERRATA_DCVDD_MAX_US);
+	else
+		madera_disable_hard_reset(madera);
 
-	if (!madera->pdata.reset) {
+	if (!madera->pdata.reset || madera->reset_errata) {
 		ret = madera_wait_for_boot(madera);
 		if (ret)
 			goto err;
@@ -503,6 +510,8 @@ int madera_dev_init(struct madera *madera)
 	 */
 	switch (madera->type) {
 	case CS47L15:
+		madera->reset_errata = true;
+		break;
 	case CS47L35:
 	case CS47L90:
 	case CS47L91:
@@ -553,13 +562,19 @@ int madera_dev_init(struct madera *madera)
 		goto err_dcvdd;
 	}
 
+	if (madera->reset_errata)
+		madera_disable_hard_reset(madera);
+
 	ret = regulator_enable(madera->dcvdd);
 	if (ret) {
 		dev_err(dev, "Failed to enable DCVDD: %d\n", ret);
 		goto err_enable;
 	}
 
-	madera_disable_hard_reset(madera);
+	if (madera->reset_errata)
+		usleep_range(ERRATA_DCVDD_MIN_US, ERRATA_DCVDD_MAX_US);
+	else
+		madera_disable_hard_reset(madera);
 
 	regcache_cache_only(madera->regmap, false);
 	regcache_cache_only(madera->regmap_32bit, false);
@@ -667,7 +682,7 @@ int madera_dev_init(struct madera *madera)
 	 * It looks like a device we support. If we don't have a hard reset
 	 * we can now attempt a soft reset.
 	 */
-	if (!madera->pdata.reset) {
+	if (!madera->pdata.reset || madera->reset_errata) {
 		ret = madera_soft_reset(madera);
 		if (ret)
 			goto err_reset;
diff --git a/include/linux/mfd/madera/core.h b/include/linux/mfd/madera/core.h
index ad2c138105d4b..03a8a788424a2 100644
--- a/include/linux/mfd/madera/core.h
+++ b/include/linux/mfd/madera/core.h
@@ -186,6 +186,7 @@ struct madera {
 	struct regulator_bulk_data core_supplies[MADERA_MAX_CORE_SUPPLIES];
 	struct regulator *dcvdd;
 	bool internal_dcvdd;
+	bool reset_errata;
 
 	struct madera_pdata pdata;
 
-- 
2.11.0

