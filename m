Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CEB2EB70C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbhAFAum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:50:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:53380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726999AbhAFAuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:50:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2188322EBD;
        Wed,  6 Jan 2021 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609894199;
        bh=TNd3++/Pj1tsqCZAGrSaGWlfOB+AGyPnFt+VGHbZkYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=paof0JiiKEEyxXtS0XoqzQt3jHJXn1zzfW4JOxhPz8QBKKy0VGZ34woRS4RbFWbsK
         MbH2ra4FGjffXZ8wNpWeCyivR8hTomxf2OEUaDIOs4Zfpm2vnvQ9aoSLj69HAz5dJJ
         V8deGzvXn/pW5Y0djiWPzutax5hY6K664UXJC5VB3u/ed1pFnxK1xN6iocQD5pR8nr
         FOCoi0hxrXIYKxSHpb31kmUQTkj1PB9X8sDAnd+yi+045L2KUk+QUvyiDR/MBGSXr/
         bQxNKcBVaDrM+jlxfAWaPMPJtAWyJkHXkWCByk40Y9txaneQ9524KDIENsauVmQS6s
         T2wNM4tsM42/g==
From:   paulmck@kernel.org
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, yury.norov@gmail.com, kernel-team@fb.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC cpumask 5/5] rcutorture: Use "all" and "last" in "nohz_full" and "rcu_nocbs"
Date:   Tue,  5 Jan 2021 16:49:56 -0800
Message-Id: <20210106004956.11961-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20210106004850.GA11682@paulmck-ThinkPad-P72>
References: <20210106004850.GA11682@paulmck-ThinkPad-P72>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit uses the shiny new "all" and "last" cpumask options to
decouple the "nohz_full" and "rcu_nocbs" kernel boot parameters in the
TREE04.boot and TREE08.boot files from the CONFIG_NR_CPUS options in
the TREE04 and TREE08 files.

Reported-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot | 2 +-
 tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
index 5adc675..25a765d 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE04.boot
@@ -1 +1 @@
-rcutree.rcu_fanout_leaf=4 nohz_full=1-7
+rcutree.rcu_fanout_leaf=4 nohz_full=1-last
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
index 22478fd..94d3844 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TREE08.boot
@@ -1,3 +1,3 @@
 rcupdate.rcu_self_test=1
 rcutree.rcu_fanout_exact=1
-rcu_nocbs=0-7
+rcu_nocbs=all
-- 
2.9.5

