Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1C1E2CEF57
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 15:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgLDOEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 09:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgLDOEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 09:04:34 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ED9C061A53
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 06:03:53 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id q13so7769411lfr.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 06:03:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Jj2eDQGHuy7qzHJnRQryFPeK+hpDPld4Zy+qKmjLYg=;
        b=cSLsSTgtH4ObL6Psf4H/qiHGGdLxIE90hsd2BrUZRNyHOmr55hFw/JOP22+POuLqvu
         29P4WmfVsWGY+WAx8csXRneIHQtVZfXwUyET1Q+PGCyzQo8Iu5iVAYGAzeuK3WJg4d5b
         Bij8PhLOEc8qJxPYHf2qDF77om8oP4lliaN+3PAV3D5I7VU77N96xsmBkgES8j8U2VGD
         poZ4BvPGmEOUqdgvL2wSE/BnVdA2qdlv+qqUxCW/ORPpKGsUmLZ8nczuD/5VS3M000E7
         RxLYN17T8xXvVFsryMzwAjsarQ+wW7whXugmjrv9PlrXq3VEjLDSWQ7duspIrWV4OXNH
         Oz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Jj2eDQGHuy7qzHJnRQryFPeK+hpDPld4Zy+qKmjLYg=;
        b=b5dMDM3ZYbCmmlTIzkId+dhTljSA/u6RNpHxejZL4QsGjObPzbng0+btUhNhr5BAFt
         mFcKRC3NMB5j+U6U1k8aQTEr26Za7Nm3sE3qPTRcObWTP1HboBwhlRH4FzrF8OCHbVr2
         kJAD29YHYBRB+w/bTxu7KZLY3RsWYUkAiekJULst1ODfADb4bMiKvHSTnmNtjqpd6m4R
         2vi3ZJgACm2vY2nQfhBjC59AQOKDgT/ufuuvX7W69nqq3Dekl7q5ao1j3rr7VHoBv3Ro
         grRBtBfcg+Ky43dQfXbc4aMTT+DD8ipYq1ydtqenUZwtmJWMRZUfIGIlQ4GCsuPXnsRW
         mYWQ==
X-Gm-Message-State: AOAM531v5P9to1C2+LtL3PB0xXxhfGyHw0qC+Sv4+S//80t39ivwDG9s
        Nb8QAAZ3mpqJnlzNtX7lvMoxaw==
X-Google-Smtp-Source: ABdhPJybAIUvdLw7YCAhtstpl8pS4HLlmij+1gMRU0cbYYGS4+D+Rgzy0+TBfMpASGbs6GJrv66frQ==
X-Received: by 2002:a19:c6d1:: with SMTP id w200mr3350393lff.217.1607090631686;
        Fri, 04 Dec 2020 06:03:51 -0800 (PST)
Received: from localhost.bredbandsbolaget (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id x30sm1773610ljd.108.2020.12.04.06.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 06:03:50 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] regulator: ab8500: Decomission platform data header
Date:   Fri,  4 Dec 2020 15:03:42 +0100
Message-Id: <20201204140342.1640941-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201204140342.1640941-1-linus.walleij@linaro.org>
References: <20201204140342.1640941-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform data header was only used to pass platform
data from board files. We now populate the regulators
exclusively from device tree, so the header contents can
be moved into the regulator drivers.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/regulator/ab8500-ext.c   |  13 ++-
 drivers/regulator/ab8500.c       | 116 ++++++++++++++++++++++-
 include/linux/regulator/ab8500.h | 156 -------------------------------
 3 files changed, 127 insertions(+), 158 deletions(-)
 delete mode 100644 include/linux/regulator/ab8500.h

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

