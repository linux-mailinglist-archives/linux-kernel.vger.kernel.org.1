Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E302F3740
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406068AbhALRcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404475AbhALRcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:32:35 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5FAC0617A4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:55 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id z11so2551535qkj.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xx4UnsmOmtCccNq/1/18LUEl/1+7nvTRczXg60RxYbI=;
        b=i8nBi27wjia8uU2Lq+zGIO96CUc3cvUDV+YNrFTDuGSKwdUhQiOsN2jkOrNbBPNjHm
         jiCreenkKAV7T+TXQ/T5ZOEz5TDBsxr5Mo12+OyKmBUCp/9iWpqy7vdwY7uhYeOZ08/U
         Ye6W27LYwBpke+kiSgEP/9g7ObsBoNIjgGv1Vr2MDBKaq8GLmoueDBXL6D+EL6ceFhr1
         weOw5r2y66JXfKzYX1IlR3Glokw7SbvBDB108P/JLiaO5vtCz+iwGegPip1IwuOGqF7U
         TdlTECVkUCrEgq7mV1CWk9u+JMszHykRJ2d/K+Rh/chJAOS0mS+/ZoRKpeJL8JDt2PoE
         La6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xx4UnsmOmtCccNq/1/18LUEl/1+7nvTRczXg60RxYbI=;
        b=kMN9k0NSQT/0WyawXI0LiOIEWn8XgSBsQNQdAk4LqqCYAqzXFZv2cJ1OhX4paOUpcn
         cemQYwlDO63SWsPkomqVfmJfrRS6IDB/AVSwggKuL2H9sDr8pVKWMmHZPl8wUav005G+
         eDTwk4Os0wxyAn/ARKi1jbp9SjmS8vOgdzu1Z/E1L9LEPAFuMtawZgamPzN/G97c+xtE
         Dy4nYhRFoAkgPt1AK+XOqWn0YOCZxya5fBxhvgQ+GwGOSXkIC7SsFEtiRuyhR0UtfrlS
         pSeHW0sPNwVwmFx5ltzgTDF/hWQJsSqQc/VF67do/Af/ly9eKZYS5AKKh34C/eco19+F
         mkBw==
X-Gm-Message-State: AOAM531IZcXL303yj9P+JPA/ek+k1rfkia5jlF81hfIF/ujWAaItW8TP
        M5dj9pY3xbZsboVR/GEykdM=
X-Google-Smtp-Source: ABdhPJz57+dXd+NcfUrGsL+kcJdAWg7m45lJAyb54Xi3zoDvywwcpJdFs1OxDB9qSoQnom0FlV+U4A==
X-Received: by 2002:a05:620a:88d:: with SMTP id b13mr365255qka.133.1610472714688;
        Tue, 12 Jan 2021 09:31:54 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id k7sm1453512qtg.65.2021.01.12.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:31:53 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v6 3/5] drivers/soc/litex: s/LITEX_REG_SIZE/LITEX_SUBREG_ALIGN/g
Date:   Tue, 12 Jan 2021 12:31:42 -0500
Message-Id: <20210112173144.4002594-4-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112173144.4002594-1-gsomlo@gmail.com>
References: <20210112173144.4002594-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The constant LITEX_REG_SIZE is renamed to the more descriptive
LITEX_SUBREG_ALIGN (LiteX CSR subregisters are located at 32-bit
aligned MMIO addresses).

NOTE: this is a non-functional change.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 include/linux/litex.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/litex.h b/include/linux/litex.h
index 918bab45243c..c63a7e1a337c 100644
--- a/include/linux/litex.h
+++ b/include/linux/litex.h
@@ -20,10 +20,12 @@
  * Supporting other configurations will require extending the logic in this
  * header and in the LiteX SoC controller driver.
  */
-#define LITEX_REG_SIZE	  0x4
 #define LITEX_SUBREG_SIZE	0x1
 #define LITEX_SUBREG_SIZE_BIT	 (LITEX_SUBREG_SIZE * 8)
 
+/* LiteX subregisters of any width are always aligned on a 4-byte boundary */
+#define LITEX_SUBREG_ALIGN	  0x4
+
 static inline void _write_litex_subregister(u32 val, void __iomem *addr)
 {
 	writel((u32 __force)cpu_to_le32(val), addr);
@@ -36,11 +38,11 @@ static inline u32 _read_litex_subregister(void __iomem *addr)
 
 #define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
 	_write_litex_subregister(val, (base_offset) + \
-					LITEX_REG_SIZE * (subreg_id))
+					LITEX_SUBREG_ALIGN * (subreg_id))
 
 #define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
 	_read_litex_subregister((base_offset) + \
-					LITEX_REG_SIZE * (subreg_id))
+					LITEX_SUBREG_ALIGN * (subreg_id))
 
 /*
  * LiteX SoC Generator, depending on the configuration, can split a single
-- 
2.26.2

