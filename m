Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 913C72B7234
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729370AbgKQXVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729298AbgKQXVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:21:00 -0500
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9F6C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:59 -0800 (PST)
Received: by mail-qv1-xf42.google.com with SMTP id a15so112285qvk.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zsg/Rw+wrYsoDFaZInX6fSxORaOZfj8CZRxJsVGQSP4=;
        b=oaSwh4nIwwA2UVHUGu2eZjauju9imBrloKojQo7XGehrh+ybz7daWaGJchoN+isJkU
         Q4F7so6TFKVGAhd4C5fVoFriaR+8lnTpsnhKTFCSRqF7AXJw/dNAx0tszWOj/wTHzCp0
         wifwgCa5qrIX0shZ2Bxsn/FYWJ24BpSMevdMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zsg/Rw+wrYsoDFaZInX6fSxORaOZfj8CZRxJsVGQSP4=;
        b=MKKCa4tuf4SGLyZPS2nDTXKgP5azbVJfyBv6Ssd3cQgba5j1CT+xCGOomZ8ws8jRxb
         +VJLKUziDbu88W1UWUXVxxQ4okhV1yaCrMwoQY/c2zs2ylmaD4T4ujKvI5zH4nnrbbmI
         YyFIFec8fr7uFnYKTG2wzJfUvKIITHDN48ZOjz/Gf0L5CIBRAc17hpWK3S65hrCaXdhU
         bo7XwvNIZvIqDFea1Em2CCFo7Kogip4NNDmG8YTbONqxZ+dFl2O+1+SpSt7PfR4pa3ji
         xr5sr6Xd56fKYiHKrq4UL0y4A1BLdBccxaQqFaD9u8ZjT1lWzw6uvdEYGYjQWWEzg61U
         9iCw==
X-Gm-Message-State: AOAM530hMU+YLZyeTLnQBVEmiH06ZvOgGLoEf4e9RNGpcNWe+hMu2EcI
        zvWDA69OS0xlBcOHrd+CJXfs8Q==
X-Google-Smtp-Source: ABdhPJwMbCmxJTEmn8HPwKAAAT9V2Hj7/NCRN9eslNJlmgmngzY7r29O7AJuNOLhA9MtRzWt0L+giQ==
X-Received: by 2002:a0c:e443:: with SMTP id d3mr2262541qvm.18.1605655259014;
        Tue, 17 Nov 2020 15:20:59 -0800 (PST)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:411:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d12sm14555544qtp.77.2020.11.17.15.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 15:20:58 -0800 (PST)
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
Subject: [PATCH -tip 24/32] sched: Release references to the per-task cookie on exit
Date:   Tue, 17 Nov 2020 18:19:54 -0500
Message-Id: <20201117232003.3580179-25-joel@joelfernandes.org>
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
In-Reply-To: <20201117232003.3580179-1-joel@joelfernandes.org>
References: <20201117232003.3580179-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During exit, we have to free the references to a cookie that might be shared by
many tasks. This commit therefore ensures when the task_struct is released, any
references to cookies that it holds are also released.

Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
Tested-by: Julien Desfossez <jdesfossez@digitalocean.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 include/linux/sched.h | 3 +++
 kernel/fork.c         | 1 +
 kernel/sched/core.c   | 8 ++++++++
 3 files changed, 12 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 79d76c78cc8e..6fbdb1a204bf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2084,11 +2084,14 @@ void sched_core_unsafe_exit(void);
 bool sched_core_wait_till_safe(unsigned long ti_check);
 bool sched_core_kernel_protected(void);
 int sched_core_share_pid(pid_t pid);
+void sched_tsk_free(struct task_struct *tsk);
 #else
 #define sched_core_unsafe_enter(ignore) do { } while (0)
 #define sched_core_unsafe_exit(ignore) do { } while (0)
 #define sched_core_wait_till_safe(ignore) do { } while (0)
 #define sched_core_kernel_protected(ignore) do { } while (0)
+#define sched_core_share_pid(pid) do { } while (0)
+#define sched_tsk_free(tsk) do { } while (0)
 #endif
 
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 7199d359690c..5468c93829c5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -736,6 +736,7 @@ void __put_task_struct(struct task_struct *tsk)
 	exit_creds(tsk);
 	delayacct_tsk_free(tsk);
 	put_signal_struct(tsk->signal);
+	sched_tsk_free(tsk);
 
 	if (!profile_handoff_task(tsk))
 		free_task(tsk);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a95898c75bdf..cc36c384364e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10066,6 +10066,14 @@ static int cpu_core_tag_write_u64(struct cgroup_subsys_state *css, struct cftype
 
 	return 0;
 }
+
+void sched_tsk_free(struct task_struct *tsk)
+{
+	if (!tsk->core_task_cookie)
+		return;
+	sched_core_put_task_cookie(tsk->core_task_cookie);
+	sched_core_put();
+}
 #endif
 
 static struct cftype cpu_legacy_files[] = {
-- 
2.29.2.299.gdc1121823c-goog

