Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BF022AF23E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgKKNfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKKNee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:34:34 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49693C0613D1;
        Wed, 11 Nov 2020 05:34:34 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id i12so1261149qtj.0;
        Wed, 11 Nov 2020 05:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wWgXpwOKfWu89zfH4z55YdVS4FoKgsyU3KjhUPw2Xk=;
        b=dNmx8letqvw7/kng3JJM9MT8cp864llEi2W+fdgHjl0ywQOexzPsPUHJHFNPynp1Fu
         KyowDk74TZHDe12eygZFrmJx/0ykft94sWcknmiP/gb2ci8KYGrnhUPNAVoX1CQ7micC
         W9dxg0yPt32jkNPh+v2S6Ec8TERKRUxhAcuQXa3NFkbWo80pdfJ6Bl7pZT/OVLOTmPOj
         ZqSlW3XjT5hv6sk/2vSinzAG6ZS7KozmDUro8la2o7lq04jT1uzUKYXTrmPAjUt7smwf
         isz4yxPSfYvHYghHVVTVYFLVyuwWgAnYoJ33J4COWXdBK+Sc1/TKSOTKCGWEZcvZVt2n
         sfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/wWgXpwOKfWu89zfH4z55YdVS4FoKgsyU3KjhUPw2Xk=;
        b=h78nz0hI6MZDa1YGKfIIaf5Ib28oKQqZEGfI4dsANSmULyZGuoSM7BLNepzkV3J49a
         Yl5pv6BCSh4JtQkTimxA6tomgFRf+Qns3v3hyyR8bgU6uS5sYnKf5Uu67+c5X8we90wZ
         mPgCymCs53jdzB57iFN8HLtQ+gbQyivTXttn0CPSSSNOdaDh+KrPdKKc2IqT2eCXfMxI
         HQc/efBO2E7N9UNDGcWsqq1JnGXpYWID5D7k4uZd0MelU1kbbwwXEIMFrQIvNnmRWbzi
         BV6AO3dZqztbtL6Esjmw6KMQ8zbFnBxJiwOcB0iXvIWy35I35hCkjBdds+Eo6PoI3u2J
         XBEQ==
X-Gm-Message-State: AOAM532z5g+8z+5Bdi4dkyTNvE4z8CKZB0pVf1DP9k6QazPwfEdwpHz0
        zPxw6HkFTKZQEr82eH5l+Tc=
X-Google-Smtp-Source: ABdhPJyXr79D39F72KQTAuWFk25+3xGmXqPHFQ+ygjm2TFYHLHgr595PCW4dLHay6xJ4RhIuu7lNGA==
X-Received: by 2002:ac8:5901:: with SMTP id 1mr17048871qty.350.1605101673552;
        Wed, 11 Nov 2020 05:34:33 -0800 (PST)
Received: from localhost.localdomain (host-173-230-99-154.tnkngak.clients.pavlovmedia.com. [173.230.99.154])
        by smtp.gmail.com with ESMTPSA id r190sm1997814qkf.101.2020.11.11.05.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 05:34:33 -0800 (PST)
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
Subject: [PATCH seccomp v2 1/8] csky: Enable seccomp architecture tracking
Date:   Wed, 11 Nov 2020 07:33:47 -0600
Message-Id: <f9219026d4803b22f3e57e3768b4e42e004ef236.1605101222.git.yifeifz2@illinois.edu>
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

