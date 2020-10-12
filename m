Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDD728B0E5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgJLIzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:55:12 -0400
Received: from mga01.intel.com ([192.55.52.88]:44619 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728268AbgJLIzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:55:12 -0400
IronPort-SDR: pslZkfJ/Guh4w/Xca8BbnK46p5DUUtGNs1b3SqcGPdiVhJ+r9/+XcnpQEgNxcZyZDTtxFZqVGn
 4I0j6orKD0nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9771"; a="183165355"
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="183165355"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 01:55:11 -0700
IronPort-SDR: 0wYcmmC2DE365hOCd3AkUbqTExfdCK705lawhSjPxDQ4UivFonsgZt+kTPouPecp1Jay1X6nAr
 Q78Loq+v6Txw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,366,1596524400"; 
   d="scan'208";a="345784955"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga008.jf.intel.com with ESMTP; 12 Oct 2020 01:55:11 -0700
Received: from [10.249.225.186] (abudanko-mobl.ccr.corp.intel.com [10.249.225.186])
        by linux.intel.com (Postfix) with ESMTP id EA2FC5805EC;
        Mon, 12 Oct 2020 01:55:08 -0700 (PDT)
Subject: [PATCH v1 03/15] perf data: open data directory in read access mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
Organization: Intel Corp.
Message-ID: <9ac7f12e-f5a4-dd91-a19a-bb7e5be27636@linux.intel.com>
Date:   Mon, 12 Oct 2020 11:55:07 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <810f3a69-0004-9dff-a911-b7ff97220ae0@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Open files located at data directory in case of read access mode.

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


