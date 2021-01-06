Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90A562EC255
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbhAFRdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:33:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727858AbhAFRcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:32:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D6BCB2313A;
        Wed,  6 Jan 2021 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609954282;
        bh=fQl7jfPWJ3IgKJuJ5YLffr2LDc65pYnm8WA/B3iFQdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PD/N3GMsAKpPPhYAizL6cRmqTOP77er2HS8Bxs7bTByxXU19u1j8nutwVWUwy4a2N
         qEYXmvAulSuT/CCIgxDgHwooPFUxeuzZ4NoGoJ9Hy2DFrGjRcgGIDh5vFhUMs+w/aU
         Vg3vNdsvoC3W+o4V823Vc1/N9PcXTlhpD6w3fv42zn+rwDQGU6BAx3vHdKqtKInvIA
         3AFkFOW97xzUDFVCtKlI3Iw/dXLtQyKjSAz7HCP6bc/05p7ouENCmueHfUU9Ev5O8g
         F98Sr1EZ/TkjEKwna+TnelV+4VDSlfcv3kt+rH/popQz/Hpgzk3zA/g/RP72p4Ht+k
         T8cklNiSXv80w==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/18] torture: Make torture.sh allmodconfig retain and label output
Date:   Wed,  6 Jan 2021 09:31:12 -0800
Message-Id: <20210106173119.23159-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106173056.GA23035@paulmck-ThinkPad-P72>
References: <20210106173056.GA23035@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit places "---" markers in the torture.sh script's allmodconfig
output, and uses "<<" to avoid overwriting earlier output from this
build test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index a01079e..e2c97f9 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -238,9 +238,12 @@ then
 	echo " --- allmodconfig:" Start `date` | tee -a $T/log
 	amcdir="tools/testing/selftests/rcutorture/res/$ds/allmodconfig"
 	mkdir -p "$amcdir"
-	make -j$MAKE_ALLOTED_CPUS clean > "$amcdir/Make.out" 2>&1
-	make -j$MAKE_ALLOTED_CPUS allmodconfig > "$amcdir/Make.out" 2>&1
-	make -j$MAKE_ALLOTED_CPUS > "$amcdir/Make.out" 2>&1
+	echo " --- make clean" > "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS clean >> "$amcdir/Make.out" 2>&1
+	echo " --- make allmodconfig" >> "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS allmodconfig >> "$amcdir/Make.out" 2>&1
+	echo " --- make " >> "$amcdir/Make.out" 2>&1
+	make -j$MAKE_ALLOTED_CPUS >> "$amcdir/Make.out" 2>&1
 	retcode="$?"
 	echo $retcode > "$amcdir/Make.exitcode"
 	if test "$retcode" == 0
-- 
2.9.5

