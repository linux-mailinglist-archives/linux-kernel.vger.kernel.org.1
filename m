Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13EC2F373E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405600AbhALRck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:32:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404844AbhALRci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:32:38 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BAD4C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:58 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id w79so2561275qkb.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HaXmvsWiqKXwewQZjXgXAsL5EALP7NYsG1xb4/CRhaw=;
        b=KX3Ml+R473Uro/JwruBSxX84D+rOxT6y+4KXMY52C/99g7ao39cQCWmMDk9NiC2l8k
         e5z+DqfICyJwH7wU11tpU9Dp57o0RkNx7kyJXLU9uMh7/sCTOz3dvjj6bFw1Y/1H79Gt
         kDp3E1vDkG1YwqOIAZfuAkfKGCXXASlRyJiwa70wJDiyP+wQLBjE6Szr0Osk4jF504m+
         oNh71cEVfTfGd59jbTTad7LTnqm0kGcQx6058zEzbHd5jqOT/bL2bSu0oHTE7oFVZEb8
         ZOcPP5LRtAAa4NUMqtWJb7YNvcQpU5zz/ptzxAoBNtSBZSGvbf1tGyKw6G+WDYyrDvjG
         7/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HaXmvsWiqKXwewQZjXgXAsL5EALP7NYsG1xb4/CRhaw=;
        b=rfwhhTpvvA4cfYBI52PIj99BAqiIrS+jBvJnJBaB10qxXb1WnKMSIuC/aEksPPyp0U
         EHEDVNQ20Papu5/EAs6YOhYJtK4zoP/pOUzFx7WmjPfusKwP5k30DUA0V3nKGcL57wUX
         o/0sTQxbUoggNIcnDktsFk+kpSDEMZqmCnNTVoWVYMsTbphzrT9yQEPtaUkfr8raAzm1
         0tNU/OKx30kwLX/Xv24bD/YIsyUz9TqWinf4Cc2nuGBXjNVrX0g8TkcZ6NEo06DI5tqR
         2RvFvNXHtsVVaYXzCFDWM8Gzc3TOFXfuSwtR1msmMs0+GgKmGXHR42AROKE6RhvZVRsr
         d3LQ==
X-Gm-Message-State: AOAM5333urNpqF9FKnroiaz/2nnQX2Y62BGJMGmbQ4OLXvHltttgco8u
        mCwzvIaJld5+qJ4xi6YilL+4nllVSpml5Q==
X-Google-Smtp-Source: ABdhPJwciY1CWEXh7QrTX+0lte0inFZt3TusTS9OMwLnsURV1Em2agqaRMSnV0+w/Y4PhvcIPUBsaA==
X-Received: by 2002:a05:620a:2227:: with SMTP id n7mr358440qkh.153.1610472717247;
        Tue, 12 Jan 2021 09:31:57 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id k7sm1453512qtg.65.2021.01.12.09.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:31:56 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v6 5/5] drivers/soc/litex: make 'litex_[set|get]_reg()' methods private
Date:   Tue, 12 Jan 2021 12:31:44 -0500
Message-Id: <20210112173144.4002594-6-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112173144.4002594-1-gsomlo@gmail.com>
References: <20210112173144.4002594-1-gsomlo@gmail.com>
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

Changes since v5:
	- fixed typo in "caller is responsible..." comments

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
index 3456d527f644..5ea9ccf5cce4 100644
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
+ * NOTE: caller is responsible for ensuring (0 < reg_size <= sizeof(u64)).
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
+ * NOTE: caller is responsible for ensuring (0 < reg_size <= sizeof(u64)).
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

