Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D87F298715
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 07:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770755AbgJZGwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 02:52:31 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:39233
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730060AbgJZGwa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 02:52:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cyRpHF4SNsr30Wk0U9sKNV/Lmsj2f7vnYFGslO+L8cFI4giXDccfF9X5akrWZJDjgL7QlT9hma/QrXlENJ3DOs0U0LluPU8b68Pv/rKEI75RAYzFvvS6UfXNZDR1pRd3PXuG9VgDVnz2A0PxSO/1JPtqNpok7kAg8xBUll9kT1x7hX5K1w/W4FxhV/JMGVuJNzngb78ARecEj8gD5SOujfQSnfOunGz4e/ycpl2GMUAT7aZu3ThAFu/idyKAyBqc/5yspuHq4VPLJQ49hyw1qOdOHqzJgLUWATs+rBpVB3y6fFSUxlbyqd1v0Lwsmv/gtmHdlbjU+DiVwsM9CYfvEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6OKJR78MpeHPoEZqD2Rpv7fTApNExHGabUySEtgIdg=;
 b=grvbq3Va41qS2O1hHBnvQ+K9q02pI+fV41aYbwNWuTwgRwh58SNWn3jEHmZmqgYliV9VoCxKvAMb9qNQAUJZYpp1gxfwt709qPxN0u+lOZSA10ReaPut9Hl6QDiqnXefrew0CTyjiwovbCAKwFyCXlAEno+z6Xeg34PnB62X4clOJLCY1Nd1Y2iSxCvj3SxaR0El4gmqq1hUp6WnN9sQfJph+i8o4Tac2X4FICRNbNmp0zhzihlfOLIaNbEXuIcLBC6tvaW+9oBugev9EQMn6RNy1D8s5eE6WI/1p59ealuMqNMajywQiEWKGphgwQQtdo0JAmFUjnrYMovFH/RHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6OKJR78MpeHPoEZqD2Rpv7fTApNExHGabUySEtgIdg=;
 b=bxnZl2RAyCd3JoawIgP9zDf1g8IY/SGODpdZrK6NPdZmba1gnRXgCYwRy5YImuRA9SJh6oK/vBpDXlrP3f2IC+6TxSrcqMaWPhOl8SCPzuY/HytR8/qM6HlcHB3xpwgwOZrxnYNwdsTnt3F1FIga5iqUkEiO9oMwQlJJnsMe+P0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BYAPR11MB2806.namprd11.prod.outlook.com (2603:10b6:a02:c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Mon, 26 Oct
 2020 06:52:26 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::80e9:e002:eeff:4d05%3]) with mapi id 15.20.3455.030; Mon, 26 Oct 2020
 06:52:26 +0000
From:   qiang.zhang@windriver.com
To:     tj@kernel.org, pmladek@suse.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH] kthread_worker: re-set CPU affinities if CPU come online
Date:   Mon, 26 Oct 2020 14:52:13 +0800
Message-Id: <20201026065213.30477-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HK2PR03CA0044.apcprd03.prod.outlook.com
 (2603:1096:202:17::14) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-qzhang2-d1.wrs.com (60.247.85.82) by HK2PR03CA0044.apcprd03.prod.outlook.com (2603:1096:202:17::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.4 via Frontend Transport; Mon, 26 Oct 2020 06:52:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0e9973d0-138e-4a12-c427-08d8797bb2dc
X-MS-TrafficTypeDiagnostic: BYAPR11MB2806:
X-Microsoft-Antispam-PRVS: <BYAPR11MB28061755F8486E7434068B86FF190@BYAPR11MB2806.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:178;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IyTPjbjGWgZadGhmPtXvrPYuzna1JSYJIYR77zlCMotkwl+KTiiLZxrNlIP8hKOprX+OEZBzSy0GPZj4UaPb5agYAvmTmqtrphdYw9PuZeZowuc2sJQzw47NY1bycjrgUVvPHMm3PO/RhvqiSy+CdZXPAJGiHD4qbHXSWB4Q9jgr7fvNjaWg4bVV72cTF976zzP3l6r7DSg6NGcOX/YMQRsU8Ypt2zP/gPNUlW+S6mwOf2shUAr8P8mdEzh5b+GnZQBYhqhXXWMyxsHGW9/iFaDWw/kD1bkLNj7el4GbN9IfTUjPjjlc9XXpqXDHgNgx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39840400004)(366004)(136003)(396003)(6486002)(2616005)(316002)(6512007)(83380400001)(956004)(9686003)(2906002)(66476007)(1076003)(66946007)(66556008)(8936002)(5660300002)(6666004)(8676002)(86362001)(26005)(478600001)(16526019)(6506007)(52116002)(186003)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: OZW1faJaAIbNVAls4P23XGCiLedlswFuHEUXLur/VkE9kJiyuZWWTxEUeBHMzHMBdHQv0pdZgFjPLvoXXTdXDkfmUMD5zOoFA0ksOOao2mN16nSwi4x1eCpf3srMut06VDahujMXHecdfk/0n9WXLH2EE6DYLbhEUVfZxJ1roovFokfcyqZba8uZFQrQwnAM/JweBd5e0E4Wm46eX+K5OhRuaWl03FwO73UuIoKLLAJaRX3Ghn0gmIcAoNwgrN/iJS8xE9IURKgRX8hdGZmrTRt2V8elwsLE51npcB9/lKCWUXDfhwutLd02adAQtez1sKBpg8pcjt23M579JOzgtsSuOElObG9goa9WII4sNQCZGmB8VvQ05DMO8J6QNuIn6gUGscLz57X0cRsxytGxX0d1iuZGZ/sLGxVay6de47tu5CMQmulg/nsys+fIpQd4ccGu6sYiS/zEd/FauQ3JYoUvJRuIfcN0BBhhOw4U0EIBPz2iWkzlJZLsKdQIDnMsABMsiqZGMs10w2cq2SVsvfo+arTuIi5ajDCkbe33qaRddG+QrxHMGuvRUE9UB8973aMalq/o1fKo3CP87LVbOb+rlljHU1rKkMtuZwmGJjz5v2kxN0SYIoLUfKAAhA7qxHuRRH4vkdNsS2pAakYfxg==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9973d0-138e-4a12-c427-08d8797bb2dc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 06:52:26.5114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WGrY0y5vSFH9v5GR7wTBlS+nPrUGOUetIjEErG20I/hy2I3tnEVV9KdhE5A5Qsd5CyRyRl61rWwwgfkYppTN/2M8+Wo02Tbo1uoJBspvYfU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2806
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

When someone CPU offlined, the 'kthread_worker' which bind this CPU,
will run anywhere, if this CPU online, recovery of 'kthread_worker'
affinity by cpuhp notifiers.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 include/linux/kthread.h |  2 ++
 kernel/kthread.c        | 35 ++++++++++++++++++++++++++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 65b81e0c494d..5acbf2e731cb 100644
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
diff --git a/kernel/kthread.c b/kernel/kthread.c
index e29773c82b70..68968832777f 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -28,8 +28,10 @@
 #include <linux/uaccess.h>
 #include <linux/numa.h>
 #include <linux/sched/isolation.h>
+#include <linux/cpu.h>
 #include <trace/events/sched.h>
 
+static enum cpuhp_state kworker_online;
 
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
 
@@ -737,8 +741,11 @@ __kthread_create_worker(int cpu, unsigned int flags,
 	if (IS_ERR(task))
 		goto fail_task;
 
-	if (cpu >= 0)
+	if (cpu >= 0) {
 		kthread_bind(task, cpu);
+		worker->bind_cpu = cpu;
+		cpuhp_state_add_instance_nocalls(kworker_online, &worker->cpuhp_node);
+	}
 
 	worker->flags = flags;
 	worker->task = task;
@@ -1220,6 +1227,9 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 	if (WARN_ON(!task))
 		return;
 
+	if (worker->bind_cpu >= 0)
+		cpuhp_state_remove_instance_nocalls(kworker_online, &worker->cpuhp_node);
+
 	kthread_flush_worker(worker);
 	kthread_stop(task);
 	WARN_ON(!list_empty(&worker->work_list));
@@ -1227,6 +1237,29 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
 
+static int kworker_cpu_online(unsigned int cpu, struct hlist_node *node)
+{
+	struct kthread_worker *worker = hlist_entry(node, struct kthread_worker, cpuhp_node);
+	struct task_struct *task = worker->task;
+
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
+					kworker_cpu_online, NULL);
+	if (ret < 0)
+		return ret;
+	kworker_online = ret;
+	return 0;
+}
+subsys_initcall(kthread_worker_hotplug_init);
+
 /**
  * kthread_use_mm - make the calling kthread operate on an address space
  * @mm: address space to operate on
-- 
2.17.1

