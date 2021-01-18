Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53F362F9D45
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389662AbhARK4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:56:00 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:55974 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390204AbhARKee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:34:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10IAUCCA138808;
        Mon, 18 Jan 2021 10:32:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2020-01-29; bh=tZYlJDnn2QmRl5Yfk9elZnJhEapTsWClfoJ1BV6RUvA=;
 b=ygFl2F9Zhj+/tPjR1ridU/FK+FxCQv6RMge1N7ssqmQWZ78nMUoMDwhZvToUJA8eAWZR
 QRO4ptitScyizXwhW5Q2bRYfLNz0P8UxGdOwJCzBPcx7NT57f5bHfeuzGc187WNJzjT+
 KDz1mwj2t/2bqmtsThfm3vm55anZOhAaOogwmiB6isczTiKDDL/AhVKpjuYbde6lAMuz
 e3vTgCB5tmL2sCUS6+K1CoARAjGXwtkMrOMqLEqEYjEVDiMdkcJ5cJ+z3oidxxAwcmiq
 C+ECYJrK7YG+Kfu0oDi/tTGWpz+g73zsJ4DGPP9V3uG1G1JV34wQICh9YtXeDiMSeNJE Hw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 363r3kmg23-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 10:32:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10IATulA166338;
        Mon, 18 Jan 2021 10:32:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 364a1w8r0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 18 Jan 2021 10:32:46 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 10IAWgoZ024693;
        Mon, 18 Jan 2021 10:32:42 GMT
Received: from localhost.localdomain (/1.129.195.2)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 18 Jan 2021 02:32:42 -0800
From:   Imran Khan <imran.f.khan@oracle.com>
To:     mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org
Cc:     juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Remove redundant sched_numa_balancing check.
Date:   Mon, 18 Jan 2021 21:32:18 +1100
Message-Id: <20210118103218.204373-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9867 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 mlxscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180061
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9867 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101180061
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

task_numa_fault is invoked from do_numa_page/do_huge_pmd_numa_page,
for task_numa_work induced memory faults. task_numa_work is scheduled
from task_tick_numa which is invoked only if sched_numa_balancing
is true.

So task_numa_fault will not get invoked if sched_numa_balancing is
false and hence we can avoid checking it again in task_numa_fault.

Signed-off-by: Imran Khan <imran.f.khan@oracle.com>
---
 kernel/sched/fair.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 04a3ce20da67..282ebd6c4197 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2643,9 +2643,6 @@ void task_numa_fault(int last_cpupid, int mem_node, int pages, int flags)
 	struct numa_group *ng;
 	int priv;
 
-	if (!static_branch_likely(&sched_numa_balancing))
-		return;
-
 	/* for example, ksmd faulting in a user's mm */
 	if (!p->mm)
 		return;
-- 
2.25.1

