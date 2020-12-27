Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56F22E31CB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 17:14:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgL0QON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 11:14:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgL0QOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 11:14:11 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B672C061799
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:13:31 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id y15so5564614qtv.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sRLUvKcgZPUB9kWrNCnYaSJMoH9aFxbeyUO+3Lc9ErE=;
        b=gFFgT8VveIQk+eYhYpRkoEptOeNBvMXqVbZS9VQYLcgMpab7bcxBuDBjwZ+mlaaDkl
         V8F9XiZAMvhoH/FzpE2mzRO+P+2OP/jUuk6N2NKnOQehQ3da6jmGLWErmikIAEjKd+bP
         /88r3f1ACa1XupqXxO/vRTzQb4aqqIdKdGAaZnNjRgXemCxtwJDdmFASZMok+0xlsBfI
         Cfrd+mAX5V3sXI95pA4+eNyZaO8gVyhBbpfl5RbKUAjpITwBhtLEwgRHkKXedPIpXmLV
         VHmFuzv/4s6JsKlS6oXosPfxnFk78Wb0VY9uY7dDcwXSsiYpZMSlDrpzoEnAtcgwNJol
         Gi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sRLUvKcgZPUB9kWrNCnYaSJMoH9aFxbeyUO+3Lc9ErE=;
        b=sEQsDwicaC7TaaHVcQKCXGds084x51N1iHCEi0Kp+qgGDLlUyUqVYsoTXyfWLCv9VN
         hDS8u4SdZ6mLtCD/ABI15HE3GKqpJHyTWiKsfyWMr1HoksSRb1E4Ek5yyVksc8WL/mJ1
         jvrio0iU+o2/4aQRGbBeBn3yHTGu1r/lRnosqcbczlVYCVcf393W1PA4enp1uiP/ERHj
         jd9DAy9eugEMB7huPvx6j/0Fgc0cFWlzYg2RPpOjqRl/9A5gYayZUoIhtu6vzt3BEO6x
         wOkaO76TZwkEAkp/eP3OcX0lgFua6FxsH7S8RwsaO18Sjm/BTRUJmbXT55FKFXGo9abO
         TE7w==
X-Gm-Message-State: AOAM533cELgBOy4dteJniS7MmH4lhlosSV6vHH9DQOeszXRSlDLtKrtm
        ghRZGZORUNTvlTB7UISx7Qc=
X-Google-Smtp-Source: ABdhPJw0pLIqIVFL2MvQMFtyEPhkAfwl7MGaXGWf7fvjvMl1ndWcK1ZrPkUhvgKfTYOM+/WcViqR3g==
X-Received: by 2002:ac8:5441:: with SMTP id d1mr41667421qtq.384.1609085610632;
        Sun, 27 Dec 2020 08:13:30 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id h75sm13088873qke.130.2020.12.27.08.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 08:13:30 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v5 4/4] drivers/soc/litex: make 'litex_[set|get]_reg()' methods private
Date:   Sun, 27 Dec 2020 11:13:20 -0500
Message-Id: <20201227161320.2194830-5-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201227161320.2194830-1-gsomlo@gmail.com>
References: <20201227161320.2194830-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'litex_[set|get]_reg()' methods use the 'reg_size' parameter to
specify the width of the LiteX CSR (MMIO) register being accessed.

Since 'u64' is the widest data being supported, the value of 'reg_size'
MUST be between 1 and sizeof(u64), which SHOULD be checked at runtime
if these methods are publicly available for use by other LiteX device
drivers.

At the same time, none of the existing (or foreseeable) LiteX device
drivers have a need to access registers whose size is unknown during
compilation. As such, all LiteX device drivers should use fixed-width
accessor methods such as 'litex_[write|read][8|16|32|64]()'.

This patch renames 'litex_[set|get]_reg()' to '_litex_[set|get]_reg()',
indicating that they should NOT be directly called from outside of
the 'include/linux/litex.h' header file.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/soc/litex/Kconfig |  2 +-
 include/linux/litex.h     | 35 ++++++++++++++++++++---------------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/litex/Kconfig b/drivers/soc/litex/Kconfig
index 973f8d2fe1a7..b9b3d51ea7df 100644
--- a/drivers/soc/litex/Kconfig
+++ b/drivers/soc/litex/Kconfig
@@ -11,7 +11,7 @@ config LITEX_SOC_CONTROLLER
 	select LITEX
 	help
 	  This option enables the SoC Controller Driver which verifies
-	  LiteX CSR access and provides common litex_get_reg/litex_set_reg
+	  LiteX CSR access and provides common litex_[read|write]*
 	  accessors.
 	  All drivers that use functions from litex.h must depend on
 	  LITEX.
diff --git a/include/linux/litex.h b/include/linux/litex.h
index 3456d527f644..14748fa86a99 100644
--- a/include/linux/litex.h
+++ b/include/linux/litex.h
@@ -59,21 +59,25 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
 	((off) + _litex_num_subregs(size) * LITEX_SUBREG_ALIGN)
 
 /*
- * The purpose of `litex_set_reg`/`litex_get_reg` is to implement the logic
- * of writing to/reading from the LiteX CSR in a single place that can be
- * then reused by all LiteX drivers.
+ * The purpose of `_litex_[set|get]_reg()` is to implement the logic of
+ * writing to/reading from the LiteX CSR in a single place that can be then
+ * reused by all LiteX drivers via the `litex_[write|read][8|16|32|64]()`
+ * accessors for the appropriate data width.
+ * NOTE: direct use of `_litex_[set|get]_reg()` by LiteX drivers is strongly
+ * discouraged, as they perform no error checking on the requested data width!
  */
 
 /**
- * litex_set_reg() - Writes the value to the LiteX CSR (Control&Status Register)
+ * _litex_set_reg() - Writes a value to the LiteX CSR (Control&Status Register)
  * @reg: Address of the CSR
  * @reg_size: The width of the CSR expressed in the number of bytes
  * @val: Value to be written to the CSR
  *
  * This function splits a single (possibly multi-byte) LiteX CSR write into
  * a series of subregister writes with a proper offset.
+ * NOTE: caller is responsible for ensuring (0 < reg_size < sizeof(u64)).
  */
-static inline void litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
+static inline void _litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
 {
 	u8 shift = _litex_num_subregs(reg_size) * LITEX_SUBREG_SIZE_BIT;
 
@@ -85,7 +89,7 @@ static inline void litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
 }
 
 /**
- * litex_get_reg() - Reads the value of the LiteX CSR (Control&Status Register)
+ * _litex_get_reg() - Reads a value of the LiteX CSR (Control&Status Register)
  * @reg: Address of the CSR
  * @reg_size: The width of the CSR expressed in the number of bytes
  *
@@ -93,8 +97,9 @@ static inline void litex_set_reg(void __iomem *reg, size_t reg_size, u64 val)
  *
  * This function generates a series of subregister reads with a proper offset
  * and joins their results into a single (possibly multi-byte) LiteX CSR value.
+ * NOTE: caller is responsible for ensuring (0 < reg_size < sizeof(u64)).
  */
-static inline u64 litex_get_reg(void __iomem *reg, size_t reg_size)
+static inline u64 _litex_get_reg(void __iomem *reg, size_t reg_size)
 {
 	u64 r;
 	u8 i;
@@ -110,42 +115,42 @@ static inline u64 litex_get_reg(void __iomem *reg, size_t reg_size)
 
 static inline void litex_write8(void __iomem *reg, u8 val)
 {
-	litex_set_reg(reg, sizeof(u8), val);
+	_litex_set_reg(reg, sizeof(u8), val);
 }
 
 static inline void litex_write16(void __iomem *reg, u16 val)
 {
-	litex_set_reg(reg, sizeof(u16), val);
+	_litex_set_reg(reg, sizeof(u16), val);
 }
 
 static inline void litex_write32(void __iomem *reg, u32 val)
 {
-	litex_set_reg(reg, sizeof(u32), val);
+	_litex_set_reg(reg, sizeof(u32), val);
 }
 
 static inline void litex_write64(void __iomem *reg, u64 val)
 {
-	litex_set_reg(reg, sizeof(u64), val);
+	_litex_set_reg(reg, sizeof(u64), val);
 }
 
 static inline u8 litex_read8(void __iomem *reg)
 {
-	return litex_get_reg(reg, sizeof(u8));
+	return _litex_get_reg(reg, sizeof(u8));
 }
 
 static inline u16 litex_read16(void __iomem *reg)
 {
-	return litex_get_reg(reg, sizeof(u16));
+	return _litex_get_reg(reg, sizeof(u16));
 }
 
 static inline u32 litex_read32(void __iomem *reg)
 {
-	return litex_get_reg(reg, sizeof(u32));
+	return _litex_get_reg(reg, sizeof(u32));
 }
 
 static inline u64 litex_read64(void __iomem *reg)
 {
-	return litex_get_reg(reg, sizeof(u64));
+	return _litex_get_reg(reg, sizeof(u64));
 }
 
 #endif /* _LINUX_LITEX_H */
-- 
2.26.2

