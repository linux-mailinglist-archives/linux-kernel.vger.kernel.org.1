Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDA12AF2AA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgKKNfP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgKKNeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:34:44 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083EC0613D1;
        Wed, 11 Nov 2020 05:34:44 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id r7so1616620qkf.3;
        Wed, 11 Nov 2020 05:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KyUFBIsp7WG/ZlJY7JJxE8NR9eUIpLAxO9Zr6R0PBAI=;
        b=F8D/Y+HZfrpZoxY1WSpU1XD08FGxbbmSRvBeCuS4pVYlmDmDfHK+86TEUz2GSieEB6
         /G826gCZaufPpqw9yqU3gNUSRCTgM9O12K4UhmNyeNdIkVTjqwPtJI9Lf+tvkb9Fg8+c
         qRpmL5clJ5CA1S+ea2Ab7oCBQhLxWEhivtggHkttRUxU6H+6bwKCbKQw40vyQeowP2ps
         XMXoUoPJxCmgod7Htt5aWIQRnBxAeBFeM00worN++PmF2dIyJGX4tB4Z/JpSdxEQSkmp
         0SlWBQ6C7R2fx7uyThUkfX85xTr/0pRg1d8IYFbC/KQ5PAYWXyryWS92ixdQ2PxoggBD
         zMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KyUFBIsp7WG/ZlJY7JJxE8NR9eUIpLAxO9Zr6R0PBAI=;
        b=sGJIOL0371+AIlMFiGJSlRBsJaxMZzXamk7ozzuv8jsxtkqNGrBlwyCGG3F9s/94Eh
         lv8f7iaXWAKZH+Tw9bV+wiMjJCDJX3yrcDjBKqh4fW/4RDB3+80lMWUG9me9uYC3RSl0
         j1bj9YxeP0rmR9G0mfLGhracstUmX1MQ9oyj/ueObmjBql4jyADAGxvznXQGRWpvh9jr
         j1b3AR+n03x+7/PZs5uVj71uxu1JqlunVuK5B45Zf8qVCDiMMDm5ii7TKSnB0MpvgS+h
         bXAmZSILDd7Q+yohWab/XzqML4xuaHf2dCyogr0827deTScKKNwJyjEFtgMRnmzx4RqQ
         55eg==
X-Gm-Message-State: AOAM5323EsZRTUMiOXNF5yncWGpgOOdkDjHQ8/yeXOHz9Iz+pf84hF1f
        qjUOXAEoEn0K5/JwiHe51DY=
X-Google-Smtp-Source: ABdhPJz84XkbzmcCHTc2+SdZFUqORQfeEggNtVRT4ylMevKQ8zIMjt4i44s0v7vCLpX1u6c6tS/Tlw==
X-Received: by 2002:a37:4145:: with SMTP id o66mr19607495qka.426.1605101683404;
        Wed, 11 Nov 2020 05:34:43 -0800 (PST)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id r190sm1997814qkf.101.2020.11.11.05.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:34:42 -0800 (PST)
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
Subject: [PATCH seccomp v2 7/8] xtensa: Enable seccomp architecture tracking
Date:   Wed, 11 Nov 2020 07:33:53 -0600
Message-Id: <79669648ba167d668ea6ffb4884250abcd5ed254.1605101222.git.yifeifz2@illinois.edu>
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
for xtensa.

Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
---
 arch/xtensa/include/asm/Kbuild    |  1 -
 arch/xtensa/include/asm/seccomp.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 arch/xtensa/include/asm/seccomp.h

diff --git a/arch/xtensa/include/asm/Kbuild b/arch/xtensa/include/asm/Kbuild
index c59c42a1221a..9718e9593564 100644
--- a/arch/xtensa/include/asm/Kbuild
+++ b/arch/xtensa/include/asm/Kbuild
@@ -7,5 +7,4 @@ generic-y += mcs_spinlock.h
 generic-y += param.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
-generic-y += seccomp.h
 generic-y += user.h
diff --git a/arch/xtensa/include/asm/seccomp.h b/arch/xtensa/include/asm/seccomp.h
new file mode 100644
index 000000000000..f1cb6b0a9e1f
--- /dev/null
+++ b/arch/xtensa/include/asm/seccomp.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_SECCOMP_H
+#define _ASM_SECCOMP_H
+
+#include <asm-generic/seccomp.h>
+
+#define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_XTENSA
+#define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
+#define SECCOMP_ARCH_NATIVE_NAME	"xtensa"
+
+#endif /* _ASM_SECCOMP_H */
-- 
2.29.2

