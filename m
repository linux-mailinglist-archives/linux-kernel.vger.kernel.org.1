Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E372D5614
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgLJJFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:05:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:6083 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgLJJFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:05:38 -0500
IronPort-SDR: FaYQ5uWQ2V9xnZHulvusSGkwlXHMZrWFaQYHgupz5A0nL1FxjEUVIQwNoDAITL2dCCuAEtGkxI
 sFaAHOqK5SRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="170712743"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="170712743"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 01:03:53 -0800
IronPort-SDR: jML4+YpAR1SPBUgv8HqqNTN+Ln3W+ck6y03/O6p1p+HAASa0VTT7vbEFOCj0rVnKTPeTqKsRTl
 mYnoA+Msed5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="408450122"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2020 01:03:49 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, mingo@redhat.com, peterz@infradead.org,
        ak@linux.intel.com, alexander.antonov@linux.intel.com
Subject: [PATCH 2/5] perf evsel: Introduce an observed performance device
Date:   Thu, 10 Dec 2020 12:03:37 +0300
Message-Id: <20201210090340.14358-3-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
References: <20201210090340.14358-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding evsel::perf_device void pointer.

For performance monitoring purposes, an evsel can have a related device.
These changes allow to attribute, for example, I/O performance metrics
to IIO stack.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/util/evsel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 79a860d8e3ee..c346920f477a 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -127,6 +127,7 @@ struct evsel {
 	 * See also evsel__has_callchain().
 	 */
 	__u64			synth_sample_type;
+	void			*perf_device;
 };
 
 struct perf_missing_features {
-- 
2.19.1

