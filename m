Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 859212B1D1C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 15:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgKMOYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 09:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgKMOYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 09:24:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6F49C0613D1;
        Fri, 13 Nov 2020 06:24:18 -0800 (PST)
Message-Id: <20201113141732.844232404@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605277456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ldQX6LV392Sp6q38lky8DIKaFNB4v1tclruB3q140vY=;
        b=DWxKl2oTbNiJFq242wyZFcPjhLIfi3MaxEuLNamTK0kgTpXZwoj9qCXalq5cmZeVakyDGb
        cvWQ7byxNNAmxOd6N/SxAJvBHXxlhNqBclgGsibUj82yLY8MuKQzAAPCHCjAf/qIYHy2D6
        W5tsHVECZdJYVjqPxrYP9rLOyReZ2k4MtGlj43h6ccGqhN6bZQ5/IjSB2po7a0CWoD980B
        iAvURAzqfrzpjhUJg4BBA0zGWTdL77O8rgWb0A1nTMg+XWiIZq71MMP2TqSl2LZoyObVtA
        VkoPC+VsDJte/Al56vqeV/59r0im2vkOGC5hEHuQhQqiYjuYshTMPE/PIM8NqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605277456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=ldQX6LV392Sp6q38lky8DIKaFNB4v1tclruB3q140vY=;
        b=nExdUbbfCrGRLLhnMqfpr0nkpzGHfv4w1OWpXggW5hEFnW/+ZTqdLmi9nHPs7YdyQs2O8Z
        ljzOoqMbS2TkhZCg==
Date:   Fri, 13 Nov 2020 15:02:09 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [patch 02/19] sh: Get rid of nmi_count()
References: <20201113140207.499353218@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nmi_count() is a historical leftover and SH is the only user. Replace it
with regular per cpu accessors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/kernel/irq.c   |    2 +-
 arch/sh/kernel/traps.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/arch/sh/kernel/irq.c
+++ b/arch/sh/kernel/irq.c
@@ -44,7 +44,7 @@ int arch_show_interrupts(struct seq_file
 
 	seq_printf(p, "%*s: ", prec, "NMI");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", nmi_count(j));
+		seq_printf(p, "%10u ", per_cpu(irq_stat.__nmi_count, j);
 	seq_printf(p, "  Non-maskable interrupts\n");
 
 	seq_printf(p, "%*s: %10u\n", prec, "ERR", atomic_read(&irq_err_count));
--- a/arch/sh/kernel/traps.c
+++ b/arch/sh/kernel/traps.c
@@ -186,7 +186,7 @@ BUILD_TRAP_HANDLER(nmi)
 	arch_ftrace_nmi_enter();
 
 	nmi_enter();
-	nmi_count(cpu)++;
+	this_cpu_inc(irq_stat.__nmi_count);
 
 	switch (notify_die(DIE_NMI, "NMI", regs, 0, vec & 0xff, SIGINT)) {
 	case NOTIFY_OK:

