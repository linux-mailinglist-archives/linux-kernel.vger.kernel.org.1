Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577392C24D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 12:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732970AbgKXLkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 06:40:43 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7671 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgKXLkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:40:42 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CgMX019WBz15KDX;
        Tue, 24 Nov 2020 19:40:16 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Tue, 24 Nov 2020 19:40:29 +0800
From:   Zou Wei <zou_wei@huawei.com>
To:     <mingo@redhat.com>, <peterz@infradead.org>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
        <bsegall@google.com>, <mgorman@suse.de>, <bristot@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, Zou Wei <zou_wei@huawei.com>
Subject: [PATCH -next] sched/topology: Mark some symbols with static keyword
Date:   Tue, 24 Nov 2020 19:52:11 +0800
Message-ID: <1606218731-3999-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:

kernel/sched/topology.c:211:1: warning: symbol 'sched_energy_mutex' was not declared. Should it be static?
kernel/sched/topology.c:212:6: warning: symbol 'sched_energy_update' was not declared. Should it be static?

Signed-off-by: Zou Wei <zou_wei@huawei.com>
---
 kernel/sched/topology.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 5d3675c..2676687 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -208,8 +208,8 @@ sd_parent_degenerate(struct sched_domain *sd, struct sched_domain *parent)
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 DEFINE_STATIC_KEY_FALSE(sched_energy_present);
 unsigned int sysctl_sched_energy_aware = 1;
-DEFINE_MUTEX(sched_energy_mutex);
-bool sched_energy_update;
+static DEFINE_MUTEX(sched_energy_mutex);
+static bool sched_energy_update;
 
 void rebuild_sched_domains_energy(void)
 {
-- 
2.6.2

