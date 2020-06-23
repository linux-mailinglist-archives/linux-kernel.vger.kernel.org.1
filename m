Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD42045DB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 02:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732233AbgFWAib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 20:38:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:33692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732164AbgFWAh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:37:58 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDAC12075A;
        Tue, 23 Jun 2020 00:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872677;
        bh=7DKndyoeB4W97SId2Rlw/2i+z3DdK48dgLbViZ1FPtc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H2N+cLlOTEyx1NpjqO3tqmsYqJ2E4mhnYmIYmNgq+6zdszU4uxOPk6at+NBk/FNoa
         ySUNWrBmF5tw/pXIEvDfeeE03yvw9cJJfa7J0NRHbHr/VUnxl7zS0ru/HFFYOUcthN
         ze4lQUp/D+loOVOwMkbF0PJ3k4VxS1n2o2P1W51I=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 19/23] torture: Add kvm-tranform.sh script for qemu-cmd files
Date:   Mon, 22 Jun 2020 17:37:48 -0700
Message-Id: <20200623003752.26872-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200623003731.GA26717@paulmck-ThinkPad-P72>
References: <20200623003731.GA26717@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a script that transforms qemu-cmd files to allow them
and the corresponding kernels to be run in contexts other than the one
that they were created for, including on systems other than the one that
they were built on.  For example, this allows the build products from a
--buildonly run to be transformed to allow distributed rcutorture testing.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 .../selftests/rcutorture/bin/kvm-transform.sh      | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-transform.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
new file mode 100755
index 0000000..c45a953
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
@@ -0,0 +1,51 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Transform a qemu-cmd file to allow reuse.
+#
+# Usage: kvm-transform.sh bzImage console.log < qemu-cmd-in > qemu-cmd-out
+#
+#	bzImage: Kernel and initrd from the same prior kvm.sh run.
+#	console.log: File into which to place console output.
+#
+# The original qemu-cmd file is provided on standard input.
+# The transformed qemu-cmd file is on standard output.
+# The transformation assumes that the qemu command is confined to a
+# single line.  It also assumes no whitespace in filenames.
+#
+# Copyright (C) 2020 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+image="$1"
+if test -z "$image"
+then
+	echo Need kernel image file.
+	exit 1
+fi
+consolelog="$2"
+if test -z "$consolelog"
+then
+	echo "Need console log file name."
+	exit 1
+fi
+
+awk -v image="$image" -v consolelog="$consolelog" '
+{
+	line = "";
+	for (i = 1; i <= NF; i++) {
+		if (line == "")
+			line = $i;
+		else
+			line = line " " $i;
+		if ($i == "-serial") {
+			i++;
+			line = line " file:" consolelog;
+		}
+		if ($i == "-kernel") {
+			i++;
+			line = line " " image;
+		}
+	}
+	print line;
+}'
-- 
2.9.5

