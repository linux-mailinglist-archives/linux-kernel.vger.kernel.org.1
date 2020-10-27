Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5D529A803
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895719AbgJ0Jli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:41:38 -0400
Received: from mx0a-001ae601.pphosted.com ([67.231.149.25]:29760 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2895705AbgJ0Jlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:41:37 -0400
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 09R9VdVf016828;
        Tue, 27 Oct 2020 04:41:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=PODMain02222019;
 bh=tkOxnWofODio6Kcr6lj76jfpDRx7wOPbDz2wDTpm7Rc=;
 b=FzROQaDemY6sOQLJnHg9EZaTxoZ40v1LNlDinHH2gP2eVtZEgxmIAMrPjTnK5apXadU7
 Nz3bTXFlpS4iANlirOA1VtfYBqxfKqFJwX0Xz3mYPV4roOclNrlwcWk7cCgMSjWrlx9M
 /aRC0qmosn+vJm8jVJEWfIqaV0wcsUpwE6+qhqOAvwUMRwgNvvOPTv32WzBK81sRjKUt
 C2kykfceUBj7Fs/D/eIaS8YlLT6Ts/4AiqHqvZduwsb9izPkTtol2TawUUd7z9OAXAOs
 kLYQZKKEThHINc3vKRDSVJLUmEoQep9Ep2OfHQvjtN7s0mVDUUaWrV17TNpPGEVvaIvj 8Q== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
        by mx0a-001ae601.pphosted.com with ESMTP id 34chp1m3me-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Oct 2020 04:41:35 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 27 Oct
 2020 09:41:33 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Tue, 27 Oct 2020 09:41:33 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 08FE82C1;
        Tue, 27 Oct 2020 09:41:33 +0000 (UTC)
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     <lee.jones@linaro.org>
CC:     <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: [PATCH RESEND 2/2] mfd: madera: Add special errata reset handling for cs47l15
Date:   Tue, 27 Oct 2020 09:41:32 +0000
Message-ID: <20201027094132.16472-2-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20201027094132.16472-1-ckeepax@opensource.cirrus.com>
References: <20201027094132.16472-1-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=1 priorityscore=1501 mlxlogscore=999
 mlxscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270063
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

