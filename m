Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3E22A8AEA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 00:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbgKEXrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 18:47:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:46062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732743AbgKEXr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 18:47:28 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-104-11.bvtn.or.frontiernet.net [50.39.104.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F394520885;
        Thu,  5 Nov 2020 23:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604620048;
        bh=rNcDc0nqZb3mhX8p82fY0o843TlkCTSfcdWRyKKOYtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oqOaUJ27rSn/JntrufbKXmvGU7jM2SaKMTy4Wl63Atm1CS6oWlmtyRsAEPP609Y88
         y8wZKEx0cBEf/LWR1LrLBL2LIrJoPFIiwNx6G76rVmTKN1RZHsKhrrhBN9KSh12yX+
         UoeHEb+CQI9cyaCgE9GN/j5fMFHfptFj7clCLMY0=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH tip/core/rcu 17/28] torture: Force weak-hashed pointers on console log
Date:   Thu,  5 Nov 2020 15:47:08 -0800
Message-Id: <20201105234719.23307-17-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20201105234658.GA23142@paulmck-ThinkPad-P72>
References: <20201105234658.GA23142@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Although the rcutorture scripting now deals correctly with full-up
security-induced pointer obfuscation, it is still counter-productive for
kernel hackers who are analyzing console output.  This commit therefore
sets the debug_boot_weak_hash kernel boot parameter, which enables
printing of weak-hashed pointers for torture-test runs.

Please note that this change applies only to runs initiated by the
kvm.sh scripting.  If you are instead using modprobe and rmmod, it is
your responsibility to build and boot the underlying kernel to your taste.

Please note further that this change does not result in a security hole
in normal use.  The rcutorture testing runs with a negligible userspace,
no networking, and no user interaction.  Besides which, there is no data
of value that can be extracted from an rcutorture guest OS that could
not also be extracted from the host that this guest is running on.

Suggested-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index 51f3464..8266349 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -169,6 +169,7 @@ identify_qemu () {
 # Output arguments for the qemu "-append" string based on CPU type
 # and the TORTURE_QEMU_INTERACTIVE environment variable.
 identify_qemu_append () {
+	echo debug_boot_weak_hash
 	local console=ttyS0
 	case "$1" in
 	qemu-system-x86_64|qemu-system-i386)
-- 
2.9.5

