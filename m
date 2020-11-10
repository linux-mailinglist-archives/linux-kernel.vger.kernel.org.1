Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340502ACF51
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 07:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbgKJGAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 01:00:40 -0500
Received: from mga17.intel.com ([192.55.52.151]:16590 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731049AbgKJGAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 01:00:40 -0500
IronPort-SDR: FOe8LrQzH5mlxWr2ZiA82fhWtRj5lIf/wv9AuzlO01greCiOFKZP0VF6XxA7puZrcqfSzcIUhN
 +YhS51CI2xKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9800"; a="149773095"
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="149773095"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 22:00:39 -0800
IronPort-SDR: vuNHAxSU1ADj2UP7kTiwrCD66IBGwx/SgCDOL0BIQRWWGjOdytp2xx7G+jwsNAVh/zwXms9TCD
 lUqsbfMJqk/Q==
X-IronPort-AV: E=Sophos;i="5.77,465,1596524400"; 
   d="scan'208";a="473300154"
Received: from yhuang-mobile.sh.intel.com ([10.238.5.184])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2020 22:00:35 -0800
From:   Huang Ying <ying.huang@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Rafael Aquini <aquini@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Rik van Riel <riel@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>
Subject: [PATCH -V3 0/2] autonuma: Migrate on fault among multiple bound nodes
Date:   Tue, 10 Nov 2020 13:59:49 +0800
Message-Id: <20201110055951.85085-1-ying.huang@intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it possible to optimize cross-socket memory accessing with
AutoNUMA even if the memory of the application is bound to multiple
NUMA nodes.

Changes:

v3:

- Rebased on latest upstream (v5.10-rc3)

- Revised the change log.

v2:

- Rebased on latest upstream (v5.10-rc1)

Huang Ying (2):
  mempolicy: Rename MPOL_F_MORON to MPOL_F_MOPRON
  autonuma: Migrate on fault among multiple bound nodes

 include/uapi/linux/mempolicy.h |  2 +-
 kernel/sched/debug.c           |  2 +-
 mm/mempolicy.c                 | 23 ++++++++++++++---------
 3 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.28.0
