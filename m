Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCB52A4836
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbgKCOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbgKCNpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:45:13 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D327CC0613D1;
        Tue,  3 Nov 2020 05:45:12 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id s14so14576210qkg.11;
        Tue, 03 Nov 2020 05:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PCRJp91/82MIer7BGmfwt2GKdylAg2x5Gxk5MeSJA78=;
        b=l1UUt3QNH+lFGhcDNXPtNMRtkqffL4tl2O3N54zCmMcpor3j0kMgvLUkphpicH1DmA
         e9gal6RMIMfV24ZCzIyXif3axp17c+gJqxlt5Z8rdoWW187/XRB5yRLtrmSF3fnFNRa5
         Gz4l7hh+A/kcwK1wh/9J1YbL45kF8pUgj+gZr8qTNoaduXm4U4vFw5nLxuqYxEhO9TH3
         1FHIRwqPxk86OlrRsKwElUT5rJ7lTXmfKiLIj6+R7Jj+iIsstunlj+07tab+NwEeiDOI
         amlsHmXjmNf1MAZl7gdBl94TpeXtOXHhLIlLKkgT/Dq+j3UvNDfH9rBNln7RpPwBLiU5
         Oklg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PCRJp91/82MIer7BGmfwt2GKdylAg2x5Gxk5MeSJA78=;
        b=HMuVukLKI/7ODekYG3Z1YNQlRD7nqcKcP81fMAGRIXi2kdDx5Z3W1EErYFpp6CLSeP
         1muNrsB2Hweudf+bnM2yMg+PQmuuW0iMn67YTIKddRjYs3U9pey3sLbb8wc6aWOtIlGe
         Piu2/mWCqrUPs7RZOQuv4LfgyHaxoP748wzspEJdNZuq4rVg9HnlFKBXVMKn7uIIVvUN
         9CCIxyXKSu7r45hHmNaqRWG7ZmsJGQl3nVXacjxOAFbrmMgnA/9cFM4EEjhJGbZT4S3p
         WawaoVBnqUS6cZMQbz4Tc+OS0F/6HEZKAAQTnOeTgAc4wgckSXydI1jVRRy/ahQUZUx+
         /3wg==
X-Gm-Message-State: AOAM532EcUmB+qbHj4lWP4dHM4/H5OxCO6vT8c5nTfDeB/Y9rfsW9M+M
        ZUTjG22rQ+v1JYoOCTaqvxo=
X-Google-Smtp-Source: ABdhPJwgqNLGy3G4kA2qMjuDmEfZ5jUgJ9Zn9b3TaNLMbOixzf8zLW3HI6CuhjtCYkEAnJi3PUqQiw==
X-Received: by 2002:a37:5002:: with SMTP id e2mr19533167qkb.453.1604411112117;
        Tue, 03 Nov 2020 05:45:12 -0800 (PST)
Received: from zhuyifei1999-ThinkPad-T480.gw.illinois.edu ([2620:0:e00:400f::31])
        by smtp.gmail.com with ESMTPSA id a206sm7356568qkb.64.2020.11.03.05.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:45:11 -0800 (PST)
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
Subject: [PATCH seccomp 3/8] powerpc: Enable seccomp architecture tracking
Date:   Tue,  3 Nov 2020 07:42:59 -0600
Message-Id: <4ec2970fcc819eb4d5dac2bd35233ccdadfda845.1604410035.git.yifeifz2@illinois.edu>
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
for powerpc.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/powerpc/include/asm/seccomp.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/powerpc/include/asm/seccomp.h b/arch/powerpc/include/asm/seccomp.h
index 51209f6071c5..3efcc83e9cc6 100644
--- a/arch/powerpc/include/asm/seccomp.h
+++ b/arch/powerpc/include/asm/seccomp.h
@@ -8,4 +8,25 @@
 
 #include <asm-generic/seccomp.h>
 
+#ifdef __LITTLE_ENDIAN__
+#define __SECCOMP_ARCH_LE_BIT		__AUDIT_ARCH_LE
+#else
+#define __SECCOMP_ARCH_LE_BIT		0
+#endif
+
+#ifdef CONFIG_PPC64
+# define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_PPC64 | __SECCOMP_ARCH_LE)
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"ppc64"
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT		(AUDIT_ARCH_PPC | __SECCOMP_ARCH_LE)
+#  define SECCOMP_ARCH_COMPAT_NR	NR_syscalls
+#  define SECCOMP_ARCH_COMPAT_NAME	"powerpc"
+# endif
+#else /* !CONFIG_PPC64 */
+# define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_PPC | __SECCOMP_ARCH_LE)
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"powerpc"
+#endif
+
 #endif	/* _ASM_POWERPC_SECCOMP_H */
-- 
2.29.2

