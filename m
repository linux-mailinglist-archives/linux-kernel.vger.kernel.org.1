Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422022A1E62
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 14:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgKAN4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 08:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgKAN4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 08:56:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72703C0617A6
        for <linux-kernel@vger.kernel.org>; Sun,  1 Nov 2020 05:56:31 -0800 (PST)
Date:   Sun, 01 Nov 2020 13:56:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604238990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5nK8sPCLBsbhimCEuNqJYzRVhV2rMWVbvlZ2rEkhqH8=;
        b=i815qW/qRH2x7Mb/PB0K3gsLxUQtUFeoxxq3YXzSb5mLjSy/S/1f8tLNpdAeZnGwcoeFYO
        AkuCLtIx8BTGS5jVPfWz+DoB4XJ2AO/WcpTC5eSkMb8fWatHc21F2t0lW8vI/10fgp20Hh
        EAyryWO+R3IGE0+EpT7yXhhmHeLXhwegUsgkHII1fRGJuTlCqClHfUJL8Ao2959LqsJ/H9
        13B3ybUdN+MoAliaFua981p9NMFOcOjd332uQyk3Y7q7OpU+cZnMv2zVJ0cRHsJi/5Mr1Y
        HwWuO1sI9wDDzgTE+r0MWKK4N7Pv89N4PcVJXNobifvKc/PfCrfiBZcfc/SoVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604238990;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=5nK8sPCLBsbhimCEuNqJYzRVhV2rMWVbvlZ2rEkhqH8=;
        b=Rx6g3USTbGAZuH2Qdb7qBjw6m0rWAQFouuLnEFWy/pWoDUjdhnF8BCpYI0rwQ8LrvkSPQL
        nOkvIbvvzorapxAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] smp/urgent for v5.10-rc2
References: <160423896136.5667.9743580255833470691.tglx@nanos>
Message-ID: <160423896257.5667.16765311760968430798.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest smp/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git smp-urgent-2020-11-01

up to:  4230e2deaa48: stop_machine, rcu: Mark functions as notrace


A single fix for stop machine. Mark functions no trace to prevent a crash
caused by recursion when enabling or disabling a tracer on RISC-V (probably
all architectures which patch through stop machine).


Thanks,

	tglx

------------------>
Zong Li (1):
      stop_machine, rcu: Mark functions as notrace


 kernel/rcu/tree.c     | 2 +-
 kernel/stop_machine.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 06895ef85d69..2a52f42f64b6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -409,7 +409,7 @@ bool rcu_eqs_special_set(int cpu)
  *
  * The caller must have disabled interrupts and must not be idle.
  */
-void rcu_momentary_dyntick_idle(void)
+notrace void rcu_momentary_dyntick_idle(void)
 {
 	int special;
 
diff --git a/kernel/stop_machine.c b/kernel/stop_machine.c
index 865bb0228ab6..890b79cf0e7c 100644
--- a/kernel/stop_machine.c
+++ b/kernel/stop_machine.c
@@ -178,7 +178,7 @@ static void ack_state(struct multi_stop_data *msdata)
 		set_state(msdata, msdata->state + 1);
 }
 
-void __weak stop_machine_yield(const struct cpumask *cpumask)
+notrace void __weak stop_machine_yield(const struct cpumask *cpumask)
 {
 	cpu_relax();
 }

