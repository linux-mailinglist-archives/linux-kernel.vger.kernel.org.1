Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B872E1001
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgLVWFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:05:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgLVWFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:05:32 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDC3C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 14:04:52 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id 22so13332906qkf.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 14:04:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=U7tr99rdG2wCwNMofGKsE5kJTVdLy0LV/f8vlmxtxnA=;
        b=gCS/bCrDLi9H+2g1tRd6VrJqid4foNv969yqaMq83Vb4d5x3lGHakfTPrm0yPf+yG1
         A122HQM9NE6l0olY1FaOL/GxjZ7Z8dSeGrwPiOYhWApEhmw9gvNDADzj8fAyTVw/cyZE
         PuhVj1T4WZFj7LwqXRsLw8be9Or0K34YSg0s3pvoxuaNVRTHaEbBKuhYN4YcFUxFl+xT
         wPOXQqRm9T24/8kgMAw+Z4MJTs/9gY5n8PlM+Wp2CIRz5goNw+0LpjUEW7n+aKKBLpSd
         OhmCkFql/qwxrwlRonxMyXZQ071Z3C2MMIE+a1e/ssMuXkU9rLtSnrf6AEyZx+wMo/+w
         lDEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U7tr99rdG2wCwNMofGKsE5kJTVdLy0LV/f8vlmxtxnA=;
        b=K7DQ3alejSsnefkz18rgSGZVvWFZrFuiyjQw5oXv2/XiL7/dvadpFgj+6ghq5GYgpy
         aKzqHpa1vIZ4ASyDLDFS1c/TDYmjn1l+YhP5a6TQqEdOdXKiySaBiwNT7uNMSADp3X85
         7vb+U+7RztK3UG/z6+kTsBjvB8g7QEoBKdYfND//0NNFsdMX1ag18dkKoGqICImtJutv
         OOsfXZX+WNsLVOiHuj0NTyl5TLESRbjY94Lb8nTNKYk0rh5fOIVeFiprRL9OdHKqEZkS
         d34tOZ4sr2W+pIaIaX4sQHGWm/FuxzMVv0v05AV6+TiEyKr16B2b0Va4dFjGzO4mo6gv
         cI+g==
X-Gm-Message-State: AOAM532DCWuI1vzOvpxfvb8DBKdcMn+xBT4Tckz/SuuNLXj9vqFN0FAD
        rcY/kdOBqiSfekL2nRmOVrc=
X-Google-Smtp-Source: ABdhPJyPXKg45FJdhKgMCW1LNHBOObPM4+ghareV+mmepSZ8bw7j1XmxabW0AeJ0oHLD17eeK4Awbw==
X-Received: by 2002:a05:620a:4047:: with SMTP id i7mr23860051qko.3.1608674691577;
        Tue, 22 Dec 2020 14:04:51 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id p13sm1589442qkg.80.2020.12.22.14.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 14:04:50 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v2] drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
Date:   Tue, 22 Dec 2020 17:04:46 -0500
Message-Id: <20201222220446.1827126-1-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201222144826.1775064-1-gsomlo@gmail.com>
References: <20201222144826.1775064-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upstream LiteX project now defaults to using 32-bit subregisters
(see https://github.com/enjoy-digital/litex/commit/a2b71fde).

This patch expands on commit 22447a99c97e, adding support for handling
both 8 and 32 bit LiteX CSR (MMIO) subregisters, as controlled by the
LITEX_SUBREG_SIZE Kconfig option.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---

Notes v2:
	- fix typo (s/u32/u64/) in litex_read64().

Notes v1:
        - LITEX_SUBREG_SIZE now provided by Kconfig.
        - it's not LITEX_REG_SIZE, but rather LITEX_SUBREG_ALIGN!
        - move litex_[get|set]_reg() to include/linux/litex.h and mark
          them as "static inline";
        - redo litex_[read|write][8|16|32|64]() using litex_[get|set]_reg()
          (compiler should produce code as efficient as hardcoded shifts,
           but also automatically matching LITEX_SUBREG_SIZE).

 drivers/soc/litex/Kconfig          |  12 ++
 drivers/soc/litex/litex_soc_ctrl.c |  76 +-----------
 include/linux/litex.h              | 179 +++++++++++++++++++++--------
 3 files changed, 143 insertions(+), 124 deletions(-)

diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
index 7c6b009b6f6c..973f8d2fe1a7 100644
--- a/drivers/soc/litex/Kconfig
+++ b/drivers/soc/litex/Kconfig
@@ -16,4 +16,16 @@ config LITEX_SOC_CONTROLLER
 	  All drivers that use functions from litex.h must depend on
 	  LITEX.
 
+config LITEX_SUBREG_SIZE
+	int "Size of a LiteX CSR subregister, in bytes"
+	depends on LITEX
+	range 1 4
+	default 4
+	help
+	LiteX MMIO registers (referred to as Configuration and Status
+	registers, or CSRs) are spread across adjacent 8- or 32-bit
+	subregisters, located at 32-bit aligned MMIO addresses. Use
+	this to select the appropriate size (1 or 4 bytes) matching
+	your particular LiteX build.
+
 endmenu
diff --git a/drivers/soc/litex/litex_soc_ctrl.c b/drivers/soc/litex/litex_soc_ctrl.c
index 1217cafdfd4d..da17ba56b795 100644
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
@@ -131,7 +58,8 @@ static int litex_check_csr_access(void __iomem *reg_addr)
 	/* restore original value of the SCRATCH register */
 	litex_write32(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_VALUE);
 
-	pr_info("LiteX SoC Controller driver initialized");
+	pr_info("LiteX SoC Controller driver initialized: subreg:%d, align:%d",
+		LITEX_SUBREG_SIZE, LITEX_SUBREG_ALIGN);
 
 	return 0;
 }
diff --git a/include/linux/litex.h b/include/linux/litex.h
index 40f5be503593..71f8110ed98d 100644
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
 
@@ -13,90 +10,172 @@
 #define _LINUX_LITEX_H
 
 #include <linux/io.h>
-#include <linux/types.h>
-#include <linux/compiler_types.h>
 
-/*
- * The parameters below are true for LiteX SoCs configured for 8-bit CSR Bus,
- * 32-bit aligned.
- *
- * Supporting other configurations will require extending the logic in this
- * header and in the LiteX SoC controller driver.
- */
-#define LITEX_REG_SIZE	  0x4
-#define LITEX_SUBREG_SIZE	0x1
+/* LiteX SoCs support 8- or 32-bit CSR Bus data width (i.e., subreg. size) */
+#if defined(CONFIG_LITEX_SUBREG_SIZE) && \
+	(CONFIG_LITEX_SUBREG_SIZE == 1 || CONFIG_LITEX_SUBREG_SIZE == 4)
+#define LITEX_SUBREG_SIZE      CONFIG_LITEX_SUBREG_SIZE
+#else
+#error LiteX subregister size (LITEX_SUBREG_SIZE) must be 4 or 1!
+#endif
 #define LITEX_SUBREG_SIZE_BIT	 (LITEX_SUBREG_SIZE * 8)
 
-#define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
-	writel((u32 __force)cpu_to_le32(val), base_offset + (LITEX_REG_SIZE * subreg_id))
+/* LiteX subregisters of any width are always aligned on a 4-byte boundary */
+#define LITEX_SUBREG_ALIGN	  0x4
 
-#define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
-	le32_to_cpu((__le32 __force)readl(base_offset + (LITEX_REG_SIZE * subreg_id)))
+static inline void _write_litex_subregister(u32 val, void __iomem *addr)
+{
+	writel((u32 __force)cpu_to_le32(val), addr);
+}
 
-void litex_set_reg(void __iomem *reg, unsigned long reg_sz, unsigned long val);
+static inline u32 _read_litex_subregister(void __iomem *addr)
+{
+	return le32_to_cpu((__le32 __force)readl(addr));
+}
 
-unsigned long litex_get_reg(void __iomem *reg, unsigned long reg_sz);
+#define _WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
+	_write_litex_subregister(val, (base_offset) + \
+					LITEX_SUBREG_ALIGN * (subreg_id))
+
+#define _READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
+	_read_litex_subregister((base_offset) + \
+					LITEX_SUBREG_ALIGN * (subreg_id))
+
+/*
+ * LiteX SoC Generator, depending on the configuration, can split a single
+ * logical CSR (Control&Status Register) into a series of consecutive physical
+ * registers.
+ *
+ * For example, in the configuration with 8-bit CSR Bus, 32-bit aligned
+ * a 32-bit logical CSR will be generated as four 32-bit physical registers,
+ * each one containing one byte of meaningful data.
+ *
+ * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
+ */
+
+/* number of LiteX subregisters needed to store a register of given reg_size */
+#define _litex_num_subregs(reg_size) \
+	(((reg_size) - 1) / LITEX_SUBREG_SIZE + 1)
+
+/* since the number of 4-byte aligned subregisters required to store a single
+ * LiteX CSR (MMIO) register varies with LITEX_SUBREG_SIZE, the offset of the
+ * next adjacent LiteX CSR register w.r.t. the offset of the current one also
+ * depends on how many subregisters the latter is spread across
+ */
+#define _next_reg_off(off, size) \
+	((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)
+
+/*
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
+ * This function splits a single (possibly multi-byte) LiteX CSR write into
+ * a series of subregister writes with a proper offset.
+ */
+static inline void litex_set_reg(void __iomem *reg, ulong reg_size, ulong val)
+{
+	u8 ns, shift, i;
+
+	ns = _litex_num_subregs(reg_size);
+	for (i = 0; i < ns; i++) {
+		shift = LITEX_SUBREG_SIZE_BIT * (ns - 1 - i);
+		_write_litex_subregister(val >> shift, reg);
+		reg += LITEX_SUBREG_ALIGN;
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
+ * This function generates a series of subregister reads with a proper offset
+ * and joins their results into a single (possibly multi-byte) LiteX CSR value.
+ */
+static inline ulong litex_get_reg(void __iomem *reg, ulong reg_size)
+{
+	ulong r;
+	u8 i;
+
+	r = _read_litex_subregister(reg);
+	for (i = 1; i < _litex_num_subregs(reg_size); i++) {
+		r <<= LITEX_SUBREG_SIZE_BIT;
+		reg += LITEX_SUBREG_ALIGN;
+		r |= _read_litex_subregister(reg);
+	}
+	return r;
+}
 
 static inline void litex_write8(void __iomem *reg, u8 val)
 {
-	WRITE_LITEX_SUBREGISTER(val, reg, 0);
+	litex_set_reg(reg, sizeof(u8), val);
 }
 
 static inline void litex_write16(void __iomem *reg, u16 val)
 {
-	WRITE_LITEX_SUBREGISTER(val >> 8, reg, 0);
-	WRITE_LITEX_SUBREGISTER(val, reg, 1);
+	litex_set_reg(reg, sizeof(u16), val);
 }
 
 static inline void litex_write32(void __iomem *reg, u32 val)
 {
-	WRITE_LITEX_SUBREGISTER(val >> 24, reg, 0);
-	WRITE_LITEX_SUBREGISTER(val >> 16, reg, 1);
-	WRITE_LITEX_SUBREGISTER(val >> 8, reg, 2);
-	WRITE_LITEX_SUBREGISTER(val, reg, 3);
+	litex_set_reg(reg, sizeof(u32), val);
 }
 
 static inline void litex_write64(void __iomem *reg, u64 val)
 {
-	WRITE_LITEX_SUBREGISTER(val >> 56, reg, 0);
-	WRITE_LITEX_SUBREGISTER(val >> 48, reg, 1);
-	WRITE_LITEX_SUBREGISTER(val >> 40, reg, 2);
-	WRITE_LITEX_SUBREGISTER(val >> 32, reg, 3);
-	WRITE_LITEX_SUBREGISTER(val >> 24, reg, 4);
-	WRITE_LITEX_SUBREGISTER(val >> 16, reg, 5);
-	WRITE_LITEX_SUBREGISTER(val >> 8, reg, 6);
-	WRITE_LITEX_SUBREGISTER(val, reg, 7);
+#ifdef CONFIG_64BIT
+	litex_set_reg(reg, sizeof(u64), val);
+#else
+	_WRITE_LITEX_SUBREGISTER(val >> 56, reg, 0);
+	_WRITE_LITEX_SUBREGISTER(val >> 48, reg, 1);
+	_WRITE_LITEX_SUBREGISTER(val >> 40, reg, 2);
+	_WRITE_LITEX_SUBREGISTER(val >> 32, reg, 3);
+	_WRITE_LITEX_SUBREGISTER(val >> 24, reg, 4);
+	_WRITE_LITEX_SUBREGISTER(val >> 16, reg, 5);
+	_WRITE_LITEX_SUBREGISTER(val >> 8, reg, 6);
+	_WRITE_LITEX_SUBREGISTER(val, reg, 7);
+#endif
 }
 
 static inline u8 litex_read8(void __iomem *reg)
 {
-	return READ_LITEX_SUBREGISTER(reg, 0);
+	return litex_get_reg(reg, sizeof(u8));
 }
 
 static inline u16 litex_read16(void __iomem *reg)
 {
-	return (READ_LITEX_SUBREGISTER(reg, 0) << 8)
-		| (READ_LITEX_SUBREGISTER(reg, 1));
+	return litex_get_reg(reg, sizeof(u16));
 }
 
 static inline u32 litex_read32(void __iomem *reg)
 {
-	return (READ_LITEX_SUBREGISTER(reg, 0) << 24)
-		| (READ_LITEX_SUBREGISTER(reg, 1) << 16)
-		| (READ_LITEX_SUBREGISTER(reg, 2) << 8)
-		| (READ_LITEX_SUBREGISTER(reg, 3));
+	return litex_get_reg(reg, sizeof(u32));
 }
 
 static inline u64 litex_read64(void __iomem *reg)
 {
-	return ((u64)READ_LITEX_SUBREGISTER(reg, 0) << 56)
-		| ((u64)READ_LITEX_SUBREGISTER(reg, 1) << 48)
-		| ((u64)READ_LITEX_SUBREGISTER(reg, 2) << 40)
-		| ((u64)READ_LITEX_SUBREGISTER(reg, 3) << 32)
-		| ((u64)READ_LITEX_SUBREGISTER(reg, 4) << 24)
-		| ((u64)READ_LITEX_SUBREGISTER(reg, 5) << 16)
-		| ((u64)READ_LITEX_SUBREGISTER(reg, 6) << 8)
-		| ((u64)READ_LITEX_SUBREGISTER(reg, 7));
+#ifdef CONFIG_64BIT
+	return litex_get_reg(reg, sizeof(u64));
+#else
+	return ((u64)_READ_LITEX_SUBREGISTER(reg, 0) << 56)
+		| ((u64)_READ_LITEX_SUBREGISTER(reg, 1) << 48)
+		| ((u64)_READ_LITEX_SUBREGISTER(reg, 2) << 40)
+		| ((u64)_READ_LITEX_SUBREGISTER(reg, 3) << 32)
+		| ((u64)_READ_LITEX_SUBREGISTER(reg, 4) << 24)
+		| ((u64)_READ_LITEX_SUBREGISTER(reg, 5) << 16)
+		| ((u64)_READ_LITEX_SUBREGISTER(reg, 6) << 8)
+		| ((u64)_READ_LITEX_SUBREGISTER(reg, 7));
+#endif
 }
 
 #endif /* _LINUX_LITEX_H */
-- 
2.26.2

