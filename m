Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F95E21EC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 11:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGNJID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 05:08:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:21673 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgGNJID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:08:03 -0400
IronPort-SDR: 5Zult3gZvu7MI0Fuwy03hVapUUoucoU1KW2dNTDbUEN6xXxe1q0jxyFczj0XDWPfnJClhJkLsl
 oLgv1aC6L6ew==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="148852561"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="148852561"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2020 02:08:03 -0700
IronPort-SDR: rsretidoWbVwg/N4AOXPc8QDnFGkuoR56SNARDaoDLTpbziD0at3pS3aDTHTXN8NgzdscyYehk
 m0LoBHWWjHvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="scan'208";a="269957054"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jul 2020 02:08:02 -0700
Received: from [10.249.230.149] (abudanko-mobl.ccr.corp.intel.com [10.249.230.149])
        by linux.intel.com (Postfix) with ESMTP id 985B5580810;
        Tue, 14 Jul 2020 02:07:58 -0700 (PDT)
Subject: [PATCH v11 08/15] perf stat: factor out body of event handling loop
 for fork case
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
Organization: Intel Corp.
Message-ID: <75e03994-ba68-e56e-a4d1-28eb923b7046@linux.intel.com>
Date:   Tue, 14 Jul 2020 12:07:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <037d737f-0ada-a9f0-9686-f7521ca6fbc3@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Factor out body of event handling loop for fork case reusing
handle_interval() function.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-stat.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 87eebf3f55ae..91f31518948e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -792,10 +792,7 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
 		if (interval || timeout) {
 			while (!waitpid(child_pid, &status, WNOHANG)) {
 				nanosleep(&ts, NULL);
-				if (timeout)
-					break;
-				process_interval();
-				if (interval_count && !(--times))
+				if (timeout || handle_interval(interval, &times))
 					break;
 			}
 		}
-- 
2.24.1


