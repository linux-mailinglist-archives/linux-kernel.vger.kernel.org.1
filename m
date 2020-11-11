Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3C602AFA31
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgKKVKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:10:42 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71185C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:10:42 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 11so3225687qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nShzfx2jlTbPvWjrgA0qLkMImP/KRoOb/9o5edtvwT8=;
        b=nDLR80BGlpKLsXqsNfvL8BgzidSKLF7NNA2lb3/wrH1jDq233HtOJptNkV90Zn0800
         eR0Fxyu7k/MrU7JAU0Pf2W9DNjC3BVEo3KvLI657/53xPFw1I/ry2rgmSQ6/vFcw7fFz
         FEi1KL9USJ7m0r/qIAt6T92kbtSx87nZ+i5jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nShzfx2jlTbPvWjrgA0qLkMImP/KRoOb/9o5edtvwT8=;
        b=ISlSLmHOmQsaavxUS2clrQ/a3YNduuVV3gKKXww7sljLcmMnM5374GCmgM/H/Vsqf0
         KTDjOmPxUu6dDUS1mrQzcvmNfl1MOs6SXs380FlzRAMezRbqaWmSf2XLTvZrwKGXrovB
         RkaFw6mnkc/pbpkW/4tCpAoYU3vlWp05RsEjGBvK9cbo1T7vM+AlXe0H8HWA8IEF6otw
         G+g4EajIAV2dG8lRKvB6TBM0c0VlCUZu9racYgNkElDAE5kOblr8+wpw2zD9hoPeL8wt
         PxpU8S212zJi3fOuFpAdsuintP/5OLCDvLOwZ0YqyLxT270IbSXCMpMyOi4X/jl6j+N2
         YSMw==
X-Gm-Message-State: AOAM532Lj0Xk92cnQyuWbt+EHiINtkaljcoUAfJ+FL/2zpi2uA8ddTmN
        rHqCK3nHZ8A75BLpBjLduzOLbQ==
X-Google-Smtp-Source: ABdhPJz2OspMfh8UZUv7C1WmKn2rxqDZ25+pqHfshZMlU6B6YcsIeYzBy3irANcsZRlRB45jBmlZAw==
X-Received: by 2002:a05:620a:7ea:: with SMTP id k10mr25335758qkk.292.1605129041688;
        Wed, 11 Nov 2020 13:10:41 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d66sm2112389qke.132.2020.11.11.13.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:10:41 -0800 (PST)
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
        amistry@google.com, Borislav Petkov <bp@alien8.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Mike Rapoport <rppt@kernel.org>,
        thomas.lendacky@amd.com, Tony Luck <tony.luck@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [RFC 1/2] x86/bugs: Disable coresched on hardware that does not need it
Date:   Wed, 11 Nov 2020 16:10:10 -0500
Message-Id: <20201111211011.1381848-2-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
In-Reply-To: <20201111211011.1381848-1-joel@joelfernandes.org>
References: <20201111211011.1381848-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some hardware such as certain AMD variants don't have cross-HT MDS/L1TF
issues. Detect this and don't enable core scheduling as it can
needlessly slow the device done.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/kernel/cpu/bugs.c | 8 ++++++++
 kernel/sched/core.c        | 7 +++++++
 kernel/sched/sched.h       | 5 +++++
 3 files changed, 20 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index dece79e4d1e9..0e6e61e49b23 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -152,6 +152,14 @@ void __init check_bugs(void)
 #endif
 }
 
+/*
+ * Do not need core scheduling if CPU does not have MDS/L1TF vulnerability.
+ */
+int arch_allow_core_sched(void)
+{
+	return boot_cpu_has_bug(X86_BUG_MDS) || boot_cpu_has_bug(X86_BUG_L1TF);
+}
+
 void
 x86_virt_spec_ctrl(u64 guest_spec_ctrl, u64 guest_virt_spec_ctrl, bool setguest)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 64c559192634..c6158b4959fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -319,6 +319,13 @@ static void __sched_core_enable(void)
 	for_each_online_cpu(cpu)
 		BUG_ON(!sched_core_empty(cpu_rq(cpu)));
 
+	/*
+	 * Some architectures may not want coresched. (ex, AMD does not have
+	 * MDS/L1TF issues so it wants SMT completely on).
+	 */
+	if (!arch_allow_core_sched())
+		return;
+
 	static_branch_enable(&__sched_core_enabled);
 	stop_machine(__sched_core_stopper, (void *)true, NULL);
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3cf08c77b678..a1b39764a6ed 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1203,6 +1203,11 @@ int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
 
 bool cfs_prio_less(struct task_struct *a, struct task_struct *b, bool fi);
 
+int __weak arch_allow_core_sched(void)
+{
+	return true;
+}
+
 #else /* !CONFIG_SCHED_CORE */
 
 static inline bool sched_core_enqueued(struct task_struct *task) { return false; }
-- 
2.29.2.222.g5d2a92d10f8-goog

