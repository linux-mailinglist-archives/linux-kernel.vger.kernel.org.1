Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DED7276492
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 01:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgIWX32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 19:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgIWX31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 19:29:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C9C0613D2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:29:27 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id q12so557769plr.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 16:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dRM2RxYevz4ZLx42XYlJ4AIQPGby+e+r+LDyrwiMJmY=;
        b=YImT8s0t4ro5HLSsWUw0wPm9p8M2rMPRr1XMLfBu5tvvY24Y3b7+SScvQCxYa+mKnA
         hgoYM5/ccPMAXnlw70N83Y9+Cl38QLui9PJIpibXpOgNKL6n5KQ4soHzwx2kGWb3WXCm
         Jnq0DOeHpwfCyW/oH3OOX/dvAtuDKFlbXMpdQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dRM2RxYevz4ZLx42XYlJ4AIQPGby+e+r+LDyrwiMJmY=;
        b=NmSNVZU5yPynFKlrujbXFMOUYnq5i3vVpGc5M4Q1OsZpZTCG9oA43ppb7aVkVhV7Db
         PUkEIHJnH6lNNCnCwRvIzM2N7MPzD/AFEgMd30bPGk16QWkXZdZYIOW1+k2FyF3MdqVy
         TJdNZ+h6YVNijzHp2/0z4y4cELV7+zVoTDkLkkCTdDMJed4cCk8R3Ta+QIR3zDZKKYrb
         r5iDbL2xrpN3OTBc1Fd5hZwiG2qB2Ms/RJEZdXOZtmwn667ayR5vlUeiEkHXrIfUtVYZ
         tG6PSsVBKi8LUIQkBaz/hVsPy1HOz63JzgjsMDAZAGH43fVh1XHDKJ3+/bf52DAIyean
         herQ==
X-Gm-Message-State: AOAM531RK1wn+cqH6nFy/GjuNUlLkq01dcUyjpxesryfXo1J+ZH8CWw9
        GmwSUS/HeY2sxNwZ8UjsYm+7Ow==
X-Google-Smtp-Source: ABdhPJxLRLuysYMwMBl98TDjJXH+A1GJK5BYJ/9bxber4JuLQfhK8FiL18o08N5dn4Gk6n7figNXTQ==
X-Received: by 2002:a17:90a:4046:: with SMTP id k6mr1441778pjg.11.1600903767231;
        Wed, 23 Sep 2020 16:29:27 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c186sm828427pga.61.2020.09.23.16.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 16:29:26 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     YiFei Zhu <yifeifz2@illinois.edu>
Cc:     Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
        Valentin Rothberg <vrothber@redhat.com>,
        Hubertus Franke <frankeh@us.ibm.com>,
        Jack Chen <jianyan2@illinois.edu>,
        Josep Torrellas <torrella@illinois.edu>,
        Tianyin Xu <tyxu@illinois.edu>, bpf@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] x86: Enable seccomp architecture tracking
Date:   Wed, 23 Sep 2020 16:29:19 -0700
Message-Id: <20200923232923.3142503-3-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200923232923.3142503-1-keescook@chromium.org>
References: <20200923232923.3142503-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide seccomp internals with the details to calculate which syscall
table the running kernel is expecting to deal with. This allows for
efficient architecture pinning and paves the way for constant-action
bitmaps.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/seccomp.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/seccomp.h b/arch/x86/include/asm/seccomp.h
index 2bd1338de236..38181e20e1d3 100644
--- a/arch/x86/include/asm/seccomp.h
+++ b/arch/x86/include/asm/seccomp.h
@@ -16,6 +16,20 @@
 #define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
 #endif
 
+#ifdef CONFIG_X86_64
+# define SECCOMP_ARCH					AUDIT_ARCH_X86_64
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT				AUDIT_ARCH_I386
+# endif
+# ifdef CONFIG_X86_X32_ABI
+#  define SECCOMP_MULTIPLEXED_SYSCALL_TABLE_ARCH	AUDIT_ARCH_X86_64
+#  define SECCOMP_MULTIPLEXED_SYSCALL_TABLE_MASK	__X32_SYSCALL_BIT
+#  define SECCOMP_MULTIPLEXED_SYSCALL_TABLE_SHIFT	29
+#endif
+#else /* !CONFIG_X86_64 */
+# define SECCOMP_ARCH					AUDIT_ARCH_I386
+#endif
+
 #include <asm-generic/seccomp.h>
 
 #endif /* _ASM_X86_SECCOMP_H */
-- 
2.25.1

