Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94F9427D6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 21:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728749AbgI2T3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 15:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728710AbgI2T3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 15:29:47 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937ECC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:29:47 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o21so4577228qtp.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 12:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9LlVi65DFKcmHpSl55kNBX6MX6XVcwkGpRStKg3hTtA=;
        b=KMLp25JdemeZRH9YnTPgRau3PxpNUKZq7kB0DPB21iYmy+yjkBVDENJMBggwthBmaC
         oEelKwJNbiIi8Yz4Rc1QzAOqASky6C7C1Sw3/UQReYKEnQDCP4w9bp2WrOBg5qNlKdYX
         5Y6dbTF4VqO3o1DVVju9/khoO4DpODz+jWbc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9LlVi65DFKcmHpSl55kNBX6MX6XVcwkGpRStKg3hTtA=;
        b=XqSfsmB1RrNNAEnWaxiHFmu4/BzxiFzbfwPvz5SpvIIxM/NLhkcaqji3V4ugkFoFUh
         4IckhUzjIHkd1d729afs3AUfVcjDvMscSC5T7jv7YPH5CGQx9alE8Np7Z5/uRB+PFk/t
         Or4Y8WkdsEwG06hDuBlJwa0p/y9B/vT2ILeh42Om/i/7tJgDSHwgQZ+kIMr4P0qbBwhH
         c8pyJQ60Rq8ajtrTxnQN4jBLluKvRSt+5z82wFSPHf5NJX96mqzaNXyRKKwOwHDR4bW8
         XkWmfpQBHRWxEtcnpCZdt2aLEb0Ba+82DwaHYd5KGD1r8q5faochlV9diJpaIfMrUnBD
         S+lg==
X-Gm-Message-State: AOAM53040le4q0GlkmPHk25ZrDoJcbMQDKUuyYA3nKacFaAk0vbLe3S2
        MQCKCjdTj4RXMLk7A38Q/hZylRuRZrUEsQ==
X-Google-Smtp-Source: ABdhPJzC3RFMOtnlwUVY0Q+I2sFUzuIkHNC9Sb7CI4XfKaPPy+SPpeN/yxmaNlj3Ddvtn2bCQuZYRQ==
X-Received: by 2002:ac8:7b3d:: with SMTP id l29mr5171700qtu.366.1601407786577;
        Tue, 29 Sep 2020 12:29:46 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id n7sm6892887qtf.27.2020.09.29.12.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 12:29:46 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 2/2] docs: Update RCU's hotplug requirements with a bit about design
Date:   Tue, 29 Sep 2020 15:29:28 -0400
Message-Id: <20200929192928.3749502-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
In-Reply-To: <20200929192928.3749502-1-joel@joelfernandes.org>
References: <20200929192928.3749502-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RCU's hotplug design will help understand the requirements an RCU
implementation needs to fullfill, such as dead-lock avoidance.

The rcu_barrier() section of the "Hotplug CPU" section already talks
about deadlocks, however the description of what else can deadlock other
than rcu_barrier is rather incomplete.

This commit therefore continues the section by describing how RCU's
design handles CPU hotplug in a deadlock-free way.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../RCU/Design/Requirements/Requirements.rst  | 30 +++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index 1ae79a10a8de..e0413aa989dd 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1929,8 +1929,10 @@ The Linux-kernel CPU-hotplug implementation has notifiers that are used
 to allow the various kernel subsystems (including RCU) to respond
 appropriately to a given CPU-hotplug operation. Most RCU operations may
 be invoked from CPU-hotplug notifiers, including even synchronous
-grace-period operations such as ``synchronize_rcu()`` and
-``synchronize_rcu_expedited()``.
+grace-period operations such as. However, the synchronous variants
+(``synchronize_rcu()`` and ``synchronize_rcu_expedited()``) should not
+from notifiers that execute via ``stop_machine()`` -- specifically those
+between the ``CPUHP_AP_OFFLINE`` and ``CPUHP_AP_ONLINE`` states.
 
 However, all-callback-wait operations such as ``rcu_barrier()`` are also
 not supported, due to the fact that there are phases of CPU-hotplug
@@ -1940,6 +1942,30 @@ deadlock. Furthermore, ``rcu_barrier()`` blocks CPU-hotplug operations
 during its execution, which results in another type of deadlock when
 invoked from a CPU-hotplug notifier.
 
+Also, RCU's implementation avoids serious deadlocks which could occur due to
+interaction between hotplug, timers and grace period processing. It does so by
+maintaining its own books of every CPU's hotplug state, independent of
+the existing general-purpose CPU masks and by reporting quiescent states
+explictly when an online CPU is going down. Due to this design, the force
+quiescent state loop (FQS) is not required to report quiescent states for
+offline CPUs, like it does for idle CPUs, but it does splat if offline CPUs are
+stalling the RCU grace period for too long.
+
+For an offline CPU, the quiescent state will be reported in either of:
+1. During CPU offlining, using RCU's hotplug notifier (``rcu_report_dead()``).
+2. During grace period initialization (``rcu_gp_init()``) if it detected a race
+   with CPU offlining, or a race with a task unblocking on a node which
+   previously had all of its CPUs offlined.
+
+The CPU onlining path (``rcu_cpu_starting()``) does not need to report a
+quiescent state for an offline CPU; in fact it would trigger a warning if a
+quiescent state was not already reported for that CPU.
+
+During the checking/modification of RCU's hotplug bookkeeping, the
+corresponding CPU's leaf node lock is held. This avoids race conditions between
+RCU's hotplug notifier hooks, grace period initialization code and the FQS loop
+which can concurrently refer to or modify the bookkeeping.
+
 Scheduler and RCU
 ~~~~~~~~~~~~~~~~~
 
-- 
2.28.0.709.gb0816b6eb0-goog

