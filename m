Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB152B378F
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 19:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727518AbgKOSBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 13:01:24 -0500
Received: from m12-12.163.com ([220.181.12.12]:51636 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727000AbgKOSBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 13:01:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=6MubN
        k2IDlcXLKxODBPdt2LcfZmGAlZrFRKaa1VWLxI=; b=hy7EnfSy+TPcFpr3dYVRo
        //U3rW9X5SAlf19MmGaY6nT4/pZlXnr3gPn02fVIgxvE+fIYYr7+/tXNiNi+HJxZ
        PxQbcot5jbuh2bCl81/KGC6damj0LkJOY9tfEx7/JcQFMgc7kV2On2bahY+BYXC5
        k8TnqFy+qP8H73KIZhjAj0=
Received: from localhost (unknown [101.86.213.176])
        by smtp8 (Coremail) with SMTP id DMCowABnM9nWbLFfvZyMBw--.838S2;
        Mon, 16 Nov 2020 02:00:54 +0800 (CST)
Date:   Mon, 16 Nov 2020 02:00:54 +0800
From:   Hui Su <sh_def@163.com>
To:     christian.brauner@ubuntu.com, serge@hallyn.com, avagin@openvz.org,
        0x7f454c46@gmail.com, linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] nsproxy: use put_nsproxy() in switch_task_namespaces()
Message-ID: <20201115180054.GA371317@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DMCowABnM9nWbLFfvZyMBw--.838S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF13ur15Ww47uFy3uw4kWFg_yoWDtFg_AF
        ZrX3Z3K34jy3Z0yr15Ww1fXFy0q39IkF4xKw4IvrW5Ar98Xr47JwsrAFy3GF9rGFs3ua45
        uFy5Gr1DCr1rWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbYhF3UUUUU==
X-Originating-IP: [101.86.213.176]
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbByxbdX1PAProDmwAAsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use put_nsproxy() instead of '
if (atomic_dec_and_test(&ns->count)) {
	free_nsproxy(ns);
}' in switch_task_namespaces().

and remove the whitespace by the way.

Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/nsproxy.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 12dd41b39a7f..3ebfd090398a 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -173,7 +173,7 @@ int copy_namespaces(unsigned long flags, struct task_struct *tsk)
 	 * it along with CLONE_NEWIPC.
 	 */
 	if ((flags & (CLONE_NEWIPC | CLONE_SYSVSEM)) ==
-		(CLONE_NEWIPC | CLONE_SYSVSEM)) 
+		(CLONE_NEWIPC | CLONE_SYSVSEM))
 		return -EINVAL;
 
 	new_ns = create_new_namespaces(flags, tsk, user_ns, tsk->fs);
@@ -250,8 +250,8 @@ void switch_task_namespaces(struct task_struct *p, struct nsproxy *new)
 	p->nsproxy = new;
 	task_unlock(p);
 
-	if (ns && atomic_dec_and_test(&ns->count))
-		free_nsproxy(ns);
+	if (ns)
+		put_nsproxy(ns);
 }
 
 void exit_task_namespaces(struct task_struct *p)
-- 
2.29.0


