Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C832B1AF5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 13:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgKMMPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 07:15:45 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7191 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgKMMPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 07:15:39 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CXcMH2JbLz15TF6;
        Fri, 13 Nov 2020 19:54:19 +0800 (CST)
Received: from SWX921481.china.huawei.com (10.126.202.143) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Fri, 13 Nov 2020 19:54:21 +0800
From:   Barry Song <song.bao.hua@hisilicon.com>
To:     <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>, Barry Song <song.bao.hua@hisilicon.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Adrian Freund <adrian@freund.io>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: [PATCH v3] Documentation: scheduler: fix information on arch SD flags, sched_domain and sched_debug
Date:   Sat, 14 Nov 2020 00:50:18 +1300
Message-ID: <20201113115018.1628-1-song.bao.hua@hisilicon.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.126.202.143]
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

On the other hand, to print the schedule debug information, users need to
set sched_debug cmdline or enable it by sysfs entry. So this patch also
adds the description for sched_debug.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Adrian Freund <adrian@freund.io>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
---
 -v3:
 * add Reviewed-by of Valentin Schneider
 * add description of sched_debug

 Documentation/scheduler/sched-domains.rst | 26 ++++++++++-------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/Documentation/scheduler/sched-domains.rst b/Documentation/scheduler/sched-domains.rst
index 5c4b7f4f0062..8582fa5e9170 100644
--- a/Documentation/scheduler/sched-domains.rst
+++ b/Documentation/scheduler/sched-domains.rst
@@ -65,21 +65,17 @@ of the SMP domain will span the entire machine, with each group having the
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
-CONFIG_SCHED_DEBUG. This enables an error checking parse of the sched domains
-which should catch most possible errors (described above). It also prints out
-the domain structure in a visual format.
+CONFIG_SCHED_DEBUG and adding 'sched_debug' to your cmdline. If you forgot to
+tweak your cmdline, you can also flip the /sys/kernel/debug/sched_debug
+knob. This enables an error checking parse of the sched domains which should
+catch most possible errors (described above). It also prints out the domain
+structure in a visual format.
-- 
2.25.1

