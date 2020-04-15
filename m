Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A721AAFD8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 19:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411344AbgDORd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 13:33:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:46318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411130AbgDORbH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 13:31:07 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C451217BA;
        Wed, 15 Apr 2020 17:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586971866;
        bh=JUcg+B91/9Gp3VgiUqN1wZx9m8F/cwzYoxpa4XW01qA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JXU8mrOI40mWCLHj7I9NlhoBCXHuWTA/ywtOsk4JOabv/MNMhjduVo5BtuwqxltFR
         YvK00786ukjo62Y3tqK2c1TrNBTbNQv/mF5itdgA0gYTOK3/TAT62NhfCXq0dadngV
         UqLoNBQnNO9bTCFSPXbjy2rEBcypvlz5ardvCcTk=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 15/18] torture: Allow scenario-specific Kconfig options to override CFcommon
Date:   Wed, 15 Apr 2020 10:30:57 -0700
Message-Id: <20200415173100.9927-15-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415173037.GA9768@paulmck-ThinkPad-P72>
References: <20200415173037.GA9768@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit applies config_override_param() to allow scenario-specific
Kconfig options to override those in CFcommon.  This in turn will allow
additional Kconfig options to be placed in CFcommon, for example, an
option common to all but a few scenario can be placed in CFcommon and
then overridden in those few scenarios.  Plus this change saves one
whole line of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index b7296f1..c7534fd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -67,12 +67,11 @@ if test -r "$config_dir/CFcommon"
 then
 	echo " --- $config_dir/CFcommon" >> $resdir/ConfigFragment.input
 	cat < $config_dir/CFcommon >> $resdir/ConfigFragment.input
-	config_override.sh $config_dir/CFcommon $config_template > $T/Kc1
+	cp $config_dir/CFcommon $T/Kc0
 else
-	cp $config_template $T/Kc1
+	echo > $T/Kc0
 fi
-echo " --- $config_template" >> $resdir/ConfigFragment.input
-cat $config_template >> $resdir/ConfigFragment.input
+config_override_param "$config_template" Kc0 Kc1 "`cat $config_template 2> /dev/null`"
 config_override_param "--kcsan options" Kc1 Kc2 "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" Kc2 Kc3 "$TORTURE_KCONFIG_ARG"
 cp $T/Kc3 $resdir/ConfigFragment
-- 
2.9.5

