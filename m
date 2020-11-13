Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D84F2B1F46
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKMPz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMPz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:55:29 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15F2C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:55:28 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d28so9157855qka.11
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZ5Qlb+FECWsTIzn7xsXGLWe+YlE1PgJ5PsN5SRg6ZU=;
        b=Kvzt45AShv425MVJ7LnE30XYlZYN1hFxofuOjxHbdb5ckNUWQ+drMBUjdcmo+LUK8E
         IWQ3kN2D0ozXicxokpQsd+QTfUAdIhiIrz6+82xmZxFTYQdK2GespXQ1KaXANNb4me5Q
         3Pb8uVL0YenqhNjHEiScu/OnIuhxohMisZsb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZ5Qlb+FECWsTIzn7xsXGLWe+YlE1PgJ5PsN5SRg6ZU=;
        b=bZMtUZqnYsfqIeHE4DnT0im1LQleDq1QLrI4JD8l5Vo/Vg2VU4OvlBB5diYjtwhX6l
         U1+a9/nslqdUkFsJiuJbl3gMCAFTILZOXCiWW7rCTgp7TMrHdbv+Tz8RJmU8+Hn2wGVo
         L8I8zDWjWNi3M4a/T9hAleJPZpajZQbe16/KmWkdnsE0Du9/kYtAj3JUCIdXUNkGFlwF
         Ym/gGK7OxUIyJo/j4BSiFpUN5bHApWLsVwmKVewNHFxXuUAKDmcWDHe6lZXhOSvjhydU
         hD+BqCV/PyC7J9+gCXLfXediDY9I1woOyGUaHGARBECYpaDTx8oTuWLOEqXKFN4Od4Uh
         0w4g==
X-Gm-Message-State: AOAM533riP1/MNW0a7ND5Gw80G3UPaflEg6CnCC19QX+zQZgH+t+7Bpf
        sgyYC6NoGMa3PSpikPvjvxzXvw==
X-Google-Smtp-Source: ABdhPJytIMwKA8QCUMtqjQolGV3XWrASTkHf4zOyOxuotLOy0WbChhPWwrvt5dxAOpvOcR0UPcUqrQ==
X-Received: by 2002:a37:9883:: with SMTP id a125mr2701560qke.430.1605282922851;
        Fri, 13 Nov 2020 07:55:22 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id s71sm515300qka.102.2020.11.13.07.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:55:21 -0800 (PST)
Date:   Fri, 13 Nov 2020 10:55:20 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Alexander Graf <graf@amazon.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Thomas Glexiner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        konrad.wilk@oracle.com, Dario Faggioli <dfaggioli@suse.com>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?utf-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        "Hyser,Chris" <chris.hyser@oracle.com>,
        Ben Segall <bsegall@google.com>, Josh Don <joshdon@google.com>,
        Hao Luo <haoluo@google.com>,
        "Anand K. Mistry" <amistry@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Subject: Re: [RFC 1/2] x86/bugs: Disable coresched on hardware that does not
 need it
Message-ID: <20201113155520.GA2156685@google.com>
References: <20201111211011.1381848-1-joel@joelfernandes.org>
 <20201111211011.1381848-2-joel@joelfernandes.org>
 <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
 <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com>
 <CAEXW_YRQ_GDcCxFcLrYjwNTG1nDZwUovczPSyOCvxXHq614DFw@mail.gmail.com>
 <CAEXW_YSC+qh8a4nhh6EC2jCaUZd1S59_enWT_rJSXSx5YHjFhw@mail.gmail.com>
 <76aa80c6-b797-f776-90fc-ef4585c41262@amazon.com>
 <20201112134005.GA1549282@google.com>
 <20201112144014.GB1549282@google.com>
 <0b311000-98a2-039a-6b47-75fb9895324f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b311000-98a2-039a-6b47-75fb9895324f@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static enum coresched_cmds coresched_cmd __ro_after_init = CORE_SCHED_SECURE;
> > +
> > +static int __init coresched_parse_cmdline(char *arg)
> > +{
> > +       if (!strcmp(arg, "off"))
> > +               coresched_cmd = CORE_SCHED_OFF;
> > +       else if (!strcmp(arg, "on"))
> > +               coresched_cmd = CORE_SCHED_ON;
> > +       else if (!strcmp(arg, "secure"))
> > +               coresched_cmd = CORE_SCHED_SECURE;
> > +       else
> > +               pr_crit("Unsupported coresched=%s, defaulting to secure.\n",
> > +                       arg);
> > +
> > +       return 0;
> 
> 
> Instead of calling the matching function over and over again, can we just
> configure a static branch (see below) based on the command line setting
> here? Or do we not know about the bugs yet?
[...]
> > +static bool __coresched_supported(void)
> > +{
> > +       /* coreched=off command line option. */
> > +       if (coresched_cmd_off())
> > +               return false;
> > +
> > +       /*
> > +        * Some arch may not need coresched, example some x86 may not need
> > +        * coresched if coresched=secure option is passed (=secure is default).
> > +        */
> > +       return arch_allow_core_sched();
> > +}
> > +
> >   void sched_core_get(void)
> >   {
> > +       if (!__coresched_supported())
> > +               return;
> 
> I would expect core scheduling to be basically an option that you set once
> and never flip. This sounds like a prefect use case for a static branch to
> me?

Something ike so then? If Ok, let me know if I can add your Reviewed-by tag.

thanks!

---8<-----------------------

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH] sched: Add a coresched command line option

Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
issues. Detect this and don't enable core scheduling as it can
needlessly slow those device down.

However, some users may want core scheduling even if the hardware is
secure. To support them, add a coresched= option which defaults to
'secure' and can be overridden to 'on' if the user wants to enable
coresched even if the HW is not vulnerable. 'off' would disable
core scheduling in any case.

Also add a sched_debug entry to indicate if core scheduling is turned on
or not.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/kernel/cpu/bugs.c | 19 +++++++++++++++++++
 include/linux/cpu.h        |  1 +
 include/linux/sched/smt.h  |  4 ++++
 kernel/cpu.c               | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/sched/core.c        |  6 ++++++
 kernel/sched/debug.c       |  4 ++++
 6 files changed, 72 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dece79e4d1e9..7607c9cd7f0f 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -43,6 +43,7 @@ static void __init mds_select_mitigation(void);
 static void __init mds_print_mitigation(void);
 static void __init taa_select_mitigation(void);
 static void __init srbds_select_mitigation(void);
+static void __init coresched_select(void);
 
 /* The base value of the SPEC_CTRL MSR that always has to be preserved. */
 u64 x86_spec_ctrl_base;
@@ -103,6 +104,9 @@ void __init check_bugs(void)
 	if (boot_cpu_has(X86_FEATURE_STIBP))
 		x86_spec_ctrl_mask |= SPEC_CTRL_STIBP;
 
+	/* Update whether core-scheduling is needed. */
+	coresched_select();
+
 	/* Select the proper CPU mitigations before patching alternatives: */
 	spectre_v1_select_mitigation();
 	spectre_v2_select_mitigation();
@@ -1808,4 +1812,19 @@ ssize_t cpu_show_srbds(struct device *dev, struct device_attribute *attr, char *
 {
 	return cpu_show_common(dev, attr, buf, X86_BUG_SRBDS);
 }
+
+/*
+ * When coresched=secure command line option is passed (default), disable core
+ * scheduling if CPU does not have MDS/L1TF vulnerability.
+ */
+static void __init coresched_select(void)
+{
+#ifdef CONFIG_SCHED_CORE
+	if (!coresched_cmd_secure())
+		return;
+	if (!boot_cpu_has_bug(X86_BUG_MDS) && !boot_cpu_has_bug(X86_BUG_L1TF))
+		static_branch_disable(&sched_coresched_supported);
+#endif
+}
+
 #endif
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d6428aaf67e7..d1f1e64316d6 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -228,4 +228,5 @@ static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0;
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
 
+extern bool coresched_cmd_secure(void);
 #endif /* _LINUX_CPU_H_ */
diff --git a/include/linux/sched/smt.h b/include/linux/sched/smt.h
index 59d3736c454c..561064eb3268 100644
--- a/include/linux/sched/smt.h
+++ b/include/linux/sched/smt.h
@@ -17,4 +17,8 @@ static inline bool sched_smt_active(void) { return false; }
 
 void arch_smt_update(void);
 
+#ifdef CONFIG_SCHED_CORE
+extern struct static_key_true sched_coresched_supported;
+#endif
+
 #endif
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..b1cdfc7616b4 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2552,3 +2552,41 @@ bool cpu_mitigations_auto_nosmt(void)
 	return cpu_mitigations == CPU_MITIGATIONS_AUTO_NOSMT;
 }
 EXPORT_SYMBOL_GPL(cpu_mitigations_auto_nosmt);
+
+/*
+ * These are used for a global "coresched=" cmdline option for controlling
+ * core scheduling. Note that core sched may be needed for usecases other
+ * than security as well.
+ */
+enum coresched_cmds {
+	CORE_SCHED_OFF,
+	CORE_SCHED_SECURE,
+	CORE_SCHED_ON,
+};
+
+static enum coresched_cmds coresched_cmd __ro_after_init = CORE_SCHED_SECURE;
+
+static int __init coresched_parse_cmdline(char *arg)
+{
+	if (!strcmp(arg, "off"))
+		coresched_cmd = CORE_SCHED_OFF;
+	else if (!strcmp(arg, "on"))
+		coresched_cmd = CORE_SCHED_ON;
+	else if (!strcmp(arg, "secure"))
+		coresched_cmd = CORE_SCHED_SECURE;
+	else
+		pr_crit("Unsupported coresched=%s, defaulting to secure.\n",
+			arg);
+
+	if (coresched_cmd == CORE_SCHED_OFF)
+		static_branch_disable(&sched_coresched_supported);
+	return 0;
+}
+early_param("coresched", coresched_parse_cmdline);
+
+/* coresched=secure */
+bool coresched_cmd_secure(void)
+{
+	return coresched_cmd == CORE_SCHED_SECURE;
+}
+EXPORT_SYMBOL_GPL(coresched_cmd_secure);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ed26b469ed6..959fddf7d8de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -333,8 +333,12 @@ static void __sched_core_disable(void)
 	printk("core sched disabled\n");
 }
 
+DEFINE_STATIC_KEY_TRUE(sched_coresched_supported);
+
 void sched_core_get(void)
 {
+	if (!static_branch_likely(&sched_coresched_supported))
+		return;
 	mutex_lock(&sched_core_mutex);
 	if (!sched_core_count++)
 		__sched_core_enable();
@@ -343,6 +347,8 @@ void sched_core_get(void)
 
 void sched_core_put(void)
 {
+	if (!static_branch_likely(&sched_coresched_supported))
+		return;
 	mutex_lock(&sched_core_mutex);
 	if (!--sched_core_count)
 		__sched_core_disable();
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 88bf45267672..935b68be18cd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -782,6 +782,10 @@ static void sched_debug_header(struct seq_file *m)
 		"sysctl_sched_tunable_scaling",
 		sysctl_sched_tunable_scaling,
 		sched_tunable_scaling_names[sysctl_sched_tunable_scaling]);
+#ifdef CONFIG_SCHED_CORE
+	SEQ_printf(m, "  .%-40s: %d\n", "core_sched_enabled",
+		   !!static_branch_likely(&__sched_core_enabled));
+#endif
 	SEQ_printf(m, "\n");
 }
 
-- 
2.29.2.299.gdc1121823c-goog

