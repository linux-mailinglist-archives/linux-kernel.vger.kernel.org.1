Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C77E2B07AA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:40:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgKLOkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:40:16 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBA2C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 06:40:16 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id z17so2807484qvy.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 06:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZ62YVoHxHzBcR9cMrEyYBwU05lPSWfWyO/VRjN8sVk=;
        b=EG5tJWeT/ABWu+s93E18Zgc5k8+34u9PLunwFLced7sixv6B5w5aO+v6c01x5GlecH
         +WNCgoi7ekxt42+2ryuE22AisMM/E9SwlDVYp/Qih1JKmyYIfvK09RqOFVYy+ukYDhpQ
         QdilYRY+oNYq81Ejmw2381ow7T9rndDFcI5Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZ62YVoHxHzBcR9cMrEyYBwU05lPSWfWyO/VRjN8sVk=;
        b=eeYYPGZHczSZcYrSJECIrqoXRehaDGgaSYWYWD6OTXt3KtWK0aMg8KefKKX/SdAQ32
         /dVXYTgbO4POc7jWNYwVzSkCiHZD9UjtNb1CQOWz9kulBco2SdNtvMj+1+cIHU6ffxLU
         703G8pEfNYZfePF72HzYVjTObaiA/7D4azCTtq03BCWz8UE1kz5UXUXnkild30OM2VEn
         nrQxo7qoJNRpbHvSsXHxamZWtrFHmODdxA0BkTXH7yOtKFhVMK+AfPOwcrXr2t24YtXp
         1GYu9dAMscSxtjZbkiY1psH9t+FyCqRGjFalrqaZiTGVizdvxrN/bBaDzFJZwtnaGZ5T
         rc3A==
X-Gm-Message-State: AOAM533Dd8InZi54O3StdqM9ojURfoESlh9gCgxlX1gHR/rxskMpIr7s
        a/6mn5qHzUf9GxpT2LZsszQQuw==
X-Google-Smtp-Source: ABdhPJxYhSfCz7tKSiqYArPPbU4U1E9NsfeTSwjn5X2ylA4GASA4rXynfi7Hd5YXK/bwKc/pA2vcwQ==
X-Received: by 2002:ad4:42a7:: with SMTP id e7mr7820905qvr.45.1605192015425;
        Thu, 12 Nov 2020 06:40:15 -0800 (PST)
Received: from localhost ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id z125sm5009833qke.54.2020.11.12.06.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 06:40:14 -0800 (PST)
Date:   Thu, 12 Nov 2020 09:40:14 -0500
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
Message-ID: <20201112144014.GB1549282@google.com>
References: <20201111211011.1381848-1-joel@joelfernandes.org>
 <20201111211011.1381848-2-joel@joelfernandes.org>
 <CAEXW_YTKTdBC_uD8E90FUNwoUWeyVG5XpFWvu-LO7X_fncnZnw@mail.gmail.com>
 <b1a1e07d-0df2-72c2-c3da-78e42fa355e8@amazon.com>
 <CAEXW_YRQ_GDcCxFcLrYjwNTG1nDZwUovczPSyOCvxXHq614DFw@mail.gmail.com>
 <CAEXW_YSC+qh8a4nhh6EC2jCaUZd1S59_enWT_rJSXSx5YHjFhw@mail.gmail.com>
 <76aa80c6-b797-f776-90fc-ef4585c41262@amazon.com>
 <20201112134005.GA1549282@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112134005.GA1549282@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 08:40:05AM -0500, Joel Fernandes wrote:
> On Wed, Nov 11, 2020 at 11:29:37PM +0100, Alexander Graf wrote:
> > 
> > 
> > On 11.11.20 23:15, Joel Fernandes wrote:
> > > 
> > > On Wed, Nov 11, 2020 at 5:13 PM Joel Fernandes <joel@joelfernandes.org> wrote:
> > > > 
> > > > On Wed, Nov 11, 2020 at 5:00 PM Alexander Graf <graf@amazon.com> wrote:
> > > > > On 11.11.20 22:14, Joel Fernandes wrote:
> > > > > > > Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
> > > > > > > issues. Detect this and don't enable core scheduling as it can
> > > > > > > needlessly slow the device done.
> > > > > > > 
> > > > > > > diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> > > > > > > index dece79e4d1e9..0e6e61e49b23 100644
> > > > > > > --- a/arch/x86/kernel/cpu/bugs.c
> > > > > > > +++ b/arch/x86/kernel/cpu/bugs.c
> > > > > > > @@ -152,6 +152,14 @@ void __init check_bugs(void)
> > > > > > >    #endif
> > > > > > >    }
> > > > > > > 
> > > > > > > +/*
> > > > > > > + * Do not need core scheduling if CPU does not have MDS/L1TF vulnerability.
> > > > > > > + */
> > > > > > > +int arch_allow_core_sched(void)
> > > > > > > +{
> > > > > > > +       return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X86_BUG_L1TF);
> > > > > 
> > > > > Can we make this more generic and user settable, similar to the L1 cache
> > > > > flushing modes in KVM?
> > > > > 
> > > > > I am not 100% convinced that there are no other thread sibling attacks
> > > > > possible without MDS and L1TF. If I'm paranoid, I want to still be able
> > > > > to force enable core scheduling.
> > > > > 
> > > > > In addition, we are also using core scheduling as a poor man's mechanism
> > > > > to give customers consistent performance for virtual machine thread
> > > > > siblings. This is important irrespective of CPU bugs. In such a
> > > > > scenario, I want to force enable core scheduling.
> > > > 
> > > > Ok,  I can make it new kernel command line option with:
> > > > coresched=on
> > > > coresched=secure (only if HW has MDS/L1TF)
> > > > coresched=off
> > > 
> > > Also, I would keep "secure" as the default.  (And probably, we should
> > > modify the informational messages in sysfs to reflect this..)
> > 
> > I agree that "secure" should be the default.
> 
> Ok.

Something like so then:

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dece79e4d1e9..3c2457d47f54 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -152,6 +152,21 @@ void __init check_bugs(void)
 #endif
 }
 
+/*
+ * When coresched=secure, do not need coresched if CPU does not have MDS/L1TF bugs.
+ */
+int arch_allow_core_sched(void)
+{
+	/*
+	 * x86: Disallow coresched if it is in secure mode and the CPU does not
+	 * have vulnerabilities.
+	 */
+	if (coresched_cmd_secure())
+		return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X86_BUG_L1TF);
+	else
+		return true;
+}
+
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index d6428aaf67e7..1be5cf85a4a6 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -228,4 +228,7 @@ static inline int cpuhp_smt_disable(enum cpuhp_smt_control ctrlval) { return 0;
 extern bool cpu_mitigations_off(void);
 extern bool cpu_mitigations_auto_nosmt(void);
 
+extern bool coresched_cmd_off(void);
+extern bool coresched_cmd_secure(void);
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ff2578ecf17..674edf534cc5 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2552,3 +2552,46 @@ bool cpu_mitigations_auto_nosmt(void)
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
+	return 0;
+}
+early_param("coresched", coresched_parse_cmdline);
+
+/* coresched=off */
+bool coresched_cmd_off(void)
+{
+	return coresched_cmd == CORE_SCHED_OFF;
+}
+EXPORT_SYMBOL_GPL(coresched_cmd_off);
+
+/* coresched=secure */
+bool coresched_cmd_secure(void)
+{
+	return coresched_cmd == CORE_SCHED_SECURE;
+}
+EXPORT_SYMBOL_GPL(coresched_cmd_secure);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ed26b469ed6..6f586d221ddb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -333,8 +333,23 @@ static void __sched_core_disable(void)
 	printk("core sched disabled\n");
 }
 
+static bool __coresched_supported(void)
+{
+	/* coreched=off command line option. */
+	if (coresched_cmd_off())
+		return false;
+
+	/*
+	 * Some arch may not need coresched, example some x86 may not need
+	 * coresched if coresched=secure option is passed (=secure is default).
+	 */
+	return arch_allow_core_sched();
+}
+
 void sched_core_get(void)
 {
+	if (!__coresched_supported())
+		return;
 	mutex_lock(&sched_core_mutex);
 	if (!sched_core_count++)
 		__sched_core_enable();
@@ -343,6 +358,8 @@ void sched_core_get(void)
 
 void sched_core_put(void)
 {
+	if (!__coresched_supported())
+		return;
 	mutex_lock(&sched_core_mutex);
 	if (!--sched_core_count)
 		__sched_core_disable();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ada56d8ce56f..20d2aa53336e 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1206,6 +1206,11 @@ int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
+int __weak arch_allow_core_sched(void)
+{
+	return true;
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enqueued(struct task_struct *task) { return false; }
