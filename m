Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3B62E31CC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 17:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgL0QOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 11:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgL0QOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 11:14:09 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107F3C061796
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:13:29 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id j18so4037592qvu.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 08:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZzbAt/uZBSjzSRu1F6Prd22rr5NufKkQ/G1C6Jc0wdM=;
        b=mitm7eu64gNQeCx4OZqDB+jFYmPnEnIPBe1iSb5VgOkiW26KgE7a4d8/vXweWbsm/l
         SYp5ZKsBCgHN8BNP9iHWSZ3X05FjBPy1DQbGzXx8H+2JEJYDzZO9MOJqf79ohRU/VrVT
         ClEV7N5SvF0fTq6NgvHgZJiAsGnyLN611XXGuHLf8zQyQ611SVmJGv8mTujpXI2yprzM
         +u1KkrCv/khCLuPpJvmHHi/hX4eqpIH3Hb/5CfZsCfCKs8Rvu3a6M2XirRi4+Myn4u1t
         oH3tPHpcMu9T2SmV09WEF2RECXAQjvxJWXynEB78YTM6pTilps20ozz05JV7Hj/Py3A+
         PBAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZzbAt/uZBSjzSRu1F6Prd22rr5NufKkQ/G1C6Jc0wdM=;
        b=uYR1/Ef1Vko7XK5Omid8ju7N7bfl/7nBSpAhi9a/ktw8Tdw4NlbEAHfMopSsXPRSke
         Zo4+fBBzG+tan+FHd+KVGqj1j+vBRkJc71gjmgMWhVuwA0RPFY49JfWZGBkkzQVipALo
         inX4MjfexVRLw8boEtgP6sAdPArHzFstS8y2NQzNrY7wm/4lXu6iGLGXLXw4LflFGma1
         oxqzQom3W6gcAM6471KXiMSYA7r9b1uFh1dwbgy7fIN4Rt0hzSfLJ+8DnqBlptYqHOYF
         cEHsdmvcPPef9nNqJYiXOMVBOE6LIF3WpcZR+ihIXwXC717izjedh25VYzdrr6xuio30
         eJDA==
X-Gm-Message-State: AOAM531qAQee1Q1cwDfpsem+JFkxfJMqNdxuoMPmAM1m50spOHeFe2U1
        gli4AXacpOMNOUuaaeSelIk=
X-Google-Smtp-Source: ABdhPJydkRYaF5VrwGRPr5jD9XNFdRKc01rGjCK/YyreNR6SO1IacP5IFTB3E1SrFqDHFodKSP6w9A==
X-Received: by 2002:ad4:4e4d:: with SMTP id eb13mr43083071qvb.6.1609085608340;
        Sun, 27 Dec 2020 08:13:28 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id h75sm13088873qke.130.2020.12.27.08.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Dec 2020 08:13:27 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     shorne@gmail.com, mholenko@antmicro.com, kgugala@antmicro.com
Cc:     linux-kernel@vger.kernel.org, pczarnecki@internships.antmicro.com,
        f.kermarrec@gmail.com, gregkh@linuxfoundation.org, gsomlo@gmail.com
Subject: [PATCH v5 2/4] drivers/soc/litex: separate MMIO from subregister offset calculation
Date:   Sun, 27 Dec 2020 11:13:18 -0500
Message-Id: <20201227161320.2194830-3-gsomlo@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201227161320.2194830-1-gsomlo@gmail.com>
References: <20201227161320.2194830-1-gsomlo@gmail.com>
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

