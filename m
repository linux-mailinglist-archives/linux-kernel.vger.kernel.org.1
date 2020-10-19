Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBA929260B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbgJSKu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:50:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:41710 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726606AbgJSKu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:50:27 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JAeFC3031351;
        Mon, 19 Oct 2020 06:49:27 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 347tf660yt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 06:49:27 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 09JAnQhT018314
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 19 Oct 2020 06:49:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 19 Oct
 2020 06:49:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 19 Oct 2020 06:49:25 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 09JAnLLO004408;
        Mon, 19 Oct 2020 06:49:22 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
CC:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <lars@metafoo.de>,
        <nuno.sa@analog.com>, <perex@perex.cz>, <tiwai@suse.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] ASoC: adau1977: remove platform data and move micbias bindings include
Date:   Mon, 19 Oct 2020 13:53:13 +0300
Message-ID: <20201019105313.24862-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_02:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1011
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change removes the platform_data include/definition. It only contains
some values for the MICBIAS.
These are moved into 'dt-bindings/sound/adi,adau1977.h' so that they can be
used inside device-trees. When moving then, they need to be converted to
pre-compiler defines, so that the DT compiler can understand them.

The driver then, also needs to include the new
'dt-bindings/sound/adi,adau1977.h' file.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 include/dt-bindings/sound/adi,adau1977.h | 15 ++++++++
 include/linux/platform_data/adau1977.h   | 44 ------------------------
 sound/soc/codecs/adau1977.c              |  9 ++---
 3 files changed, 18 insertions(+), 50 deletions(-)
 create mode 100644 include/dt-bindings/sound/adi,adau1977.h
 delete mode 100644 include/linux/platform_data/adau1977.h

diff --git a/include/dt-bindings/sound/adi,adau1977.h b/include/dt-bindings/sound/adi,adau1977.h
new file mode 100644
index 000000000000..8eebec6570f2
--- /dev/null
+++ b/include/dt-bindings/sound/adi,adau1977.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __DT_BINDINGS_ADI_ADAU1977_H__
+#define __DT_BINDINGS_ADI_ADAU1977_H__
+
+#define ADAU1977_MICBIAS_5V0	0x0
+#define ADAU1977_MICBIAS_5V5	0x1
+#define ADAU1977_MICBIAS_6V0	0x2
+#define ADAU1977_MICBIAS_6V5	0x3
+#define ADAU1977_MICBIAS_7V0	0x4
+#define ADAU1977_MICBIAS_7V5	0x5
+#define ADAU1977_MICBIAS_8V0	0x6
+#define ADAU1977_MICBIAS_8V5	0x7
+#define ADAU1977_MICBIAS_9V0	0x8
+
+#endif /* __DT_BINDINGS_ADI_ADAU1977_H__ */
diff --git a/include/linux/platform_data/adau1977.h b/include/linux/platform_data/adau1977.h
deleted file mode 100644
index 86667235077a..000000000000
--- a/include/linux/platform_data/adau1977.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * ADAU1977/ADAU1978/ADAU1979 driver
- *
- * Copyright 2014 Analog Devices Inc.
- *  Author: Lars-Peter Clausen <lars@metafoo.de>
- */
-
-#ifndef __LINUX_PLATFORM_DATA_ADAU1977_H__
-#define __LINUX_PLATFORM_DATA_ADAU1977_H__
-
-/**
- * enum adau1977_micbias - ADAU1977 MICBIAS pin voltage setting
- * @ADAU1977_MICBIAS_5V0: MICBIAS is set to 5.0 V
- * @ADAU1977_MICBIAS_5V5: MICBIAS is set to 5.5 V
- * @ADAU1977_MICBIAS_6V0: MICBIAS is set to 6.0 V
- * @ADAU1977_MICBIAS_6V5: MICBIAS is set to 6.5 V
- * @ADAU1977_MICBIAS_7V0: MICBIAS is set to 7.0 V
- * @ADAU1977_MICBIAS_7V5: MICBIAS is set to 7.5 V
- * @ADAU1977_MICBIAS_8V0: MICBIAS is set to 8.0 V
- * @ADAU1977_MICBIAS_8V5: MICBIAS is set to 8.5 V
- * @ADAU1977_MICBIAS_9V0: MICBIAS is set to 9.0 V
- */
-enum adau1977_micbias {
-	ADAU1977_MICBIAS_5V0 = 0x0,
-	ADAU1977_MICBIAS_5V5 = 0x1,
-	ADAU1977_MICBIAS_6V0 = 0x2,
-	ADAU1977_MICBIAS_6V5 = 0x3,
-	ADAU1977_MICBIAS_7V0 = 0x4,
-	ADAU1977_MICBIAS_7V5 = 0x5,
-	ADAU1977_MICBIAS_8V0 = 0x6,
-	ADAU1977_MICBIAS_8V5 = 0x7,
-	ADAU1977_MICBIAS_9V0 = 0x8,
-};
-
-/**
- * struct adau1977_platform_data - Platform configuration data for the ADAU1977
- * @micbias: Specifies the voltage for the MICBIAS pin
- */
-struct adau1977_platform_data {
-	enum adau1977_micbias micbias;
-};
-
-#endif
diff --git a/sound/soc/codecs/adau1977.c b/sound/soc/codecs/adau1977.c
index 0a36e523584c..8260f49caa24 100644
--- a/sound/soc/codecs/adau1977.c
+++ b/sound/soc/codecs/adau1977.c
@@ -12,7 +12,6 @@
 #include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/module.h>
-#include <linux/platform_data/adau1977.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
@@ -24,6 +23,8 @@
 #include <sound/soc.h>
 #include <sound/tlv.h>
 
+#include <dt-bindings/sound/adi,adau1977.h>
+
 #include "adau1977.h"
 
 #define ADAU1977_REG_POWER		0x00
@@ -881,13 +882,9 @@ static const struct snd_soc_component_driver adau1977_component_driver = {
 
 static int adau1977_setup_micbias(struct adau1977 *adau1977)
 {
-	struct adau1977_platform_data *pdata = adau1977->dev->platform_data;
 	unsigned int micbias;
 
-	if (pdata)
-		micbias = pdata->micbias;
-	else if (device_property_read_u32(adau1977->dev, "adi,micbias",
-					  &micbias))
+	if (device_property_read_u32(adau1977->dev, "adi,micbias", &micbias))
 		micbias = ADAU1977_MICBIAS_8V5;
 
 	if (micbias > ADAU1977_MICBIAS_9V0) {
-- 
2.17.1

