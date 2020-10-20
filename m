Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FEA2932D4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 03:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390337AbgJTBox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 21:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390327AbgJTBov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 21:44:51 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A92C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:51 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l16so269384ilt.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 18:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYRuExtbSgWjM4FYX9nCK6I1/Pc07M5b5kD77e19zKs=;
        b=LlG484iMib0jL0GPGukjEQ3DL6YTJU0PjdixF56M1scF3k2e4TqSo8q2vUDde9AzJJ
         n5UFQdlYgHpxTJEi/Ndkg+6o/YOm0BFGp5p29Bz1HWAfbPKbtZo7hbxltapZ631elOVp
         3bc5M9ce38R7z3mW3fcDNW8mZxkdwxFM7+dOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYRuExtbSgWjM4FYX9nCK6I1/Pc07M5b5kD77e19zKs=;
        b=VFWSxzS3OgYMInZkjaF3aQY1aq4FcN9s4JWQx38/klrrsW56kD+hgfS4TQ/lKeMCT7
         xP89UVH1ANqYuZnqdOMTGM7mnP+fQaVVmlqitxXxVUjkbd6qDqbYRByM4rao6b3WmLmT
         MOOf6V40J4HlmcnAznqwkoW9z5kSYutATaKKcRFyYc+8tFkR1SaBDk6Oc6NkzSlbzcR9
         RplN+GGmNUq/tceVqU1e0tnP+DodM3bF7Pz5TS6JT6uIoUpGRMFy709cQJxey02G0OG7
         RjQxoM//WmmdumGRG8aizfmcXH6blPI7ktqLTJNMcgOpRyFL9NWCOdOLVJ78loKb70BI
         Z10g==
X-Gm-Message-State: AOAM531K8eWHavNyNnIkpOYYbATSaWYZDVL8SdrtAk2eSZXef2jSC65R
        n/txVl13UjZ1aYpFA3OXNXfpQw==
X-Google-Smtp-Source: ABdhPJwPa9seXOoLAWqrvdnPYhYYR1KaMUU/hhDyuFi/TXq+8CHYhwFpotLHJGi6fqVJOYhym7BH8g==
X-Received: by 2002:a92:bb57:: with SMTP id w84mr241736ili.41.1603158291116;
        Mon, 19 Oct 2020 18:44:51 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id t22sm485306ili.9.2020.10.19.18.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 18:44:50 -0700 (PDT)
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
Subject: [PATCH v8 -tip 22/26] sched/debug: Add CGroup node for printing group cookie if SCHED_DEBUG
Date:   Mon, 19 Oct 2020 21:43:32 -0400
Message-Id: <20201020014336.2076526-23-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
In-Reply-To: <20201020014336.2076526-1-joel@joelfernandes.org>
References: <20201020014336.2076526-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will be used by kselftest to verify the CGroup cookie value that is
set by the CGroup interface.

Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/sched/core.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1321c26a8385..b3afbba5abe1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9520,6 +9520,13 @@ static u64 cpu_core_tag_color_read_u64(struct cgroup_subsys_state *css, struct c
 	return tg->core_tag_color;
 }
 
+#ifdef CONFIG_SCHED_DEBUG
+static u64 cpu_core_group_cookie_read_u64(struct cgroup_subsys_state *css, struct cftype *cft)
+{
+	return cpu_core_get_group_cookie(css_tg(css));
+}
+#endif
+
 struct write_core_tag {
 	struct cgroup_subsys_state *css;
 	unsigned long cookie;
@@ -9695,6 +9702,14 @@ static struct cftype cpu_legacy_files[] = {
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
@@ -9882,6 +9897,14 @@ static struct cftype cpu_files[] = {
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
2.29.0.rc1.297.gfa9743e501-goog

