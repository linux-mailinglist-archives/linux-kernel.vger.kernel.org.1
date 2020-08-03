Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2FE23A9D6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Aug 2020 17:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHCPqb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 3 Aug 2020 11:46:31 -0400
Received: from smtp.h3c.com ([60.191.123.50]:59210 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgHCPqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:46:31 -0400
X-Greylist: delayed 1682 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Aug 2020 11:46:30 EDT
Received: from h3cspam02-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam02-ex.h3c.com with ESMTP id 073FIPg7047534
        for <linux-kernel@vger.kernel.org>; Mon, 3 Aug 2020 23:18:25 +0800 (GMT-8)
        (envelope-from ning.le@h3c.com)
Received: from DAG2EX02-BASE.srv.huawei-3com.com ([10.8.0.65])
        by h3cspam02-ex.h3c.com with ESMTPS id 073FI97Q046708
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 3 Aug 2020 23:18:09 +0800 (GMT-8)
        (envelope-from ning.le@h3c.com)
Received: from localhost.localdomain (10.114.40.30) by
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 3 Aug 2020 23:18:12 +0800
From:   "ning.le" <ning.le@h3c.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>
CC:     <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>,
        <linux-kernel@vger.kernel.org>, <he.feng@h3c.com>,
        "ning.le" <ning.le@h3c.com>
Subject: [PATCH] sched/cpuacct:Fix previous bugs submitted in history.
Date:   Mon, 3 Aug 2020 15:14:06 +0000
Message-ID: <20200803151406.59465-1-ning.le@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.114.40.30]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX02-BASE.srv.huawei-3com.com (10.8.0.65)
Content-Transfer-Encoding: 8BIT
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 073FI97Q046708
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Historical submission introduces new issues that When the current cpu
wakes up the thread which works on other cores,the cpuacct module may
add the execution time of thread which on the the other core's rq to
the current core's cpuusage.

Signed-off-by: ning.le <ning.le@h3c.com>
---
 kernel/sched/cpuacct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 941c28cf9738..bd38c9cffdd6 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -341,6 +341,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
        struct cpuacct *ca;
        int index = CPUACCT_STAT_SYSTEM;
        struct pt_regs *regs = get_irq_regs() ? : task_pt_regs(tsk);
+ int cpu = task_cpu(tsk);

        if (regs && user_mode(regs))
                index = CPUACCT_STAT_USER;
@@ -348,8 +349,7 @@ void cpuacct_charge(struct task_struct *tsk, u64 cputime)
        rcu_read_lock();

        for (ca = task_ca(tsk); ca; ca = parent_ca(ca))
-               __this_cpu_add(ca->cpuusage->usages[index], cputime);
-
+   per_cpu_ptr(ca->cpuusage, cpu)->usages[index] += cputime;
        rcu_read_unlock();
 }

--
2.17.1

-------------------------------------------------------------------------------------------------------------------------------------
���ʼ����丽�������»������ŵı�����Ϣ�������ڷ��͸������ַ���г�
�ĸ��˻�Ⱥ�顣��ֹ�κ����������κ���ʽʹ�ã�������������ȫ���򲿷ֵ�й¶�����ơ�
��ɢ�������ʼ��е���Ϣ������������˱��ʼ������������绰���ʼ�֪ͨ�����˲�ɾ����
�ʼ���
This e-mail and its attachments contain confidential information from New H3C, which is
intended only for the person or entity whose address is listed above. Any use of the
information contained herein in any way (including, but not limited to, total or partial
disclosure, reproduction, or dissemination) by persons other than the intended
recipient(s) is prohibited. If you receive this e-mail in error, please notify the sender
by phone or email immediately and delete it!
