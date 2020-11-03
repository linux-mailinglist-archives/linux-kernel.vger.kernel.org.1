Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287242A4864
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729679AbgKCOUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729227AbgKCNpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:45:11 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AFF0C0613D1;
        Tue,  3 Nov 2020 05:45:11 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id b18so14594948qkc.9;
        Tue, 03 Nov 2020 05:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LIHaRbcW33holGtLxAdu7MnC0XA7v48flZenL4Xa8vU=;
        b=iuwgpDk+ywyZuJVS5CkkW+UWoj8ZeMu3W2DRLryyvnrW+Yalap3GJHVoD8C4+cBD+7
         i0mlc7ylUKWR3VTM8HUiGkrSd6GfEzWHDrKM2Yi/EUh4SUeQJGC5iWhdIlHg1FwsfmU7
         5j2mbRcAQ+Kabs4nK6b2QlwboR4cF7QiMu8M72ms85+IdB3oy7S+KkgeNASKDc+esvNS
         rxHPsuHmxZd6k2hEmZ4gnCaD4zMtAJepsCqvCTOJcS3RDl0yqGmQrE1llfApvK0RDGby
         kEpnD+/cchNFssyPLLdYRHqwyzAWUPNEyXHCd8X+DCF/NW6Ni9L1BESHJg76npfZXeog
         1pWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LIHaRbcW33holGtLxAdu7MnC0XA7v48flZenL4Xa8vU=;
        b=TjACBfXyqbMBA+WDjpyChGv5Q0J4SUF7Blzb2qPJsfTQwbcJAJA5SwdlrVCTYoUvNJ
         q80s3stDivHdrS0Nc4f49bxPwu83/uOokSCiG53KBsNPP5Da8G6baiPaTX3cR2kZVKSy
         AKws8IQnicd7Zl+Ugk8g/YINQjnc/AKXIrbDRZVYdEG3Ay505Yo6QNEc0zoMjhERGj5n
         h/oRotU320n9pJAQAZdKKmqmYrlPDqm2AM2Z3kxpfDlfcl2mJDgezoh3PII0ChNoALLM
         QNeWI3CsziIT/p6KOkODDJKdrnsuswIy6CUOVvQvDw1SHm8+XXI2Mra/twB3UtoDQCfe
         C9dA==
X-Gm-Message-State: AOAM5323TdBD8CF5bNjWh52g+EpP3Hpuw22AtuCBPpnjw3mnk0iFxUvQ
        EplzHNASGxBIPQ67uqPHdhM=
X-Google-Smtp-Source: ABdhPJza/Al4BmaaKLSE3M46BZOoXGqpH/lMostTkMqGorYeqXkDTUPky+7rUNYdGBfTqt+ibTx7dg==
X-Received: by 2002:a05:620a:492:: with SMTP id 18mr20260926qkr.149.1604411110339;
        Tue, 03 Nov 2020 05:45:10 -0800 (PST)
Received: from zhuyifei1999-ThinkPad-T480.gw.illinois.edu ([2620:0:e00:400f::31])
        by smtp.gmail.com with ESMTPSA id a206sm7356568qkb.64.2020.11.03.05.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:45:08 -0800 (PST)
From:   YiFei Zhu <zhuyifei1999@gmail.com>
To:     containers@lists.linux-foundation.org
Cc:     YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        David Laight <David.Laight@aculab.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Jann Horn <jannh@google.com>,
        Josep Torrellas <torrella@illinois.edu>,
        Kees Cook <keescook@chromium.org>,
        Tianyin Xu <tyxu@illinois.edu>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Valentin Rothberg <vrothber@redhat.com>,
        Will Drewry <wad@chromium.org>
Subject: [PATCH seccomp 2/8] parisc: Enable seccomp architecture tracking
Date:   Tue,  3 Nov 2020 07:42:58 -0600
Message-Id: <9bb86c546eda753adf5270425e7353202dbce87c.1604410035.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1604410035.git.yifeifz2@illinois.edu>
References: <cover.1604410035.git.yifeifz2@illinois.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YiFei Zhu <yifeifz2@illinois.edu>

To enable seccomp constant action bitmaps, we need to have a static
mapping to the audit architecture and system call table size. Add these
for parisc.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/parisc/include/asm/Kbuild    |  1 -
 arch/parisc/include/asm/seccomp.h | 22 ++++++++++++++++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)
 create mode 100644 arch/parisc/include/asm/seccomp.h

diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kbuild
index e3ee5c0bfe80..f16c4db80116 100644
--- a/arch/parisc/include/asm/Kbuild
+++ b/arch/parisc/include/asm/Kbuild
@@ -5,5 +5,4 @@ generated-y += syscall_table_c32.h
 generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += mcs_spinlock.h
-generic-y += seccomp.h
 generic-y += user.h
diff --git a/arch/parisc/include/asm/seccomp.h b/arch/parisc/include/asm/seccomp.h
new file mode 100644
index 000000000000..b058b2220322
--- /dev/null
+++ b/arch/parisc/include/asm/seccomp.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_SECCOMP_H
+#define _ASM_SECCOMP_H
+
+#include <asm-generic/seccomp.h>
+
+#ifdef CONFIG_64BIT
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_PARISC64
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"parisc64"
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_PARISC
+#  define SECCOMP_ARCH_COMPAT_NR	NR_syscalls
+#  define SECCOMP_ARCH_COMPAT_NAME	"parisc"
+# endif
+#else /* !CONFIG_64BIT */
+# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_PARISC
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"parisc"
+#endif
+
+#endif /* _ASM_SECCOMP_H */
-- 
2.29.2

