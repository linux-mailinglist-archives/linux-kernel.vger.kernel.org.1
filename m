Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8481A84C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391548AbgDNQ1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2391531AbgDNQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:26:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0E3C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:26:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y24so14713523wma.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 09:26:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/VXMLsnEdFtu7k13O3hijxHV9EAnp9rCBMScPJUvt8E=;
        b=so3gP1RlA1DMJNkabV9BVJKpPKhVefRrd749cpbQsMSUw9vEy2MT2snTkC0Iccc76H
         AzVizRJ5FKnqt7TeKCsOnDj9RS9cHfRtLwvxTLsJ3j7Lh16aDRNKcmt0mNc1DzdBZSqy
         Zktggq0zEqSoHYB4NUkTRUEMUGhz1MrfEX5ZBpfK9llw0545J4uoaF9JNWsCZkWYs9D1
         Ak+pbPikFBBvTaMdnLuT1RXbOmREnoEcyCY2TcbfIqoTetk1iedUrw6ag9Tc0Pm9rQY1
         Zcns8E/zxoM/7klSmWX6+o9Pj7vsFb+xz4RXO26dYkdeObLmqvSaXGn4z45wigjJgU0j
         d/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/VXMLsnEdFtu7k13O3hijxHV9EAnp9rCBMScPJUvt8E=;
        b=SRCKeVWcXLaAOj/hMM5Nzer4szs4gAKWAPQ6HpS1OgwzgVVKJAYVf/fHMIjHlWUPdM
         G/E338WegRj4bKzEwyApgCEo2JGLfShNT+SW9wmhy8nP2LWmw1lNh+HdWqRQEjfRcCLg
         uIh5432tMapcJgRpQXskPmwTDjflhXVPk33LOyJ+TdYU+BrdwvQrOn2xlaOjPnWBomHP
         i6zRU6PSbvhrZnGwWxnYw7HOhkHnoWc5n+cmm63a6IGjEiDdoeVZCb56Jnn2IOsHbSDt
         03uG7Qln8D20rwrSTkfoKnfI039gGi0wJ/G4s0l+N5k9cordBHcxADit37pfbNwF+YpM
         5fcA==
X-Gm-Message-State: AGi0PuYFJd35wjbvdc4REk7BuojgjVk4bxmtnbW4ABKjo5xiHdzBGNl3
        xtxCBRJ8xSQ9/2czxidH7IfqGA==
X-Google-Smtp-Source: APiQypLZSqAKnKa8/7bmUDaBawS19DxuB4c+NUiF7UJsB8UNeKpicbm4VpGHB77i6kzhldKm0rxM1Q==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr639225wmm.9.1586881613656;
        Tue, 14 Apr 2020 09:26:53 -0700 (PDT)
Received: from localhost.localdomain (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.gmail.com with ESMTPSA id s14sm20199388wme.33.2020.04.14.09.26.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 09:26:53 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rui.zhang@intel.com
Cc:     amit.kucheria@verdurent.com,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:POWER MANAGEMENT CORE),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/4] powercap/drivers/idle_inject: Specify idle state max latency
Date:   Tue, 14 Apr 2020 18:26:26 +0200
Message-Id: <20200414162634.1867-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the idle injection framework uses the play_idle() function
which puts the current CPU in an idle state. The idle state is the
deepest one, as specified by the latency constraint when calling the
subsequent play_idle_precise() function with the INT_MAX.

The idle_injection is used by the cpuidle_cooling device which
computes the idle / run duration to mitigate the temperature by
injecting idle cycles. The cooling device has no control on the depth
of the idle state.

Allow finer control of the idle injection mechanism by allowing to
specify the latency for the idle state. Thus the cooling device has
the ability to have a guarantee on the exit latency of the idle states
it is injecting.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/idle_inject.c | 16 +++++++++++++++-
 include/linux/idle_inject.h    |  4 ++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index cd1270614cc6..49f42c475620 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -61,12 +61,14 @@ struct idle_inject_thread {
  * @timer: idle injection period timer
  * @idle_duration_us: duration of CPU idle time to inject
  * @run_duration_us: duration of CPU run time to allow
+ * @latency_us: max allowed latency
  * @cpumask: mask of CPUs affected by idle injection
  */
 struct idle_inject_device {
 	struct hrtimer timer;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
+	unsigned int latency_us;
 	unsigned long int cpumask[0];
 };
 
@@ -138,7 +140,8 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
-	play_idle(READ_ONCE(ii_dev->idle_duration_us));
+	play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
+			  READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
 }
 
 /**
@@ -169,6 +172,16 @@ void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 	*idle_duration_us = READ_ONCE(ii_dev->idle_duration_us);
 }
 
+/**
+ * idle_inject_set_latency - set the maximum latency allowed
+ * @latency_us: set the latency requirement for the idle state
+ */
+void idle_inject_set_latency(struct idle_inject_device *ii_dev,
+			     unsigned int latency_us)
+{
+	WRITE_ONCE(ii_dev->latency_us, latency_us);
+}
+
 /**
  * idle_inject_start - start idle injections
  * @ii_dev: idle injection control device structure
@@ -297,6 +310,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	cpumask_copy(to_cpumask(ii_dev->cpumask), cpumask);
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
+	ii_dev->latency_us = UINT_MAX;
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index a445cd1a36c5..91a8612b8bf9 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -26,4 +26,8 @@ void idle_inject_set_duration(struct idle_inject_device *ii_dev,
 void idle_inject_get_duration(struct idle_inject_device *ii_dev,
 				 unsigned int *run_duration_us,
 				 unsigned int *idle_duration_us);
+
+void idle_inject_set_latency(struct idle_inject_device *ii_dev,
+			     unsigned int latency_ns);
+
 #endif /* __IDLE_INJECT_H__ */
-- 
2.17.1

