Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2515F2CF811
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 01:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgLEAlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 19:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgLEAlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 19:41:51 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE56AC061A4F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 16:41:04 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id s27so10114628lfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 16:41:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sflKrEH3m+t8+VIGuMyHLMnHyCy9S9cvUCjOYOz7hpI=;
        b=fYRJ8wXWmGoH2ltXDOrDyf5LNOBwxjuDa9ltsFgvd0ld5HdI2EOmLeLOiWi529aj7m
         s60fdFvLbmoM0xRIY4FozxERzWHDgXemvKlI4KYFF4D6k2x6iSlCVjQBFlldoIWmgChL
         CZiiz2u3skCcJZf7zct902bJKCBUgFjTPpybqMXLl16kmP85XsrXTfHcVqvC3dUSZyAq
         cMzEm6Yst92otSwD721fpcgkhzZNsTN7zwT8QAgQF+U6iYwz6ezDO+Tv+ESlEyefEEod
         VK8nN82NW0dm24BMRkJz/HnIn3m2j1JsIdYtPLBZh5Zvh7rANqfbhw3UOb4QMKntQODF
         RRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sflKrEH3m+t8+VIGuMyHLMnHyCy9S9cvUCjOYOz7hpI=;
        b=rfSDVaGlOQD6VUlak7f8kouNg0ya3YqPVKg0xwyvqc/5YnEoy1U+N/n+TzyMWdCJ1b
         P8Cb2FGfQ6joHAV0qElz19DWWmh94Ye7Q6DbPN6dgMcYFw0ZahY2Y/RABCS0M9lStwII
         mo8T/NHkWkAWnT6ukOAEUrgAPH7NFy6NQeoaQ8YoCFghJoYf+l0dy7syJ1DyKxLGCZRt
         UjHKujGJptZk3u3gih6tVZ5HVfnkqyPPDZDU2ND2FrYOdSUESiH9bB6jU6aBjkE9Vqvc
         pronwp9S/Nj0d71Ry6kZN0mIPzViuf+KpeV/VU3fww6cNVJIWI7YVMNK4t4yVZsShFbl
         fhKQ==
X-Gm-Message-State: AOAM532v6kSoLZQFmzmCJLtwyjEWaPdW0hdUZv8lFCgU2XbmpkEiJ34s
        aqMFleHE5PduYQMsrxtge0aArA==
X-Google-Smtp-Source: ABdhPJzjTd4c8Q6D6j6YW4vWLHgCeWhQD+gaLr+bb7InA5454Ia/mXs90GYk+FedwSEW7dXJImU8UQ==
X-Received: by 2002:a19:c60c:: with SMTP id w12mr4175007lff.244.1607128863298;
        Fri, 04 Dec 2020 16:41:03 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id w123sm2125477lff.138.2020.12.04.16.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 16:41:02 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 2/2 v2] regulator: ab8500: Decomission platform data header
Date:   Sat,  5 Dec 2020 01:40:57 +0100
Message-Id: <20201205004057.1712753-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201205004057.1712753-1-linus.walleij@linaro.org>
References: <20201205004057.1712753-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform data header was only used to pass platform
data from board files. We now populate the regulators
exclusively from device tree, so the header contents can
be moved into the regulator drivers.

Cc: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix a dangling include in ab8500-core.c

Lee: a oneliner hits ab8500-core.c as well. Again I think
this is safe to merge without any special merge
mechanics quirks.
---
 drivers/mfd/ab8500-core.c        |   1 -
 drivers/regulator/ab8500-ext.c   |  13 ++-
 drivers/regulator/ab8500.c       | 116 ++++++++++++++++++++++-
 include/linux/regulator/ab8500.h | 156 -------------------------------
 4 files changed, 127 insertions(+), 159 deletions(-)
 delete mode 100644 include/linux/regulator/ab8500.h

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index a3bac9da8cbb..3b2276f04a98 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -21,7 +21,6 @@
 #include <linux/mfd/abx500/ab8500.h>
 #include <linux/mfd/abx500/ab8500-bm.h>
 #include <linux/mfd/dbx500-prcmu.h>
-#include <linux/regulator/ab8500.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
 
diff --git a/drivers/regulator/ab8500-ext.c b/drivers/regulator/ab8500-ext.c
index 05f9531bd108..4f26952caa56 100644
--- a/drivers/regulator/ab8500-ext.c
+++ b/drivers/regulator/ab8500-ext.c
@@ -22,7 +22,18 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/mfd/abx500.h>
 #include <linux/mfd/abx500/ab8500.h>
-#include <linux/regulator/ab8500.h>
+
+/* AB8500 external regulators */
+enum ab8500_ext_regulator_id {
+	AB8500_EXT_SUPPLY1,
+	AB8500_EXT_SUPPLY2,
+	AB8500_EXT_SUPPLY3,
+	AB8500_NUM_EXT_REGULATORS,
+};
+
+struct ab8500_ext_regulator_cfg {
+	bool hwreq; /* requires hw mode or high power mode */
+};
 
 /* supply for VextSupply3 */
 static struct regulator_consumer_supply ab8500_ext_supply3_consumers[] = {
diff --git a/drivers/regulator/ab8500.c b/drivers/regulator/ab8500.c
index 47b8b6f7b571..23a401734a98 100644
--- a/drivers/regulator/ab8500.c
+++ b/drivers/regulator/ab8500.c
@@ -25,9 +25,123 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
-#include <linux/regulator/ab8500.h>
 #include <linux/slab.h>
 
+/* AB8500 regulators */
+enum ab8500_regulator_id {
+	AB8500_LDO_AUX1,
+	AB8500_LDO_AUX2,
+	AB8500_LDO_AUX3,
+	AB8500_LDO_INTCORE,
+	AB8500_LDO_TVOUT,
+	AB8500_LDO_AUDIO,
+	AB8500_LDO_ANAMIC1,
+	AB8500_LDO_ANAMIC2,
+	AB8500_LDO_DMIC,
+	AB8500_LDO_ANA,
+	AB8500_NUM_REGULATORS,
+};
+
+/* AB8505 regulators */
+enum ab8505_regulator_id {
+	AB8505_LDO_AUX1,
+	AB8505_LDO_AUX2,
+	AB8505_LDO_AUX3,
+	AB8505_LDO_AUX4,
+	AB8505_LDO_AUX5,
+	AB8505_LDO_AUX6,
+	AB8505_LDO_INTCORE,
+	AB8505_LDO_ADC,
+	AB8505_LDO_AUDIO,
+	AB8505_LDO_ANAMIC1,
+	AB8505_LDO_ANAMIC2,
+	AB8505_LDO_AUX8,
+	AB8505_LDO_ANA,
+	AB8505_NUM_REGULATORS,
+};
+
+/* AB8500 registers */
+enum ab8500_regulator_reg {
+	AB8500_REGUREQUESTCTRL2,
+	AB8500_REGUREQUESTCTRL3,
+	AB8500_REGUREQUESTCTRL4,
+	AB8500_REGUSYSCLKREQ1HPVALID1,
+	AB8500_REGUSYSCLKREQ1HPVALID2,
+	AB8500_REGUHWHPREQ1VALID1,
+	AB8500_REGUHWHPREQ1VALID2,
+	AB8500_REGUHWHPREQ2VALID1,
+	AB8500_REGUHWHPREQ2VALID2,
+	AB8500_REGUSWHPREQVALID1,
+	AB8500_REGUSWHPREQVALID2,
+	AB8500_REGUSYSCLKREQVALID1,
+	AB8500_REGUSYSCLKREQVALID2,
+	AB8500_REGUMISC1,
+	AB8500_VAUDIOSUPPLY,
+	AB8500_REGUCTRL1VAMIC,
+	AB8500_VPLLVANAREGU,
+	AB8500_VREFDDR,
+	AB8500_EXTSUPPLYREGU,
+	AB8500_VAUX12REGU,
+	AB8500_VRF1VAUX3REGU,
+	AB8500_VAUX1SEL,
+	AB8500_VAUX2SEL,
+	AB8500_VRF1VAUX3SEL,
+	AB8500_REGUCTRL2SPARE,
+	AB8500_REGUCTRLDISCH,
+	AB8500_REGUCTRLDISCH2,
+	AB8500_NUM_REGULATOR_REGISTERS,
+};
+
+/* AB8505 registers */
+enum ab8505_regulator_reg {
+	AB8505_REGUREQUESTCTRL1,
+	AB8505_REGUREQUESTCTRL2,
+	AB8505_REGUREQUESTCTRL3,
+	AB8505_REGUREQUESTCTRL4,
+	AB8505_REGUSYSCLKREQ1HPVALID1,
+	AB8505_REGUSYSCLKREQ1HPVALID2,
+	AB8505_REGUHWHPREQ1VALID1,
+	AB8505_REGUHWHPREQ1VALID2,
+	AB8505_REGUHWHPREQ2VALID1,
+	AB8505_REGUHWHPREQ2VALID2,
+	AB8505_REGUSWHPREQVALID1,
+	AB8505_REGUSWHPREQVALID2,
+	AB8505_REGUSYSCLKREQVALID1,
+	AB8505_REGUSYSCLKREQVALID2,
+	AB8505_REGUVAUX4REQVALID,
+	AB8505_REGUMISC1,
+	AB8505_VAUDIOSUPPLY,
+	AB8505_REGUCTRL1VAMIC,
+	AB8505_VSMPSAREGU,
+	AB8505_VSMPSBREGU,
+	AB8505_VSAFEREGU, /* NOTE! PRCMU register */
+	AB8505_VPLLVANAREGU,
+	AB8505_EXTSUPPLYREGU,
+	AB8505_VAUX12REGU,
+	AB8505_VRF1VAUX3REGU,
+	AB8505_VSMPSASEL1,
+	AB8505_VSMPSASEL2,
+	AB8505_VSMPSASEL3,
+	AB8505_VSMPSBSEL1,
+	AB8505_VSMPSBSEL2,
+	AB8505_VSMPSBSEL3,
+	AB8505_VSAFESEL1, /* NOTE! PRCMU register */
+	AB8505_VSAFESEL2, /* NOTE! PRCMU register */
+	AB8505_VSAFESEL3, /* NOTE! PRCMU register */
+	AB8505_VAUX1SEL,
+	AB8505_VAUX2SEL,
+	AB8505_VRF1VAUX3SEL,
+	AB8505_VAUX4REQCTRL,
+	AB8505_VAUX4REGU,
+	AB8505_VAUX4SEL,
+	AB8505_REGUCTRLDISCH,
+	AB8505_REGUCTRLDISCH2,
+	AB8505_REGUCTRLDISCH3,
+	AB8505_CTRLVAUX5,
+	AB8505_CTRLVAUX6,
+	AB8505_NUM_REGULATOR_REGISTERS,
+};
+
 /**
  * struct ab8500_shared_mode - is used when mode is shared between
  * two regulators.
diff --git a/include/linux/regulator/ab8500.h b/include/linux/regulator/ab8500.h
deleted file mode 100644
index ecf7b4713df9..000000000000
--- a/include/linux/regulator/ab8500.h
+++ /dev/null
@@ -1,156 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) ST-Ericsson SA 2010
- *
- * Authors: Sundar Iyer <sundar.iyer@stericsson.com> for ST-Ericsson
- *          Bengt Jonsson <bengt.g.jonsson@stericsson.com> for ST-Ericsson
- *          Daniel Willerud <daniel.willerud@stericsson.com> for ST-Ericsson
- */
-
-#ifndef __LINUX_MFD_AB8500_REGULATOR_H
-#define __LINUX_MFD_AB8500_REGULATOR_H
-
-#include <linux/platform_device.h>
-
-/* AB8500 regulators */
-enum ab8500_regulator_id {
-	AB8500_LDO_AUX1,
-	AB8500_LDO_AUX2,
-	AB8500_LDO_AUX3,
-	AB8500_LDO_INTCORE,
-	AB8500_LDO_TVOUT,
-	AB8500_LDO_AUDIO,
-	AB8500_LDO_ANAMIC1,
-	AB8500_LDO_ANAMIC2,
-	AB8500_LDO_DMIC,
-	AB8500_LDO_ANA,
-	AB8500_NUM_REGULATORS,
-};
-
-/* AB8505 regulators */
-enum ab8505_regulator_id {
-	AB8505_LDO_AUX1,
-	AB8505_LDO_AUX2,
-	AB8505_LDO_AUX3,
-	AB8505_LDO_AUX4,
-	AB8505_LDO_AUX5,
-	AB8505_LDO_AUX6,
-	AB8505_LDO_INTCORE,
-	AB8505_LDO_ADC,
-	AB8505_LDO_AUDIO,
-	AB8505_LDO_ANAMIC1,
-	AB8505_LDO_ANAMIC2,
-	AB8505_LDO_AUX8,
-	AB8505_LDO_ANA,
-	AB8505_NUM_REGULATORS,
-};
-
-/* AB8500 and AB8505 register initialization */
-struct ab8500_regulator_reg_init {
-	int id;
-	u8 mask;
-	u8 value;
-};
-
-#define INIT_REGULATOR_REGISTER(_id, _mask, _value)	\
-	{						\
-		.id = _id,				\
-		.mask = _mask,				\
-		.value = _value,			\
-	}
-
-/* AB8500 registers */
-enum ab8500_regulator_reg {
-	AB8500_REGUREQUESTCTRL2,
-	AB8500_REGUREQUESTCTRL3,
-	AB8500_REGUREQUESTCTRL4,
-	AB8500_REGUSYSCLKREQ1HPVALID1,
-	AB8500_REGUSYSCLKREQ1HPVALID2,
-	AB8500_REGUHWHPREQ1VALID1,
-	AB8500_REGUHWHPREQ1VALID2,
-	AB8500_REGUHWHPREQ2VALID1,
-	AB8500_REGUHWHPREQ2VALID2,
-	AB8500_REGUSWHPREQVALID1,
-	AB8500_REGUSWHPREQVALID2,
-	AB8500_REGUSYSCLKREQVALID1,
-	AB8500_REGUSYSCLKREQVALID2,
-	AB8500_REGUMISC1,
-	AB8500_VAUDIOSUPPLY,
-	AB8500_REGUCTRL1VAMIC,
-	AB8500_VPLLVANAREGU,
-	AB8500_VREFDDR,
-	AB8500_EXTSUPPLYREGU,
-	AB8500_VAUX12REGU,
-	AB8500_VRF1VAUX3REGU,
-	AB8500_VAUX1SEL,
-	AB8500_VAUX2SEL,
-	AB8500_VRF1VAUX3SEL,
-	AB8500_REGUCTRL2SPARE,
-	AB8500_REGUCTRLDISCH,
-	AB8500_REGUCTRLDISCH2,
-	AB8500_NUM_REGULATOR_REGISTERS,
-};
-
-/* AB8505 registers */
-enum ab8505_regulator_reg {
-	AB8505_REGUREQUESTCTRL1,
-	AB8505_REGUREQUESTCTRL2,
-	AB8505_REGUREQUESTCTRL3,
-	AB8505_REGUREQUESTCTRL4,
-	AB8505_REGUSYSCLKREQ1HPVALID1,
-	AB8505_REGUSYSCLKREQ1HPVALID2,
-	AB8505_REGUHWHPREQ1VALID1,
-	AB8505_REGUHWHPREQ1VALID2,
-	AB8505_REGUHWHPREQ2VALID1,
-	AB8505_REGUHWHPREQ2VALID2,
-	AB8505_REGUSWHPREQVALID1,
-	AB8505_REGUSWHPREQVALID2,
-	AB8505_REGUSYSCLKREQVALID1,
-	AB8505_REGUSYSCLKREQVALID2,
-	AB8505_REGUVAUX4REQVALID,
-	AB8505_REGUMISC1,
-	AB8505_VAUDIOSUPPLY,
-	AB8505_REGUCTRL1VAMIC,
-	AB8505_VSMPSAREGU,
-	AB8505_VSMPSBREGU,
-	AB8505_VSAFEREGU, /* NOTE! PRCMU register */
-	AB8505_VPLLVANAREGU,
-	AB8505_EXTSUPPLYREGU,
-	AB8505_VAUX12REGU,
-	AB8505_VRF1VAUX3REGU,
-	AB8505_VSMPSASEL1,
-	AB8505_VSMPSASEL2,
-	AB8505_VSMPSASEL3,
-	AB8505_VSMPSBSEL1,
-	AB8505_VSMPSBSEL2,
-	AB8505_VSMPSBSEL3,
-	AB8505_VSAFESEL1, /* NOTE! PRCMU register */
-	AB8505_VSAFESEL2, /* NOTE! PRCMU register */
-	AB8505_VSAFESEL3, /* NOTE! PRCMU register */
-	AB8505_VAUX1SEL,
-	AB8505_VAUX2SEL,
-	AB8505_VRF1VAUX3SEL,
-	AB8505_VAUX4REQCTRL,
-	AB8505_VAUX4REGU,
-	AB8505_VAUX4SEL,
-	AB8505_REGUCTRLDISCH,
-	AB8505_REGUCTRLDISCH2,
-	AB8505_REGUCTRLDISCH3,
-	AB8505_CTRLVAUX5,
-	AB8505_CTRLVAUX6,
-	AB8505_NUM_REGULATOR_REGISTERS,
-};
-
-/* AB8500 external regulators */
-struct ab8500_ext_regulator_cfg {
-	bool hwreq; /* requires hw mode or high power mode */
-};
-
-enum ab8500_ext_regulator_id {
-	AB8500_EXT_SUPPLY1,
-	AB8500_EXT_SUPPLY2,
-	AB8500_EXT_SUPPLY3,
-	AB8500_NUM_EXT_REGULATORS,
-};
-
-#endif
-- 
2.26.2

