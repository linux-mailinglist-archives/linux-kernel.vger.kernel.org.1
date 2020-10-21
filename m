Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82A2295046
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444248AbgJUP56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:57:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:31390 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387963AbgJUP55 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:57:57 -0400
IronPort-SDR: IN9MF/FIzXzWYeNd3/Jfp1UM7V/S9BsnZZPsC0D00JdsnXrIb+3XEuilT5TpI4cdWUvCypJeAg
 EfpzKFOs0VTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="229015350"
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="229015350"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2020 08:57:56 -0700
IronPort-SDR: 91ZSyJiRZQkYxjao9T715rcxo2B5yWh3+WDB32S5mK/Q9qeGJeSqLXVoWN6OfQ9FWRdqryjP46
 Ia/lkH49pTYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,401,1596524400"; 
   d="scan'208";a="522789255"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 21 Oct 2020 08:57:56 -0700
Received: from [10.249.231.46] (abudanko-mobl.ccr.corp.intel.com [10.249.231.46])
        by linux.intel.com (Postfix) with ESMTP id 6986E580720;
        Wed, 21 Oct 2020 08:57:54 -0700 (PDT)
Subject: [PATCH v2 03/15] perf data: open data directory in read access mode
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Organization: Intel Corp.
Message-ID: <dc78ce8b-664c-45b9-ad44-4faaeb5d544f@linux.intel.com>
Date:   Wed, 21 Oct 2020 18:57:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <1ec29ed6-0047-d22f-630b-a7f5ccee96b4@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Open files located at trace data directory in case read access
mode is requested. File are opened and its fds assigned to
perf_data dir files especially for loading data directories
content in perf report mode.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/util/data.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index c47aa34fdc0a..6ad61ac6ba67 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -321,6 +321,10 @@ static int open_dir(struct perf_data *data)
 		return -1;
 
 	ret = open_file(data);
+	if (!ret && perf_data__is_dir(data)) {
+		if (perf_data__is_read(data))
+			ret = perf_data__open_dir(data);
+	}
 
 	/* Cleanup whatever we managed to create so far. */
 	if (ret && perf_data__is_write(data))
-- 
2.24.1

