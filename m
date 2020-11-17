Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44BFC2B7241
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgKQXVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgKQXVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:21:13 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E89FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:13 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id m65so236232qte.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6WuM+6r0yCFZdrHDSQ2aQlujX43o/jCxVOfwb7J1QCk=;
        b=pbluQwSsaYe/twaGGvRgdLyzgFXxR6Af5lGd3JLfNDoDTamSTBk3pAU30gp0moWP9T
         4czZjV+9fhq/ZOTogXw+7fxdR9zgxvMRXOTCLu3yBQUsuQw5lv8AU2sy3lWPJZDOc0aV
         pPuRfYA3Er8TMUums6GwdPDD1vpVPLYnfGZF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6WuM+6r0yCFZdrHDSQ2aQlujX43o/jCxVOfwb7J1QCk=;
        b=LqfdiToSe3Q539+P4q94jET6yBhdb3ea02dTYNyYpzvqJ6a2UJE7xbXa+q12R9fVSn
         xo9Mc2kndKnTmmLI3k3FJM+1GfpDmtullDggMbGvKBGt2NGcQ7joKGV28J4TB7odzsXP
         y2HEupYjyuwFV3c/YYveG5IR++mASrvyv5tnv1vO7wTD6dKtsiKhQ8YBwfC7p8SM0QfV
         Qk3meeemC6lMg5ygSD1iLxveR4e1LoGeY4FtEQTiAt0YERTdVQxvRmVglTtcpl+RdO5t
         q0h37G0dC9hLXqx1YZ8MJ9rlKTJ/kVGCtO1Om51hgUBwh7gcpuu5ECIlKk+/p1pXbDYf
         k8ww==
X-Gm-Message-State: AOAM530t/Wi2mTR61IeZg/Y1+4CBbmCHmECWW68tqdhJP+Dbekp4k/jR
        quNgg/3j9EflEVJ9nT6Vv87oew==
X-Google-Smtp-Source: ABdhPJxyVO14UZGfsPzg/bBJvN9hQQCZ9Eh9LmpAL/OcKox7QIZpriL59+E+XeRjKevhx+PAU+WOvg==
X-Received: by 2002:ac8:3607:: with SMTP id m7mr2144222qtb.361.1605655272532;
        Tue, 17 Nov 2020 15:21:12 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:21:11 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, torvalds@linux-foundation.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        pjt@google.com, rostedt@goodmis.org, derkling@google.com,
        benbjiang@tencent.com,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        James.Bottomley@hansenpartnership.com, OWeisse@umich.edu,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Junaid Shahid <junaids@google.com>, jsbarnes@google.com,
        chris.hyser@oracle.com, Ben Segall <bsegall@google.com>,
        Josh Don <joshdon@google.com>, Hao Luo <haoluo@google.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH -tip 31/32] sched: Add a coresched command line option
Date:   Tue, 17 Nov 2020 18:20:01 -0500
Message-Id: <20201117232003.3580179-32-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Reviewed-by: Alexander Graf <graf@amazon.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 .../admin-guide/kernel-parameters.txt         | 14 ++++++
 arch/x86/kernel/cpu/bugs.c                    | 19 ++++++++
 include/linux/cpu.h                           |  1 +
 include/linux/sched/smt.h                     |  4 ++
 kernel/cpu.c                                  | 43 +++++++++++++++++++
 kernel/sched/core.c                           |  6 +++
 kernel/sched/debug.c                          |  4 ++
 7 files changed, 91 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b185c6ed4aba..9cd2cf7c18d4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -698,6 +698,20 @@
 			/proc/<pid>/coredump_filter.
 			See also Documentation/filesystems/proc.rst.
 
+	coresched=	[SCHED_CORE] This feature allows the Linux scheduler
+			to force hyperthread siblings of a CPU to only execute tasks
+			concurrently on all hyperthreads that are running within the
+			same core scheduling group.
+			Possible values are:
+			'on' - Enable scheduler capability to core schedule.
+			By default, no tasks will be core scheduled, but the coresched
+			interface can be used to form groups of tasks that are forced
+			to share a core.
+			'off' - Disable scheduler capability to core schedule.
+			'secure' - Like 'on' but only enable on systems affected by
+			MDS or L1TF vulnerabilities. 'off' otherwise.
+			Default: 'secure'.
+
 	coresight_cpu_debug.enable
 			[ARM,ARM64]
 			Format: <bool>
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dece79e4d1e9..f3163f4a805c 100644
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
+	if (coresched_cmd_secure() &&
+	    !boot_cpu_has_bug(X86_BUG_MDS) &&
+	    !boot_cpu_has_bug(X86_BUG_L1TF))
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
index fa535eaa4826..f22330c3ab4c 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2559,3 +2559,46 @@ bool cpu_mitigations_auto_nosmt(void)
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
+		/*
+		 * On x86, coresched=secure means coresched is enabled only if
+		 * system has MDS/L1TF vulnerability (see x86/bugs.c).
+		 */
+		coresched_cmd = CORE_SCHED_SECURE;
+	else
+		pr_crit("Unsupported coresched=%s, defaulting to secure.\n",
+			arg);
+
+	if (coresched_cmd == CORE_SCHED_OFF)
+		static_branch_disable(&sched_coresched_supported);
+
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
index 5ef04bdc849f..01938a2154fd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -325,8 +325,12 @@ static void __sched_core_disable(void)
 	static_branch_disable(&__sched_core_enabled);
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
@@ -335,6 +339,8 @@ void sched_core_get(void)
 
 void sched_core_put(void)
 {
+	if (!static_branch_likely(&sched_coresched_supported))
+		return;
 	mutex_lock(&sched_core_mutex);
 	if (!--sched_core_count)
 		__sched_core_disable();
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8c452b8010ad..cffdfab7478e 100644
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

