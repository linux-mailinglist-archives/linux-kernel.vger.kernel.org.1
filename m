Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5302EBA41
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 07:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbhAFG7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 01:59:13 -0500
Received: from mga14.intel.com ([192.55.52.115]:7933 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbhAFG7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 01:59:13 -0500
IronPort-SDR: j9tuBRhudZcjADS8/YVDF78IQws1kDbK8n+IeU+mTcr8kesgIWElSRZmwEPz3UuFP/4pIkyqvX
 eC4fKumGXHHg==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="176458131"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="176458131"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 22:58:33 -0800
IronPort-SDR: pZV6gnJwILxdV17BuTwK8fFBM3m28H4kPeejk8B0ANIhBr4vcLibuw9wYzQYNVwhm0JS0aRQy+
 hmXlTBiLSoXg==
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="379178227"
Received: from yhuang6-mobl1.sh.intel.com ([10.238.6.89])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 22:58:31 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Alejandro Colomar" <alx.mailinglists@gmail.com>
Subject: [PATCH -V8 2/3] NOT kernel/man2/set_mempolicy.2: Add mode flag MPOL_F_NUMA_BALANCING
Date:   Wed,  6 Jan 2021 14:57:53 +0800
Message-Id: <20210106065754.17955-3-ying.huang@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106065754.17955-1-ying.huang@intel.com>
References: <20210106065754.17955-1-ying.huang@intel.com>
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

