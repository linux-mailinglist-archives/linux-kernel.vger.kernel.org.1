Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363A12A8AE3
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732441AbgKEXrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:45860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKEXrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:22 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE70320756;
        Thu,  5 Nov 2020 23:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620042;
        bh=cHPyby7pAr8kcs5Rx52a5F9TaNyVrHGa7UCBfNWtirg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cYXFNrNcfDfo0+WAVqIfjD2ElsanHYyXMO8Di9RG1Pu6ikaevmTENFbIoofIjCFm/
         Km0M9xxe6mxT1t42ghoS4Ru/9eRra3//eFZtS/xnerNCU1E8rYG1wy6OOAXXhcuyUr
         6N9VuA2ojGuugqnXKcFcVslBUQWmhve0pc771Fb0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 01/28] refscale: Bounds-check module parameters
Date:   Thu,  5 Nov 2020 15:46:52 -0800
Message-Id: <20201105234719.23307-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The default value for refscale.nreaders is -1, which results in the code
setting the value to three-quarters of the number of CPUs.  On single-CPU
systems, this results in three-quarters of the value one, which the C
language's integer arithmetic rounds to zero.  This in turn results in
a divide-by-zero error.

This commit therefore adds bounds checking to the refscale module
parameters, so that if they are less than one, they are set to the
value one.

Reported-by: kernel test robot <lkp@intel.com>
Tested-by "Chen, Rong A" <rong.a.chen@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refscale.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 952595c..fb5f20d 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -681,6 +681,12 @@ ref_scale_init(void)
 	// Reader tasks (default to ~75% of online CPUs).
 	if (nreaders < 0)
 		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
+	if (WARN_ONCE(loops <= 0, "%s: loops = %ld, adjusted to 1\n", __func__, loops))
+		loops = 1;
+	if (WARN_ONCE(nreaders <= 0, "%s: nreaders = %d, adjusted to 1\n", __func__, nreaders))
+		nreaders = 1;
+	if (WARN_ONCE(nruns <= 0, "%s: nruns = %d, adjusted to 1\n", __func__, nruns))
+		nruns = 1;
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
-- 
2.9.5

