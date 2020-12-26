Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E125D2E2CBB
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 01:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbgLZARo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 19:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729376AbgLZARl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 19:17:41 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5BCC0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 16:17:01 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id 186so4799747qkj.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 16:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bJvxZCqMybv/nofB3mpoddgmIcKenV63BtuFTB/Jak=;
        b=JtRULHNYFM86nQ/Ry++yv6DQzck/4mw0051GJrf3B27cu5AJ7F988y4iacxeKDZaYX
         VByK3cmu1BGjN8e0u5/fmbOxwpTnKO1Uyh37gYbEF8y2avG0EB3RQIPgqo35Pv97WhJL
         aVU5CQmaMMd7ShUBme97STTmdWArA7s9KKc//KVc/nKscplJvkmVQXrec2HGqec2mp+/
         zMyT/9R03Npuhip9INOBJNyrKlE9EkKdPakTzd0/ROWho5LIIdZAxcB6feySJ+1Eqsmq
         pEfEwFRaUsCT4W6l0hs+mteHdr2U05qDmXlTjrXc/H3FO0xwSVgPXp/XsewVRfbDkL/t
         eQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bJvxZCqMybv/nofB3mpoddgmIcKenV63BtuFTB/Jak=;
        b=jQeopqvKZKatj/ZG494FPQ2lMxx5eB9Xxla+rn9AAfrrjYfz65nfxFsTQzVgyZ3DiH
         jjNrMsW6K13w0mLUlGhFnTJ2xz3rt6pn1P4gNjmFeIlMU7LOKq5rwWl0Q6IqCVUYCv+U
         4po3jzrxGx5cXMaKTu0R3gMJqmdFnt50Zw5EHRX5ojqq4i9pRolern4q7C7sgeANXb+C
         wWy5EgAThOEJvH8aFZ5ZINYMfwTk0IvT7k4LGjh7ilCuasEknGzLZB3AuqM40eQUVzgv
         1tPGR3VmWU6WoljStLiN0xhm0lhTwKXmE7HQ3nehm/XUiI/GmY9gls+nBPOpW4jC9Slc
         Rl6A==
X-Gm-Message-State: AOAM531sRhsGxpjHguP5ztQMGNHvElJKIK+uMU+gsTrdtSdzJmGt52q4
        ifHfh6rz4oMeqwMhBPvXN40=
X-Google-Smtp-Source: ABdhPJzIJeqgSIzmRGpVi59dT+wY5SWccMQ8/9tkBrSxoSbYvUU/4WrnfDyI3nzAikqUWBKJTlX2Ow==
X-Received: by 2002:a05:620a:2227:: with SMTP id n7mr34652715qkh.153.1608941819353;
        Fri, 25 Dec 2020 16:16:59 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id h1sm18645425qtr.1.2020.12.25.16.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 16:16:58 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v4 3/3] drivers/soc/litex: support 32-bit subregisters, 64-bit CPUs
Date:   Fri, 25 Dec 2020 19:16:49 -0500
Message-Id: <20201226001649.2061703-4-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201226001649.2061703-1-gsomlo@gmail.com>
References: <20201226001649.2061703-1-gsomlo@gmail.com>
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

The constant LITEX_REG_SIZE is renamed to the more descriptive
LITEX_SUBREG_ALIGN (LiteX CSR subregisters are located at 32-bit
aligned MMIO addresses).

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
 drivers/soc/litex/Kconfig          |  12 +++
 drivers/soc/litex/litex_soc_ctrl.c |   3 +-
 include/linux/litex.h              | 141 ++++++++++++-----------------
 3 files changed, 72 insertions(+), 84 deletions(-)

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
index 918bab45243c..ec969b131f23 100644
--- a/include/linux/litex.h
+++ b/include/linux/litex.h
@@ -10,20 +10,19 @@
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
 
+/* LiteX subregisters of any width are always aligned on a 4-byte boundary */
+#define LITEX_SUBREG_ALIGN	  0x4
+
 static inline void _write_litex_subregister(u32 val, void __iomem *addr)
 {
 	writel((u32 __force)cpu_to_le32(val), addr);
@@ -34,25 +33,32 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
 	return le32_to_cpu((__le32 __force)readl(addr));
 }
 
-#define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
-	_write_litex_subregister(val, (base_offset) + \
-					LITEX_REG_SIZE * (subreg_id))
-
-#define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
-	_read_litex_subregister((base_offset) + \
-					LITEX_REG_SIZE * (subreg_id))
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
@@ -64,22 +70,19 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
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
+	u8 ns, shift, i;
 
-	for (i = 0; i < reg_size; ++i) {
-		shift = ((reg_size - i - 1) * LITEX_SUBREG_SIZE_BIT);
-		shifted_data = val >> shift;
-
-		WRITE_LITEX_SUBREGISTER(shifted_data, reg, i);
+	ns = _litex_num_subregs(reg_size);
+	shift = LITEX_SUBREG_SIZE_BIT * (ns - 1);
+	for (i = 0; i < ns; i++) {
+		_write_litex_subregister(val >> shift, reg);
+		shift -= LITEX_SUBREG_SIZE_BIT;
+		reg += LITEX_SUBREG_ALIGN;
 	}
 }
 
@@ -90,89 +93,61 @@ static inline void litex_set_reg(void __iomem *reg, ulong reg_size, ulong val)
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

