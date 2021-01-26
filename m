Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF6B430459E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 18:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393158AbhAZRpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 12:45:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:6417 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389654AbhAZIKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:10:12 -0500
IronPort-SDR: fWdhjMby5RX4KyYSm37M1E7zECiUKeBF5oN5CIsM+C8Kq+tphyIZsOe9gzx+WhrDSVcU83X6DI
 cKaJS+MtDjBA==
X-IronPort-AV: E=McAfee;i="6000,8403,9875"; a="264688816"
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="264688816"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2021 00:06:39 -0800
IronPort-SDR: D8fOA/oz6aofMwP/kJzc0Jmp4aL89xtcC9TLUXrLwSXRF3vv8xnbGmqcWX0DHhJkm4yIgp3bTw
 1ehkbMgcq36g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,375,1602572400"; 
   d="scan'208";a="572855881"
Received: from nntpdsd52-183.inn.intel.com ([10.125.52.183])
  by orsmga005.jf.intel.com with ESMTP; 26 Jan 2021 00:06:36 -0800
From:   Alexander Antonov <alexander.antonov@linux.intel.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, ak@linux.intel.com,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        namhyung@kernel.org, irogers@google.com, mingo@redhat.com,
        peterz@infradead.org, alexander.antonov@linux.intel.com
Subject: [PATCH v3 5/5] perf: Update .gitignore file
Date:   Tue, 26 Jan 2021 11:06:19 +0300
Message-Id: <20210126080619.30275-6-alexander.antonov@linux.intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20210126080619.30275-1-alexander.antonov@linux.intel.com>
References: <20210126080619.30275-1-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After a "make -C tools/perf", git reports the following untracked file:
perf-iostat

Add this generated file to perf's .gitignore file.

Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
---
 tools/perf/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index bf1252dc2cb0..421f27e2b9af 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -19,6 +19,7 @@ perf.data.old
 output.svg
 perf-archive
 perf-with-kcore
+perf-iostat
 tags
 TAGS
 cscope*
-- 
2.19.1

