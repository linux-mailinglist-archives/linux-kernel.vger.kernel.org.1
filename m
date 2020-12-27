Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F192E31C9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 17:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgL0QOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 11:14:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgL0QOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 11:14:08 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9027C061795
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:13:27 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id 2so5545780qtt.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iwDK6kUy3iJw1z1eayVlQOWhTY0qaRdJTbWtRK4aEOA=;
        b=ZbbpwgOvCg08w2irq74uRipdKR7EhOvOsDqzvE4seMRX9YOybRKykzlkXGJQsl6C+B
         hYX90e1Krg0GbTe0q9iLpZ/NQ8rEajgPHtG8UV+zF64CpDepYOIM+cV/v49/n+oF3ZHt
         IQJ3bD3btxfHlCR13rrRFf+OSrFq+MwFHIXZJMJfZEkm9CvzdrXeB7eLArvFZEYBQjuo
         B6EEJNHrqp6ggUHuvM7/lGTe+NKtMw4NakzBOMYMyz4PW1SJB/BOj8UImSa2gpcJ7cRP
         WrP4YwL4mr8f2pW+adrvAH1T1lZyz5AgwtlHnVfRuKu7dDkSFi/sCTXQQqEbDVpTO1F6
         po0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iwDK6kUy3iJw1z1eayVlQOWhTY0qaRdJTbWtRK4aEOA=;
        b=lqz4ckW5GQRBcoggnhZueLCDXPJ04JL+1OyIB/sVsXa38AA7mWx1Qm4hoBRyF/ocFF
         PeuEjGLonLRAeF5U3d1gBixvI+XfvoALBGayEbfNliR70Sc0AjyL7SL9y68GBeFVmyYN
         573AKzb7/iLeDOjp4FPKWDaLMGMzfw45n/Lozvl11LlGSztQQpo76Ve9xwpVcgNlywlq
         ElKtwg4xqG4ssXYiDhqnWbIJdnf5mmqn35xvnb9lg0d2BeodkHgep6yyEMmcM7SYvd/4
         Ami//8ZA0oz7N+izLUASLs98JcU6FwvolhevD4S4O+ZcAqsRvyUqsdp5QUaMAVsXDaTj
         M/6A==
X-Gm-Message-State: AOAM532FNw4+r7Uj4JJIbbOBXHtpjPJYiodIiHQv0DWwG/rvyB8mVQqk
        Drm/sHw57prin3aJipnt82w=
X-Google-Smtp-Source: ABdhPJy2RY8uQGld5ybZCHzvAKMcLnG/HM1XioT3OpBLWxpc2i0aMsO2GgJ8BIRp6Byj71ajvZqK4w==
X-Received: by 2002:ac8:3452:: with SMTP id v18mr41426245qtb.191.1609085607067;
        Sun, 27 Dec 2020 08:13:27 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id h75sm13088873qke.130.2020.12.27.08.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 08:13:26 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v5 1/4] drivers/soc/litex: move generic accessors to litex.h
Date:   Sun, 27 Dec 2020 11:13:17 -0500
Message-Id: <20201227161320.2194830-2-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201227161320.2194830-1-gsomlo@gmail.com>
References: <20201227161320.2194830-1-gsomlo@gmail.com>
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

