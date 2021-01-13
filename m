Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FE22F432D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbhAMEcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:32:19 -0500
Received: from mga02.intel.com ([134.134.136.20]:19654 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbhAMEcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:32:19 -0500
IronPort-SDR: MWBWr67jXR6Ml0lp53QZy/YPbkkH4TxFU9wU0prke2lQIuHQ468xFDd36ztEiy+4yNTCJnq1od
 avV9BIGSPtAg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="165236797"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="165236797"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 20:31:38 -0800
IronPort-SDR: d57Is5FnukTlOoTHHUfYaaQYAabhj5/2BZ8pNchRXrdFSjjMlXk9RnFpzQ25vWazGnnOLj0NAA
 ggyCB/86wlIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="scan'208";a="569310304"
Received: from aubrey-ubuntu.sh.intel.com ([10.239.53.16])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jan 2021 20:31:36 -0800
From:   Aubrey Li <aubrey.li@intel.com>
To:     lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org
Cc:     linux-kernel@vger.kernel.org, Aubrey Li <aubrey.li@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>
Subject: [PATCH] cpuset: fix typos in comments
Date:   Wed, 13 Jan 2021 12:37:41 +0800
Message-Id: <1610512661-135383-1-git-send-email-aubrey.li@intel.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change hierachy to hierarchy and congifured to configured, no functionality
changed.

Signed-off-by: Aubrey Li <aubrey.li@linux.intel.com>
---
 kernel/cgroup/cpuset.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 57b5b5d..15f4300 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -98,7 +98,7 @@ struct cpuset {
 	 * and if it ends up empty, it will inherit the parent's mask.
 	 *
 	 *
-	 * On legacy hierachy:
+	 * On legacy hierarchy:
 	 *
 	 * The user-configured masks are always the same with effective masks.
 	 */
@@ -1286,10 +1286,10 @@ static int update_parent_subparts_cpumask(struct cpuset *cpuset, int cmd,
  * @cs:  the cpuset to consider
  * @tmp: temp variables for calculating effective_cpus & partition setup
  *
- * When congifured cpumask is changed, the effective cpumasks of this cpuset
+ * When configured cpumask is changed, the effective cpumasks of this cpuset
  * and all its descendants need to be updated.
  *
- * On legacy hierachy, effective_cpus will be the same with cpu_allowed.
+ * On legacy hierarchy, effective_cpus will be the same with cpu_allowed.
  *
  * Called with cpuset_mutex held
  */
-- 
2.7.4

