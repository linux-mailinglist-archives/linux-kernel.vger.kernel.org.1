Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2969F2F373F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406017AbhALRcp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404494AbhALRch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:32:37 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD014C0617A5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:56 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id n142so2573343qkn.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sx8mlC71KAh/QJK0Pw5GOKGTNdWyzxNJhqo/iDgwXA8=;
        b=O3g98DsGsKPtLAR6oVHKMHn2AHGitG6Ntvbzs1yZcu9+7hbO04f24ue9vDtuQatYVS
         w1EV+GV9Gct6uIc23YQx2TJCIVlt2vAoddR8iguKwJQNpHBHnmKOD1ZTLJ2kC4uofBbc
         RNojPKl+6p1+0g4V/d0CkZiHZoX6CG+O9RHJlMSp4ggZzSnpHUVxCGZSYl/0WBJYrfnf
         5Z8jOSxsXP9qsD6R4KYuGXh20x6HRMn5CXBoqNixs6U1PNdyPqgYWce6nQ+LwjWDkWVE
         Jxs3uafV5Qe48mGrLukKe393IJ2Q/jZy3pVGF76WGruSUND4OOVA8QoQmuijTvkF9URT
         MWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sx8mlC71KAh/QJK0Pw5GOKGTNdWyzxNJhqo/iDgwXA8=;
        b=fW/xootp3giQk/+q+o60961ZUUGXDZRHpTI+RwsI7SRNKiG0N8XCyy0XpeUXQL9/54
         rDWoAJ9ZS83FElApr2ZbCPBLUBaEsQaVnYLfj63ZNTs3G3eYhA64Pyn7sj/jqFp3eFLm
         6hvRKv1JwlQKjoGbtF0n3XTfWx4BBkQ9rRWgUDo2ulr8iqjc2TQA5xVR8Gs+jcnM4kWv
         fcboOArECx383BSpMsOrdrEUHQw6EaC/yPZ08+1ogF7sNc3hmgHiZnzvHFcyP4/CJ3by
         Dk32PneMD5xCIDnmDRt14D8vMBKE8t5n1N4a0IUJZFokTccB891GZDxiGoJ5W9B6Wupk
         uobg==
X-Gm-Message-State: AOAM532yy17KhmmyXBVn4KAKatKpFCkOvqEgcUW0//s4C4At42bxtKva
        jThg8ZMNr/nBk2d6ebpFLZ0=
X-Google-Smtp-Source: ABdhPJys/VJBXY2a4Pxx4saZdlIcKC02X0GqVS2yTS/vI54X6mEHSKfh5T0oMITkRGkl704XtkehMA==
X-Received: by 2002:a37:38e:: with SMTP id 136mr403494qkd.102.1610472715846;
        Tue, 12 Jan 2021 09:31:55 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id k7sm1453512qtg.65.2021.01.12.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:31:55 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v6 4/5] drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
Date:   Tue, 12 Jan 2021 12:31:43 -0500
Message-Id: <20210112173144.4002594-5-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112173144.4002594-1-gsomlo@gmail.com>
References: <20210112173144.4002594-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upstream LiteX now defaults to using 32-bit CSR subregisters
(see https://github.com/enjoy-digital/litex/commit/a2b71fde).

This patch expands on commit 22447a99c97e ("drivers/soc/litex: add
LiteX SoC Controller driver"), adding support for handling both 8-
and 32-bit LiteX CSR (MMIO) subregisters, as determined by the
LITEX_SUBREG_SIZE Kconfig option.

NOTE that while LITEX_SUBREG_SIZE could theoretically be a device
tree property, defining it as a compile-time constant allows for
much better optimization of the resulting code. This is further
supported by the low expected usefulness of deploying the same
kernel across LiteX SoCs built with different CSR-Bus data widths.

Finally, the litex_[read|write][8|16|32|64]() accessors are
redefined in terms of litex_[get|set]_reg(), which, after compiler
optimization, will result in code as efficient as hardcoded shifts,
but with the added benefit of automatically matching the appropriate
LITEX_SUBREG_SIZE.

NOTE that litex_[get|set]_reg() nominally operate on 64-bit data,
but that will also be optimized by the compiler in situations where
narrower data is used from a call site.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---

Changes since v5:
	- split out s/LITEX_REG_SIZE/LITEX_SUBREG_ALIGN/g into separate
	  (cosmetic-only) patch (3/5)
	- fix typo in "Changes since v2" log entry

Changes since v4:
	- tighter, more optimized implementation of 'litex_set_reg()'

Changes since v3:
	- improved legibility, fixed typos in commit blurb
	- fixed instance of "disgusting" commit style :)
	- litex_[get|set]_reg() now using size_t for 'reg_size' argument
	- slightly tighter shift calculation in litex_set_reg()

Changes since v2:
	- more detailed commit blurb
	- eliminate compiler warning caused by shift in litex_set_reg()

Changes since v1:
	- fix typo (s/u32/u64/) in litex_read64().

 drivers/soc/litex/Kconfig          |  12 +++
 drivers/soc/litex/litex_soc_ctrl.c |   3 +-
 include/linux/litex.h              | 135 +++++++++++------------------
 3 files changed, 67 insertions(+), 83 deletions(-)

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
index 65977526d68e..da17ba56b795 100644
--- a/drivers/soc/litex/litex_soc_ctrl.c
+++ b/drivers/soc/litex/litex_soc_ctrl.c
@@ -58,7 +58,8 @@ static int litex_check_csr_access(void __iomem *reg_addr)
 	/* restore original value of the SCRATCH register */
 	litex_write32(reg_addr + SCRATCH_REG_OFF, SCRATCH_REG_VALUE);
 
-	pr_info("LiteX SoC Controller driver initialized");
+	pr_info("LiteX SoC Controller driver initialized: subreg:%d, align:%d",
+		LITEX_SUBREG_SIZE, LITEX_SUBREG_ALIGN);
 
 	return 0;
 }
diff --git a/include/linux/litex.h b/include/linux/litex.h
index c63a7e1a337c..3456d527f644 100644
--- a/include/linux/litex.h
+++ b/include/linux/litex.h
@@ -10,17 +10,14 @@
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
-#define LITEX_SUBREG_SIZE	0x1
+/* LiteX SoCs support 8- or 32-bit CSR Bus data width (i.e., subreg. size) */
+#if defined(CONFIG_LITEX_SUBREG_SIZE) && \
+	(CONFIG_LITEX_SUBREG_SIZE == 1 || CONFIG_LITEX_SUBREG_SIZE == 4)
+#define LITEX_SUBREG_SIZE      CONFIG_LITEX_SUBREG_SIZE
+#else
+#error LiteX subregister size (LITEX_SUBREG_SIZE) must be 4 or 1!
+#endif
 #define LITEX_SUBREG_SIZE_BIT	 (LITEX_SUBREG_SIZE * 8)
 
 /* LiteX subregisters of any width are always aligned on a 4-byte boundary */
@@ -36,25 +33,32 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
 	return le32_to_cpu((__le32 __force)readl(addr));
 }
 
-#define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
-	_write_litex_subregister(val, (base_offset) + \
-					LITEX_SUBREG_ALIGN * (subreg_id))
-
-#define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
-	_read_litex_subregister((base_offset) + \
-					LITEX_SUBREG_ALIGN * (subreg_id))
-
 /*
  * LiteX SoC Generator, depending on the configuration, can split a single
  * logical CSR (Control&Status Register) into a series of consecutive physical
  * registers.
  *
- * For example, in the configuration with 8-bit CSR Bus, 32-bit aligned (the
- * default one for 32-bit CPUs) a 32-bit logical CSR will be generated as four
- * 32-bit physical registers, each one containing one byte of meaningful data.
+ * For example, in the configuration with 8-bit CSR Bus, a 32-bit aligned,
+ * 32-bit wide logical CSR will be laid out as four 32-bit physical
+ * subregisters, each one containing one byte of meaningful data.
  *
  * For details see: https://github.com/enjoy-digital/litex/wiki/CSR-Bus
- *
+ */
+
+/* number of LiteX subregisters needed to store a register of given reg_size */
+#define _litex_num_subregs(reg_size) \
+	(((reg_size) - 1) / LITEX_SUBREG_SIZE + 1)
+
+/*
+ * since the number of 4-byte aligned subregisters required to store a single
+ * LiteX CSR (MMIO) register varies with LITEX_SUBREG_SIZE, the offset of the
+ * next adjacent LiteX CSR register w.r.t. the offset of the current one also
+ * depends on how many subregisters the latter is spread across
+ */
+#define _next_reg_off(off, size) \
+	((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)
+
+/*
  * The purpose of `litex_set_reg`/`litex_get_reg` is to implement the logic
  * of writing to/reading from the LiteX CSR in a single place that can be
  * then reused by all LiteX drivers.
@@ -66,22 +70,17 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
  * @reg_size: The width of the CSR expressed in the number of bytes
  * @val: Value to be written to the CSR
  *
- * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
- * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
- * each one containing one byte of meaningful data.
- *
- * This function splits a single possibly multi-byte write into a series of
- * single-byte writes with a proper offset.
+ * This function splits a single (possibly multi-byte) LiteX CSR write into
+ * a series of subregister writes with a proper offset.
  */
-static inline void litex_set_reg(void __iomem *reg, ulong reg_size, ulong val)
+static inline void litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
 {
-	ulong shifted_data, shift, i;
+	u8 shift = _litex_num_subregs(reg_size) * LITEX_SUBREG_SIZE_BIT;
 
-	for (i = 0; i < reg_size; ++i) {
-		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
-		shifted_data = val >> shift;
-
-		WRITE_LITEX_SUBREGISTER(shifted_data, reg, i);
+	while (shift > 0) {
+		shift -= LITEX_SUBREG_SIZE_BIT;
+		_write_litex_subregister(val >> shift, reg);
+		reg += LITEX_SUBREG_ALIGN;
 	}
 }
 
@@ -92,89 +91,61 @@ static inline void litex_set_reg(void __iomem *reg, ulong reg_size, ulong val)
  *
  * Return: Value read from the CSR
  *
- * In the currently supported LiteX configuration (8-bit CSR Bus, 32-bit aligned),
- * a 32-bit LiteX CSR is generated as 4 consecutive 32-bit physical registers,
- * each one containing one byte of meaningful data.
- *
- * This function generates a series of single-byte reads with a proper offset
- * and joins their results into a single multi-byte value.
+ * This function generates a series of subregister reads with a proper offset
+ * and joins their results into a single (possibly multi-byte) LiteX CSR value.
  */
-static inline ulong litex_get_reg(void __iomem *reg, ulong reg_size)
+static inline u64 litex_get_reg(void __iomem *reg, size_t reg_size)
 {
-	ulong shifted_data, shift, i;
-	ulong result = 0;
+	u64 r;
+	u8 i;
 
-	for (i = 0; i < reg_size; ++i) {
-		shifted_data = READ_LITEX_SUBREGISTER(reg, i);
-
-		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
-		result |= (shifted_data << shift);
+	r = _read_litex_subregister(reg);
+	for (i = 1; i < _litex_num_subregs(reg_size); i++) {
+		r <<= LITEX_SUBREG_SIZE_BIT;
+		reg += LITEX_SUBREG_ALIGN;
+		r |= _read_litex_subregister(reg);
 	}
-
-	return result;
+	return r;
 }
 
-
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
+	litex_set_reg(reg, sizeof(u64), val);
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
+	return litex_get_reg(reg, sizeof(u64));
 }
 
 #endif /* _LINUX_LITEX_H */
-- 
2.26.2

