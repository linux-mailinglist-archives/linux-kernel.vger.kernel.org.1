Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC792EC225
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 18:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbhAFR1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 12:27:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:37872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727814AbhAFR1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 12:27:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 567972313C;
        Wed,  6 Jan 2021 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609953971;
        bh=AMTxrHyq+9dicstXRz/9A+/B8wGoo1L6oZC/1Ne5D2w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QRChZ1xkwMy+rS/6Lij1wRD0xZFWvj4GS1J4NlSBGC6sHZ39xjr7k4xR/xLUJsJyE
         xolGIliN674wntHdf9dD6VizcK2WGACfu7t3rmC5pTsvXc7xBjEcE/6I9Dow0Q+M23
         5TZ9cFA/878xvtKevrsHewL1NfKlvQ5MDct2x7QbcbF1tY3vqWnxzWfYra106h0mm8
         leNusdStsbsNzmP5EeUxNYkJrRMmYXeipfoly+4xjzmwJXbQFrKswwWKQN+DkHPdMY
         WaUCeROYtTb3VvyO10ZN1D48FRoHUwi0bfZ1jiEyPDxXmEuI/zKz33HlJjP7+Av15k
         gYsUTPu9gUHaQ==
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 11/20] torture: Make kvm.sh return failure upon build failure
Date:   Wed,  6 Jan 2021 09:25:58 -0800
Message-Id: <20210106172607.22816-11-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106172547.GA22404@paulmck-ThinkPad-P72>
References: <20210106172547.GA22404@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

The kvm.sh script uses kvm-find-errors.sh to evaluate whether or not
a build failed.  Unfortunately, kvm-find-errors.sh returns success if
there are no failed runs (including when there are no runs at all) even if
there are build failures.  This commit therefore makes kvm-find-errors.sh
return failure in response to build failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
index 6f50722..be26598 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-find-errors.sh
@@ -39,6 +39,7 @@ done
 if test -n "$files"
 then
 	$editor $files
+	editorret=1
 else
 	echo No build errors.
 fi
@@ -62,5 +63,10 @@ then
 	exit 1
 else
 	echo No errors in console logs.
-	exit 0
+	if test -n "$editorret"
+	then
+		exit $editorret
+	else
+		exit 0
+	fi
 fi
-- 
2.9.5

