Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 148292E2BB8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 15:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbgLYOWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 09:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgLYOWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 09:22:12 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBD2C061575
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:21:32 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id n142so4080683qkn.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwDK6kUy3iJw1z1eayVlQOWhTY0qaRdJTbWtRK4aEOA=;
        b=EWOgLDtMEWwyG7iT132r9hC6yohGfVyASe2jl5MZ3ZPuXh4k89wa/4syJQJSl4/m/W
         N8FxqcrgY/yskc37sOcnRCobHAjARA153+HesYmQg/dORCtktnX42/v5VouGvPGXUCQT
         5P/two5QDfRN4QN9xhL7iX/up11WAJXy49bwdqbr6FzQegKmorJhDlEek5MlDnr+kxEY
         Ci0LMcTQVSQk+uUpoVupwG389jLchMGQunK9mcA7WTSNUFWkjFBJqdhkVCiHIBdUV0fN
         7rWi/M6Oholm8D0DKyyXWBycWwLniQi0APeGSdUu2QYhKzi4VtG8OZ+Ad0gp7/otGVAv
         +ivg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwDK6kUy3iJw1z1eayVlQOWhTY0qaRdJTbWtRK4aEOA=;
        b=l6/h39WTEOxjduokHvbpvvlSD8tLV7xJiWW27FmIel06QzWAMTnTlyKYmLWQ6Hw0DD
         kgov5yYoEXB09OEEgnp9Na/qXoyErgRc9JmxBgRz2vE7Mhp1mZhp3kWfqWy//FUukgF2
         vbEk0Z6fTFU/IOhpKwBskI0YZkKCJj89AUw9abDM3zMu2bmb0cLfJK/BAEGYHmJg5Gdr
         oxkbftMEwPSHtf+cS3CI9shYLVQKirG0xCy6j7kd2pknRh8elU83cWNnyN1sGWsDVAkK
         kQEqKIuLMS1mIZHbsw9wLR8sbVUcHACSIRPoLeX43gyQDAJmH54YDxokpVWRAbUfyg+8
         YJWg==
X-Gm-Message-State: AOAM533C9fVtfZclT1gUYX8WqBABoP+g6Q0EVFYZ3qWdnY/L0N5qA2nV
        oHPTednX3BC0sPTsTOoy0sQ=
X-Google-Smtp-Source: ABdhPJyORMHNgUhMgkdI8p0QrG7UgVGeZg47/6Hjlzz9RsI49s/t/sjB+larKf6AfFyGGNcbqbnRUQ==
X-Received: by 2002:a37:9f14:: with SMTP id i20mr35301930qke.321.1608906091350;
        Fri, 25 Dec 2020 06:21:31 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id l191sm18279039qke.7.2020.12.25.06.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 06:21:30 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v3 1/3] drivers/soc/litex: move generic accessors to litex.h
Date:   Fri, 25 Dec 2020 09:21:18 -0500
Message-Id: <20201225142120.2018222-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201225142120.2018222-1-gsomlo@gmail.com>
References: <20201225142120.2018222-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move generic LiteX CSR (MMIO) register accessors to litex.h and
declare them as "static inline", in preparation for supporting
32-bit CSR subregisters and 64-bit CPUs.

NOTE: this is a non-functional change.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/soc/litex/litex_soc_ctrl.c | 73 -----------------------------
 include/linux/litex.h              | 74 ++++++++++++++++++++++++++++--
 2 files changed, 69 insertions(+), 78 deletions(-)

diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index 1217cafdfd4d..65977526d68e 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -16,79 +16,6 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 
-/*
- * LiteX SoC Generator, depending on the configuration, can split a single
- * logical CSR (Control&Status Register) into a series of consecutive physical
- * registers.
- *
- * For example, in the configuration with 8-bit CSR Bus, 32-bit aligned (the
- * default one for 32-bit CPUs) a 32-bit logical CSR will be generated as four
- * 32-bit physical registers, each one containing one byte of meaningful data.
- *
- * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
- *
- * The purpose of `litex_set_reg`/`litex_get_reg` is to implement the logic
- * of writing to/reading from the LiteX CSR in a single place that can be
- * then reused by all LiteX drivers.
- */
-
-/**
- * litex_set_reg() - Writes the value to the LiteX CSR (Control&Status Register)
- * @reg: Address of the CSR
- * @reg_size: The width of the CSR expressed in the number of bytes
- * @val: Value to be written to the CSR
- *
- * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
- * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
- * each one containing one byte of meaningful data.
- *
- * This function splits a single possibly multi-byte write into a series of
- * single-byte writes with a proper offset.
- */
-void litex_set_reg(void __iomem *reg, unsigned long reg_size,
-		    unsigned long val)
-{
-	unsigned long shifted_data, shift, i;
-
-	for (i = 0; i < reg_size; ++i) {
-		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
-		shifted_data = val >> shift;
-
-		WRITE_LITEX_SUBREGISTER(shifted_data, reg, i);
-	}
-}
-EXPORT_SYMBOL_GPL(litex_set_reg);
-
-/**
- * litex_get_reg() - Reads the value of the LiteX CSR (Control&Status Register)
- * @reg: Address of the CSR
- * @reg_size: The width of the CSR expressed in the number of bytes
- *
- * Return: Value read from the CSR
- *
- * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
- * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
- * each one containing one byte of meaningful data.
- *
- * This function generates a series of single-byte reads with a proper offset
- * and joins their results into a single multi-byte value.
- */
-unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_size)
-{
-	unsigned long shifted_data, shift, i;
-	unsigned long result = 0;
-
-	for (i = 0; i < reg_size; ++i) {
-		shifted_data = READ_LITEX_SUBREGISTER(reg, i);
-
-		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
-		result |= (shifted_data << shift);
-	}
-
-	return result;
-}
-EXPORT_SYMBOL_GPL(litex_get_reg);
-
 #define SCRATCH_REG_OFF         0x04
 #define SCRATCH_REG_VALUE       0x12345678
 #define SCRATCH_TEST_VALUE      0xdeadbeef
diff --git a/include/linux/litex.h b/include/linux/litex.h
index 40f5be503593..67c1a18a7425 100644
--- a/include/linux/litex.h
+++ b/include/linux/litex.h
@@ -3,9 +3,6 @@
  * Common LiteX header providing
  * helper functions for accessing CSRs.
  *
- * Implementation of the functions is provided by
- * the LiteX SoC Controller driver.
- *
  * Copyright (C) 2019-2020 Antmicro <www.antmicro.com>
  */
 
@@ -33,9 +30,76 @@
 #define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
 	le32_to_cpu((__le32 __force)readl(base_offset + (LITEX_REG_SIZE * subreg_id)))
 
-void litex_set_reg(void __iomem *reg, unsigned long reg_sz, unsigned long val);
+/*
+ * LiteX SoC Generator, depending on the configuration, can split a single
+ * logical CSR (Control&Status Register) into a series of consecutive physical
+ * registers.
+ *
+ * For example, in the configuration with 8-bit CSR Bus, 32-bit aligned (the
+ * default one for 32-bit CPUs) a 32-bit logical CSR will be generated as four
+ * 32-bit physical registers, each one containing one byte of meaningful data.
+ *
+ * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
+ *
+ * The purpose of `litex_set_reg`/`litex_get_reg` is to implement the logic
+ * of writing to/reading from the LiteX CSR in a single place that can be
+ * then reused by all LiteX drivers.
+ */
+
+/**
+ * litex_set_reg() - Writes the value to the LiteX CSR (Control&Status Register)
+ * @reg: Address of the CSR
+ * @reg_size: The width of the CSR expressed in the number of bytes
+ * @val: Value to be written to the CSR
+ *
+ * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
+ * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
+ * each one containing one byte of meaningful data.
+ *
+ * This function splits a single possibly multi-byte write into a series of
+ * single-byte writes with a proper offset.
+ */
+static inline void litex_set_reg(void __iomem *reg, ulong reg_size, ulong val)
+{
+	ulong shifted_data, shift, i;
+
+	for (i = 0; i < reg_size; ++i) {
+		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
+		shifted_data = val >> shift;
+
+		WRITE_LITEX_SUBREGISTER(shifted_data, reg, i);
+	}
+}
+
+/**
+ * litex_get_reg() - Reads the value of the LiteX CSR (Control&Status Register)
+ * @reg: Address of the CSR
+ * @reg_size: The width of the CSR expressed in the number of bytes
+ *
+ * Return: Value read from the CSR
+ *
+ * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
+ * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
+ * each one containing one byte of meaningful data.
+ *
+ * This function generates a series of single-byte reads with a proper offset
+ * and joins their results into a single multi-byte value.
+ */
+static inline ulong litex_get_reg(void __iomem *reg, ulong reg_size)
+{
+	ulong shifted_data, shift, i;
+	ulong result = 0;
+
+	for (i = 0; i < reg_size; ++i) {
+		shifted_data = READ_LITEX_SUBREGISTER(reg, i);
+
+		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
+		result |= (shifted_data << shift);
+	}
+
+	return result;
+}
 
-unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_sz);
 
 static inline void litex_write8(void __iomem *reg, u8 val)
 {
-- 
2.26.2

