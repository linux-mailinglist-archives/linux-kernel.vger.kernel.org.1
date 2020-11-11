Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0D302AF263
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgKKNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgKKNeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:34:36 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5F2C0613D1;
        Wed, 11 Nov 2020 05:34:35 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id y197so1591177qkb.7;
        Wed, 11 Nov 2020 05:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LIHaRbcW33holGtLxAdu7MnC0XA7v48flZenL4Xa8vU=;
        b=dNk+mHcnxtrEMnoth+9YuSZp+YnaTGFIRKqb6ReOwm4fVp8t0mkh3bSdlUABRoAUlx
         tqquHCE17akyy8N/Nvpjg7Qp3AoZ+ubiA4cXGcr+8ulSr6YMzogVfYe8HW84FHb0lUm/
         /WtN9ZpC8VKXLz1L5tvxxFBda/OJbmO8xfmRMZm9yZjClDUw3ZscP+K5NBtyp4h7niez
         LHJ/nuWNzhr4vfD1yroJHXynte84EkEErCMxO2wU7yBLkN2zhT/krvfPoB2KZrvmREHc
         mmIHwwl9ZlD8hTh+jTTrb+HdoDQ4CsYqasWnyeceqpG0wekPMdPvQ3VXOB/H33Sm4FEB
         Rwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LIHaRbcW33holGtLxAdu7MnC0XA7v48flZenL4Xa8vU=;
        b=WAcMis8hL1Q1YX4OzJy/iRPmfN6jjQpqhy2sG5+c88b+q3Y+jFm/lLeqmsha4zSVBB
         +KExNlFtT+S2oW+FViu85XBnHeNbQwgN1nE0/8xNr4IK2u3LGD0f7EuL2FzZnCntBXMY
         CMK+1ZaAa6TyT1s5pGxWTHDWrHyaajBBacigY4nlGxyc82ci9wXuN6vLMz84bmakVRol
         3kADMhBWKTegASyH17T714267+jkxIqzeKi7MgEe697vkxVJoarUvyV4Upc82BZfCfBS
         FzuljtSFkmJ6MFxchYdKy+Jmgv0EyqLbl0eluWsgU65sp8hUePEjkOola97Ss3TMFu40
         qYsw==
X-Gm-Message-State: AOAM5302BEXtXrKuMif1n1In+zEnZBbFSC01mddSboGJRYj1FbX/Tj/g
        eNmN32gmKq69+0O7RfUhGBiVYygS30+vOA==
X-Google-Smtp-Source: ABdhPJwWi7mIj07jdzREPXg7rZ5J8YjabnB76CW+3UwHPeuu2d0EaLhFYKhjOvqP7+1Mxz1/dz90Iw==
X-Received: by 2002:a05:620a:142e:: with SMTP id k14mr24946158qkj.483.1605101675195;
        Wed, 11 Nov 2020 05:34:35 -0800 (PST)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id r190sm1997814qkf.101.2020.11.11.05.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:34:34 -0800 (PST)
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
Subject: [PATCH seccomp v2 2/8] parisc: Enable seccomp architecture tracking
Date:   Wed, 11 Nov 2020 07:33:48 -0600
Message-Id: <9bb86c546eda753adf5270425e7353202dbce87c.1605101222.git.yifeifz2@illinois.edu>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1605101222.git.yifeifz2@illinois.edu>
References: <cover.1605101222.git.yifeifz2@illinois.edu>
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

