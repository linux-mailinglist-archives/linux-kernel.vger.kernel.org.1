Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C382FCAFE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 07:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbhATGSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 01:18:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:39846 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbhATGOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 01:14:07 -0500
IronPort-SDR: BsTYUqpXJlIJXinPiA1UhqiZnk26PkaCp8PTu8FelZJTgTjk2ZzGvKzqC2rts5y+OWb8wHhZI8
 xSW5nlU6eJeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9869"; a="263861799"
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="263861799"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 22:13:26 -0800
IronPort-SDR: 8IqeVCpowqrbAPYEc0RVr7R4ZhSfJiIfcxEihoIM1srisFo0e7PZk2oEcI14l52oQ8TpsSZdpZ
 oTbwVEzlx2zQ==
X-IronPort-AV: E=Sophos;i="5.79,360,1602572400"; 
   d="scan'208";a="384449328"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2021 22:13:24 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Alejandro Colomar" <alx.mailinglists@gmail.com>
Subject: [PATCH -V9 2/3] NOT kernel/man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
Date:   Wed, 20 Jan 2021 14:12:34 +0800
Message-Id: <20210120061235.148637-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120061235.148637-1-ying.huang@intel.com>
References: <20210120061235.148637-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Cc: "Alejandro Colomar" <alx.mailinglists@gmail.com>
---
 man2/set_mempolicy.2 | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/man2/set_mempolicy.2 b/man2/set_mempolicy.2
index 68011eecb..fa64a1820 100644
--- a/man2/set_mempolicy.2
+++ b/man2/set_mempolicy.2
@@ -113,6 +113,22 @@ A nonempty
 .I nodemask
 specifies node IDs that are relative to the set of
 node IDs allowed by the process's current cpuset.
+.TP
+.BR MPOL_F_NUMA_BALANCING " (since Linux 5.12)"
+When
+.I mode
+is
+.BR MPOL_BIND ,
+enable the kernel NUMA balancing for the task if it is supported by
+the kernel.
+If the flag isn't supported by the kernel, or is used with
+.I mode
+other than
+.BR MPOL_BIND ,
+return \-1 and
+.I errno
+is set to
+.BR EINVAL .
 .PP
 .I nodemask
 points to a bit mask of node IDs that contains up to
@@ -293,6 +309,12 @@ argument specified both
 .B MPOL_F_STATIC_NODES
 and
 .BR MPOL_F_RELATIVE_NODES .
+Or, the
+.B MPOL_F_NUMA_BALANCING
+isn't supported by the kernel, or is used with
+.I mode
+other than
+.BR MPOL_BIND .
 .TP
 .B ENOMEM
 Insufficient kernel memory was available.
-- 
2.29.2

