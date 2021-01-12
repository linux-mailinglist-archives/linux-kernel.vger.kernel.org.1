Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAEA2F2517
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 02:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbhALArg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 19:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:46734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbhALAqG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 19:46:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4ED7422DA9;
        Tue, 12 Jan 2021 00:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610412325;
        bh=8U6LUqTDM5YuaogvjW/QELcFRa+i9jk02H562m1P1u4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fxZ1s07fEDaoz2WhwMr3bfPXAZSwNqSDhgVOFqkG1cmpJduNC/Ugnv4qXmYmbQ2Af
         Wwqa4Cs+9nqQozgpxWqS751WE0InDUVm7M46j7aSjLJyk4sEscXh2DqD9tYk1UqD6u
         EAxilMnWsNsKK4/AolTqqB6sjHT6p8P5jfM5/DoGbCGiFv5rTUDVfoqeBWpJ/Amv6O
         C9o+0VijwIpeytsbCkHnVGZjbZ4TKF5FcJPejfewIEJ1YKnM1VXGmoqM+/LTrLhZrR
         ELUtDkV2E29Jq5DhAvruLsrwZTmmz1sT9BdrC2GQJ1krlncobM+ab81aYR914bu+yw
         S5BTkpdmb5jSQ==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
        corbet@lwn.net, Mark.Rutland@arm.com, maz@kernel.org,
        kernel-team@fb.com, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v2 clocksource 4/5] clocksource: Provide a module parameter to fuzz per-CPU clock checking
Date:   Mon, 11 Jan 2021 16:45:19 -0800
Message-Id: <20210112004520.24027-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210112004258.GA23158@paulmck-ThinkPad-P72>
References: <20210112004258.GA23158@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

Code that checks for clock desynchronization must itself be tested, so
this commit creates a new clocksource.inject_delay_shift_percpu= kernel
boot parameter that adds or subtracts a large value from the check read,
using the specified bit of the CPU ID to determine whether to add or
to subtract.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Reported-by: Chris Mason <clm@fb.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++++++++
 kernel/time/clocksource.c                       | 10 +++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4c59813..ca64b0c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -593,6 +593,15 @@
 			times the value specified for inject_delay_freq
 			of consecutive non-delays.
 
+	clocksource.inject_delay_shift_percpu= [KNL]
+			Shift count to obtain bit from CPU number to
+			determine whether to shift the time of the per-CPU
+			clock under test ahead or behind.  For example,
+			setting this to the value four will result in
+			alternating groups of 16 CPUs shifting ahead and
+			the rest of the CPUs shifting behind.  The default
+			value of -1 disable this type of error injection.
+
 	clocksource.max_read_retries= [KNL]
 			Number of clocksource_watchdog() retries due to
 			external delays before the clock will be marked
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 23bcefe..67cf41c 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -190,6 +190,8 @@ static int inject_delay_freq;
 module_param(inject_delay_freq, int, 0644);
 static int inject_delay_run = 1;
 module_param(inject_delay_run, int, 0644);
+static int inject_delay_shift_percpu = -1;
+module_param(inject_delay_shift_percpu, int, 0644);
 static int max_read_retries = 3;
 module_param(max_read_retries, int, 0644);
 
@@ -219,8 +221,14 @@ static cpumask_t cpus_behind;
 static void clocksource_verify_one_cpu(void *csin)
 {
 	struct clocksource *cs = (struct clocksource *)csin;
+	s64 delta = 0;
+	int sign;
 
-	__this_cpu_write(csnow_mid, cs->read(cs));
+	if (inject_delay_shift_percpu >= 0) {
+		sign = ((smp_processor_id() >> inject_delay_shift_percpu) & 0x1) * 2 - 1;
+		delta = sign * NSEC_PER_SEC;
+	}
+	__this_cpu_write(csnow_mid, cs->read(cs) + delta);
 }
 
 static void clocksource_verify_percpu_wq(struct work_struct *unused)
-- 
2.9.5

