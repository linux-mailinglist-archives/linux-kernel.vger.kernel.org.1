Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 382252FE350
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbhAUHB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:01:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:36452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbhAUG5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:57:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C5AC23977;
        Thu, 21 Jan 2021 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212195;
        bh=+lVc5kXTHoD8tXEyQxzixx97JVig0Qgc5LRMhACBKUo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OPeyHBUYxylR9oygPRH5nLMX+1cmIMb3Vm/pp29MJz+f4jzezAqXcQzj8GK0+KxBC
         6yKjOtMKPX/yEGL9VTvGU7KoRTL9uVZYS48L4FEHznRkurjWrvhBRcpvecgWAhK+PQ
         USXskH86IBxhr6D09Es1U33PyPleY1JsGtM2xhZAS5Abj5oQGcFUYvcsYC1ZnwRci3
         T1COYRMtYgMgaJZ7SunCY4QpFrXhAPKtV7REQLayw2yBGe1tJivSeyeVgsmPFHfBP1
         5K2as6FOe2b884yiKwB2XLE0WwNCH1mQycMqnXIhhh5LI+Fjkze8OEnnW06ZVd+1Yx
         78A1dlOky3iiw==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 03/29] csky: Fixup show_regs doesn't contain regs->usp
Date:   Thu, 21 Jan 2021 14:53:23 +0800
Message-Id: <20210121065349.3188251-3-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current show_regs didn't display regs->usp and it confused debug.
So fixup wrong SP display and add PT_REGS.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/ptrace.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index d822144906ac..e5bd4e01b861 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -363,9 +363,10 @@ void show_regs(struct pt_regs *fp)
 
 	pr_info("PC: 0x%08lx (%pS)\n", (long)fp->pc, (void *)fp->pc);
 	pr_info("LR: 0x%08lx (%pS)\n", (long)fp->lr, (void *)fp->lr);
-	pr_info("SP: 0x%08lx\n", (long)fp);
-	pr_info("orig_a0: 0x%08lx\n", fp->orig_a0);
+	pr_info("SP: 0x%08lx\n", (long)fp->usp);
 	pr_info("PSR: 0x%08lx\n", (long)fp->sr);
+	pr_info("orig_a0: 0x%08lx\n", fp->orig_a0);
+	pr_info("PT_REGS: 0x%08lx\n", (long)fp);
 
 	pr_info(" a0: 0x%08lx   a1: 0x%08lx   a2: 0x%08lx   a3: 0x%08lx\n",
 		fp->a0, fp->a1, fp->a2, fp->a3);
-- 
2.17.1

