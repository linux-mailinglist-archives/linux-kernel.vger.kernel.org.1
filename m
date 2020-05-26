Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA5A1DE28E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 May 2020 11:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgEVJEy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 May 2020 05:04:54 -0400
Received: from mail5.windriver.com ([192.103.53.11]:35028 "EHLO mail5.wrs.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728424AbgEVJEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:04:54 -0400
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail5.wrs.com (8.15.2/8.15.2) with ESMTPS id 04M94Bt0031878
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 02:04:43 -0700
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.487.0; Fri, 22 May 2020 02:04:06 -0700
From:   <qiang.zhang@windriver.com>
To:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/hung_task: Use task_pid_nr function to get pid
Date:   Fri, 22 May 2020 17:12:50 +0800
Message-ID: <20200522091250.37931-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

Use task_pid_nr(t) function instead of t->pid when printing
task pid.

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 kernel/hung_task.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c16cb3..0a77f6af6909 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -128,7 +128,8 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+			t->comm, task_pid_nr(t),
+			(jiffies - t->last_switch_time) / HZ);
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
-- 
2.24.1

