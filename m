Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 549AA295D48
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 13:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897178AbgJVLVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 07:21:22 -0400
Received: from mx01-sz.bfs.de ([194.94.69.67]:63682 "EHLO mx01-sz.bfs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2507169AbgJVLVV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 07:21:21 -0400
Received: from SRVEX01-SZ.bfs.intern (exchange-sz.bfs.de [10.129.90.31])
        by mx01-sz.bfs.de (Postfix) with ESMTPS id 3B723208FF;
        Thu, 22 Oct 2020 13:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bfs.de; s=dkim201901;
        t=1603365678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kI1gJJ4LPpfd7YVjDLM4v3gF7mLUl4e3Fxbr1UJrLWg=;
        b=LardUT2xu2e32TkAFm/5+9lzrCjFHMtA01jL3hWyB6zZ7Om3OA9GEGNCsW8Wor2ZAVowod
        apAwrp4orrZ7lYoKKv51Kjk03fCxuYIMnTfDWaAB0mDJvuaYRO6bNsBUI5lq/zKEjaFt25
        cgYkr17NYSr50w+o/+LQgyoePzdu2zfB0jJY0EcIBnLfS1JnHYd7YjJczZgSjpATO6C5DS
        viRVpl0Z/3aGkDDQOKpcgmGYDT2lCbBEbjsycy0PFs3+afw3xBge6GenDAJDGP/fXRK/SZ
        9e8p61StcZLhnKxQ4ap6HuODCK6VIg7qYIpKWrBxq2G9mVAp6SkOjNCTYOCMVw==
Received: from SRVEX01-SZ.bfs.intern (10.129.90.31) by SRVEX01-SZ.bfs.intern
 (10.129.90.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2106.2; Thu, 22 Oct
 2020 13:21:17 +0200
Received: from SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a]) by
 SRVEX01-SZ.bfs.intern ([fe80::7d2d:f9cb:2761:d24a%6]) with mapi id
 15.01.2106.002; Thu, 22 Oct 2020 13:21:17 +0200
From:   Walter Harms <wharms@bfs.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Julia Lawall <julia.lawall@inria.fr>, Mel Gorman <mgorman@suse.de>,
        "Ingo Molnar" <mingo@redhat.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Valentin Schneider" <valentin.schneider@arm.com>,
        Gilles Muller <Gilles.Muller@inria.fr>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>
Subject: AW: [PATCH] sched/fair: check for idle core
Thread-Topic: [PATCH] sched/fair: check for idle core
Thread-Index: AQHWpwVxSTZrU4t2jk6t1ZH3xGK6lqmhyNUAgAAKI4CAAAZnAIAADiQAgABUQICAANndgIAAZi4u
Date:   Thu, 22 Oct 2020 11:21:17 +0000
Message-ID: <ce7715fafa714f5a9624d9ff8c447d99@bfs.de>
References: <1603211879-1064-1-git-send-email-Julia.Lawall@inria.fr>
 <20201021121950.GF2628@hirez.programming.kicks-ass.net>
 <20201021131026.GY2651@hirez.programming.kicks-ass.net>
 <6145907.dAfbsivgMF@kreacher>,<20201022071145.GM2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201022071145.GM2628@hirez.programming.kicks-ass.net>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.137.16.40]
x-tm-as-product-ver: SMEX-14.0.0.3031-8.6.1012-25740.006
x-tm-as-result: No-10--10.096300-5.000000
x-tmase-matchedrid: MujQYtwgHnCX397y9hQgaBvgzEPRJaDEWw/S0HB7eoMTiSW9r3PknDmy
        vi/pk1f1It7bNImlIM7KHwe3hNiinrcwbi0W8PvT8pRHzcG+oi3ImecPUV56jpskuXz9GadkLIH
        ZB0nMVDGJTVSEVDRVRWjNaAkXSuPR7Vx0xQfTY1327WtDgGBc8txFGfTJ24HLfrj4yBPL4vaMy8
        hIFiZqQcAkYaYESz9CIqTMxPv7iijb0fmG0L5pPEhwlOfYeSqx1mc05rOhnpKgunpxJlu0Xzv3/
        JKoTaAEKz8Ggk1VbTQkT5o/Gtl4WSlSYOZ/YVjGEpA219sDMzlboh0Au8fxU+14sF0xQxVmPlAW
        wfVA2w65TJRvLmNxi5w8fg9ndzOvLGmmJTL2jhyLCYYg4B+SYXIqSD9/oJNAvn1ivDdpAIcOPMz
        xpzzbjllaO8mqlLs4PGRNE1M/dLkvHvj1p62VvACSHRN4FLBrihreXybOpWCVDBAppAT/pWRWeP
        usFQaMW05UR6QkmXJoBqkOj3ZCZ30kQA0a0S/66zi8j+r17t3bODDlFP8Gtlcn81OBopCmW2g2r
        2LI8m1QoSW16breSP1+tT1rdLd8KKy/x4fnL1GL6q5RsNhv5PNYQxCOihTNftL/DOumX3/fkEv4
        DlDrSVTDz/VUOg1P8pdiaZBarE8M8jMXjBF+sIMbH85DUZXy3QfwsVk0Ubv+efAnnZBiL8z+Ba7
        +nv3uxo6OGA1toZxcY6rILqxiFCghwK6RP2YXJozBz7Xegbd+3BndfXUhXQ==
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--10.096300-5.000000
x-tmase-version: SMEX-14.0.0.3031-8.6.1012-25740.006
x-tm-snts-smtp: 5677B7D1F78A602B89E19D0AA46A1EE39355F2DD18293E57E0C358753CA3540B2000:9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-0.17
Authentication-Results: mx01-sz.bfs.de;
        none
X-Spamd-Result: default: False [-0.17 / 7.00];
         ARC_NA(0.00)[];
         TO_DN_EQ_ADDR_SOME(0.00)[];
         HAS_XOIP(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_TWELVE(0.00)[17];
         NEURAL_HAM(-0.00)[-1.041];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_MATCH_FROM(0.00)[];
         BAYES_HAM(-0.17)[69.78%]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid this #ifdef jungle ..
I guess it would be save to search for a governor even=20
ones that are not enabled.

and a second thing: can we change the subject please ?

jm2c
 wh



________________________________________
Von: Peter Zijlstra [peterz@infradead.org]
Gesendet: Donnerstag, 22. Oktober 2020 09:11
An: Rafael J. Wysocki
Cc: Julia Lawall; Mel Gorman; Ingo Molnar; kernel-janitors@vger.kernel.org;=
 Juri Lelli; Vincent Guittot; Dietmar Eggemann; Steven Rostedt; Ben Segall;=
 Daniel Bristot de Oliveira; linux-kernel@vger.kernel.org; Valentin Schneid=
er; Gilles Muller; viresh.kumar@linaro.org; srinivas.pandruvada@linux.intel=
.com
Betreff: Re: [PATCH] sched/fair: check for idle core

On Wed, Oct 21, 2020 at 08:11:59PM +0200, Rafael J. Wysocki wrote:

> > @@ -144,6 +145,7 @@ config CPU_FREQ_GOV_USERSPACE
> >
> >  config CPU_FREQ_GOV_ONDEMAND
> >     tristate "'ondemand' cpufreq policy governor"
> > +   depends on !SMP
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
-       prompt "Default CPUFreq governor"
-       default CPU_FREQ_DEFAULT_GOV_USERSPACE if ARM_SA1100_CPUFREQ || ARM=
_SA1110_CPUFREQ
-       default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if ARM64 || ARM
-       default CPU_FREQ_DEFAULT_GOV_SCHEDUTIL if X86_INTEL_PSTATE && SMP
-       default CPU_FREQ_DEFAULT_GOV_PERFORMANCE
-       help
-         This option sets which CPUFreq governor shall be loaded at
-         startup. If in doubt, use the default setting.
-
-config CPU_FREQ_DEFAULT_GOV_PERFORMANCE
-       bool "performance"
-       select CPU_FREQ_GOV_PERFORMANCE
-       help
-         Use the CPUFreq governor 'performance' as default. This sets
-         the frequency statically to the highest frequency supported by
-         the CPU.
-
-config CPU_FREQ_DEFAULT_GOV_POWERSAVE
-       bool "powersave"
-       select CPU_FREQ_GOV_POWERSAVE
-       help
-         Use the CPUFreq governor 'powersave' as default. This sets
-         the frequency statically to the lowest frequency supported by
-         the CPU.
-
-config CPU_FREQ_DEFAULT_GOV_USERSPACE
-       bool "userspace"
-       select CPU_FREQ_GOV_USERSPACE
-       help
-         Use the CPUFreq governor 'userspace' as default. This allows
-         you to set the CPU frequency manually or when a userspace
-         program shall be able to set the CPU dynamically without having
-         to enable the userspace governor manually.
-
-config CPU_FREQ_DEFAULT_GOV_ONDEMAND
-       bool "ondemand"
-       select CPU_FREQ_GOV_ONDEMAND
-       select CPU_FREQ_GOV_PERFORMANCE
-       help
-         Use the CPUFreq governor 'ondemand' as default. This allows
-         you to get a full dynamic frequency capable system by simply
-         loading your cpufreq low-level hardware driver.
-         Be aware that not all cpufreq drivers support the ondemand
-         governor. If unsure have a look at the help section of the
-         driver. Fallback governor will be the performance governor.
-
-config CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
-       bool "conservative"
-       select CPU_FREQ_GOV_CONSERVATIVE
-       select CPU_FREQ_GOV_PERFORMANCE
-       help
-         Use the CPUFreq governor 'conservative' as default. This allows
-         you to get a full dynamic frequency capable system by simply
-         loading your cpufreq low-level hardware driver.
-         Be aware that not all cpufreq drivers support the conservative
-         governor. If unsure have a look at the help section of the
-         driver. Fallback governor will be the performance governor.
-
-config CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
-       bool "schedutil"
-       depends on SMP
-       select CPU_FREQ_GOV_SCHEDUTIL
-       select CPU_FREQ_GOV_PERFORMANCE
-       help
-         Use the 'schedutil' CPUFreq governor by default. If unsure,
-         have a look at the help section of that governor. The fallback
-         governor will be 'performance'.
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
+       select CPU_FREQ_GOV_PERFORMANCE
        help
          'ondemand' - This driver adds a dynamic cpufreq policy governor.
          The governor does a periodic polling and
@@ -164,6 +94,7 @@ config CPU_FREQ_GOV_CONSERVATIVE
        tristate "'conservative' cpufreq governor"
        depends on CPU_FREQ
        select CPU_FREQ_GOV_COMMON
+       select CPU_FREQ_GOV_PERFORMANCE
        help
          'conservative' - this driver is rather similar to the 'ondemand'
          governor both in its source code and its purpose, the difference =
is
@@ -188,6 +119,7 @@ config CPU_FREQ_GOV_SCHEDUTIL
        bool "'schedutil' cpufreq policy governor"
        depends on CPU_FREQ && SMP
        select CPU_FREQ_GOV_ATTR_SET
+       select CPU_FREQ_GOV_PERFORMANCE
        select IRQ_WORK
        help
          This governor makes decisions based on the utilization data provi=
ded
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 1877f5e2e5b0..6848e3337b65 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -626,6 +626,49 @@ static struct cpufreq_governor *find_governor(const ch=
ar *str_governor)
        return NULL;
 }

+static struct cpufreq_governor *cpufreq_default_governor(void)
+{
+       struct cpufreq_governor *gov =3D NULL;
+
+#ifdef CONFIG_CPU_FREQ_GOV_SCHEDUTIL
+       gov =3D find_governor("schedutil");
+       if (gov)
+               return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_ONDEMAND
+       gov =3D find_governor("ondemand");
+       if (gov)
+               return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_CONSERVATIVE
+       gov =3D find_governor("conservative");
+       if (gov)
+               return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_USERSPACE
+       gov =3D find_governor("userspace");
+       if (gov)
+               return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_POWERSAVE
+       gov =3D find_governor("powersave");
+       if (gov)
+               return gov;
+#endif
+
+#ifdef CONFIG_CPU_FREQ_GOV_PERFORMANCE
+       gov =3D find_governor("performance");
+       if (gov)
+               return gov;
+#endif
+
+       return gov;
+}
+
 static struct cpufreq_governor *get_governor(const char *str_governor)
 {
        struct cpufreq_governor *t;
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufr=
eq_conservative.c
index aa39ff31ec9f..25449a1ee954 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -330,12 +330,5 @@ MODULE_DESCRIPTION("'cpufreq_conservative' - A dynamic=
 cpufreq governor for "
                "optimised for use in a battery environment");
 MODULE_LICENSE("GPL");

-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-       return &CPU_FREQ_GOV_CONSERVATIVE;
-}
-#endif
-
 cpufreq_governor_init(CPU_FREQ_GOV_CONSERVATIVE);
 cpufreq_governor_exit(CPU_FREQ_GOV_CONSERVATIVE);
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_o=
ndemand.c
index ac361a8b1d3b..2a7fd645e1fb 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -467,12 +467,5 @@ MODULE_DESCRIPTION("'cpufreq_ondemand' - A dynamic cpu=
freq governor for "
        "Low Latency Frequency Transition capable processors");
 MODULE_LICENSE("GPL");

-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-       return &CPU_FREQ_GOV_ONDEMAND;
-}
-#endif
-
 cpufreq_governor_init(CPU_FREQ_GOV_ONDEMAND);
 cpufreq_governor_exit(CPU_FREQ_GOV_ONDEMAND);
diff --git a/drivers/cpufreq/cpufreq_performance.c b/drivers/cpufreq/cpufre=
q_performance.c
index 71c1d9aba772..c6c7473a3a73 100644
--- a/drivers/cpufreq/cpufreq_performance.c
+++ b/drivers/cpufreq/cpufreq_performance.c
@@ -23,12 +23,6 @@ static struct cpufreq_governor cpufreq_gov_performance =
=3D {
        .limits         =3D cpufreq_gov_performance_limits,
 };

-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-       return &cpufreq_gov_performance;
-}
-#endif
 #ifndef CONFIG_CPU_FREQ_GOV_PERFORMANCE_MODULE
 struct cpufreq_governor *cpufreq_fallback_governor(void)
 {
diff --git a/drivers/cpufreq/cpufreq_powersave.c b/drivers/cpufreq/cpufreq_=
powersave.c
index 7749522355b5..8b9555f70e9d 100644
--- a/drivers/cpufreq/cpufreq_powersave.c
+++ b/drivers/cpufreq/cpufreq_powersave.c
@@ -27,12 +27,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>");
 MODULE_DESCRIPTION("CPUfreq policy governor 'powersave'");
 MODULE_LICENSE("GPL");

-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-       return &cpufreq_gov_powersave;
-}
-#endif
-
 cpufreq_governor_init(cpufreq_gov_powersave);
 cpufreq_governor_exit(cpufreq_gov_powersave);
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_=
userspace.c
index 50a4d7846580..48ce53038ac0 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -131,12 +131,5 @@ MODULE_AUTHOR("Dominik Brodowski <linux@brodo.de>, "
 MODULE_DESCRIPTION("CPUfreq policy governor 'userspace'");
 MODULE_LICENSE("GPL");

-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-       return &cpufreq_gov_userspace;
-}
-#endif
-
 cpufreq_governor_init(cpufreq_gov_userspace);
 cpufreq_governor_exit(cpufreq_gov_userspace);
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedu=
til.c
index 5ae7b4e6e8d6..3b77e408377a 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -888,13 +888,6 @@ struct cpufreq_governor schedutil_gov =3D {
        .limits                 =3D sugov_limits,
 };

-#ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
-struct cpufreq_governor *cpufreq_default_governor(void)
-{
-       return &schedutil_gov;
-}
-#endif
-
 cpufreq_governor_init(schedutil_gov);

 #ifdef CONFIG_ENERGY_MODEL

