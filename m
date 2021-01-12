Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E742F373D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405135AbhALRci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404410AbhALRce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:32:34 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E252EC06179F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:53 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id r9so2059003qtp.11
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 09:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzbAt/uZBSjzSRu1F6Prd22rr5NufKkQ/G1C6Jc0wdM=;
        b=WjrxO/EJ3S+fngjvQeVP4T16Ee02tdcwpRsu2U8MIxIRLdcaLhx4zT8mNGA+D/O7xd
         /DV6En4wCalKG2eVe2EqD1+8snIDFCTeJ+dX4dJ3Zj2P6uGrQ4nSUYCccOFNxrhrunmB
         VBF71qJzCI3uOW8hwazv0eBus5odFEbU1j0k2lY7ltyNCeOJi04DwrjJTRoQYGxiCb6G
         iSVyCmQh02ylcCBh6gOcEJ/OHEAsjprXC/ArlDQcrOS9kM5rzdMN2hcVNJxFpfWFLLoB
         iYJwhkffDXT4a9iWNVXVg2n591613N/q6BdvSf8zs4QYYfx6vL7ibXhitjWhqiEOaU3X
         8pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzbAt/uZBSjzSRu1F6Prd22rr5NufKkQ/G1C6Jc0wdM=;
        b=ju/lu1LMlKN/hriAJls2q6Y1331m5LHxk9xj+bdtmBEdzzRVle+UYBc3j1VOoFcsHh
         +K5eO2EiUlsla38Rjt1cQaISWDclyvK31k+CFF99BYvI/tRun2z5l81nqJxJJ+MLZNj8
         jAVy+N+fNl7hHc4xJU9m+fmpo3c9aWxNV2Nm4xcJHKE/HK1KPhFNeS4kmAjrTUC5mqAU
         R8+DOkBCRnteMXEqymsuMrxdiOJfY4hSr4sHut+a7uAWBGZ9vEG7simVb+DVh3/hjP+D
         SkVWkSW0MfMXbz58ZL8awWkXBk9dw/xGm6b2XiS++PalpCMd+2GDLFa0+pb7qrc1Vag+
         eXhw==
X-Gm-Message-State: AOAM533yeAtRsr3zMOmsypn4INteBvI8aNlOl6kzAsz3fzFUoi1deiBh
        w3VI52rtU3Q8Yw4w2XFwgFr8ea+Q4gS/3w==
X-Google-Smtp-Source: ABdhPJwInKji//lwFckfN9GxMHTGJW3yIUHCqvnzdeFAZuu/oJSZUsuSEht3yOyUyeNhRNL09v219w==
X-Received: by 2002:ac8:5c93:: with SMTP id r19mr18394qta.107.1610472713233;
        Tue, 12 Jan 2021 09:31:53 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id k7sm1453512qtg.65.2021.01.12.09.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 09:31:52 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v6 2/5] drivers/soc/litex: separate MMIO from subregister offset calculation
Date:   Tue, 12 Jan 2021 12:31:41 -0500
Message-Id: <20210112173144.4002594-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112173144.4002594-1-gsomlo@gmail.com>
References: <20210112173144.4002594-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Separate MMIO (read/write) access into _[read|write]_litex_subregister()
static inline functions, leaving existing "READ|WRITE" macros to handle
calculation of the subregister offset only.

NOTE: this is a non-functional change.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 include/linux/litex.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/linux/litex.h b/include/linux/litex.h
index 67c1a18a7425..918bab45243c 100644
--- a/include/linux/litex.h
+++ b/include/linux/litex.h
@@ -24,11 +24,23 @@
 #define LITEX_SUBREG_SIZE	0x1
 #define LITEX_SUBREG_SIZE_BIT	 (LITEX_SUBREG_SIZE * 8)
 
+static inline void _write_litex_subregister(u32 val, void __iomem *addr)
+{
+	writel((u32 __force)cpu_to_le32(val), addr);
+}
+
+static inline u32 _read_litex_subregister(void __iomem *addr)
+{
+	return le32_to_cpu((__le32 __force)readl(addr));
+}
+
 #define WRITE_LITEX_SUBREGISTER(val, base_offset, subreg_id) \
-	writel((u32 __force)cpu_to_le32(val), base_offset + (LITEX_REG_SIZE * subreg_id))
+	_write_litex_subregister(val, (base_offset) + \
+					LITEX_REG_SIZE * (subreg_id))
 
 #define READ_LITEX_SUBREGISTER(base_offset, subreg_id) \
-	le32_to_cpu((__le32 __force)readl(base_offset + (LITEX_REG_SIZE * subreg_id)))
+	_read_litex_subregister((base_offset) + \
+					LITEX_REG_SIZE * (subreg_id))
 
 /*
  * LiteX SoC Generator, depending on the configuration, can split a single
-- 
2.26.2

