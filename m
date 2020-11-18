Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35372B74E1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 04:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKRDgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 22:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726682AbgKRDgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 22:36:47 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577E7C0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:46 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id 18so229118pli.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 19:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yqr8AsUYG2ItLZV8enoV8lgL+MN51d74ph8g1LaesdQ=;
        b=QsbAhJc2P5LOy2hC3PEJf5EPG+nTFix+lXpYMc+mvc7bnjIra5/S1c/gaxanFsVpr1
         wRXl36PuX/Zr+nteo7Z/m1jtqxMlAx3xpynvcAMkX6a58yMvOfnNZcy1Is+jTsQSTtvs
         C2s6Hbp0a2LIGv04vFMb5hVCK3qhGTr7Q798yJdVtZkqotX3GhWAOFJB4Q6PY5oki6YW
         +aWt90EiAr3Qx9XWkHRTKZyNE8GlwROyD7sIIDN62KF+hVk+PCFEHicNZ48etsG0Rug4
         /fnXTzuFNp0z4Rt8gyfsHzCUrEYmVNfzE8tgHkp6LK/Q7N6lz+PB1e5E+fCr06/CWzj+
         n3Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yqr8AsUYG2ItLZV8enoV8lgL+MN51d74ph8g1LaesdQ=;
        b=a1hNBTWtzdAJcCSKRd1Pj9RYFyki152N3OWK+JkpoavIjXmrtLegaJBSqmLNBfJYzd
         Ko/UHXaZBRxS2pJHMPFqeotIvq/OTIvsSVZhGNern7dwGvuI3evWC8YPUiT8zK+eSNCb
         gq+YdUwIw/P2rIJEA7oS253HQibDazg9wrNcM6nLaA5gamlYA1s6XUAVehTiuqBPhk9P
         lE3eqgBtouZKmMyLnbqlvCHSObZjwvdYGpTlqrAlOxkjy5NzABnETmCY6jwyZHWI4t1l
         kOpi0UxWagYyeQWwqAyG+MOmQT5lxgKhxLl6Rdm2nMBYkR8W0V5pm/r86MmdYMpqeLFb
         k6kg==
X-Gm-Message-State: AOAM530cVg2RLCmE4r8nI5lEPgIYWRoQyvGQ2/VjVS2aTa+mpiK2TRPw
        oERVgeKzM0D3xO7xlc8EzwYfqd9sMg==
X-Google-Smtp-Source: ABdhPJwzvXS9+3dmJ/n2yhqjEhXApm0rTg/0sQVduxqvIVErGrqMYrrnu6XuQgVNjQwMUx0y8KW18g==
X-Received: by 2002:a17:90a:e28f:: with SMTP id d15mr2065106pjz.96.1605670605815;
        Tue, 17 Nov 2020 19:36:45 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s21sm8915450pgm.65.2020.11.17.19.36.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 19:36:45 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Petr Mladek <pmladek@suse.com>, kexec@lists.infradead.org
Subject: [PATCH 1/3] x86/irq: account the unused irq
Date:   Wed, 18 Nov 2020 11:36:16 +0800
Message-Id: <1605670578-23681-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
References: <87tuueftou.fsf@nanos.tec.linutronix.de>
 <1605670578-23681-1-git-send-email-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Accounting the unused irq in order to count it if irq flood.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: kexec@lists.infradead.org
To: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/irq.c       | 1 +
 include/linux/kernel_stat.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index c5dd503..6f583a7 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -254,6 +254,7 @@ DEFINE_IDTENTRY_IRQ(common_interrupt)
 			pr_emerg_ratelimited("%s: %d.%u No irq handler for vector\n",
 					     __func__, smp_processor_id(),
 					     vector);
+			__this_cpu_inc(kstat.unused_irqs_sum);
 		} else {
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 		}
diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 89f0745..c8d5cb8 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -37,6 +37,7 @@ struct kernel_cpustat {
 
 struct kernel_stat {
 	unsigned long irqs_sum;
+	unsigned long unused_irqs_sum;
 	unsigned int softirqs[NR_SOFTIRQS];
 };
 
-- 
2.7.5

