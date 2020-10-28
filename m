Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFF9629E090
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 02:23:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbgJ2BXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 21:23:01 -0400
Received: from mail-eopbgr770057.outbound.protection.outlook.com ([40.107.77.57]:4517
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729911AbgJ1WEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:04:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrlABDs0RuQhE5y4C0/JNA6M3CQVjsXllvwwmowLWJLnkggs56qovAURjMD0XUpgP206Tia4eOj7C/MJh/CZgePRlqhuJB8hLzKuyxD5UpZ1A5QyHTFe9NlutfSel10XW0yoGvb4gIP4Y6MM2NkAs89XPECP6/OPqX6edsDBw7ez41grjpRjN12LyCkib4ndZ7hGti6Fi4j4dZNzazWcd2BrAFAsowyMfeRMXRoLnkxkmez4Rrmq+AqKFATeVBNVSpfe9GHpLjCT4vGIaKJY7OO644eCHN9lRXH5k7W1u9vvx6G6JJvGzorzp+qor/CkHMhcxSV+OJFvrCZleAGD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui/hQDbnnIGc+qTYw63R31iBydW6qKgAZGZgrrNG5VM=;
 b=BhRzU8iaOA4ZoRR5KUZD+aH2YvJ9W9WpfSO19Wjx9UVqcIWfF3sUQlKWqoYj/VIWOs17vCOO48AtMsTJjPVqT3nREymG2xirN84oi+pKpOSSoPwOZ12r7KXgAJicdU1bIbap/QdJOwseoZZzE0d/SYx+jpl2WcY9bo46O6qH0kQZ3IUuTc5mKw3Xiav1Y/oqUHC4mX8fs/IomLjLzpWDOo0jDmvQVBqd9HjHiqGpA1ejSkEKK9oq6neZY8vVeIgvVQv9zQEeQSnrYaL4uTltsETuhGeTnmAe343J3HIQUn2e3HQN+ZIlpiF6x1O8x+lqPsgzAfsiYRl45wHlwpc6Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ui/hQDbnnIGc+qTYw63R31iBydW6qKgAZGZgrrNG5VM=;
 b=P2rPDCcspp6MMfiHLR0B8doeZbxE8gLtFuSU9s4Ix0laMhXXExD+JAuyGCwSDoF+wCspRGDw6NalSflvoyJhVBQHqYPb7BkosLbadPshE1n1EScfmN2/na9BSxi08/zd85qTCLIpLOve0cLGBRLmQts6ef4CBjcL4mcnsupxM1k=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB3352.namprd11.prod.outlook.com (2603:10b6:a03:1d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Wed, 28 Oct
 2020 07:30:43 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.037; Wed, 28 Oct 2020
 07:30:42 +0000
From:   qiang.zhang@windriver.com
To:     pmladek@suse.com, tj@kernel.org
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kthread_worker: re-set CPU affinities if CPU come online
Date:   Wed, 28 Oct 2020 15:30:31 +0800
Message-Id: <20201028073031.4536-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BY5PR20CA0020.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::33) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by BY5PR20CA0020.namprd20.prod.outlook.com (2603:10b6:a03:1f4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend Transport; Wed, 28 Oct 2020 07:30:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10b00318-b6cf-4d4a-a03d-08d87b135fe5
X-MS-TrafficTypeDiagnostic: BYAPR11MB3352:
X-Microsoft-Antispam-PRVS: <BYAPR11MB335277C59075C8279ADD25A6FF170@BYAPR11MB3352.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:751;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: amuaVcqakWUaldVvVtXwVJRycrTnKMU6GScL5Ou7JnQSYzjCbXU8SlHnf/LdiG8tXuprWvo1XY2EZbzJJD6If1MKp8S9/VzLehGaLtuiGuLGiQqA9ZbjGvGKB4w8+2Vs3I3z1xHTJ5Rio3rnXm89XI3+ub/XmZTAW2YQ2dOjfZ3PTA17MEUuB+zftuiST+M4SgEp+Q8NLq3EXMNaXg5iSXap8bGUn1zzB8Ag1Ztf2spiIc+CuKQWhsmipgTaSVpZPkJGl9aUBIhnWoUJkTzu8gPk/WXHRazyuSMzW0enTvMKCg9HvDmTHR76hsT/Ymkh
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(366004)(376002)(346002)(136003)(396003)(52116002)(4326008)(36756003)(86362001)(16526019)(8676002)(956004)(66556008)(66476007)(186003)(2616005)(2906002)(66946007)(9686003)(6512007)(478600001)(26005)(6486002)(83380400001)(6506007)(1076003)(6666004)(5660300002)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lgnPW0Yj6r668kCQFL7g63ugzBE5cLsX8EoNvzGk7fR+Y4S44MR2ephSVunS/95L4HkNIuTBmDVB5aUh2GKHoGm2aijwPw4yfuDdM1hCFWaEOKUmmk+o6i6kpaKA6OcHgvMuWTjK+9ycet6sz487OejVVhD7Jxat6FJrfXz0rEnHe2JkyORaMFWDORaPQlrUfBC7msNcBY8qaud/vSOjRETl8iKXXtUMIVN8/V/8T6XYY/gOaFyw+Yaf9jcEasW8u327Ae9Y7ZCfpZq6HRbwIDKDUufiNM3oZeWKJupV2ySh0xpw4yLXJC8ew3XxgRA9iJX7PW0T0cXseq53ooDL55i2nOqd4h0vG3nMXzMLe356D8yQStWYHgUOWgNQ/baCSwc/muPKRg6CG0EdQ52aoEUfmhgXdekW/1X5lVFxZsOEeOmu17DTEj3VPjT1lwKJlijMCtX1jhTCAi1ixt7oJVKlw+VLUnt+Kc1zgmBk/xivQybh6J/ruaja+wqa3UMEtLhxnTFKteMy79T+DHfsxu7Z+5DuEij2nKE+gYvaCEvg5rtn521ZXrgbKNbiqjaYH9ota+IwXBcqOQrhpG2IPgiROmaTR60E3BGbKW4JZfklPh+N5vkq9guCjlt9LpZ3l4DvAzHuThljW+8Vs1T4UQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b00318-b6cf-4d4a-a03d-08d87b135fe5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2020 07:30:42.2930
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BzJEB6YpHiTeTKLcwi0DmJaoj+wFCX2LAG//gkzB2h8XmPhJdRoxpL7Fxr8ujSArPXGpZRyENyuYFk9TwA22FEerIK92JuZXvkB6Gl31h0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3352
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

When someone CPU offlined, the 'kthread_worker' which bind this CPU,
will run anywhere, if this CPU online, recovery of 'kthread_worker'
affinity by cpuhp notifiers.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 rename variable kworker_online to kthread_worker_online.
 add 'cpuhp_node' and 'bind_cpu' init in KTHREAD_WORKER_INIT.
 add a comment explaining for WARN_ON_ONCE.

 include/linux/kthread.h |  4 ++++
 kernel/kthread.c        | 36 +++++++++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 65b81e0c494d..c28963e87b18 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -93,6 +93,8 @@ struct kthread_worker {
 	struct list_head	delayed_work_list;
 	struct task_struct	*task;
 	struct kthread_work	*current_work;
+	struct hlist_node       cpuhp_node;
+	int                     bind_cpu;
 };
 
 struct kthread_work {
@@ -112,6 +114,8 @@ struct kthread_delayed_work {
 	.lock = __RAW_SPIN_LOCK_UNLOCKED((worker).lock),		\
 	.work_list = LIST_HEAD_INIT((worker).work_list),		\
 	.delayed_work_list = LIST_HEAD_INIT((worker).delayed_work_list),\
+	.cpuhp_node = {.next = NULL, .pprev = NULL},			\
+	.bind_cpu = -1,							\
 	}
 
 #define KTHREAD_WORK_INIT(work, fn)	{				\
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 34516b0a6eb7..6c66df585225 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -28,8 +28,10 @@
 #include <linux/uaccess.h>
 #include <linux/numa.h>
 #include <linux/sched/isolation.h>
+#include <linux/cpu.h>
 #include <trace/events/sched.h>
 
+static enum cpuhp_state kthread_worker_online;
 
 static DEFINE_SPINLOCK(kthread_create_lock);
 static LIST_HEAD(kthread_create_list);
@@ -649,6 +651,8 @@ void __kthread_init_worker(struct kthread_worker *worker,
 	lockdep_set_class_and_name(&worker->lock, key, name);
 	INIT_LIST_HEAD(&worker->work_list);
 	INIT_LIST_HEAD(&worker->delayed_work_list);
+	worker->bind_cpu = -1;
+	INIT_HLIST_NODE(&worker->cpuhp_node);
 }
 EXPORT_SYMBOL_GPL(__kthread_init_worker);
 
@@ -744,8 +748,11 @@ __kthread_create_worker(int cpu, unsigned int flags,
 	if (IS_ERR(task))
 		goto fail_task;
 
-	if (cpu >= 0)
+	if (cpu >= 0) {
+		cpuhp_state_add_instance_nocalls(kthread_worker_online, &worker->cpuhp_node);
 		kthread_bind(task, cpu);
+		worker->bind_cpu = cpu;
+	}
 
 	worker->flags = flags;
 	worker->task = task;
@@ -1230,6 +1237,9 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 	if (WARN_ON(!task))
 		return;
 
+	if (worker->bind_cpu >= 0)
+		cpuhp_state_remove_instance_nocalls(kthread_worker_online, &worker->cpuhp_node);
+
 	kthread_flush_worker(worker);
 	kthread_stop(task);
 	WARN_ON(!list_empty(&worker->work_list));
@@ -1237,6 +1247,30 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
 
+static int kthread_worker_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct kthread_worker *worker = hlist_entry(node, struct kthread_worker, cpuhp_node);
+	struct task_struct *task = worker->task;
+
+	/* as we're called from CPU_ONLINE, the following shouldn't fail */
+	if (cpu == worker->bind_cpu)
+		WARN_ON_ONCE(set_cpus_allowed_ptr(task, cpumask_of(cpu)) < 0);
+	return 0;
+}
+
+static __init int kthread_worker_hotplug_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN, "kthread-worker/online",
+					kthread_worker_cpu_online, NULL);
+	if (ret < 0)
+		return ret;
+	kthread_worker_online = ret;
+	return 0;
+}
+core_initcall(kthread_worker_hotplug_init);
+
 /**
  * kthread_use_mm - make the calling kthread operate on an address space
  * @mm: address space to operate on
-- 
2.17.1

