Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4112045D6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732201AbgFWAiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:38:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:33692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732149AbgFWAh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:57 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B43820E65;
        Tue, 23 Jun 2020 00:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872676;
        bh=A4vha9pyInfPaCLA6akZMwVrr7X6XKSlu00Tn4YD7JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RN8+wrZk+rhP3TiLfjxaVsjUuU0Cml1bXb24T4i0Lb/cHgWcB3cxKunP0GFrZ+sLl
         7Eqh7/8RueWQ+QtWLb8rTkrMRn//LcnPmoZ+51LVtTMG4jJsSSkj7ikBCF2npRRBpC
         h+ehF3sA1EkbtQwn2WDMGD9RqulFiLkNwg5b6Q2M=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 13/23] torture: Abstract out console-log error detection
Date:   Mon, 22 Jun 2020 17:37:42 -0700
Message-Id: <20200623003752.26872-13-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit pulls the simple pattern-based error detection from the
console log into a new console-badness.sh file.  This will enable future
commits to end a run on the first error.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../testing/selftests/rcutorture/bin/console-badness.sh  | 16 ++++++++++++++++
 tools/testing/selftests/rcutorture/bin/parse-console.sh  |  5 +----
 2 files changed, 17 insertions(+), 4 deletions(-)
 create mode 100755 tools/testing/selftests/rcutorture/bin/console-badness.sh

diff --git a/tools/testing/selftests/rcutorture/bin/console-badness.sh b/tools/testing/selftests/rcutorture/bin/console-badness.sh
new file mode 100755
index 0000000..0e4c0b2
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/console-badness.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Scan standard input for error messages, dumping any found to standard
+# output.
+#
+# Usage: console-badness.sh
+#
+# Copyright (C) 2020 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for|!!!' |
+grep -v 'ODEBUG: ' |
+grep -v 'This means that this is a DEBUG kernel and it is' |
+grep -v 'Warning: unable to open an initial console'
diff --git a/tools/testing/selftests/rcutorture/bin/parse-console.sh b/tools/testing/selftests/rcutorture/bin/parse-console.sh
index 1c64ca8..98478e1 100755
--- a/tools/testing/selftests/rcutorture/bin/parse-console.sh
+++ b/tools/testing/selftests/rcutorture/bin/parse-console.sh
@@ -116,10 +116,7 @@ then
 	fi
 fi | tee -a $file.diags
 
-egrep 'Badness|WARNING:|Warn|BUG|===========|Call Trace:|Oops:|detected stalls on CPUs/tasks:|self-detected stall on CPU|Stall ended before state dump start|\?\?\? Writer stall state|rcu_.*kthread starved for' < $file |
-grep -v 'ODEBUG: ' |
-grep -v 'This means that this is a DEBUG kernel and it is' |
-grep -v 'Warning: unable to open an initial console' > $T.diags
+console-badness.sh < $file > $T.diags
 if test -s $T.diags
 then
 	print_warning "Assertion failure in $file $title"
-- 
2.9.5

