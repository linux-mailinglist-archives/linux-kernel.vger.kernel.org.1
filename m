Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4312932D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgJTBov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390258AbgJTBon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:43 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31666C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:43 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id t12so321754ilh.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLobPh/Mu0L9eTfv8cdLTuUNtiYeE1LXqzmT89mKjlA=;
        b=oqTstvKrBaWr85WBxxchFVzDKRZpr23kZchq1kl+Sumr03R0JvhtcxLCUhjeWiOV8w
         t5x/wsWH1yyvfLEorEr+Zt/2gbqBHyyJdBi5L0LYrvxR/iBM5gXfzQqzFQVCz+wHs0aN
         LEQrAQqEzfAdwLY026CCnDXK9wh4lRZuHJnKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLobPh/Mu0L9eTfv8cdLTuUNtiYeE1LXqzmT89mKjlA=;
        b=kRzmDCQjDWBEsqrFcPNHZXhWp2YReOpcqUZkSdmH0UV0UktwjBq4knLMumZm1UQ1zK
         uEykEoe3ypyOgRGUTCx96htl18Dhkkwai5kiICY+Lh/bTz4fmGUTYr/MOm1lD/RhSl/T
         zGhB2RvKwVI8q9EDJM+suOrMlHHYjB7tP0TID5UXEvfCAmH1k+ARaQxpYx6bxrEg2vNw
         6LEy+4oj9EwLz+vVg2iksekhZyZIDTfSYiHvbOgDN7ncw09DjvcxFF82HJ/Qthk3lfmM
         3N8Rmr27URg3PV98SjjAPAnmQzlq4OC3v2zTXS4b1EHuEthwFAlEOH1LhBPUXBHFoHSa
         BHzA==
X-Gm-Message-State: AOAM533uWHyk/ti5ncCZQP55cMtGTVgFEVFu2x21a07EYahvzvj1N2PZ
        3IOvcn9mcuJWv/2rsxsbQUyE+Q==
X-Google-Smtp-Source: ABdhPJx7zMSIAkpmqaU3ZvW1WBlfYiDGrYjTMRQKvgCXy6kIhAHVL71MVyxIDCcj0re29+1MWACPRQ==
X-Received: by 2002:a05:6e02:1386:: with SMTP id d6mr261178ilo.116.1603158282467;
        Mon, 19 Oct 2020 18:44:42 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:41 -0700 (PDT)
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
        chris.hyser@oracle.com, Aubrey Li <aubrey.li@linux.intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>
Subject: [PATCH v8 -tip 19/26] sched: Add a second-level tag for nested CGroup usecase
Date:   Mon, 19 Oct 2020 21:43:29 -0400
Message-Id: <20201020014336.2076526-20-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Google has a usecase where the first level tag to tag a CGroup is not
sufficient. So, a patch is carried for years where a second tag is added which
is writeable by unprivileged users.

Google uses DAC controls to make the 'tag' possible to set only by root while
the second-level 'color' can be changed by anyone. The actual names that
Google uses is different, but the concept is the same.

The hierarchy looks like:

Root group
   / \
  A   B    (These are created by the root daemon - borglet).
 / \   \
C   D   E  (These are created by AppEngine within the container).

The reason why Google has two parts is that AppEngine wants to allow a subset of
subcgroups within a parent tagged cgroup sharing execution. Think of these
subcgroups belong to the same customer or project. Because these subcgroups are
created by AppEngine, they are not tracked by borglet (the root daemon),
therefore borglet won't have a chance to set a color for them. That's where
'color' file comes from. Color could be set by AppEngine, and once set, the
normal tasks within the subcgroup would not be able to overwrite it. This is
enforced by promoting the permission of the color file in cgroupfs.

The 'color' is a 8-bit value allowing for upto 256 unique colors. IMHO, having
more than these many CGroups sounds like a scalability issue so this suffices.
We steal the lower 8-bits of the cookie to set the color.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c  | 181 +++++++++++++++++++++++++++++++++++++------
 kernel/sched/sched.h |   3 +-
 2 files changed, 158 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a0678614a056..42aa811eab14 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8522,7 +8522,7 @@ static void sched_change_group(struct task_struct *tsk, int type)
 	if ((unsigned long)tsk->sched_task_group == tsk->core_cookie)
 		tsk->core_cookie = 0UL;
 
-	if (tg->tagged /* && !tsk->core_cookie ? */)
+	if (tg->core_tagged /* && !tsk->core_cookie ? */)
 		tsk->core_cookie = (unsigned long)tg;
 #endif
 
@@ -8623,9 +8623,9 @@ static void cpu_cgroup_css_offline(struct cgroup_subsys_state *css)
 #ifdef CONFIG_SCHED_CORE
 	struct task_group *tg = css_tg(css);
 
-	if (tg->tagged) {
+	if (tg->core_tagged) {
 		sched_core_put();
-		tg->tagged = 0;
+		tg->core_tagged = 0;
 	}
 #endif
 }
@@ -9228,7 +9228,7 @@ void sched_core_tag_requeue(struct task_struct *p, unsigned long cookie, bool gr
 
 	if (sched_core_enqueued(p)) {
 		sched_core_dequeue(task_rq(p), p);
-		if (!p->core_task_cookie)
+		if (!p->core_cookie)
 			return;
 	}
 
@@ -9448,41 +9448,100 @@ int sched_core_share_pid(pid_t pid)
 }
 
 /* CGroup interface */
+
+/*
+ * Helper to get the cookie in a hierarchy.
+ * The cookie is a combination of a tag and color. Any ancestor
+ * can have a tag/color. tag is the first-level cookie setting
+ * with color being the second. Atmost one color and one tag is
+ * allowed.
+ */
+static unsigned long cpu_core_get_group_cookie(struct task_group *tg)
+{
+	unsigned long color = 0;
+
+	if (!tg)
+		return 0;
+
+	for (; tg; tg = tg->parent) {
+		if (tg->core_tag_color) {
+			WARN_ON_ONCE(color);
+			color = tg->core_tag_color;
+		}
+
+		if (tg->core_tagged) {
+			unsigned long cookie = ((unsigned long)tg << 8) | color;
+			cookie &= (1UL << (sizeof(unsigned long) * 4)) - 1;
+			return cookie;
+		}
+	}
+
+	return 0;
+}
+
+/* Determine if any group in @tg's children are tagged or colored. */
+static bool cpu_core_check_descendants(struct task_group *tg, bool check_tag,
+					bool check_color)
+{
+	struct task_group *child;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(child, &tg->children, siblings) {
+		if ((child->core_tagged && check_tag) ||
+		    (child->core_tag_color && check_color)) {
+			rcu_read_unlock();
+			return true;
+		}
+
+		rcu_read_unlock();
+		return cpu_core_check_descendants(child, check_tag, check_color);
+	}
+
+	rcu_read_unlock();
+	return false;
+}
+
 static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
 {
 	struct task_group *tg = css_tg(css);
 
-	return !!tg->tagged;
+	return !!tg->core_tagged;
+}
+
+static u64 cpu_core_tag_color_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return tg->core_tag_color;
 }
 
 struct write_core_tag {
 	struct cgroup_subsys_state *css;
-	int val;
+	unsigned long cookie;
 };
 
 static int __sched_write_tag(void *data)
 {
 	struct write_core_tag *tag = (struct write_core_tag *) data;
-	struct cgroup_subsys_state *css = tag->css;
-	int val = tag->val;
-	struct task_group *tg = css_tg(tag->css);
-	struct css_task_iter it;
 	struct task_struct *p;
+	struct cgroup_subsys_state *css;
 
-	tg->tagged = !!val;
+	rcu_read_lock();
+	css_for_each_descendant_pre(css, tag->css) {
+		struct css_task_iter it;
 
-	css_task_iter_start(css, 0, &it);
-	/*
-	 * Note: css_task_iter_next will skip dying tasks.
-	 * There could still be dying tasks left in the core queue
-	 * when we set cgroup tag to 0 when the loop is done below.
-	 */
-	while ((p = css_task_iter_next(&it))) {
-		unsigned long cookie = !!val ? (unsigned long)tg : 0UL;
+		css_task_iter_start(css, 0, &it);
+		/*
+		 * Note: css_task_iter_next will skip dying tasks.
+		 * There could still be dying tasks left in the core queue
+		 * when we set cgroup tag to 0 when the loop is done below.
+		 */
+		while ((p = css_task_iter_next(&it)))
+			sched_core_tag_requeue(p, tag->cookie, true /* group */);
 
-		sched_core_tag_requeue(p, cookie, true /* group */);
+		css_task_iter_end(&it);
 	}
-	css_task_iter_end(&it);
+	rcu_read_unlock();
 
 	return 0;
 }
@@ -9498,20 +9557,80 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 	if (!static_branch_likely(&sched_smt_present))
 		return -EINVAL;
 
-	if (tg->tagged == !!val)
+	if (!tg->core_tagged && val) {
+		/* Tag is being set. Check ancestors and descendants. */
+		if (cpu_core_get_group_cookie(tg) ||
+		    cpu_core_check_descendants(tg, true /* tag */, true /* color */))
+			return -EBUSY;
+	} else if (tg->core_tagged && !val) {
+		/* Tag is being reset. Check descendants. */
+		if (cpu_core_check_descendants(tg, true /* tag */, true /* color */))
+			return -EBUSY;
+	} else {
 		return 0;
+	}
 
 	if (!!val)
 		sched_core_get();
 
 	wtag.css = css;
-	wtag.val = val;
+	wtag.cookie = (unsigned long)tg << 8; /* Reserve lower 8 bits for color. */
+
+	/* Truncate the upper 32-bits - those are used by the per-task cookie. */
+	wtag.cookie &= (1UL << (sizeof(unsigned long) * 4)) - 1;
+
+	tg->core_tagged = val;
+
 	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
 	if (!val)
 		sched_core_put();
 
 	return 0;
 }
+
+static int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
+					struct cftype *cft, u64 val)
+{
+	struct task_group *tg = css_tg(css);
+	struct write_core_tag wtag;
+	u64 cookie;
+
+	if (val > 255)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	cookie = cpu_core_get_group_cookie(tg);
+	/* Can't set color if nothing in the ancestors were tagged. */
+	if (!cookie)
+		return -EINVAL;
+
+	/*
+	 * Something in the ancestors already colors us. Can't change the color
+	 * at this level.
+	 */
+	if (!tg->core_tag_color && (cookie & 255))
+		return -EINVAL;
+
+	/*
+	 * Check if any descendants are colored. If so, we can't recolor them.
+	 * Don't need to check if descendants are tagged, since we don't allow
+	 * tagging when already tagged.
+	 */
+	if (cpu_core_check_descendants(tg, false /* tag */, true /* color */))
+		return -EINVAL;
+
+	cookie &= ~255;
+	cookie |= val;
+	wtag.css = css;
+	wtag.cookie = cookie;
+	tg->core_tag_color = val;
+
+	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
+
+	return 0;
+}
 #endif
 
 static struct cftype cpu_legacy_files[] = {
@@ -9552,11 +9671,17 @@ static struct cftype cpu_legacy_files[] = {
 #endif
 #ifdef CONFIG_SCHED_CORE
 	{
-		.name = "tag",
+		.name = "core_tag",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_core_tag_read_u64,
 		.write_u64 = cpu_core_tag_write_u64,
 	},
+	{
+		.name = "core_tag_color",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_color_read_u64,
+		.write_u64 = cpu_core_tag_color_write_u64,
+	},
 #endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
@@ -9733,11 +9858,17 @@ static struct cftype cpu_files[] = {
 #endif
 #ifdef CONFIG_SCHED_CORE
 	{
-		.name = "tag",
+		.name = "core_tag",
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = cpu_core_tag_read_u64,
 		.write_u64 = cpu_core_tag_write_u64,
 	},
+	{
+		.name = "core_tag_color",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_tag_color_read_u64,
+		.write_u64 = cpu_core_tag_color_write_u64,
+	},
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 661569ee4650..aebeb91c4a0f 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -385,7 +385,8 @@ struct task_group {
 	struct cgroup_subsys_state css;
 
 #ifdef CONFIG_SCHED_CORE
-	int			tagged;
+	int			core_tagged;
+	u8			core_tag_color;
 #endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
-- 
2.29.0.rc1.297.gfa9743e501-goog

