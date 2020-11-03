Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25BE2A48BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 15:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbgKCOUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 09:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729240AbgKCNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 08:45:16 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C86AC0613D1;
        Tue,  3 Nov 2020 05:45:16 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id k9so14611729qki.6;
        Tue, 03 Nov 2020 05:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+eMXBOnvKPM7N/Eu0cs4UA1I6FeurfdgB6uFLVTMPX8=;
        b=WQlGQ9Jd6IJQey7nb9UMUDYsL+DEjmMTVkMHPOOrYSdV926tvA93ywvzKvPW9EdJzQ
         xWYruju83XXsh1i6XxcvxRg6hDqU6tq8BaNfGIDHsg2pgJYtsAkvynEeGwGPRGe+ZPsx
         biGcniO7POm0x08s1Iwq88HHNGiqadVQYcORh5b/WkN2ytRV8n2H7zXHbG9CyN36/TNs
         CvFVpr4PvgANBbzTT2RtpSiuCEWpI/CT6RmO+Fk+zaNRO64hUzWUoNMlpPKDi4ZwlNos
         6rRlllg7BYoJdX53s9pkkLBvkmTEqozVXkK0+PARPMrbpsjLaiSLI/uef0UWqLlg9En5
         LfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+eMXBOnvKPM7N/Eu0cs4UA1I6FeurfdgB6uFLVTMPX8=;
        b=HaayDovTTYcLgBXGwRpwF834DWJCnWt26Nyrkv9jU0mFLzanG2jws27siHN0vFu1kL
         VF7IUlyXKExnFbU23Seq5Ym8g3b5R5a0cqH7hTVCOiYhK8IM7h0nH/r+h6U6fhtGCUYF
         TnhvbOEfI+CQR1R72okp0nMIiDiMOv0U1ljFYam0QfbnAEqWBX3Ib/Y2f7vmOFFejeCJ
         sAG/NsGhV5QLm8ASVCFb6Onx6pOkFUQY/5pwzl76uXfx4ztyGxY+c06YEim8zJbZ00xH
         B4aF6DWckYlYinuJK8g+pNVqTKusGApegVWZUgvMHgJaMFv4GG/V+sb0X679CPFof7Rp
         Jfbw==
X-Gm-Message-State: AOAM532hEiDGtxucYTQXXbbmODfRf6sBpMLd462RD8tJ91Hnls+OYOFH
        96ykj+alVkdTvHkz+tJyCmE=
X-Google-Smtp-Source: ABdhPJwPGCoGB0mzNqbRbE7eqaQrs2dVEZ+ysMN9iFWpphI5Jv582QKy4aIVAjZqImUIW48ZcJyckw==
X-Received: by 2002:a37:6187:: with SMTP id v129mr8374191qkb.31.1604411115473;
        Tue, 03 Nov 2020 05:45:15 -0800 (PST)
Received: from zhuyifei1999-ThinkPad-T480.gw.illinois.edu ([2620:0:e00:400f::31])
        by smtp.gmail.com with ESMTPSA id a206sm7356568qkb.64.2020.11.03.05.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2020 05:45:14 -0800 (PST)
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
Subject: [PATCH seccomp 5/8] s390: Enable seccomp architecture tracking
Date:   Tue,  3 Nov 2020 07:43:01 -0600
Message-Id: <0fbe0c14d598e18effad3b648ab4808f9cd95eba.1604410035.git.yifeifz2@illinois.edu>
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
for s390.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/s390/include/asm/seccomp.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/include/asm/seccomp.h b/arch/s390/include/asm/seccomp.h
index 795bbe0d7ca6..71d46f0ba97b 100644
--- a/arch/s390/include/asm/seccomp.h
+++ b/arch/s390/include/asm/seccomp.h
@@ -16,4 +16,13 @@
 
 #include <asm-generic/seccomp.h>
 
+#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_S390X
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"s390x"
+#ifdef CONFIG_COMPAT
+# define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_S390
+# define SECCOMP_ARCH_COMPAT_NR		NR_syscalls
+# define SECCOMP_ARCH_COMPAT_NAME	"s390"
+#endif
+
 #endif	/* _ASM_S390_SECCOMP_H */
-- 
2.29.2

