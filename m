Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9425E270125
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 17:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIRPfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 11:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgIRPfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 11:35:53 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CD1C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:35:53 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k13so3185735plk.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 08:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcopGDK9hSIqTxMAksLRcaCuxtkJfGidWzxvqmPC0LQ=;
        b=rF1V+JFDa5AQPi3fis7yf6icTw5fAdLTA7IvNSYm5Jg7mKZcqMwY6CpvJ08/7xYEiE
         0gt5PxOVHldqv/dlf1h/yTTAC/VDW9gfnuSvGI6WwlOihhLsYyYjRuYo81xpg1WDxEz7
         1fqiM15pGYTN3gyOVg40BpunAltKQd3snX0+BN3bSTiNTN2suNE89iHboOR32eysWA5Y
         3k6SbPV5/HLvo2IgqZZWEBkDc80sNaVOcFeBQ/0CFTgzQsr2D4+DSA0CwA4LURjDAP1F
         Bz5ohMbUGOzvov/LH0Dg3tHEOl2qGF+hjC2IApFZGFyyg3rDhC+esG8jPClg20eNCI4a
         XQXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QcopGDK9hSIqTxMAksLRcaCuxtkJfGidWzxvqmPC0LQ=;
        b=YlSs7Mjfx7zIamA6Ibgbvcojv5We7vj2S3XreNb/+PrEEDZLX3leY0E4wkOFhzBouB
         0v/GqXlJj6Mg5R6tMuCBnar126YtWCGBFYKhhDS1/4U13T+SsVuHm40jRFHmPSEHMNwd
         36eiEdlJ/fUMO63Kt2buP8/45u0b+TPXK/qXP3MObv9EIMCMUaJ3yyUCGRLf3kVu/vk5
         YpaDL6Og45kBw72vQFmagX9uZmjZNm+jWs/n18Qy+pKxTOBQsY394meeLWObW/yLWR7x
         Lxu7ZP8ekCU717nzcFtver9nUz0PfeyeOkzn+kbsxGjvlfqtN0FwvpMdbKB4aQYRwAMl
         8BXA==
X-Gm-Message-State: AOAM530jx6m/BlioWQCZXADDj4k6rCss24UXJG9EFkpKfKOkDJ83qwA8
        ifQ2lrvpa4Y3KEaEIc90VBw=
X-Google-Smtp-Source: ABdhPJzf9qo2foejLIFjrh+UevPzj8GAcsp6eUOrgT9WNBxjFVSQufeSbDF2kyFeL6TpUXSVny/74Q==
X-Received: by 2002:a17:902:8306:b029:d0:cbe1:e7aa with SMTP id bd6-20020a1709028306b02900d0cbe1e7aamr33728872plb.27.1600443353096;
        Fri, 18 Sep 2020 08:35:53 -0700 (PDT)
Received: from localhost.localdomain ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id y29sm4047910pfq.207.2020.09.18.08.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 08:35:52 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] arm64: ipi_teardown() should depend on HOTPLUG_CPU
Date:   Sat, 19 Sep 2020 00:35:48 +0900
Message-Id: <20200918153548.836986-1-sergey.senozhatsky@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ipi_teardown() is used only when CONFIG_HOTPLUG_CPU is set.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 arch/arm64/kernel/smp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index b6bde2675ccc..82e75fc2c903 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -82,9 +82,9 @@ static int nr_ipi __read_mostly = NR_IPI;
 static struct irq_desc *ipi_desc[NR_IPI] __read_mostly;
 
 static void ipi_setup(int cpu);
-static void ipi_teardown(int cpu);
 
 #ifdef CONFIG_HOTPLUG_CPU
+static void ipi_teardown(int cpu);
 static int op_cpu_kill(unsigned int cpu);
 #else
 static inline int op_cpu_kill(unsigned int cpu)
@@ -964,6 +964,7 @@ static void ipi_setup(int cpu)
 		enable_percpu_irq(ipi_irq_base + i, 0);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static void ipi_teardown(int cpu)
 {
 	int i;
@@ -974,6 +975,7 @@ static void ipi_teardown(int cpu)
 	for (i = 0; i < nr_ipi; i++)
 		disable_percpu_irq(ipi_irq_base + i);
 }
+#endif
 
 void __init set_smp_ipi_range(int ipi_base, int n)
 {
-- 
2.28.0

