Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2492E2BBA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 15:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgLYOWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 09:22:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727119AbgLYOWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 09:22:13 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D1FC061757
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:21:33 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id g24so3030142qtq.12
        for <linux-kernel@vger.kernel.org>; Fri, 25 Dec 2020 06:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzbAt/uZBSjzSRu1F6Prd22rr5NufKkQ/G1C6Jc0wdM=;
        b=s+5Zie7x6dla5qaIaLct4YpeIrNlSYgVN3vEoJfONC6WWPI2EphMSO6HRKp3ZSHAkL
         4mdXzKKITifUTuHN981R1dgT1I1HblZNN4HVq1h2/Ha2tZzxRu2AQocWtMYEFOu9aKgN
         Nq/7Ic5l9pcmv/kS5bjgzDWM0XM13YP+NI8Q2nbvemHBd5gvWnoTkxcTq0XOCYSi3skh
         PsVXzqFJosu6ApZMC+s0iR3L2s90rYLHHnc0L+24sgAcOWXZoUQle4lnJOH1n5AYfdc7
         UvJRfkOMN1pd2Yrzgrat5nZL9dNj9btXr+qw1d61Y40yxBJ6vfaK7ekulvOvKG4IbanD
         XErg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzbAt/uZBSjzSRu1F6Prd22rr5NufKkQ/G1C6Jc0wdM=;
        b=HrQcL6xDAJBv5PJJPVZW7VI18SdeYT/Ws4a01gAonsF6QavbGUUsG9uc+dZRPTh+nt
         6pGCI51YWY1Cdp/yF13jTa6WrHD3WWKjZFMVDYH+f8lova46lsSzXI8g0ZFVFXWQp//7
         0xMcuEaAsIpHio3v+wSgjKbofAvBw1761V6M2C2gUWMrUTtTqOocSnWijmLo+0Wl3l5z
         DEI7lVN80Dwcpdq3t+Qpuer85GuLmi1AlH8JREja55hReoUJ39dQrefXfPZaOBKxehrd
         k6/FK6oDxQ2x0FCvtZPpjV9ErOKn5hRs0JNli9cSLIc6T3V6PHSw04wuJShlu7vg4oga
         ZyAw==
X-Gm-Message-State: AOAM530nWPmA0m21FDMwJUHKd6AEGmScbXTsXuOPxLsf6gQN7laRM+dI
        SKnU4nnSPrYcqA41LASpbECDnlr7fIZ4Qw==
X-Google-Smtp-Source: ABdhPJy7XZSy0ieprCCaAciHf946LLINZx5YDWY4CvLow8TUFOpKRgGZ2XuuXm68sxnjzS+6toLIfQ==
X-Received: by 2002:aed:2f64:: with SMTP id l91mr33750049qtd.363.1608906092556;
        Fri, 25 Dec 2020 06:21:32 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id l191sm18279039qke.7.2020.12.25.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Dec 2020 06:21:31 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v3 2/3] drivers/soc/litex: separate MMIO from subregister offset calculation
Date:   Fri, 25 Dec 2020 09:21:19 -0500
Message-Id: <20201225142120.2018222-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201225142120.2018222-1-gsomlo@gmail.com>
References: <20201225142120.2018222-1-gsomlo@gmail.com>
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

