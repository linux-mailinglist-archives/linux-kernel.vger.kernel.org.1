Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E67C32958D6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505371AbgJVHMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505353AbgJVHMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:12:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D08C0613CE;
        Thu, 22 Oct 2020 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hh++jN2ESvWMGdhOpb0oyfSONsEPik+19EQBLDe/X2M=; b=bUlvYqZlMhyV2vSGm2m83amlgJ
        H+IZenrUWMusw5pdl84CMURmDTJoeCv4B1CLY2zE9T2mm5qq3vpJ8OUF1/B+e0BpNKvC5+S9zV1t0
        PsH0208rvkGln0xqFHxm6rbSZ1lk9twLpjub/wQnJqLoq8EGnEqlEyhdUTYYbE3ozS2702z3QVPXJ
        ugNCX2/xyhNLb8GvssB3cvMe+yb8ry/kbSd/99kQIalWppxv0dBrHzWJxT59j0LBMH/L+G1HCLS3L
        mWjN5dGsq4V2p48q7lu7djIAItrmqpEvGj5zfbS23v/MW0PX59MC+C21A4vopKSASJRxW//gWIyZZ
        iXbjfNuA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVUlI-0000Fr-4W; Thu, 22 Oct 2020 07:11:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32B993010D2;
        Thu, 22 Oct 2020 09:11:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21D032BB9BA69; Thu, 22 Oct 2020 09:11:45 +0200 (CEST)
Date:   Thu, 22 Oct 2020 09:11:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Julia Lawall <julia.lawall@inria.fr>, Mel Gorman <mgorman@suse.de>,
        Ingo Molnar <mingo@redhat.com>,
        kernel-janitors@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        viresh.kumar@linaro.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] sched/fair: check for idle core
Message-ID: <20201022071145.GM2628@hirez.programming.kicks-ass.net>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021121950.GF2628@hirez.programming.kicks-ass.net>
 <20201021131026.GY2651@hirez.programming.kicks-ass.net>
 <6145907.dAfbsivgMF@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6145907.dAfbsivgMF@kreacher>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 08:11:59PM +0200, Rafael J. Wysocki wrote:

> > @@ -144,6 +145,7 @@ config CPU_FREQ_GOV_USERSPACE
> >  
> >  config CPU_FREQ_GOV_ONDEMAND
> >  	tristate "'ondemand' cpufreq policy governor"
> > +	depends on !SMP
> 
> But I don't think that we can do this and the one below.

Well, but we need to do something to force people onto schedutil,
otherwise we'll get more crap like this thread.

Can we take the choice away? Only let Kconfig select which governors are
available and then set the default ourselves? I mean, the end goal being
to not have selectable governors at all, this seems like a good step
anyway.

---

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2c7171e0b001..3a9f54b382c0 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -34,77 +34,6 @@ config CPU_FREQ_STAT
 
 	  If in doubt, say N.
 
-choice
-	prompt "Default CPUFreq governor"
-	default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM_SA1110_CPUFREQ
-	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
-	default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
-	default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
-	help
-	  This option sets which CPUFreq governor shall be loaded at
-	  startup. If in doubt, use the default setting.
-
-config CPU_FREQ_DEFAULT_GOV_PERFORMANCE
-	bool "performance"
-	select CPU_FREQ_GOV_PERFORMANCE
-	help
-	  Use the CPUFreq governor 'performance' as default. This sets
-	  the frequency statically to the highest frequency supported by
-	  the CPU.
-
-config CPU_FREQ_DEFAULT_GOV_POWERSAVE
-	bool "powersave"
-	select CPU_FREQ_GOV_POWERSAVE
-	help
-	  Use the CPUFreq governor 'powersave' as default. This sets
-	  the frequency statically to the lowest frequency supported by
-	  the CPU.
-
-config CPU_FREQ_DEFAULT_GOV_USERSPACE
-	bool "userspace"
-	select CPU_FREQ_GOV_USERSPACE
-	help
-	  Use the CPUFreq governor 'userspace' as default. This allows
-	  you to set the CPU frequency manually or when a userspace 
-	  program shall be able to set the CPU dynamically without having
-	  to enable the userspace governor manually.
-
-config CPU_FREQ_DEFAULT_GOV_ONDEMAND
-	bool "ondemand"
-	select CPU_FREQ_GOV_ONDEMAND
-	select CPU_FREQ_GOV_PERFORMANCE
-	help
-	  Use the CPUFreq governor 'ondemand' as default. This allows
-	  you to get a full dynamic frequency capable system by simply
-	  loading your cpufreq low-level hardware driver.
-	  Be aware that not all cpufreq drivers support the ondemand
-	  governor. If unsure have a look at the help section of the
-	  driver. Fallback governor will be the performance governor.
-
-config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
-	bool "conservative"
-	select CPU_FREQ_GOV_CONSERVATIVE
-	select CPU_FREQ_GOV_PERFORMANCE
-	help
-	  Use the CPUFreq governor 'conservative' as default. This allows
-	  you to get a full dynamic frequency capable system by simply
-	  loading your cpufreq low-level hardware driver.
-	  Be aware that not all cpufreq drivers support the conservative
-	  governor. If unsure have a look at the help section of the
-	  driver. Fallback governor will be the performance governor.
-
-config CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
-	bool "schedutil"
-	depends on SMP
-	select CPU_FREQ_GOV_SCHEDUTIL
-	select CPU_FREQ_GOV_PERFORMANCE
-	help
-	  Use the 'schedutil' CPUFreq governor by default. If unsure,
-	  have a look at the help section of that governor. The fallback
-	  governor will be 'performance'.
-
-endchoice
-
 config CPU_FREQ_GOV_PERFORMANCE
 	tristate "'performance' governor"
 	help
@@ -145,6 +74,7 @@ config CPU_FREQ_GOV_USERSPACE
 config CPU_FREQ_GOV_ONDEMAND
 	tristate "'ondemand' cpufreq policy governor"
 	select CPU_FREQ_GOV_COMMON
+	select CPU_FREQ_GOV_PERFORMANCE
 	help
 	  'ondemand' - This driver adds a dynamic cpufreq policy governor.
 	  The governor does a periodic polling and 
@@ -164,6 +94,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
 	tristate "'conservative' cpufreq governor"
 	depends on CPU_FREQ
 	select CPU_FREQ_GOV_COMMON
+	select CPU_FREQ_GOV_PERFORMANCE
 	help
 	  'conservative' - this driver is rather similar to the 'ondemand'
 	  governor both in its source code and its purpose, the difference is
@@ -188,6 +119,7 @@ config CPU_FREQ_GOV_SCHEDUTIL
 	bool "'schedutil' cpufreq policy governor"
 	depends on CPU_FREQ && SMP
 	select CPU_FREQ_GOV_ATTR_SET
+	select CPU_FREQ_GOV_PERFORMANCE
 	select IRQ_WORK
 	help
 	  This governor makes decisions based on the utilization data provided
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1877f5e2e5b0..6848e3337b65 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -626,6 +626,49 @@ static struct cpufreq_governor *find_governor(const char *str_governor)
 	return NULL;
 }
 
+static struct cpufreq_governor *cpufreq_default_governor(void)
+{
+	struct cpufreq_governor *gov = NULL;
+
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+	gov = find_governor("schedutil");
+	if (gov)
+		return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_ONDEMAND
+	gov = find_governor("ondemand");
+	if (gov)
+		return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_CONSERVATIVE
+	gov = find_governor("conservative");
+	if (gov)
+		return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_USERSPACE
+	gov = find_governor("userspace");
+	if (gov)
+		return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_POWERSAVE
+	gov = find_governor("powersave");
+	if (gov)
+		return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE
+	gov = find_governor("performance");
+	if (gov)
+		return gov;
+#endif
+
+	return gov;
+}
+
 static struct cpufreq_governor *get_governor(const char *str_governor)
 {
 	struct cpufreq_governor *t;
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index aa39ff31ec9f..25449a1ee954 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -330,12 +330,5 @@ MODULE_DESCRIPTION("'cpufreq_conservative' - A dynamic cpufreq governor for "
 		"optimised for use in a battery environment");
 MODULE_LICENSE("GPL");
 
-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-	return &CPU_FREQ_GOV_CONSERVATIVE;
-}
-#endif
-
 cpufreq_governor_init(CPU_FREQ_GOV_CONSERVATIVE);
 cpufreq_governor_exit(CPU_FREQ_GOV_CONSERVATIVE);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index ac361a8b1d3b..2a7fd645e1fb 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -467,12 +467,5 @@ MODULE_DESCRIPTION("'cpufreq_ondemand' - A dynamic cpufreq governor for "
 	"Low Latency Frequency Transition capable processors");
 MODULE_LICENSE("GPL");
 
-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-	return &CPU_FREQ_GOV_ONDEMAND;
-}
-#endif
-
 cpufreq_governor_init(CPU_FREQ_GOV_ONDEMAND);
 cpufreq_governor_exit(CPU_FREQ_GOV_ONDEMAND);
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufreq_performance.c
index 71c1d9aba772..c6c7473a3a73 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -23,12 +23,6 @@ static struct cpufreq_governor cpufreq_gov_performance = {
 	.limits		= cpufreq_gov_performance_limits,
 };
 
-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-	return &cpufreq_gov_performance;
-}
-#endif
 #ifndef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE
 struct cpufreq_governor *cpufreq_fallback_governor(void)
 {
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_powersave.c
index 7749522355b5..8b9555f70e9d 100644
--- a/drivers/cpufreq/cpufreq_powersave.c
+++ b/drivers/cpufreq/cpufreq_powersave.c
@@ -27,12 +27,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'powersave'");
 MODULE_LICENSE("GPL");
 
-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-	return &cpufreq_gov_powersave;
-}
-#endif
-
 cpufreq_governor_init(cpufreq_gov_powersave);
 cpufreq_governor_exit(cpufreq_gov_powersave);
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index 50a4d7846580..48ce53038ac0 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -131,12 +131,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>, "
 MODULE_DESCRIPTION("CPUfreq policy governor 'userspace'");
 MODULE_LICENSE("GPL");
 
-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-	return &cpufreq_gov_userspace;
-}
-#endif
-
 cpufreq_governor_init(cpufreq_gov_userspace);
 cpufreq_governor_exit(cpufreq_gov_userspace);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 5ae7b4e6e8d6..3b77e408377a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -888,13 +888,6 @@ struct cpufreq_governor schedutil_gov = {
 	.limits			= sugov_limits,
 };
 
-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-	return &schedutil_gov;
-}
-#endif
-
 cpufreq_governor_init(schedutil_gov);
 
 #ifdef CONFIG_ENERGY_MODEL

