Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5589B27AB9A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgI1KNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgI1KNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:13:41 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E55C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:13:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so362468pjr.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7sgTeVLvLeSQvkNniwe9wr5TNxpCRtDL+X32iGc1MCc=;
        b=iPfwpp3kKMvGkz1xjGNkMSNsdE7T70NThsV5YNMEgCWNTgv/RZLxCwl194fLWz3k/u
         HrYQceGM04KbL+JAnVEkr0TVjUj6WqNHNxdWUr8cmijiAvcasz34qBc4LI2mAenBG6DN
         cRRHw6qC0/dAAM/atDPXU99roc77OJKCn1t1UW5MQoGbjEWSVRyn1x0FCKU/LgUYyfzv
         h1xsJakekPBhgWgt/rDUw8Yd2l4NeJY0q85c6YBS5cijM9QRw0DYbKyzVLDdBM/aC7BB
         xtBAtkrdE950JcKyu3q36Uu4BOwg9xt/3PiecxGECuIwgyicRDJzRdds0Uh3pW1tYuET
         HqSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7sgTeVLvLeSQvkNniwe9wr5TNxpCRtDL+X32iGc1MCc=;
        b=s8r4RheAqxdE0tKwnZoXFlkIDLc7Q/sHklqXHWhUokjvbcWuidslu4lXRsySx2G8rA
         DARvSTHCSMq+Nns5+cLtDQU2M9zQ5XAAm2tdsEWKTTXhVdKqFlu0ztKNTyJ8+ZejZaUd
         18TUiqz2EMjOgrn1E3u01iHhWo97J5xOSnjEnB42/wa2wstu5KvvjKZP8W2wqc/WlIaz
         ufvsx5N9KfAxM1AHmmeBcv5mtf/TVmne7g3xYiUyJi2kgdUVJziF0vepRn2Fs8X1ejlf
         /ywf1Z1ji7JcsnixTXi+GTM8NNQYs+AodtlHMp5dHpZZywI4UVPPhdlw6ZTq2Hrwi26O
         8rPw==
X-Gm-Message-State: AOAM533hADK6ofJS6itUhBjNFVi628qVmWH0CuA0Ar8xiuqi+MghiPFS
        bbdngeVPKGokx8W4Zu0bqw==
X-Google-Smtp-Source: ABdhPJw39qHbP1i8jrTbQZ7zdnWe081pF0uB5JBd/ZAcxUPOcxDPn2osBmbWmPZpfudPeStQdYopaA==
X-Received: by 2002:a17:90a:8c83:: with SMTP id b3mr672760pjo.206.1601288021409;
        Mon, 28 Sep 2020 03:13:41 -0700 (PDT)
Received: from localhost.localdomain ([47.242.140.181])
        by smtp.gmail.com with ESMTPSA id 1sm865539pgm.4.2020.09.28.03.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 03:13:40 -0700 (PDT)
From:   Pujin Shi <shipujin.t@gmail.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Maulik Shah <mkshah@codeaurora.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     linux-kernel@vger.kernel.org, shipujin.t@gmail.com
Subject: [PATCH v2] MIPS: irq: Add missing prototypes for init_IRQ()
Date:   Mon, 28 Sep 2020 18:12:41 +0800
Message-Id: <20200928101241.1240-1-shipujin.t@gmail.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

init_IRQ() have no prototype, add one in linux/irq.h

Fix the following warnings (treated as error in W=1):
arch/mips/kernel/irq.c:52:13: error: no previous prototype for 'init_IRQ' [-Werror=missing-prototypes]

Signed-off-by: Pujin Shi <shipujin.t@gmail.com>
---
 include/linux/irq.h | 2 ++
 init/main.c         | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 63b9d962ee67..4e8c462e00fc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -585,6 +585,8 @@ enum {
 # define ARCH_IRQ_INIT_FLAGS	0
 #endif
 
+extern void init_IRQ(void);
+
 #define IRQ_DEFAULT_INIT_FLAGS	ARCH_IRQ_INIT_FLAGS
 
 struct irqaction;
diff --git a/init/main.c b/init/main.c
index 1af84337cb18..63c7cd1f2131 100644
--- a/init/main.c
+++ b/init/main.c
@@ -110,7 +110,6 @@
 
 static int kernel_init(void *);
 
-extern void init_IRQ(void);
 extern void radix_tree_init(void);
 
 /*
-- 
2.18.1

