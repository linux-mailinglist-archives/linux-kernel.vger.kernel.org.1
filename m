Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4D0204555
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbgFWAae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:55402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731700AbgFWAaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:30:20 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4C03208E4;
        Tue, 23 Jun 2020 00:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872219;
        bh=1veGT3UQhfKYOYux03q+oos70fj1Q5bSyqp9pTfmx8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=smdLsBMM4wYdtb1RNQqD2UdLdew6AuyAhJzFsw40C0S5QjlxVJ1bFyg6fzIwkT/GU
         nmrN8PHhH1hFDKiM1uboqrqgJnxglNcfJ52uO915Di56VURpdNeUgyVRD2zFNKsYof
         ii0QBguO2Xt4pbkoG8n7aTbgtafYQAF+zhuj3dAE=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 22/30] doc: Document rcuperf's module parameters
Date:   Mon, 22 Jun 2020 17:30:05 -0700
Message-Id: <20200623003013.26252-22-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623002941.GA26089@paulmck-ThinkPad-P72>
References: <20200623002941.GA26089@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds documentation for the rcuperf module parameters.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 36 +++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index fb95fad..20cd00b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4407,6 +4407,42 @@
 			      reboot_cpu is s[mp]#### with #### being the processor
 					to be used for rebooting.
 
+	refperf.holdoff= [KNL]
+			Set test-start holdoff period.  The purpose of
+			this parameter is to delay the start of the
+			test until boot completes in order to avoid
+			interference.
+
+	refperf.loops= [KNL]
+			Set the number of loops over the synchronization
+			primitive under test.  Increasing this number
+			reduces noise due to loop start/end overhead,
+			but the default has already reduced the per-pass
+			noise to a handful of picoseconds on ca. 2020
+			x86 laptops.
+
+	refperf.nreaders= [KNL]
+			Set number of readers.  The default value of -1
+			selects N, where N is roughly 75% of the number
+			of CPUs.  A value of zero is an interesting choice.
+
+	refperf.nruns= [KNL]
+			Set number of runs, each of which is dumped onto
+			the console log.
+
+	refperf.readdelay= [KNL]
+			Set the read-side critical-section duration,
+			measured in microseconds.
+
+	refperf.shutdown= [KNL]
+			Shut down the system at the end of the performance
+			test.  This defaults to 1 (shut it down) when
+			rcuperf is built into the kernel and to 0 (leave
+			it running) when rcuperf is built as a module.
+
+	refperf.verbose= [KNL]
+			Enable additional printk() statements.
+
 	relax_domain_level=
 			[KNL, SMP] Set scheduler's default relax_domain_level.
 			See Documentation/admin-guide/cgroup-v1/cpusets.rst.
-- 
2.9.5

