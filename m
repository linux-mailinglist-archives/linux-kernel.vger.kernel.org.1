Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6EF2C5360
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:55:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388157AbgKZLzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730213AbgKZLzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:55:08 -0500
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0C1C0613D4;
        Thu, 26 Nov 2020 03:55:08 -0800 (PST)
Received: by mail-ed1-x543.google.com with SMTP id cq7so1996660edb.4;
        Thu, 26 Nov 2020 03:55:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=9Hi/Nl+02gC+fyOEUM/sanPTp43DBjXXEgimX2gpIKg=;
        b=N0uyyCx7Rzg1dLhx+KV00YSwGqUXKSRRInBUTtzz99MVN9G/t4nHwGZwe7PIPIZ+5Z
         19JqsfEISo14xR/h6ExiMho+jxE2zOfAhyYqybgzqOs5fJ0c9xw6UW999uDi9XdmsZqy
         YfW2JrxbPgQKPkrwkTxnw676p3T0nf/3KQEXIJSVK/n1v/TkkC55lpg8FFDjtKKz+Zk0
         ZE5PNjLJ/qcvvrMbUN1r+xn2YN1FgMPa+gLHF1OarZ1h4fs+dKE9VpbrYcKUKW6Dq1+8
         wFE0tUMjsurLEcRvLzfd95tko1S3LwEAcNC4XXtvMj555gPsLHiBv4ySthVKfWL4CCvb
         c7Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=9Hi/Nl+02gC+fyOEUM/sanPTp43DBjXXEgimX2gpIKg=;
        b=rfHwwLYv2fIZN/dzyuzQzIzYWsG0g4aUTrtPEoNcQ4A9qHD3IzdjdNSVaPdVyCcgYA
         UfO6Sy1tON6rClRPk1wU/AhPMnLIPrbmc+Ox28kFmMNXUhJ/VEu8Z6QjFKrsFfBkHJBe
         RYCIxU/m3tuULlaujKl1f5KJWms6GHv603RKErfkqV20Q4f9C/OdbfAguqCXZo4igXwB
         Nd05aEjVQdriUmJAz9saGzIi0GHE8vxmGdleTLPv+EO/qC7uYKyzpbpFCC2omJ87Uk51
         nhZw0X8VdmlfyqJIr2Qfc1tQFJ7zwSDgbXyrLKT8nhsbqi0hRaootlhe28xAMRyR/aCs
         AfYw==
X-Gm-Message-State: AOAM530+LL+BLykcforCUUw+K/LGC2I3rh7wg2zFTt5qjC5RS+2RfcYG
        B/VgfWM7+H6C0EcIZKO4G0U=
X-Google-Smtp-Source: ABdhPJwfZTwkjcOOTw5b7qncXxUhldFTlYe5z9eO/dWvEkf7nqcsDyLbfFNnKuVqlPD8aDBFQAUaDQ==
X-Received: by 2002:a05:6402:114b:: with SMTP id g11mr2231855edw.228.1606391707045;
        Thu, 26 Nov 2020 03:55:07 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d3f:bc00:f974:ed5c:285b:a99a])
        by smtp.gmail.com with ESMTPSA id m13sm797993edi.87.2020.11.26.03.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 03:55:06 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Akinobu Mita <akinobu.mita@gmail.com>,
        Joerg Roedel <jroedel@suse.de>
Cc:     "H . Peter Anvin" <hpa@zytor.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86/cpu: correct values for GDT_ENTRY_INIT
Date:   Thu, 26 Nov 2020 12:54:59 +0100
Message-Id: <20201126115459.28980-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 1e5de18278e6 ("x86: Introduce GDT_ENTRY_INIT()") unintentionally
transformed a few 0xffff values to 0xfffff (note: five times "f" instead of
four) as part of the refactoring.

A quick check with:

  git show 1e5de18278e6 | grep "fffff"

reveals all those 14 occurrences:

    12 in ./arch/x86/kernel/cpu/common.c, and
    2  in ./arch/x86/include/asm/lguest.h.

The two occurrences in ./arch/x86/include/asm/lguest.h were deleted with
commit ecda85e70277 ("x86/lguest: Remove lguest support").
Correct the remaining twelve occurrences in ./arch/x86/kernel/cpu/common.c
back to the original values in the source code before the refactoring.

Commit 866b556efa12 ("x86/head/64: Install startup GDT") probably simply
copied the required startup gdt information from
./arch/x86/kernel/cpu/common.c to ./arch/x86/kernel/head64.c.
So, correct those three occurrences in ./arch/x86/kernel/head64.c as well.

As this value is truncated anyway, the object code has not changed when
introducing the mistake and is also not changed with this correction now.

This was discovered with sparse, which warns with:

  warning: cast truncates bits from constant value (fffff becomes ffff)

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201126

Akinobu, Joerg, please ack.

Boris, Ingo, Thomas, please pick this minor non-urgent clean-up patch.

 arch/x86/kernel/cpu/common.c | 24 ++++++++++++------------
 arch/x86/kernel/head64.c     |  6 +++---
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad8480c464..77aec0078fb5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -122,17 +122,17 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 	 * TLS descriptors are currently at a different place compared to i386.
 	 * Hopefully nobody expects them at a fixed place (Wine?)
 	 */
-	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(0xc0fb, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f3, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xa0fb, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]		= GDT_ENTRY_INIT(0xc09b, 0, 0xffff),
+	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xa09b, 0, 0xffff),
+	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc093, 0, 0xffff),
+	[GDT_ENTRY_DEFAULT_USER32_CS]	= GDT_ENTRY_INIT(0xc0fb, 0, 0xffff),
+	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f3, 0, 0xffff),
+	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xa0fb, 0, 0xffff),
 #else
-	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xc09a, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xc0fa, 0, 0xfffff),
-	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f2, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL_CS]		= GDT_ENTRY_INIT(0xc09a, 0, 0xffff),
+	[GDT_ENTRY_KERNEL_DS]		= GDT_ENTRY_INIT(0xc092, 0, 0xffff),
+	[GDT_ENTRY_DEFAULT_USER_CS]	= GDT_ENTRY_INIT(0xc0fa, 0, 0xffff),
+	[GDT_ENTRY_DEFAULT_USER_DS]	= GDT_ENTRY_INIT(0xc0f2, 0, 0xffff),
 	/*
 	 * Segments used for calling PnP BIOS have byte granularity.
 	 * They code segments and data segments have fixed 64k limits,
@@ -159,8 +159,8 @@ DEFINE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page) = { .gdt = {
 	/* data */
 	[GDT_ENTRY_APMBIOS_BASE+2]	= GDT_ENTRY_INIT(0x4092, 0, 0xffff),
 
-	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
-	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(0xc092, 0, 0xfffff),
+	[GDT_ENTRY_ESPFIX_SS]		= GDT_ENTRY_INIT(0xc092, 0, 0xffff),
+	[GDT_ENTRY_PERCPU]		= GDT_ENTRY_INIT(0xc092, 0, 0xffff),
 	GDT_STACK_CANARY_INIT
 #endif
 } };
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 5e9beb77cafd..28d761c6b285 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -69,9 +69,9 @@ EXPORT_SYMBOL(vmemmap_base);
  * GDT used on the boot CPU before switching to virtual addresses.
  */
 static struct desc_struct startup_gdt[GDT_ENTRIES] = {
-	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xfffff),
+	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(0xc09b, 0, 0xffff),
+	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(0xa09b, 0, 0xffff),
+	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(0xc093, 0, 0xffff),
 };
 
 /*
-- 
2.17.1
