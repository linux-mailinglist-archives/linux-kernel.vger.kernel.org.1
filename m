Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC292AF254
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgKKNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgKKNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:34:37 -0500
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C368C0613D1;
        Wed, 11 Nov 2020 05:34:37 -0800 (PST)
Received: by mail-qt1-x842.google.com with SMTP id g17so1244604qts.5;
        Wed, 11 Nov 2020 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p4ug0/ujexdr5eX2KHZwXV+5OEEE0LQ6CHuZfwOYci4=;
        b=vNGoRE4T2vueWtMyfIqsMJnHQf5sexlSfNm5+JYWvZrbhr28FRAtAv3lFmTY0+4W0Y
         WcYZoYHknNJQqlmA5lKA2IjQ5N2wYEjtpuzYl7OO06EsiIGv6XJZ3Kb9UjRl3/b7/1X8
         XfCjrkryG0QaqerFaC1fcQ9Tr2HyAB4KKtxuVtQp0xutUOI57AMaDr4CA2MgmoE4mjCv
         KB12O8KYoI95e70wD3aaXcRNbfK6zccMr68ebqQN7E8uk7S2TR1coNLaubqwUvBts/Lv
         zorqhisqngJ2ZuCEG1/njxhxTc7yrzx1m99VyQR+bb/RgHndyJV5i+iGi1vdeZUV7FdW
         piDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p4ug0/ujexdr5eX2KHZwXV+5OEEE0LQ6CHuZfwOYci4=;
        b=kNHrKJpjnwUFpUjIkHZJfnFlPO31514sfssyvHBhgGUZ2GFgGVDI1Y3Qr64Av5HUOn
         Tn/NMjELOprB9mmQnKqmqngVsqR3dPT6nlCQ+GRO/M4z73dizL5IG6SvNbizrPJJrKvm
         4tkjjJzeenGF9vDIog7vRgrYB64MDkSaM8cOgrbnLGKphK/Pbke779pbyW1mo9uyLdEu
         +ogmWSPlI6G0I3WYvx3XqU+U6rTM1r1Pya5Eaninr1Nmz37Kzy72BTy47Gm7CcGCKiSC
         1mD5ILZyaB2LGP8d4YhRhBpeGpHF6Git1vkuDU6MjybkRqdcdGejnol+O+NkVSPX30Hd
         hAEQ==
X-Gm-Message-State: AOAM530ai8B4VyLDnvpuO3AIvmoya+avyKog0Anm38dqZjyS5BlBTrMd
        fOdqcurAk5pxOIfQV3t2fyg=
X-Google-Smtp-Source: ABdhPJyVXjxkJWplKVPB4NFyM0YLYj5IP428vFSUkWNwwyzA8cf7e/mXCgVyvFukKTHkEaORyR7aHQ==
X-Received: by 2002:aed:39c2:: with SMTP id m60mr12461442qte.206.1605101676823;
        Wed, 11 Nov 2020 05:34:36 -0800 (PST)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id r190sm1997814qkf.101.2020.11.11.05.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:34:36 -0800 (PST)
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
Subject: [PATCH seccomp v2 3/8] powerpc: Enable seccomp architecture tracking
Date:   Wed, 11 Nov 2020 07:33:49 -0600
Message-Id: <0b64925362671cdaa26d01bfe50b3ba5e164adfd.1605101222.git.yifeifz2@illinois.edu>
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
for powerpc.

__LITTLE_ENDIAN__ is used here instead of CONFIG_CPU_LITTLE_ENDIAN
to keep it consistent with asm/syscall.h.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/powerpc/include/asm/seccomp.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/powerpc/include/asm/seccomp.h b/arch/powerpc/include/asm/seccomp.h
index 51209f6071c5..ac2033f134f0 100644
--- a/arch/powerpc/include/asm/seccomp.h
+++ b/arch/powerpc/include/asm/seccomp.h
@@ -8,4 +8,27 @@
 
 #include <asm-generic/seccomp.h>
 
+#ifdef __LITTLE_ENDIAN__
+#define __SECCOMP_ARCH_LE		__AUDIT_ARCH_LE
+#define __SECCOMP_ARCH_LE_NAME		"le"
+#else
+#define __SECCOMP_ARCH_LE		0
+#define __SECCOMP_ARCH_LE_NAME
+#endif
+
+#ifdef CONFIG_PPC64
+# define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_PPC64 | __SECCOMP_ARCH_LE)
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"ppc64" __SECCOMP_ARCH_LE_NAME
+# ifdef CONFIG_COMPAT
+#  define SECCOMP_ARCH_COMPAT		(AUDIT_ARCH_PPC | __SECCOMP_ARCH_LE)
+#  define SECCOMP_ARCH_COMPAT_NR	NR_syscalls
+#  define SECCOMP_ARCH_COMPAT_NAME	"ppc" __SECCOMP_ARCH_LE_NAME
+# endif
+#else /* !CONFIG_PPC64 */
+# define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_PPC | __SECCOMP_ARCH_LE)
+# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+# define SECCOMP_ARCH_NATIVE_NAME	"ppc" __SECCOMP_ARCH_LE_NAME
+#endif
+
 #endif	/* _ASM_POWERPC_SECCOMP_H */
-- 
2.29.2

