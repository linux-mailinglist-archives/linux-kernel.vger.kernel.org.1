Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188662F603C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 12:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbhANLhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 06:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbhANLhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 06:37:08 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07257C061799
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:36:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m5so3034950pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 03:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4KknPcU14oAn6dzl/c3Edg+OCaB8DryL02Uf90ePZlw=;
        b=kp5Ji1BSU4CgZgWD0QPhxWTsgcExYWvSvuaNABPB5hTr95W239seYxDXr3uXnFVoOL
         8mZeeWU3ZXk1n2ycUYcx+4wZGiP/z+kqQ/PGPzzg03uKdzPxnRmBH3YvKl3/IrLvIdW4
         E+TwaqLtTDQlFbaPj2V2CyIhJDWliADcWLX2CSZadvsgHHsX8CftPHChV1IX7AANXssc
         zItUWa/HHLCo+pKCIN3vkfvjFKc7Rak3ZOs9C7lSYJDIJNo3zGNUrApY++FTwyKFy13a
         kXoIqkIWg4kYqMMXVUzoW/mGrgZU25lrxH4VPv6RKn/Zpfh6oqnI2kiveI4/TtKjnaUe
         tftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4KknPcU14oAn6dzl/c3Edg+OCaB8DryL02Uf90ePZlw=;
        b=EHnrYITaj4HH2Jc5hAypSBOa8Y+fmIRi5k6jbxWk/tox/yLHrFQx6FF+mZOOJnLl82
         JAzd2120APVs3XM2NOT1v3bZC00Y4zr5tuP4PxZlTXDTSPSzQQB1RM8C1eetkwASgkEk
         NMiGk7wZvz3PeIV79Um2yR35HsHyw0HQCVpEuJB3ZA2+H52JuGfYA7K7Fhup0+XeozOu
         lqKlp4pFp+lp4Rv9i7TC/McFceKgcADkyvxOYV9f0afPYgQaVrHUBW4xjAZJMkVWYtq0
         8YP6zw3bHlTs1K2T3drDRVHToDDNbnmrTPxdBlMNIZdmkwavzHDXUXW0I1AuUd8IOVrO
         8mGA==
X-Gm-Message-State: AOAM533EFNmwx/Gg6nVGoGficQZTIVkbA/+rrqAOUZ5UPFmSdgCFSXBL
        wyAbkOArXud2Do8Q7C2ViCQNDw==
X-Google-Smtp-Source: ABdhPJxIpjnVGrrszX3TsqasLIGta7qEXa/ZKTRnt0ZaKdqKO3e1trQ7Ndh8UU02B1GL0UZ7ZP7Zpw==
X-Received: by 2002:a17:902:bf44:b029:da:d140:6f91 with SMTP id u4-20020a170902bf44b02900dad1406f91mr7254131pls.51.1610624167614;
        Thu, 14 Jan 2021 03:36:07 -0800 (PST)
Received: from localhost ([122.172.85.111])
        by smtp.gmail.com with ESMTPSA id a18sm5150737pfg.107.2021.01.14.03.36.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 03:36:07 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] arch: parisc: Remove CONFIG_OPROFILE support
Date:   Thu, 14 Jan 2021 17:05:22 +0530
Message-Id: <1b3e210d98d419eba4d0d648a3a181fe2190dc67.1610622251.git.viresh.kumar@linaro.org>
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
 arch/parisc/Kconfig           |  1 -
 arch/parisc/Makefile          |  2 --
 arch/parisc/oprofile/Makefile | 10 ----------
 arch/parisc/oprofile/init.c   | 23 -----------------------
 4 files changed, 36 deletions(-)
 delete mode 100644 arch/parisc/oprofile/Makefile
 delete mode 100644 arch/parisc/oprofile/init.c

diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 78b17621ee4a..c2216e53fa81 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -4,7 +4,6 @@ config PARISC
 	select ARCH_32BIT_OFF_T if !64BIT
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_IDE
-	select HAVE_OPROFILE
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 5140c602207f..7d9f71aa829a 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -116,8 +116,6 @@ kernel-y			:= mm/ kernel/ math-emu/
 core-y	+= $(addprefix arch/parisc/, $(kernel-y))
 libs-y	+= arch/parisc/lib/ $(LIBGCC)
 
-drivers-$(CONFIG_OPROFILE)		+= arch/parisc/oprofile/
-
 boot	:= arch/parisc/boot
 
 PALO := $(shell if (which palo 2>&1); then : ; \
diff --git a/arch/parisc/oprofile/Makefile b/arch/parisc/oprofile/Makefile
deleted file mode 100644
index 86a1ccc328eb..000000000000
--- a/arch/parisc/oprofile/Makefile
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
-oprofile-y				:= $(DRIVER_OBJS) init.o
diff --git a/arch/parisc/oprofile/init.c b/arch/parisc/oprofile/init.c
deleted file mode 100644
index 026cba2af07a..000000000000
--- a/arch/parisc/oprofile/init.c
+++ /dev/null
@@ -1,23 +0,0 @@
-/**
- * @file init.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author John Levon <levon@movementarian.org>
- */
-
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/oprofile.h>
-
-int __init oprofile_arch_init(struct oprofile_operations *ops)
-{
-	return -ENODEV;
-}
-
-
-void oprofile_arch_exit(void)
-{
-}
-- 
2.25.0.rc1.19.g042ed3e048af

