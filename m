Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9A226B253
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 00:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgIOWpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 18:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727482AbgIOPx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 11:53:59 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C39EC061353
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:53:58 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id l126so2185295pfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU2nEMhjCVWVrMXPlsQXavcJV9QfPkKaCh123WirJUY=;
        b=fZ2zBCziQ3BDs46gAsEfUI7yxJtBST2rD1IAijko7XSzcOwptW4Ut8cyp/pKulyFN5
         Ya4+QRLBdUkedXev1V3EdJCBcWw7K2d1vm39dZMITMuBww53C+M6rM4NEoxRfDq+96Yq
         2hILdPF14cQEnz3v9ybLMFkS5pimkLRnuRTMrfCq5Hqy0KBcOcUjxpRFWbPMDZMUJqMZ
         JPJbtE/cVWhEHuZd7qbloKU9e+hR+nATFMV8pU+Rx6w1VBa40PqCN6W+dSAz4PQVeQeJ
         kt8jlvKwp4uuM6KWcCHU8nbzruP+ox0zWXUzIfgBxlatJaEpX6d7VdrCYvQraoKKotZH
         aM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kU2nEMhjCVWVrMXPlsQXavcJV9QfPkKaCh123WirJUY=;
        b=fWQij+Wdj++QSWOyrUQxGVVpUeXYZZtfFvxnDqUm2q+tizc7h7wFnJjDfZeVdDvEtz
         ruEBxtrIuOX4V2h6LQncQQ5MiH1YE76f1/V6ZaMf14xHnOyemrol8ztRnDY7LvZxycs3
         eOGdx7eRqjPea8z+6XBCj05QsyD22CPRZXhKpr43Nwd7nrjiUxSh5+8+S/nIFzzR46dX
         9v0KCHPsjnF+2+HXSuc/JTap/uCUvKiMXxsWe7AWlihB2yMoY9gQDwaO0Vibtwyk3qAt
         htvfuWaHmDbc+mdbGCTCbSkzfZu90MVkixgAEcJiem0/HQMlJaE1WBTSRnVRPklNdaOk
         CSWw==
X-Gm-Message-State: AOAM5320B69kKjLhU8mYQVG6fxsFLpkVG2KtVJi6ztGgcazPTvCk+oxa
        DZEXcRxGWuxg0WNxdu2x4aKlKQ==
X-Google-Smtp-Source: ABdhPJwi4fkNDvtVlto8KWYR1aJj5ID6DauHtUvOTVllokb0/rs8ghVhOYd/5I+QLqtz7r8sPEBupg==
X-Received: by 2002:a62:1bc7:0:b029:13e:d13d:a0f6 with SMTP id b190-20020a621bc70000b029013ed13da0f6mr18184752pfb.18.1600185237926;
        Tue, 15 Sep 2020 08:53:57 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.70])
        by smtp.gmail.com with ESMTPSA id b20sm14808636pfb.198.2020.09.15.08.53.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 08:53:57 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, lizefan@huawei.com, hannes@cmpxchg.org,
        corbet@lwn.net, cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhouchengming@bytedance.com, luodaowen.backend@bytedance.com,
        songmuchun@bytedance.com
Subject: [PATCH] cgroup: Add cgroupstats numbers to cgroup.stat file
Date:   Tue, 15 Sep 2020 23:53:49 +0800
Message-Id: <20200915155349.15181-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cgroup v1, we can use netlink interface to get cgroupstats for
a cgroup. But it has been excluded from cgroup v2 interface intentionally
due to the duplication and inconsistencies with other statistics.
To make container monitor tool like "cadvisor" continue to work, we add
these cgroupstats numbers to the cgroup.stat file, and change the
admin-guide doc accordingly.

Reported-by: Daowen Luo <luodaowen.backend@bytedance.com>
Tested-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 Documentation/admin-guide/cgroup-v2.rst | 15 ++++++++++++++
 kernel/cgroup/cgroup.c                  | 36 +++++++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 6be43781ec7f..9f781edca95a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -925,6 +925,21 @@ All cgroup core files are prefixed with "cgroup."
 		A dying cgroup can consume system resources not exceeding
 		limits, which were active at the moment of cgroup deletion.
 
+          nr_running
+                Number of tasks running.
+
+          nr_sleeping
+                Number of tasks sleeping.
+
+          nr_uninterruptible
+                Number of tasks in uninterruptible state.
+
+          nr_stopped
+                Number of tasks in stopped state.
+
+          nr_io_wait
+                Number of tasks waiting on IO.
+
   cgroup.freeze
 	A read-write single value file which exists on non-root cgroups.
 	Allowed values are "0" and "1". The default is "0".
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 0e23ae3b1e56..c6ccacaf812d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -42,6 +42,7 @@
 #include <linux/rcupdate.h>
 #include <linux/sched.h>
 #include <linux/sched/task.h>
+#include <linux/delayacct.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/percpu-rwsem.h>
@@ -3499,11 +3500,46 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
 static int cgroup_stat_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgroup = seq_css(seq)->cgroup;
+	struct css_task_iter it;
+	struct task_struct *tsk;
+	u64 nr_running = 0;
+	u64 nr_sleeping = 0;
+	u64 nr_uninterruptible = 0;
+	u64 nr_stopped = 0;
+	u64 nr_io_wait = 0;
+
+	css_task_iter_start(&cgroup->self, 0, &it);
+	while ((tsk = css_task_iter_next(&it))) {
+		switch (tsk->state) {
+		case TASK_RUNNING:
+			nr_running++;
+			break;
+		case TASK_INTERRUPTIBLE:
+			nr_sleeping++;
+			break;
+		case TASK_UNINTERRUPTIBLE:
+			nr_uninterruptible++;
+			break;
+		case TASK_STOPPED:
+			nr_stopped++;
+			break;
+		default:
+			if (delayacct_is_task_waiting_on_io(tsk))
+				nr_io_wait++;
+			break;
+		}
+	}
+	css_task_iter_end(&it);
 
 	seq_printf(seq, "nr_descendants %d\n",
 		   cgroup->nr_descendants);
 	seq_printf(seq, "nr_dying_descendants %d\n",
 		   cgroup->nr_dying_descendants);
+	seq_printf(seq, "nr_running %llu\n", nr_running);
+	seq_printf(seq, "nr_sleeping %llu\n", nr_sleeping);
+	seq_printf(seq, "nr_uninterruptible %llu\n", nr_uninterruptible);
+	seq_printf(seq, "nr_stopped %llu\n", nr_stopped);
+	seq_printf(seq, "nr_io_wait %llu\n", nr_io_wait);
 
 	return 0;
 }
-- 
2.11.0

