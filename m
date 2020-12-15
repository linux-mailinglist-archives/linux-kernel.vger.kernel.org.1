Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF7A2DA837
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 07:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgLOGtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 01:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgLOGtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 01:49:52 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BFFC06179C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 22:49:12 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id t6so10481177plq.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 22:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=eLnIUx3l+Brym/e0JE3weR96RHbJYQDK+gZ9FFBC7F4=;
        b=NgKFv9qir0l1sABWnGjYKcqxy/c0kLfaS8eKiD9SAH6IhyyxtJGKeH9TMdvkPYnQ6l
         lBUemINbQkvixSfxFufpuIjOOHicuWW6LSz4e2St19gDihhiQB8sXTCmvNL5wMBAJ/di
         8+3b4ZgqXiDAhdEhmyQK5PGh5eOUGi7dojwvt/DDS4XFwMefYeGqJuepr7LCj4ZBsVpa
         XKqnVxujIoWBGMZV70i6rGLGzLf2JzrtQ2246pQe8AB2WhIvyEzgwFtC9Ui3QtJ4HkvE
         hp433hJgDTLY3IYAuzq1y9VvY9rGqxXVPxRYq+xA3ph11ZiNrWOuQUOHUTK3gNJDLjpO
         PFGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=eLnIUx3l+Brym/e0JE3weR96RHbJYQDK+gZ9FFBC7F4=;
        b=XZGiINxu0mmNd5DoAO/Q+5bE8VyXjGM7aC+pqqtKOJp3OOTrLE8objj7oZEoWcZm4E
         XX9W+cGKgBaI2LrFJPmfqErDmH4p7SfNMSUaz9ZFwuy5wxyIcQdiwwqdEqoyFLYp8YR4
         sgRJGxEQ66iSQ3GbB72cysBjK1GZkW6+tn7RBX2an+ivjzJQACLqC7Kd1eEsAgn32V2z
         dB7JJqpas8xVQJ9pxKwgyvBuAFtp8+U1Fjf09pFDRzU7yuNKnyfans+NfDUXphbvvOV6
         FDEBGv33iSw9+jeuXUBS33b/Dz/YzWlWQIcCD/e83f4O8hFpQ3t0vu2dtArYB/HaQMoQ
         wF+g==
X-Gm-Message-State: AOAM532Ig5jmPbU/6EMG1GNNMy9mDGzrlQfXAYkSTTn4OrU1EpPWtsL/
        pruVU5vJ8L465SZHHH4qzXjNfxwUdEFkjdMSQKY=
X-Google-Smtp-Source: ABdhPJykpcA+kwt2gjV5vfQz6Q8JsUoojzInOcCwJrCcyUri5Y3x6icQynqxaV8bIFDj9BPpO+W8/A==
X-Received: by 2002:a17:90a:5b18:: with SMTP id o24mr28745640pji.120.1608014951340;
        Mon, 14 Dec 2020 22:49:11 -0800 (PST)
Received: from localhost.localdomain ([203.205.141.39])
        by smtp.gmail.com with ESMTPSA id m13sm21713602pff.21.2020.12.14.22.49.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Dec 2020 22:49:10 -0800 (PST)
From:   chenxg1x@gmail.com
X-Google-Original-From: xiaoggchen@tencent.com
To:     linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, heddchen@tencent.com, xiaoggchen@tencent.com
Subject: [PATCH] sched: don't check rq after newidle_balance return positive
Date:   Tue, 15 Dec 2020 14:48:50 +0800
Message-Id: <1608014930-5144-1-git-send-email-xiaoggchen@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen Xiaoguang <xiaoggchen@tencent.com>

In pick_next_task_fair, if CPU is going to idle newidle_balance
is called first trying to pull some tasks.
When newidle_balance returns positive which means it does
pulls tasks or some tasks enqueued then there is no need to check
sched_fair_runnable again.

Signed-off-by: He Chen <heddchen@tencent.com>
Signed-off-by: Xiaoguang Chen <xiaoggchen@tencent.com>
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ae7ceba..c2f7eac 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7004,10 +7004,9 @@ struct task_struct *
 	struct task_struct *p;
 	int new_tasks;
 
-again:
 	if (!sched_fair_runnable(rq))
 		goto idle;
-
+again:
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	if (!prev || prev->sched_class != &fair_sched_class)
 		goto simple;
-- 
1.8.3.1

