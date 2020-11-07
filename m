Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE4A62AA2DF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 07:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgKGGr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 01:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgKGGr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 01:47:27 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 22:47:26 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r186so2919398pgr.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 22:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:mime-version:content-disposition;
        bh=ZzsNrGFan4OrroMZuX6/87lpdqcSsjMEcCkQ4hRXR+o=;
        b=fQGtbkLnKqLaIzIKD0J+VZYUEFniWxFAqsxWzoKirHEFExd1IQymfyJmeUCvD1Bigc
         aIcDBQhNBh52rlV5RBodWKGXLZTl8nrrjBiGj2HFHw/PKcr+ZH3lPGvKD7d0A1+WYLUy
         FV0S4CkPuTrPU3BtY1jd4yjExDzFOTAETlFR5Zs/6AHLQCExPs2Qc9yVgcYrduhGSnoP
         Ib9/DqreqRpYScwKntF1oxmBy1uHEOx84wqMLU6omfU2/iQUkJ2fB+8nIMBCfJQHynCk
         XQmynqNncA4MGgyq9+AKDzcx+L9zLQWvGVVhfDx7ReQ/MBmtgPaVODcob+LIjtzw74Pj
         Bpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=ZzsNrGFan4OrroMZuX6/87lpdqcSsjMEcCkQ4hRXR+o=;
        b=gvyHQqnNBS+ASi6h5nDbwOOtr3ofAXF4WPRqrA3WhUHTHdOW9qVOQDBC+h911UgcIK
         LS4SauHrOzxYHhnVNR28yPPA8xISuS/PYOOek9GfVkJ6a6ZVV0Lay5NiZ7e07IdAGDnd
         tz30Dmv5D/l2CAEy/Het0HO0qQmEnbn3xiO+QH9UHQRvjG1l7HOLuoOnua8tShM5YELM
         u9kBI357zo2zu6PJoZEJuZIDHFfftMFkeC0rEW1NJEvyLvd1OwcZQwmfO/5ocgAWk+cO
         jbA0v9/qAAv6yNmWZo2Dc7IhwsNor/cj9JdVpDGxuXuhsd7WPn10/oTq7boSzhRIuYdF
         7FkA==
X-Gm-Message-State: AOAM530yyD/msYhYVStEqF6F6r9vdifak3INrQKEekAitIA9E71B3uUw
        GnOe7/QVcSDfDwZGcnzuBq+/tBLxGX562g==
X-Google-Smtp-Source: ABdhPJxVAbnHOZ/5LyvTdKepnPua9/mtfngw5AWoA3YrhWYQ8iruEAEy2Z7UO3UJudHQoNCTsCTbdg==
X-Received: by 2002:a63:b55e:: with SMTP id u30mr4424665pgo.381.1604731646276;
        Fri, 06 Nov 2020 22:47:26 -0800 (PST)
Received: from arch-e3.localdomain (180-177-112-186.dynamic.kbronet.com.tw. [180.177.112.186])
        by smtp.gmail.com with ESMTPSA id n72sm4529750pfd.202.2020.11.06.22.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 22:47:25 -0800 (PST)
From:   Eddy Wu <itseddy0402@gmail.com>
X-Google-Original-From: Eddy Wu <eddy_wu@trendmicro.com>
Date:   Sat, 7 Nov 2020 14:47:22 +0800
To:     oleg@redhat.com
Cc:     security@kernel.org, linux-kernel@vger.kernel.org,
        eddy_wu@trendmicro.com
Subject: [PATCH] fork: fix copy_process(CLONE_PARENT) race with the exiting
 ->real_parent
Message-ID: <20201107064722.GA139215@arch-e3.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

current->group_leader->exit_signal may change during copy_process() if
current->real_parent exits, move the assignment inside tasklist_lock to avoid
the race.

Signed-off-by: Eddy Wu <eddy_wu@trendmicro.com>
---
 kernel/fork.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index da8d360fb032..7abda2a888a9 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2142,14 +2142,9 @@ static __latent_entropy struct task_struct *copy_process(
 	/* ok, now we should be set up.. */
 	p->pid = pid_nr(pid);
 	if (clone_flags & CLONE_THREAD) {
-		p->exit_signal = -1;
 		p->group_leader = current->group_leader;
 		p->tgid = current->tgid;
 	} else {
-		if (clone_flags & CLONE_PARENT)
-			p->exit_signal = current->group_leader->exit_signal;
-		else
-			p->exit_signal = args->exit_signal;
 		p->group_leader = p;
 		p->tgid = p->pid;
 	}
@@ -2193,9 +2188,14 @@ static __latent_entropy struct task_struct *copy_process(
 	if (clone_flags & (CLONE_PARENT|CLONE_THREAD)) {
 		p->real_parent = current->real_parent;
 		p->parent_exec_id = current->parent_exec_id;
+		if (clone_flags & CLONE_THREAD)
+			p->exit_signal = -1;
+		else
+			p->exit_signal = current->group_leader->exit_signal;
 	} else {
 		p->real_parent = current;
 		p->parent_exec_id = current->self_exec_id;
+		p->exit_signal = args->exit_signal;
 	}
 
 	klp_copy_process(p);
-- 
2.17.1

