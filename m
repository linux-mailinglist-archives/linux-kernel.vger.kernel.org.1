Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59AC42B119E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 23:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgKLWfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 17:35:41 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7184 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgKLWfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 17:35:40 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXGdW0X5qz15KMQ;
        Fri, 13 Nov 2020 06:35:27 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.203.95) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 06:35:30 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Adrian Freund <adrian@freund.io>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v2 1/2] Documentation: scheduler: fix outdated information on arch SD flags and sched_domain
Date:   Fri, 13 Nov 2020 11:31:28 +1300
Message-ID: <20201112223129.26580-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.203.95]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document seems to be out of date for many, many years. Even it has
misspelled from the first day.
ARCH_HASH_SCHED_TUNE should be ARCH_HAS_SCHED_TUNE
ARCH_HASH_SCHED_DOMAIN should be ARCH_HAS_SCHED_DOMAIN

Since v2.6.14, kernel completely deleted the relevant code and even
arch_init_sched_domains() was deleted.

Right now, kernel is asking architectures to call set_sched_topology() to
override the default sched domains.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Adrian Freund <adrian@freund.io>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v2: refine the SD_ flags description with respect to Valentin's comment

 Documentation/scheduler/sched-domains.rst | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 5c4b7f4f0062..55983b7e1098 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -65,19 +65,13 @@ of the SMP domain will span the entire machine, with each group having the
 cpumask of a node. Or, you could do multi-level NUMA or Opteron, for example,
 might have just one domain covering its one NUMA level.
 
-The implementor should read comments in include/linux/sched.h:
-struct sched_domain fields, SD_FLAG_*, SD_*_INIT to get an idea of
-the specifics and what to tune.
+The implementor should read comments in include/linux/sched/sd_flags.h:
+SD_* to get an idea of the specifics and what to tune for the SD flags
+of a sched_domain.
 
-Architectures may retain the regular override the default SD_*_INIT flags
-while using the generic domain builder in kernel/sched/core.c if they wish to
-retain the traditional SMT->SMP->NUMA topology (or some subset of that). This
-can be done by #define'ing ARCH_HASH_SCHED_TUNE.
-
-Alternatively, the architecture may completely override the generic domain
-builder by #define'ing ARCH_HASH_SCHED_DOMAIN, and exporting your
-arch_init_sched_domains function. This function will attach domains to all
-CPUs using cpu_attach_domain.
+Architectures may override the generic domain builder and the default SD flags
+for a given topology level by creating a sched_domain_topology_level array and
+calling set_sched_topology() with this array as the parameter.
 
 The sched-domains debugging infrastructure can be enabled by enabling
 CONFIG_SCHED_DEBUG. This enables an error checking parse of the sched domains
-- 
2.25.1

