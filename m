Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5117928D03F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 16:31:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388685AbgJMObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 10:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387516AbgJMObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 10:31:48 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A98C0613D0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:31:48 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k8so16862220pfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whZcmd1DoIGzv1TTWC7S5idYiXOkR/uN8ym99T2oiRk=;
        b=T5LW0LxTyNASILjSNKZiokahh5SdjRmDG0/16847nNxNRLv3IJVlHwMAN0uTIhwLBe
         ++aChLDfwf68ZwRsBnKgKIrLAL89l5o25OpMlFuIhgNk6DQRLsajqWcFITyQCPwYk6au
         Sw6Y8kf7/SlLbz8DlRfoTARPvGj6UQ6hIJRb9zFGgOniAO5mkfvgA/floWChq3PURgzp
         hHCul5LpCduHT9abaOZ87DbF53+gkhV/mOUutZajW7rRJ/4E2HcMwpOeN3tKWDE07Yc2
         kOr+3dd7ZvL6tLZh7M6SDX6Y7kJGmwhZzdONWEFqCdVpKwBI9Xc9fv0ZqtpxFUMljoRb
         c45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=whZcmd1DoIGzv1TTWC7S5idYiXOkR/uN8ym99T2oiRk=;
        b=KJSy2XIoaT72dMWNKuTH+MOLnmpIplBMppmZw8aJG5rUHw/Eo6I2/L63z4cC9HCDey
         5PNKx/40zJTq1WNnUbf5htAZADcN0dC353rUIaBGilhDIpVFkoExvMhz+HtYvrtCp1dX
         mb4aaZnQ0vbanwijdEmMDFEP2pIhBhj78O0mrhcRodBOFmhfXeGV4JJrxZFk46bxfg6/
         LSJ9Em9bdrT0zIOb68923K4h5lNh8Bt92Ma5vDIuhJx/NpPxMUgFhScWUilgnq28YIii
         DoPo25c4PLs/1dAlHprA3minYtU7LLU9AZDeYo+XcrUMpNE7y7+iFC+CwvnFNifwlRF6
         Zygg==
X-Gm-Message-State: AOAM530B1VXzDhuP5vjbTa1KaKwKMGKsQ+o9jUifm+9ahmw9u7VICExh
        6Xvo/dhmKdC6t6sCUwca0Vk=
X-Google-Smtp-Source: ABdhPJzPO8HUo4M2Oo1cY3VEAn9TBglEKybyX7G+0cRRY3qHMQRrCuuNLRT7h2d/vV2qL8c3a7+vUA==
X-Received: by 2002:a63:5b03:: with SMTP id p3mr17419931pgb.154.1602599507629;
        Tue, 13 Oct 2020 07:31:47 -0700 (PDT)
Received: from XiaoXinPro-13.hytera.com (ec2-18-166-210-80.ap-east-1.compute.amazonaws.com. [18.166.210.80])
        by smtp.gmail.com with ESMTPSA id t6sm14419424pgn.26.2020.10.13.07.31.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 07:31:46 -0700 (PDT)
From:   Qi Zheng <arch0.zheng@gmail.com>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Qi Zheng <arch0.zheng@gmail.com>
Subject: [PATCH] sched/deadline: Replace rq_of_dl_rq(dl_rq_of_se(dl_se)) with ... ...task_rq(dl_task_of(dl_se))
Date:   Tue, 13 Oct 2020 22:31:40 +0800
Message-Id: <20201013143140.237750-1-arch0.zheng@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rq is already obtained in the dl_rq_of_se() function:
	struct task_struct *p = dl_task_of(dl_se);
        struct rq *rq = task_rq(p);
So there is no need to do extra conversion.

Signed-off-by: Qi Zheng <arch0.zheng@gmail.com>
---
 kernel/sched/deadline.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6d93f4518734..f64e577f6aba 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1152,7 +1152,7 @@ void init_dl_task_timer(struct sched_dl_entity *dl_se)
 static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 {
 	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq_of_se(dl_se));
+	struct rq *rq = task_rq(p);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
@@ -1498,7 +1498,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se,
 		replenish_dl_entity(dl_se, pi_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
 		  dl_time_before(dl_se->deadline,
-				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
+				 rq_clock(task_rq(dl_task_of(dl_se))))) {
 		setup_new_dl_entity(dl_se);
 	}
 
-- 
2.25.1

