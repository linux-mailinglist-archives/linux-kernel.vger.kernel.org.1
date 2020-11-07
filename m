Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26FD2AA3DB
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 09:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgKGI2J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 03:28:09 -0500
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:24863 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbgKGI2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 03:28:08 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id 55E7E665F0E;
        Sat,  7 Nov 2020 16:28:05 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] sched: remove duplicate include unnecessary
Date:   Sat,  7 Nov 2020 16:28:00 +0800
Message-Id: <1604737680-17887-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZT0sYTxhDSx5JS09OVkpNS09MSExNQ05DT0lVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NjI6Sww5Tj8jQhw8Hx8tKRxC
        EUkwCwhVSlVKTUtPTEhMTUNNSUpOVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFKTExKNwY+
X-HM-Tid: 0a75a1d1d8d19373kuws55e7e665f0e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove duplicate header include which is unnecessary.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 kernel/sched/sched.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index df80bfc..dd91a8b
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -351,7 +351,6 @@ extern bool dl_cpu_busy(unsigned int cpu);
 #ifdef CONFIG_CGROUP_SCHED
 
 #include <linux/cgroup.h>
-#include <linux/psi.h>
 
 struct cfs_rq;
 struct rt_rq;
-- 
2.7.4

