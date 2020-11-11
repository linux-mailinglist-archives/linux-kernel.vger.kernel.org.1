Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE8B2AF294
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgKKNfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgKKNem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:34:42 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71384C0613D1;
        Wed, 11 Nov 2020 05:34:42 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id i12so1261440qtj.0;
        Wed, 11 Nov 2020 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z8BEo0x7DBxygVu3ezyut+Q+/5lHQFyLMFsea6yH4dY=;
        b=AiHrWEt19R14SjvDJPKLr7v7i72FmAs7tKIcKGMSWFQwQ/DIoBrkASCkncBIALbImW
         ovXjCz0vPL0IwyG05D0ScobV3buaYwTntzRWG4DvErPgobGS3lP6aF57Y5z/ROppbM15
         U5alV4hGDTuqamCbUCRSnEElgLlyHQqyfApA9IFdiByMiEgJ9T5aChZZ8FuOLffq7taE
         8RCryXNGD6+QzxN4QWCFwCmheQXdMAr5LaXXLZuZJoit1BPXhkYBBltSg8ODItIgxHp4
         ULkURkvuGrMOziExOLhaMa/N/5bMiNtXHKjvWx5fTW5xKcw7pTxjO4xz/fvpWPD8dS5Q
         jWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z8BEo0x7DBxygVu3ezyut+Q+/5lHQFyLMFsea6yH4dY=;
        b=B9G166sWDSpp4jE6qoPX2pQXGCyQuB2kCAdweMbszXFTdI4MGQTuW3doFDTB1Gx4xQ
         iQv6T69xGN1y1MX5s4oySAR2wLt0A0vgnqkg15k2V9307IOGY1NMwB7dFVFCuucZgHkP
         CO27SbhROxy4n/klh/EvY5AFR2yyX8D85sVIfgmeCV97kxIH9CFB699hjOYHxEtIHLuQ
         MCoiUhcakmQ8bOAPFcj8gPucUeW9nISWk32ifndiaAlYMc4mkQ8zQAh1UlxW/1UMfAHu
         ghL0OwHBvWB34K5dfVOoiJw3s2+2xzti9+AwwgOTbjjXwff0N2zAGVwQuN+dLDfp2J6T
         ADRQ==
X-Gm-Message-State: AOAM530aDNwEwe1IJEJOKGDnICWanLNf+/UMR/2JVmSKbFz3BqHS+ntD
        HNhCQnhHp1Qpm1atvMCfdGk=
X-Google-Smtp-Source: ABdhPJyZWAhNIXxg3LfT4oElO/X43US70dnQmIy4NoyGeM0Dg949Sb1UtyuDuo3lMLZdX0WTBziFrQ==
X-Received: by 2002:aed:2744:: with SMTP id n62mr24170273qtd.67.1605101681720;
        Wed, 11 Nov 2020 05:34:41 -0800 (PST)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id r190sm1997814qkf.101.2020.11.11.05.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:34:41 -0800 (PST)
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
Subject: [PATCH seccomp v2 6/8] sh: Enable seccomp architecture tracking
Date:   Wed, 11 Nov 2020 07:33:52 -0600
Message-Id: <61ae084cd4783b9b50860d9dedb4a348cf1b7b6f.1605101222.git.yifeifz2@illinois.edu>
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
for sh.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/sh/include/asm/seccomp.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/sh/include/asm/seccomp.h b/arch/sh/include/asm/seccomp.h
index 54111e4d32b8..d4578395fd66 100644
--- a/arch/sh/include/asm/seccomp.h
+++ b/arch/sh/include/asm/seccomp.h
@@ -8,4 +8,14 @@
 #define __NR_seccomp_exit __NR_exit
 #define __NR_seccomp_sigreturn __NR_rt_sigreturn
 
+#ifdef CONFIG_CPU_LITTLE_ENDIAN
+#define __SECCOMP_ARCH_LE		__AUDIT_ARCH_LE
+#else
+#define __SECCOMP_ARCH_LE		0
+#endif
+
+#define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_SH | __SECCOMP_ARCH_LE)
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"sh"
+
 #endif /* __ASM_SECCOMP_H */
-- 
2.29.2

