Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 613032B723C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgKQXVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729437AbgKQXVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:21:07 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DD6C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:05 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b16so275039qtb.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/lM84oNLQ+30tWLWeZIn+ggWVAns9aJ5yoonWjl8po=;
        b=JcRn0qVJ2eexWxYF7oFFqBsXmRMtad3lg9vq2MV/bFYjK9A+icZNWJae90YTH50FA+
         t7cwwVPmUoZxvpYkGaB5DDV2lhCFV3lkpD34+aTSkRZhgOVVxPft4I8N9e87gyR/0f7j
         VRAGKf01jLSlqigpVB3FckYPOQoKJnkRSA7hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/lM84oNLQ+30tWLWeZIn+ggWVAns9aJ5yoonWjl8po=;
        b=Sr7xay1+GX1eiGbV6p50Xn+7IX78wCOm700EQ7vmQlHAB3ZXsnMosVwaZoQF8Aozj/
         NFGyl5qRwMq0fdYdX14A/nkUfiKE1pQUiuWiSqMq/9oAyzo73SMGwXPs1I4KSLKgMQmG
         PjNsoZuLl6fkZMhOuIwnIXVWdWDwr6rE5j6Z971vYqke/KQXQpsujap/+vKRj67oUcAJ
         Qfemd3yooM4hUov18gB9PdIyzXt2nFnreknOCBRCNyhIRTAG4HDtDYVNfRYhXb07l4Uw
         s1cBLSE9UP3s8tIHclVs5mRFL4RxRGvy9hVwuDPK/XcH7I3nguEoWMAFZpczwksXQdqs
         D/Sg==
X-Gm-Message-State: AOAM532JCeCuGUBD6KO5Bo3Dnoc5RkZeK98PepLxTG9tfh69ycGUMuDV
        KC0rQfQ0YlrkQ1Rws41qm7+A8A==
X-Google-Smtp-Source: ABdhPJyqX5ZIRxrmt45GZkfCyLUzPSynI5vM/qfDbTmZbHrtUslwvoGvlS4ew4ROh1HVnI4+s/gPFw==
X-Received: by 2002:ac8:7159:: with SMTP id h25mr1661949qtp.63.1605655264721;
        Tue, 17 Nov 2020 15:21:04 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:21:04 -0800 (PST)
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
Subject: [PATCH -tip 27/32] sched/debug: Add CGroup node for printing group cookie if SCHED_DEBUG
Date:   Tue, 17 Nov 2020 18:19:57 -0500
Message-Id: <20201117232003.3580179-28-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used by kselftest to verify the CGroup cookie value that is
set by the CGroup interface.

Reviewed-by: Josh Don <joshdon@google.com>
Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8f17ec8e993e..f1d9762b571a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10277,6 +10277,21 @@ static u64 cpu_core_tag_color_read_u64(struct cgroup_subsys_state *css, struct c
 	return tg->core_tag_color;
 }
 
+#ifdef CONFIG_SCHED_DEBUG
+static u64 cpu_core_group_cookie_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	unsigned long group_cookie, color;
+
+	cpu_core_get_group_cookie_and_color(css_tg(css), &group_cookie, &color);
+
+	/*
+	 * Combine group_cookie and color into a single 64 bit value, for
+	 * display purposes only.
+	 */
+	return (group_cookie << 32) | (color & 0xffffffff);
+}
+#endif
+
 struct write_core_tag {
 	struct cgroup_subsys_state *css;
 	unsigned long cookie;
@@ -10550,6 +10565,14 @@ static struct cftype cpu_legacy_files[] = {
 		.read_u64 = cpu_core_tag_color_read_u64,
 		.write_u64 = cpu_core_tag_color_write_u64,
 	},
+#ifdef CONFIG_SCHED_DEBUG
+	/* Read the effective cookie (color+tag) of the group. */
+	{
+		.name = "core_group_cookie",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_group_cookie_read_u64,
+	},
+#endif
 #endif
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	{
@@ -10737,6 +10760,14 @@ static struct cftype cpu_files[] = {
 		.read_u64 = cpu_core_tag_color_read_u64,
 		.write_u64 = cpu_core_tag_color_write_u64,
 	},
+#ifdef CONFIG_SCHED_DEBUG
+	/* Read the effective cookie (color+tag) of the group. */
+	{
+		.name = "core_group_cookie",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.read_u64 = cpu_core_group_cookie_read_u64,
+	},
+#endif
 #endif
 #ifdef CONFIG_CFS_BANDWIDTH
 	{
-- 
2.29.2.299.gdc1121823c-goog

