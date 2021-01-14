Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A12F602F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbhANLgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbhANLgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:36:25 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1248EC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:35:45 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n7so3613220pgg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AYFhWYvlMHFaN194DuP9Mk/3w2ENP7CTYz+Se/lFzBQ=;
        b=zZUJNJPhK7vwVZo3zG1L/ZLlhGgRFtQKowTKqhvvF7eFc3s3ezuRailFhUhF2kVpg1
         XqlIlpxX1roPBkCGmEG4JkGCWMCZrmtUSHYhup+Q+9g364u4bEvTsgbKUquse8cVWgTj
         piQAfeXwWyDTfwsMUHcD0aA+o/CQPOkybKOn/6hOE71SZeW2oksCYnahsxgiNJkH/xF5
         ItmDc/bpU9bMl/gJlifRnXyhlTDY0vVXisakj25ILk2G13A8mnqd4wlcMvjIEGN8vsww
         yAa+rogw5E/eiY34s70yJr8QPk8qEkG6c84T6J/2a8cJhLgFl/iEqOqjhaaYu5wNb5Fn
         XnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYFhWYvlMHFaN194DuP9Mk/3w2ENP7CTYz+Se/lFzBQ=;
        b=oj/DxHQ+ZgriAnjRHQFNfCi35lq6ebaWSAHcY/HvkXx6SWhqk7F+WVWSLLu0mV9qun
         btj/JcjpDNmgEljWmoDyDvtBwoUS0GX5QHuWaMAordpBh1ok7XwSYezYGlM79G+fhzHe
         stM7S3G5QsEK/tLWJa6xL4TGnxo0kLWp1wKNqhYhRkEThDoCvR4gwlG57WysWk7IqUwf
         QvVkWaXMh7Y+wT81M4tZx6P0+XCqL7DLZOFhEnDpgYR3uSBaCXkDi4m3bb03P5AOoyBf
         6Q/vP5BimeU9dh0NzQBLCAbSPft1TyersvwSlw6yZUC0/U7smkLZOykLmLQyeHXTbcrx
         4UxQ==
X-Gm-Message-State: AOAM532RfS0h3OZUfBzBu92n4j/qctIgD8DKqsA8Ix6zYb9HRI25abhL
        i6sjFLGP4LiJweu2j5Mx1fDxUA==
X-Google-Smtp-Source: ABdhPJzg1zptJKMu9bTjn6PS8c4QYvzj+iujyctChMFT1NQzHaOeW3F1te+tLmaKVJLiXtZeLXQpnQ==
X-Received: by 2002:aa7:8583:0:b029:1a9:39bc:ed3b with SMTP id w3-20020aa785830000b02901a939bced3bmr7001430pfn.48.1610624144666;
        Thu, 14 Jan 2021 03:35:44 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id m4sm5320866pgv.16.2021.01.14.03.35.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 03:35:44 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/18] arch: arc: Remove CONFIG_OPROFILE support
Date:   Thu, 14 Jan 2021 17:05:16 +0530
Message-Id: <906d9d40746bb1b60823a288d00820cb50d29138.1610622251.git.viresh.kumar@linaro.org>
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
 arch/arc/Kconfig           |  1 -
 arch/arc/Makefile          |  2 --
 arch/arc/oprofile/Makefile | 10 ----------
 arch/arc/oprofile/common.c | 23 -----------------------
 4 files changed, 36 deletions(-)
 delete mode 100644 arch/arc/oprofile/Makefile
 delete mode 100644 arch/arc/oprofile/common.c

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index b55ca77f619b..bc8d6aecfbbd 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -37,7 +37,6 @@ config ARC
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
-	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select HANDLE_DOMAIN_IRQ
 	select IRQ_DOMAIN
diff --git a/arch/arc/Makefile b/arch/arc/Makefile
index 578bdbbb0fa7..4392c9c189c4 100644
--- a/arch/arc/Makefile
+++ b/arch/arc/Makefile
@@ -96,8 +96,6 @@ core-$(CONFIG_ARC_PLAT_TB10X)	+= arch/arc/plat-tb10x/
 core-$(CONFIG_ARC_PLAT_AXS10X)	+= arch/arc/plat-axs10x/
 core-$(CONFIG_ARC_SOC_HSDK)	+= arch/arc/plat-hsdk/
 
-drivers-$(CONFIG_OPROFILE)	+= arch/arc/oprofile/
-
 libs-y		+= arch/arc/lib/ $(LIBGCC)
 
 boot		:= arch/arc/boot
diff --git a/arch/arc/oprofile/Makefile b/arch/arc/oprofile/Makefile
deleted file mode 100644
index 698367bb41d0..000000000000
--- a/arch/arc/oprofile/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_OPROFILE) += oprofile.o
-
-DRIVER_OBJS = $(addprefix ../../../drivers/oprofile/, \
-		oprof.o cpu_buffer.o buffer_sync.o \
-		event_buffer.o oprofile_files.o \
-		oprofilefs.o oprofile_stats.o \
-		timer_int.o )
-
-oprofile-y	:= $(DRIVER_OBJS) common.o
diff --git a/arch/arc/oprofile/common.c b/arch/arc/oprofile/common.c
deleted file mode 100644
index 86bf5899533b..000000000000
--- a/arch/arc/oprofile/common.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- *
- * Based on orig code from @author John Levon <levon@movementarian.org>
- */
-
-#include <linux/oprofile.h>
-#include <linux/perf_event.h>
-
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	/*
-	 * A failure here, forces oprofile core to switch to Timer based PC
-	 * sampling, which will happen if say perf is not enabled/available
-	 */
-	return oprofile_perf_init(ops);
-}
-
-void oprofile_arch_exit(void)
-{
-	oprofile_perf_exit();
-}
-- 
2.25.0.rc1.19.g042ed3e048af

