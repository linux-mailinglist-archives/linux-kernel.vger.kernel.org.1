Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E7B2CF2CD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388526AbgLDRKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731192AbgLDRKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:10:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3DEC061A54
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 09:09:56 -0800 (PST)
Message-Id: <20201204170805.338268919@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607101795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TFX54TvGMffw/o6aEgrLgJJn5GPJ5JlAAN3zCOb5gkI=;
        b=HsSGcBo460yo8QLH5CAwtgokj1BB+HP4qjRZGSbtkVPg5PhrHnFVoSrkYB7pwpm/mW3Nz5
        mK0U6FmswsvAbXhHfPgOewak+qxcSMszCkAMdYRmfX0r4x6jIZ9L1CTtuPziawuNeQFmKZ
        zjOsRMG+IKDOBlNuZRFnqZcrjLVD0NSqD6z0cyK/on2/uZsBPLEhlMKpWQ85lAGqLH9S9y
        T/4M/vaUDngt1uPRUTrStwP402hGR7bH5vzWvcPCAFOOiK3Mh0rUS08O5Q0/CmtseiJ7xB
        5r3z9svzR+K/BN4+/eOhrm1V+d7aepuyXLQg0VpQNMoqrxQbAGznJjwQIelTig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607101795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=TFX54TvGMffw/o6aEgrLgJJn5GPJ5JlAAN3zCOb5gkI=;
        b=x7HEbA/zFI3LrnItfShrgVVc+paHq90pyramZ4jF5HCd3RIij3NSB1L/oGWz+Ne8FSkFkp
        EFYYGQAYOn7oLAAw==
Date:   Fri, 04 Dec 2020 18:01:57 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [patch V2 6/9] rcu: Prevent false positive softirq warning on RT
References: <20201204170151.960336698@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Soft interrupt disabled sections can legitimately be preempted or schedule
out when blocking on a lock on RT enabled kernels so the RCU preempt check
warning has to be disabled for RT kernels.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/rcupdate.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -319,7 +319,8 @@ static inline void rcu_preempt_sleep_che
 #define rcu_sleep_check()						\
 	do {								\
 		rcu_preempt_sleep_check();				\
-		RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
+		if (!IS_ENABLED(CONFIG_PREEMPT_RT))			\
+		    RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map),	\
 				 "Illegal context switch in RCU-bh read-side critical section"); \
 		RCU_LOCKDEP_WARN(lock_is_held(&rcu_sched_lock_map),	\
 				 "Illegal context switch in RCU-sched read-side critical section"); \

