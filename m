Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D29B2688F2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgINKEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgINKDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:03:52 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C8C06178B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:52 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o5so17968687wrn.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 03:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3X4Vd3A6gScV/gufVFiq/pRbiP+e3hXWUGeI2js/4h0=;
        b=VmM5E3jyLCKJb2ryQM5oUt46Dsspg3d7jajKR0fDe7hcc8yEfeK9kcZvPScM1wobaR
         j184EOZ38MqVBvJuvWXKE71VberXnkLAvaZy+07dKSpzCWijjZHZGUhLGv/N183AW5uf
         hfSdbBoZY30syzDb4TyOv8zaW+kso+Z3oLhDf+e/RBqCVqP8s569Gcy+gbPi1PNwKo2o
         yLGprzWDj9TkC8oD64QYnseYcN/32QnWr/2nsz6Gzy9RLTbSEC1EvG/jI5BvZE7Oi3Um
         /p7Wabv8nh3dyLPuzxE1ccrLydPnQSeznOQqCH0Ka7tyxxpUM3YPe99GKke+eyTDPgOZ
         8BsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3X4Vd3A6gScV/gufVFiq/pRbiP+e3hXWUGeI2js/4h0=;
        b=LZFkjDxn+vOHCLTqUgbqOMts6JCqt1RLkG/+DmE1LZvAAbEYgPR5errMikYWJPLgJb
         ju1fimfhyRB3SMYV+2dkt9z+3xlOt8LBY3ltk4LzexTTZPXlmxlW6Unmnvyo+JUdhqlR
         RZwSbPVZaimYEpiBKcmVyZMf9mMkCeteNX1mZdbwO9cgphh5PlmldArpZm9FqqpwPLmO
         YkQMOw7JL/MKwn0w9UdiDj7s6W/dCUwnIHY0XIt297Mo0Cp4QB/9nYmSDAtPdjOU9V1D
         qS3agz62pUsLBPwsqPWJDWAii79X70G9zhEeFtIW0i+zfxlew57UWJew22DpRKv8Qc74
         zWQA==
X-Gm-Message-State: AOAM533B4pa2L1VenK29M72OkvrcrN8jU114boZhldacdXLt5OpXwRJC
        cGyEPnR8o2iz+uHxDe1GW5OFUg0LYdc3Xw==
X-Google-Smtp-Source: ABdhPJydL8r8a+JLvXOYjCGCQmupmUoMcem6H6fxKkI0TZl7p62HHQLaspKr5YUEYeyTDz6frv05VQ==
X-Received: by 2002:a5d:4709:: with SMTP id y9mr15136612wrq.59.1600077830862;
        Mon, 14 Sep 2020 03:03:50 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f815:527d:332f:d631])
        by smtp.gmail.com with ESMTPSA id v6sm19740795wrt.90.2020.09.14.03.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 03:03:49 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org
Cc:     valentin.schneider@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/4] sched/fair: minimize concurrent LBs between domain level
Date:   Mon, 14 Sep 2020 12:03:39 +0200
Message-Id: <20200914100340.17608-4-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914100340.17608-1-vincent.guittot@linaro.org>
References: <20200914100340.17608-1-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched domains tend to trigger simultaneously the load balance loop but
the larger domains often need more time to collect statistics. This
slowness makes the larger domain trying to detach tasks from a rq whereas
tasks already migrated somewhere else at a sub-domain level. This is not
a real problem for idle LB because the period of smaller domains will
increase with its CPUs being busy and this will let time for higher ones
to pulled tasks. But this becomes a problem when all CPUs are already busy
because all domains stay synced when they trigger their LB.

A simple way to minimize simultaneous LB of all domains is to decrement the
the busy interval by 1 jiffies. Because of the busy_factor, the interval of
larger domain will not be a multiple of smaller ones anymore.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/fair.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 765be8273292..7d7eefd8e2d4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9780,6 +9780,9 @@ get_sd_balance_interval(struct sched_domain *sd, int cpu_busy)
 
 	/* scale ms to jiffies */
 	interval = msecs_to_jiffies(interval);
+	if (cpu_busy)
+		interval -= 1;
+
 	interval = clamp(interval, 1UL, max_load_balance_interval);
 
 	return interval;
-- 
2.17.1

