Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C977B1C8622
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgEGJvR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 May 2020 05:51:17 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32953 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgEGJvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:51:16 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-LUyIP0opP-Oqd82D9mY13w-1; Thu, 07 May 2020 05:51:07 -0400
X-MC-Unique: LUyIP0opP-Oqd82D9mY13w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AC293462;
        Thu,  7 May 2020 09:51:05 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D2C110013BD;
        Thu,  7 May 2020 09:51:03 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, Paul Khuong <pvk@pvk.ca>
Subject: [PATCH 5/5] perf script: Enable IP fields for callchains
Date:   Thu,  7 May 2020 11:50:24 +0200
Message-Id: <20200507095024.2789147-6-jolsa@kernel.org>
In-Reply-To: <20200507095024.2789147-1-jolsa@kernel.org>
References: <20200507095024.2789147-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the callchains were deleted in pipe mode,
we need to ensure that the IP fields are enabled,
otherwise the callchain is not displayed.

Enabling IP and SYM, which should be enough for
callchains.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-script.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 5c4a580c048a..ecc8bd4c5e57 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2118,8 +2118,6 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 			return 0;
 	}
 
-	set_print_ip_opts(&evsel->core.attr);
-
 	if (evsel->core.attr.sample_type) {
 		err = perf_evsel__check_attr(evsel, scr->session);
 		if (err)
@@ -2132,6 +2130,13 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	 */
 	sample_type = perf_evlist__combined_sample_type(evlist);
 	callchain_param_setup(sample_type);
+
+	/* Enable fields for callchain entries, if it got enabled. */
+	if (callchain_param.record_mode != CALLCHAIN_NONE) {
+		output[output_type(evsel->core.attr.type)].fields |= PERF_OUTPUT_IP |
+								     PERF_OUTPUT_SYM;
+	}
+	set_print_ip_opts(&evsel->core.attr);
 	return 0;
 }
 
-- 
2.25.4

