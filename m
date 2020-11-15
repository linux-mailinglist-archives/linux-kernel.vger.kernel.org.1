Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBF82B37B3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:16:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKOSPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:15:32 -0500
Received: from m12-18.163.com ([220.181.12.18]:51367 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbgKOSPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:15:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=adebA
        P0ds1BhxIpklwNKRlL7iwkY1ihT1RM94CKHo3w=; b=aflViqMi/WY94Az6Y9mHm
        FPVfERmkhLDkT0j7lhkZH+1JK5dtXtIBzzHB0aHWrX91TmWOGrg+ZAs713TIoxaq
        SiUUDex9H99DtE/pJ0GypKxiwyFqFCpXRgiJcSojhTXw6vXmhnmzhDB5U+X1odny
        lFJD9WcrbAbnylV8sUnFq0=
Received: from localhost (unknown [101.86.213.176])
        by smtp14 (Coremail) with SMTP id EsCowADn99chcLFfbHwLEQ--.34571S2;
        Mon, 16 Nov 2020 02:14:57 +0800 (CST)
Date:   Mon, 16 Nov 2020 02:14:57 +0800
From:   Hui Su <sh_def@163.com>
To:     christian.brauner@ubuntu.com, serge@hallyn.com, avagin@openvz.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] nsproxy: remove judge of timens_on_fork()'s return val
Message-ID: <20201115181457.GA376527@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: EsCowADn99chcLFfbHwLEQ--.34571S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GrW7ZFy5ur4UZFykXF1xAFb_yoWDAFg_AF
        ZFq3ZIgFnIqFnavry3Ca1fXF97t390krWxCw4Iqay3AFn8JF4UJwsrAr98GryDCFs3WFy5
        uFWUJryDJw1YqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8ov35UUUUU==
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbipAHdX1r7rdL7rAAAsu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timens_on_fork() always return 0, and maybe not
need to judge the return value in copy_namespaces().

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/nsproxy.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 12dd41b39a7f..e2e6c5dc433f 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -153,7 +153,6 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	struct nsproxy *old_ns = tsk->nsproxy;
 	struct user_namespace *user_ns = task_cred_xxx(tsk, user_ns);
 	struct nsproxy *new_ns;
-	int ret;
 
 	if (likely(!(flags & (CLONE_NEWNS | CLONE_NEWUTS | CLONE_NEWIPC |
 			      CLONE_NEWPID | CLONE_NEWNET |
@@ -180,11 +179,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	if (IS_ERR(new_ns))
 		return  PTR_ERR(new_ns);
 
-	ret = timens_on_fork(new_ns, tsk);
-	if (ret) {
-		free_nsproxy(new_ns);
-		return ret;
-	}
+	timens_on_fork(new_ns, tsk);
 
 	tsk->nsproxy = new_ns;
 	return 0;
-- 
2.29.0


