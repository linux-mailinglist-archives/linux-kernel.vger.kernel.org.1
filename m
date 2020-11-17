Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 016942B7239
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgKQXVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729411AbgKQXVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:21:04 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B07C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:03 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id 7so303704qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YEDfac65OY3DLuVKnFqM6y9NPMBrNBuAKRUHSFh0xrc=;
        b=uXkoemp5i8w7pGcJSKazUMIfeNWzK+4ZLqQY2vbq+X4N3ntuaH9I0jP0OdXvCC5xkx
         83sIxE3ZKzqjs57iubm7Vor3pEr3NrHRLePenPe3M9WiMA5Z53KEGE6iIleSVRTJzsoa
         m2zLi8ODAX6ZTUb/9gdygpfGd44PV8bCU0OPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YEDfac65OY3DLuVKnFqM6y9NPMBrNBuAKRUHSFh0xrc=;
        b=WTG5CoPGfP0R4FfJ/MMo+hUi1r6lQSyeOW0uCO4+e0dw/P0Ax2VF7nHmNWU53/LCLl
         UsBi7o5etrdDvOaoLY9SpN8WH9YYDTW2qS2GX4B9dFHjzvfF7Ea42B3PxShRKz4ycW0H
         JxtZ5pTl1iSZnSZPZ202NIVNz+UD4WF2JO1cKE7CngZd//c/fC5L3vfRLXYj6usOnkvK
         Hi2/4jqlzGBp/4oTpD6bPbm6ELIJtdf8z5NsS1xXl36+JAjH5n1Gw/6/wqURlwV/tGfd
         k81a0PktIBdJBhQu1KYjjutU6TTrtdTBc31xJqwPcIF2Hc7YbErlkXroTkqXD2bk1Amu
         ChjA==
X-Gm-Message-State: AOAM533FYu0BMEHk88KqDJWTBXejfz+VSJ6V/pmCiENtyp3z6WBtFRFv
        Cc6AOYdP2cmJ/WOlp390mL1uyw==
X-Google-Smtp-Source: ABdhPJxlK3Re5PIF2RJETAR9XPeKA1pD2SvKgqWSITtsn9iphyIDesxVjiizYjFWagJB8yPWAv/vUw==
X-Received: by 2002:ac8:c04:: with SMTP id k4mr2316764qti.66.1605655262907;
        Tue, 17 Nov 2020 15:21:02 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:21:02 -0800 (PST)
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
Subject: [PATCH -tip 26/32] sched: Add a second-level tag for nested CGroup usecase
Date:   Tue, 17 Nov 2020 18:19:56 -0500
Message-Id: <20201117232003.3580179-27-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josh Don <joshdon@google.com>

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

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h |   1 +
 kernel/sched/core.c   | 120 +++++++++++++++++++++++++++++++++++-------
 kernel/sched/sched.h  |   2 +
 3 files changed, 103 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6fbdb1a204bf..c9efdf8ccdf3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -690,6 +690,7 @@ struct task_struct {
 	unsigned long			core_cookie;
 	unsigned long			core_task_cookie;
 	unsigned long			core_group_cookie;
+	unsigned long			core_color;
 	unsigned int			core_occupation;
 #endif
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bd75b3d62a97..8f17ec8e993e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9049,9 +9049,6 @@ void sched_offline_group(struct task_group *tg)
 	spin_unlock_irqrestore(&task_group_lock, flags);
 }
 
-void cpu_core_get_group_cookie(struct task_group *tg,
-			       unsigned long *group_cookie_ptr);
-
 static void sched_change_group(struct task_struct *tsk, int type)
 {
 	struct task_group *tg;
@@ -9747,6 +9744,7 @@ static u64 cpu_rt_period_read_uint(struct cgroup_subsys_state *css,
 struct sched_core_cookie {
 	unsigned long task_cookie;
 	unsigned long group_cookie;
+	unsigned long color;
 
 	struct rb_node node;
 	refcount_t refcnt;
@@ -9782,6 +9780,7 @@ static int sched_core_cookie_cmp(const struct sched_core_cookie *a,
 
 	COOKIE_CMP_RETURN(task_cookie);
 	COOKIE_CMP_RETURN(group_cookie);
+	COOKIE_CMP_RETURN(color);
 
 	/* all cookie fields match */
 	return 0;
@@ -9819,7 +9818,7 @@ static void sched_core_put_cookie(struct sched_core_cookie *cookie)
 
 /*
  * A task's core cookie is a compound structure composed of various cookie
- * fields (task_cookie, group_cookie). The overall core_cookie is
+ * fields (task_cookie, group_cookie, color). The overall core_cookie is
  * a pointer to a struct containing those values. This function either finds
  * an existing core_cookie or creates a new one, and then updates the task's
  * core_cookie to point to it. Additionally, it handles the necessary reference
@@ -9837,6 +9836,7 @@ static void __sched_core_update_cookie(struct task_struct *p)
 	struct sched_core_cookie temp = {
 		.task_cookie	= p->core_task_cookie,
 		.group_cookie	= p->core_group_cookie,
+		.color		= p->core_color
 	};
 	const bool is_zero_cookie =
 		(sched_core_cookie_cmp(&temp, &zero_cookie) == 0);
@@ -9892,6 +9892,7 @@ static void __sched_core_update_cookie(struct task_struct *p)
 
 		match->task_cookie = temp.task_cookie;
 		match->group_cookie = temp.group_cookie;
+		match->color = temp.color;
 		refcount_set(&match->refcnt, 1);
 
 		rb_link_node(&match->node, parent, node);
@@ -9949,6 +9950,9 @@ static void sched_core_update_cookie(struct task_struct *p, unsigned long cookie
 	case sched_core_group_cookie_type:
 		p->core_group_cookie = cookie;
 		break;
+	case sched_core_color_type:
+		p->core_color = cookie;
+		break;
 	default:
 		WARN_ON_ONCE(1);
 	}
@@ -9967,19 +9971,23 @@ static void sched_core_update_cookie(struct task_struct *p, unsigned long cookie
 		sched_core_enqueue(task_rq(p), p);
 }
 
-void cpu_core_get_group_cookie(struct task_group *tg,
-			       unsigned long *group_cookie_ptr);
+void cpu_core_get_group_cookie_and_color(struct task_group *tg,
+					 unsigned long *group_cookie_ptr,
+					 unsigned long *color_ptr);
 
 void sched_core_change_group(struct task_struct *p, struct task_group *new_tg)
 {
-	unsigned long new_group_cookie;
+	unsigned long new_group_cookie, new_color;
 
-	cpu_core_get_group_cookie(new_tg, &new_group_cookie);
+	cpu_core_get_group_cookie_and_color(new_tg, &new_group_cookie,
+					    &new_color);
 
-	if (p->core_group_cookie == new_group_cookie)
+	if (p->core_group_cookie == new_group_cookie &&
+	    p->core_color == new_color)
 		return;
 
 	p->core_group_cookie = new_group_cookie;
+	p->core_color = new_color;
 
 	__sched_core_update_cookie(p);
 }
@@ -10203,17 +10211,24 @@ int sched_core_share_pid(pid_t pid)
  * Helper to get the group cookie and color in a hierarchy.
  * Any ancestor can have a tag/color. Atmost one color and one
  * tag is allowed.
- * Sets *group_cookie_ptr to the hierarchical group cookie.
+ * Sets *group_cookie_ptr and *color_ptr to the hierarchical group cookie
+ * and color.
  */
-void cpu_core_get_group_cookie(struct task_group *tg,
-			       unsigned long *group_cookie_ptr)
+void cpu_core_get_group_cookie_and_color(struct task_group *tg,
+					 unsigned long *group_cookie_ptr,
+					 unsigned long *color_ptr)
 {
 	unsigned long group_cookie = 0UL;
+	unsigned long color = 0UL;
 
 	if (!tg)
 		goto out;
 
 	for (; tg; tg = tg->parent) {
+		if (tg->core_tag_color) {
+			WARN_ON_ONCE(color);
+			color = tg->core_tag_color;
+		}
 
 		if (tg->core_tagged) {
 			group_cookie = (unsigned long)tg;
@@ -10223,22 +10238,25 @@ void cpu_core_get_group_cookie(struct task_group *tg,
 
 out:
 	*group_cookie_ptr = group_cookie;
+	*color_ptr = color;
 }
 
-/* Determine if any group in @tg's children are tagged. */
-static bool cpu_core_check_descendants(struct task_group *tg, bool check_tag)
+/* Determine if any group in @tg's children are tagged or colored. */
+static bool cpu_core_check_descendants(struct task_group *tg, bool check_tag,
+					bool check_color)
 {
 	struct task_group *child;
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(child, &tg->children, siblings) {
-		if ((child->core_tagged && check_tag)) {
+		if ((child->core_tagged && check_tag) ||
+		    (child->core_tag_color && check_color)) {
 			rcu_read_unlock();
 			return true;
 		}
 
 		rcu_read_unlock();
-		return cpu_core_check_descendants(child, check_tag);
+		return cpu_core_check_descendants(child, check_tag, check_color);
 	}
 
 	rcu_read_unlock();
@@ -10252,6 +10270,13 @@ static u64 cpu_core_tag_read_u64(struct cgroup_subsys_state *css, struct cftype
 	return !!tg->core_tagged;
 }
 
+static u64 cpu_core_tag_color_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	struct task_group *tg = css_tg(css);
+
+	return tg->core_tag_color;
+}
+
 struct write_core_tag {
 	struct cgroup_subsys_state *css;
 	unsigned long cookie;
@@ -10289,7 +10314,7 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 {
 	struct task_group *tg = css_tg(css);
 	struct write_core_tag wtag;
-	unsigned long group_cookie;
+	unsigned long group_cookie, color;
 
 	if (val > 1)
 		return -ERANGE;
@@ -10299,13 +10324,13 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 
 	if (!tg->core_tagged && val) {
 		/* Tag is being set. Check ancestors and descendants. */
-		cpu_core_get_group_cookie(tg, &group_cookie);
+		cpu_core_get_group_cookie_and_color(tg, &group_cookie, &color);
 		if (group_cookie ||
-		    cpu_core_check_descendants(tg, true /* tag */))
+		    cpu_core_check_descendants(tg, true /* tag */, true /* color */))
 			return -EBUSY;
 	} else if (tg->core_tagged && !val) {
 		/* Tag is being reset. Check descendants. */
-		if (cpu_core_check_descendants(tg, true /* tag */))
+		if (cpu_core_check_descendants(tg, true /* tag */, true /* color */))
 			return -EBUSY;
 	} else {
 		return 0;
@@ -10327,6 +10352,49 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 	return 0;
 }
 
+static int cpu_core_tag_color_write_u64(struct cgroup_subsys_state *css,
+					struct cftype *cft, u64 val)
+{
+	struct task_group *tg = css_tg(css);
+	struct write_core_tag wtag;
+	unsigned long group_cookie, color;
+
+	if (val > ULONG_MAX)
+		return -ERANGE;
+
+	if (!static_branch_likely(&sched_smt_present))
+		return -EINVAL;
+
+	cpu_core_get_group_cookie_and_color(tg, &group_cookie, &color);
+	/* Can't set color if nothing in the ancestors were tagged. */
+	if (!group_cookie)
+		return -EINVAL;
+
+	/*
+	 * Something in the ancestors already colors us. Can't change the color
+	 * at this level.
+	 */
+	if (!tg->core_tag_color && color)
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
+	wtag.css = css;
+	wtag.cookie = val;
+	wtag.cookie_type = sched_core_color_type;
+	tg->core_tag_color = val;
+
+	stop_machine(__sched_write_tag, (void *) &wtag, NULL);
+
+	return 0;
+}
+
 static int sched_update_core_tag_stopper(void *data)
 {
 	struct task_struct *p = (struct task_struct *)data;
@@ -10476,6 +10544,12 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -10657,6 +10731,12 @@ static struct cftype cpu_files[] = {
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
index 042a9d6a3be9..0ca22918b69a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -379,6 +379,7 @@ struct task_group {
 
 #ifdef CONFIG_SCHED_CORE
 	int			core_tagged;
+	unsigned long		core_tag_color;
 #endif
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
@@ -1134,6 +1135,7 @@ enum sched_core_cookie_type {
 	sched_core_no_update = 0,
 	sched_core_task_cookie_type,
 	sched_core_group_cookie_type,
+	sched_core_color_type
 };
 
 static inline bool sched_core_enabled(struct rq *rq)
-- 
2.29.2.299.gdc1121823c-goog

