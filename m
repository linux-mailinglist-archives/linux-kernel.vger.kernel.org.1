Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0E1B2DC2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 19:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbgDUREQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 13:04:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgDUREO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:04:14 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CE3EE206E9;
        Tue, 21 Apr 2020 17:04:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587488654;
        bh=CxnQgYfmQMbfwv1N4rTe+ZDNd9dR0rBI+32iF1QViMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVHJ73MlSx2cAaQU3Mf4LugojmeeBE6nmyuM9FrvgbHAq/RC5cjHkc7iZocO+L7uN
         Jh74ZuOTvQICo6yRdxKQFBShPVn5mbIudOUQ6VMxc841jh3lUcdfr0BSXxec95kKY5
         6Tdq63GKe7MNCYFgFSP8neZXMKt1w2ZBeDndCV40=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jQwJg-00CmLW-2R; Tue, 21 Apr 2020 19:04:12 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: [PATCH 01/10] docs: RCU: convert checklist.txt to ReST
Date:   Tue, 21 Apr 2020 19:04:02 +0200
Message-Id: <d289ae5cfaa2ff556a1b18e9ed009cb7063275c1.1587488137.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1587488137.git.mchehab+huawei@kernel.org>
References: <cover.1587488137.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Use the right list markups;
- Add it to RCU/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../RCU/{checklist.txt => checklist.rst}        | 17 ++++++++++++-----
 Documentation/RCU/index.rst                     |  3 +++
 2 files changed, 15 insertions(+), 5 deletions(-)
 rename Documentation/RCU/{checklist.txt => checklist.rst} (98%)

diff --git a/Documentation/RCU/checklist.txt b/Documentation/RCU/checklist.rst
similarity index 98%
rename from Documentation/RCU/checklist.txt
rename to Documentation/RCU/checklist.rst
index e98ff261a438..2efed9926c3f 100644
--- a/Documentation/RCU/checklist.txt
+++ b/Documentation/RCU/checklist.rst
@@ -1,4 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+================================
 Review Checklist for RCU Patches
+================================
 
 
 This document contains a checklist for producing and reviewing patches
@@ -411,18 +415,21 @@ over a rather long period of time, but improvements are always welcome!
 	__rcu sparse checks to validate your RCU code.	These can help
 	find problems as follows:
 
-	CONFIG_PROVE_LOCKING: check that accesses to RCU-protected data
+	CONFIG_PROVE_LOCKING:
+		check that accesses to RCU-protected data
 		structures are carried out under the proper RCU
 		read-side critical section, while holding the right
 		combination of locks, or whatever other conditions
 		are appropriate.
 
-	CONFIG_DEBUG_OBJECTS_RCU_HEAD: check that you don't pass the
+	CONFIG_DEBUG_OBJECTS_RCU_HEAD:
+		check that you don't pass the
 		same object to call_rcu() (or friends) before an RCU
 		grace period has elapsed since the last time that you
 		passed that same object to call_rcu() (or friends).
 
-	__rcu sparse checks: tag the pointer to the RCU-protected data
+	__rcu sparse checks:
+		tag the pointer to the RCU-protected data
 		structure with __rcu, and sparse will warn you if you
 		access that pointer without the services of one of the
 		variants of rcu_dereference().
@@ -442,8 +449,8 @@ over a rather long period of time, but improvements are always welcome!
 
 	You instead need to use one of the barrier functions:
 
-	o	call_rcu() -> rcu_barrier()
-	o	call_srcu() -> srcu_barrier()
+	-	call_rcu() -> rcu_barrier()
+	-	call_srcu() -> srcu_barrier()
 
 	However, these barrier functions are absolutely -not- guaranteed
 	to wait for a grace period.  In fact, if there are no call_rcu()
diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
index 81a0a1e5f767..c1ba4d130bb0 100644
--- a/Documentation/RCU/index.rst
+++ b/Documentation/RCU/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 .. _rcu_concepts:
 
 ============
@@ -8,6 +10,7 @@ RCU concepts
    :maxdepth: 3
 
    arrayRCU
+   checklist
    rcubarrier
    rcu_dereference
    whatisRCU
-- 
2.25.2

