Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ADA2A9E95
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgKFUco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 15:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFUcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:32:43 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80077C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 12:32:43 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id e21so1829052pgr.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 12:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PkvXPr5zRt9c79wXe0lFh0HyRUZh0ALu/SSWSOopLw8=;
        b=tQ8gw4rhQ/+f7Nz4CZr/cHFXTIVQI/1xVvlm+geWQV8vn9+NVunE6e7B4GTxLnpXI3
         oNnjddkVVzaBGyZ8qmLOFucUZML2wRgpEgL/E3svpGXZxxwKoRrnh3DUI0U+OYYqHXmv
         2+1sox+YaZZWS6OMQ1KepWmVle7q/AgVODVNNuw8069XNls3sVAEqvCUW4XzRotTdpS5
         9disIfZ50fg1r5ovJBc+S8F/jalVg7m5FuRYCmZFASkhaWDi32uRo+ZYQeiUKJH/oXDA
         dpmKAi+mcD6DiJoM5YrYh4l8Bg1zFhgDNvjgx2zq6R3vUZZCm/QZbo4oTw2zhcu6SzaP
         WPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=PkvXPr5zRt9c79wXe0lFh0HyRUZh0ALu/SSWSOopLw8=;
        b=Yv+WbLmrvHT1PXrd7Mm0Xf1bTyadaBAWzcspL3xGuSX1LfCoocdcibAfq5Izru1rQC
         tAwH9rzUHEvEmWSWkizGhLh5BsIr3bXpVR6/R1ruwT/6qHoL18DsqXZUt7ptQhgquNyf
         hTw89PwixYoFYzFtED9l4sIy43uaVR6pFWqc/Zzjk8vuSFVddEk3L4YSgq8YWwe1Qu5a
         4/1ML002hYbk5yyU038c5bb+DVQnxTeaO9OyNzFKgkCHUbbXgzah8OfUtW+QQPl9EK5R
         kd/Xaum9irSJZ1rOsM36BcDesC8QkN3jCOZ/V4V6X5ATGctTXcJ+brGA1bI+G5arVA/c
         J7vQ==
X-Gm-Message-State: AOAM5315ix9NWF3x1wb4usbwOxp3bsw8DAqti75QIQRLS+eN6sWDoceF
        wSOSUbbq85k90XWNopqwTloItV1vBxc=
X-Google-Smtp-Source: ABdhPJwolHgUPm3z0zvjns3t/ctGcn7N/1qwo5ZoF1k4A2Q46/r2fi1fftA958FBqgwopJv40WWqBg==
X-Received: by 2002:a17:90a:fe07:: with SMTP id ck7mr1405212pjb.212.1604694762984;
        Fri, 06 Nov 2020 12:32:42 -0800 (PST)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id v126sm3150538pfb.137.2020.11.06.12.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 12:32:41 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>
Subject: [PATCH] mm: introduce oom_kill_disable sysctl knob
Date:   Fri,  6 Nov 2020 12:32:38 -0800
Message-Id: <20201106203238.1375577-1-minchan@kernel.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's hard to have some tests to be supposed to work under heavy
memory pressure(e.g., injecting some memory hogger) because
out-of-memory killer easily kicks out one of processes so system
is broken or system loses the memory pressure state since it has
plenty of free memory soon so.
Even though we could mark existing process's oom_adj to -1000,
it couldn't cover upcoming processes to be forked for the job.

This knob is handy to keep system memory pressure.

Signed-off-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/admin-guide/sysctl/vm.rst | 14 ++++++++++++++
 include/linux/mm.h                      |  2 ++
 include/linux/oom.h                     |  1 +
 kernel/sysctl.c                         |  9 +++++++++
 mm/oom_kill.c                           | 24 ++++++++++++++++++++++++
 5 files changed, 50 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/vm.rst b/Documentation/admin-guide/sysctl/vm.rst
index f455fa00c00f..49dcedfaf0c0 100644
--- a/Documentation/admin-guide/sysctl/vm.rst
+++ b/Documentation/admin-guide/sysctl/vm.rst
@@ -694,6 +694,20 @@ is used in oom_kill_allocating_task.
 
 The default value is 0.
 
+oom_kill_disable
+================
+
+This disables or enables OOM killing in out-of-memory situations.
+
+If this is set to one, the OOM killer is disabled so OOM kill never
+hapens in out-of-memory situation. It could cause system dangerous
+state due to memory allocation failure so user should be careful to
+use it.
+
+If this is set to zero, the OOM killer is enabled so OOM kill happens
+in out-of-memory situations.
+
+The default value is 0.
 
 overcommit_kbytes
 =================
diff --git a/include/linux/mm.h b/include/linux/mm.h
index db6ae4d3fb4e..a98400cee341 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -215,6 +215,8 @@ int overcommit_kbytes_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
 int overcommit_policy_handler(struct ctl_table *, int, void *, size_t *,
 		loff_t *);
+int oom_kill_disable_handler(struct ctl_table *, int, void *, size_t *,
+		loff_t *);
 
 #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
 
diff --git a/include/linux/oom.h b/include/linux/oom.h
index 2db9a1432511..0f378498e6aa 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -126,5 +126,6 @@ extern struct task_struct *find_lock_task_mm(struct task_struct *p);
 /* sysctls */
 extern int sysctl_oom_dump_tasks;
 extern int sysctl_oom_kill_allocating_task;
+extern int sysctl_oom_kill_disable;
 extern int sysctl_panic_on_oom;
 #endif /* _INCLUDE_LINUX_OOM_H */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index afad085960b8..1fe872fe1c05 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2690,6 +2690,15 @@ static struct ctl_table vm_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec,
 	},
+	{
+		.procname	= "oom_kill_disable",
+		.data		= &sysctl_oom_kill_disable,
+		.maxlen		= sizeof(sysctl_oom_kill_disable),
+		.mode		= 0644,
+		.proc_handler	= oom_kill_disable_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
 	{
 		.procname	= "oom_dump_tasks",
 		.data		= &sysctl_oom_dump_tasks,
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 8b84661a6410..0f48cdeeb1e7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -53,6 +53,7 @@
 
 int sysctl_panic_on_oom;
 int sysctl_oom_kill_allocating_task;
+int sysctl_oom_kill_disable;
 int sysctl_oom_dump_tasks = 1;
 
 /*
@@ -72,6 +73,29 @@ static inline bool is_memcg_oom(struct oom_control *oc)
 	return oc->memcg != NULL;
 }
 
+int oom_kill_disable_handler(struct ctl_table *table, int write, void *buffer,
+		size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	if (ret || !write)
+		goto out;
+	if (sysctl_oom_kill_disable == 1) {
+		if (!oom_killer_disable(HZ))
+			ret = -EBUSY;
+	} else {
+		if (mutex_lock_killable(&oom_lock)) {
+			ret = -EBUSY;
+			goto out;
+		}
+		oom_killer_enable();
+		mutex_unlock(&oom_lock);
+	}
+out:
+	return ret;
+}
+
 #ifdef CONFIG_NUMA
 /**
  * oom_cpuset_eligible() - check task eligiblity for kill
-- 
2.29.1.341.ge80a0c044ae-goog

