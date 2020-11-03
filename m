Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1D52A47F7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgKCOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgKCNpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:45:08 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9D9C0613D1;
        Tue,  3 Nov 2020 05:45:08 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id 140so14628191qko.2;
        Tue, 03 Nov 2020 05:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wWgXpwOKfWu89zfH4z55YdVS4FoKgsyU3KjhUPw2Xk=;
        b=HUmeo8PKFkCINZljvfRc+P6j2X0+0GOhvVUFZGwDVi5RBcL6yCRRP7JuB0zv9c9+Po
         E3+9kj9NX57UzwwDZNGdD8iaYBGU9wXX967tHeoCgvkJm1CovDmhTO1emhffrLi5usDF
         0oEzRtLhoIuA39ggcO6eQcTv/OGvRmPgCQX4sTZrzio50ODOqs0YICXq0MgBjQAfHPdz
         xl7tXTacq4qNhz9LC51MS1M++unu3TcfcbkGRzSQxWGdRezIwQbhQELfkQD+RH+S21A/
         sax7yhctLMgZTMGgygja3clLmsRRE7W8PkbbGI7EUIeZ8EaqV18ap7HIw7j/Z7WF3HJx
         8pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wWgXpwOKfWu89zfH4z55YdVS4FoKgsyU3KjhUPw2Xk=;
        b=L0THD44tUiobW8XHwy4mwOF08UXf/8Z/E7FezRNEKdPPigyZrw5AOfr+T56qEuZiBV
         ZYhQeSevN+7xVzRVmi3C7WZpPa2Rc6rROTXe85qARb3s8rXKqbngzJA/CDYJZXy9/JRz
         CayUhwy96wmaoiDAkjoIvPwo5wgHgU3UEsBYvD86ZMw3GozNBV1QRpEixmAyir3ksbRm
         khhIWBNpBXd04GyBYYT4jHTVzE2fwoLuC2wpNb5T4At1pwkOUqLezuSoJSgRneayGTua
         RjfnjDi3wfPkYH3DJm3btIQ3LezYW7wO+oy1QxQ5KjEWWTx5ztxbWx6V2eTgmw532B8c
         XrYQ==
X-Gm-Message-State: AOAM531xUy51m/4w23nI6W2NheIaKK9B1OLwMK3p7yLWnBgJpumd7VNM
        LDCVod/dMGDJbWJyJpWaKQc=
X-Google-Smtp-Source: ABdhPJyHAHCGbEEm09WION+/UIzzZ/lrqbH487CGEGOVROPc59579zIEupD9GaMmhFNRyF9+2N11RQ==
X-Received: by 2002:ae9:dec5:: with SMTP id s188mr20227157qkf.250.1604411107951;
        Tue, 03 Nov 2020 05:45:07 -0800 (PST)
Received: from zhuyifei1999-ThinkPad-T480.gw.illinois.edu ([2620:0:e00:400f::31])
        by smtp.gmail.com with ESMTPSA id a206sm7356568qkb.64.2020.11.03.05.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:45:07 -0800 (PST)
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
Subject: [PATCH seccomp 1/8] csky: Enable seccomp architecture tracking
Date:   Tue,  3 Nov 2020 07:42:57 -0600
Message-Id: <f9219026d4803b22f3e57e3768b4e42e004ef236.1604410035.git.yifeifz2@illinois.edu>
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
for csky.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/csky/include/asm/Kbuild    |  1 -
 arch/csky/include/asm/seccomp.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 arch/csky/include/asm/seccomp.h

diff --git a/arch/csky/include/asm/Kbuild b/arch/csky/include/asm/Kbuild
index 64876e59e2ef..93372255984d 100644
--- a/arch/csky/include/asm/Kbuild
+++ b/arch/csky/include/asm/Kbuild
@@ -4,6 +4,5 @@ generic-y += gpio.h
 generic-y += kvm_para.h
 generic-y += local64.h
 generic-y += qrwlock.h
-generic-y += seccomp.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
diff --git a/arch/csky/include/asm/seccomp.h b/arch/csky/include/asm/seccomp.h
new file mode 100644
index 000000000000..d33e758126fb
--- /dev/null
+++ b/arch/csky/include/asm/seccomp.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_SECCOMP_H
+#define _ASM_SECCOMP_H
+
+#include <asm-generic/seccomp.h>
+
+#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_CSKY
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"csky"
+
+#endif /* _ASM_SECCOMP_H */
-- 
2.29.2

