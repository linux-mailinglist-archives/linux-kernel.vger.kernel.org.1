Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A072F6039
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:39:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbhANLhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728837AbhANLhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:37:04 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52814C061794
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:35:59 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id c22so3568573pgg.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfKQWzY7g6bl4dvYg0DvLy9sotgmT/aIIjZC+k1x6MY=;
        b=KfoPeokcc84VAT2vVy/K+gWl8B8rV10CEbggJ0yBMdMPp5J+M2XJ0EdRT04iX5+rS8
         NB3X3AY4LXXByzg0peB+mqcFb0NgenHQOL5ElwehZWNPU1Ihs86ycwdZWTiMi/3OicJz
         b0b+iYPvq/cwkJVFM7uQCDIfy1clbGu+CyMBJDI0yH3wU566fex7ZiveLs4mpzziINR7
         sQvYcqiEgbl2d/4DcJqJIgiUnBiTDoniFcUBXhehAJUilnCCbwg/Sh+/pEAnQeh3F7EB
         Y1JfEH+5OkthGpKQasLONrh2joiVM8KwRyWU95lJnnJ6u67kND/6V2P5Bceapv+ImdSU
         S2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfKQWzY7g6bl4dvYg0DvLy9sotgmT/aIIjZC+k1x6MY=;
        b=CmaXg49Ji3UUU3ci9UqhIPxrJdbFhQEpOpmfQlMvMFc65/pnoW2GI3caeEou7sDqX8
         3ce0rews1x81XpNmWntHcDwaGzjHG29ye8pB7xsFNgormYYFvCjPp/aVlJO/nMX/wIiC
         ZggeUMjJl8blTRNxTsPhaX0EJJ2O0LpslTdR+p0QeABUBK736iQ8owAyf3vNhSEJbX4L
         vFHVBHfb42lHk3T9pnWTirCyGx/gBguZAs9qUmp4K6nCSJeyZQV9M1dpPZsGZSgf3IDo
         C9LAx+2XoPSc7MgcluKU98gydGhUsZ/eLdZ2m6URrlLNfePOTR6hKpv6ItSrLlSlEcOW
         vMgw==
X-Gm-Message-State: AOAM5300EDHzMRwPba+oIxUL7YCPR4u0+KOx2iIL3/5iWnGtqlGpMBrW
        04quU9G5nDudfKWB1p8tPMkYxjCBheWkuA==
X-Google-Smtp-Source: ABdhPJy61sjpnlO4eZYOZOP/pWpxcFUSGlPPxqVSk3fWBIdZQvVnJfxgg8Wg7PuMzAcl4OEdEopBWg==
X-Received: by 2002:a63:150b:: with SMTP id v11mr7256845pgl.183.1610624158930;
        Thu, 14 Jan 2021 03:35:58 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id m3sm4695787pfa.134.2021.01.14.03.35.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 03:35:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Michal Simek <monstr@monstr.eu>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] arch: microblaze: Remove CONFIG_OPROFILE support
Date:   Thu, 14 Jan 2021 17:05:20 +0530
Message-Id: <592887f3a5baf0d2b2919617757f1f629aa4030b.1610622251.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1610622251.git.viresh.kumar@linaro.org>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "oprofile" user-space tools don't use the kernel OPROFILE support
any more, and haven't in a long time. User-space has been converted to
the perf interfaces.

Remove the old oprofile's architecture specific support.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/microblaze/Kconfig                       |  1 -
 arch/microblaze/Makefile                      |  2 --
 arch/microblaze/oprofile/Makefile             | 14 ------------
 .../microblaze/oprofile/microblaze_oprofile.c | 22 -------------------
 4 files changed, 39 deletions(-)
 delete mode 100644 arch/microblaze/oprofile/Makefile
 delete mode 100644 arch/microblaze/oprofile/microblaze_oprofile.c

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index f82795592ce5..25a5a3fb14aa 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -30,7 +30,6 @@ config MICROBLAZE
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
-	select HAVE_OPROFILE
 	select HAVE_PCI
 	select IRQ_DOMAIN
 	select XILINX_INTC
diff --git a/arch/microblaze/Makefile b/arch/microblaze/Makefile
index bb980891816d..b41f323e1fde 100644
--- a/arch/microblaze/Makefile
+++ b/arch/microblaze/Makefile
@@ -54,8 +54,6 @@ core-y += arch/microblaze/kernel/
 core-y += arch/microblaze/mm/
 core-$(CONFIG_PCI) += arch/microblaze/pci/
 
-drivers-$(CONFIG_OPROFILE) += arch/microblaze/oprofile/
-
 boot := arch/microblaze/boot
 
 # Are we making a simpleImage.<boardname> target? If so, crack out the boardname
diff --git a/arch/microblaze/oprofile/Makefile b/arch/microblaze/oprofile/Makefile
deleted file mode 100644
index 107f2f55d995..000000000000
--- a/arch/microblaze/oprofile/Makefile
+++ /dev/null
@@ -1,14 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-#
-# arch/microblaze/oprofile/Makefile
-#
-
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS := $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
-
-oprofile-y := $(DRIVER_OBJS) microblaze_oprofile.o
diff --git a/arch/microblaze/oprofile/microblaze_oprofile.c b/arch/microblaze/oprofile/microblaze_oprofile.c
deleted file mode 100644
index def17e59888e..000000000000
--- a/arch/microblaze/oprofile/microblaze_oprofile.c
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Microblaze oprofile code
- *
- * Copyright (C) 2009 Michal Simek <monstr@monstr.eu>
- * Copyright (C) 2009 PetaLogix
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License. See the file "COPYING" in the main directory of this archive
- * for more details.
- */
-
-#include <linux/oprofile.h>
-#include <linux/init.h>
-
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	return -1;
-}
-
-void oprofile_arch_exit(void)
-{
-}
-- 
2.25.0.rc1.19.g042ed3e048af

