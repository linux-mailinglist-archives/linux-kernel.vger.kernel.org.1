Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 509C12FE38E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbhAUHMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:12:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:36778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726769AbhAUG7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:59:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4DAFB239E4;
        Thu, 21 Jan 2021 06:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611212233;
        bh=aRLtqF4YbrQ34I9YroLtA3j5T30/Mx9DbP0nQnuPAfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bn7OfkVCVZiydpcgdtTT/pbYowNWdut5YPGO4NDRSHX4w6mM3v6f7UnlBR31EzNl2
         IMSQfK18ZsFe6SZHRKpky8qujXd+QFsyuJ/vmNk6FoamO7k7XQgjehbcWxpfFNS4ZK
         oBK0GyVf4zCy3VvoR83HPbCMGhVamvnwD8kHS4F04sq5caEfeqcyXce4VzKLs5SIUI
         3TNm0Z8CN+1KGMMpcWs4yflSfTTlcXTixc4v61kaoLtgYy3pcFj82247pfmY8XQxxk
         Pv3hAt/GDcg6GjDY9dVLCkZozM93CL0V4xb3InN+FibBAUto5gfUmuh3XfNWkOxpL0
         jASyJfMII28+A==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 17/29] csky: Fixup do_page_fault parent irq status
Date:   Thu, 21 Jan 2021 14:53:37 +0800
Message-Id: <20210121065349.3188251-17-guoren@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121065349.3188251-1-guoren@kernel.org>
References: <20210121065349.3188251-1-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

We must succeed parent's context irq status in page fault handler.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/csky/kernel/entry.S | 2 +-
 arch/csky/mm/fault.c     | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/csky/kernel/entry.S b/arch/csky/kernel/entry.S
index 185fea477a8d..c1bd7a6b4ab6 100644
--- a/arch/csky/kernel/entry.S
+++ b/arch/csky/kernel/entry.S
@@ -42,7 +42,7 @@ ENTRY(csky_pagefault)
 	SAVE_ALL 0
 	zero_fp
 	context_tracking
-	psrset  ee, ie
+	psrset  ee
 	mov     a0, sp
 	jbsr    do_page_fault
 	jmpi    ret_from_exception
diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 9533bd8d9a6a..cd8c7304c7e9 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -143,6 +143,10 @@ asmlinkage void do_page_fault(struct pt_regs *regs)
 		return;
 	}
 
+	/* Enable interrupts if they were enabled in the parent context. */
+	if (likely(regs->sr & BIT(6)))
+		local_irq_enable();
+
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
-- 
2.17.1

