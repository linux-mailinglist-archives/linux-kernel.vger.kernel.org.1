Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D80268148
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbgIMVFV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:05:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47660 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725945AbgIMVEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:04:49 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-202-08eBv_XMOLyAfeuTlk8vBQ-1; Sun, 13 Sep 2020 17:04:45 -0400
X-MC-Unique: 08eBv_XMOLyAfeuTlk8vBQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24F141882FA1;
        Sun, 13 Sep 2020 21:04:43 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 81E311002393;
        Sun, 13 Sep 2020 21:04:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Song Liu <songliubraving@fb.com>,
        "Frank Ch. Eigler" <fche@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 18/26] perf tests: Add mmap3 support for perf record test
Date:   Sun, 13 Sep 2020 23:03:05 +0200
Message-Id: <20200913210313.1985612-19-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-1-jolsa@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding mmap3 support for perf record test so it can
pass for kernel with mmap3 support.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/perf-record.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/perf-record.c b/tools/perf/tests/perf-record.c
index 67d3f5aad016..722c0cc02e57 100644
--- a/tools/perf/tests/perf-record.c
+++ b/tools/perf/tests/perf-record.c
@@ -224,6 +224,7 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 				if ((type == PERF_RECORD_COMM ||
 				     type == PERF_RECORD_MMAP ||
 				     type == PERF_RECORD_MMAP2 ||
+				     type == PERF_RECORD_MMAP3 ||
 				     type == PERF_RECORD_FORK ||
 				     type == PERF_RECORD_EXIT) &&
 				     (pid_t)event->comm.pid != evlist->workload.pid) {
@@ -233,7 +234,8 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 
 				if ((type == PERF_RECORD_COMM ||
 				     type == PERF_RECORD_MMAP ||
-				     type == PERF_RECORD_MMAP2) &&
+				     type == PERF_RECORD_MMAP2 ||
+				     type == PERF_RECORD_MMAP3) &&
 				     event->comm.pid != event->comm.tid) {
 					pr_debug("%s with different pid/tid!\n", name);
 					++errs;
@@ -253,6 +255,9 @@ int test__PERF_RECORD(struct test *test __maybe_unused, int subtest __maybe_unus
 					goto check_bname;
 				case PERF_RECORD_MMAP2:
 					mmap_filename = event->mmap2.filename;
+					goto check_bname;
+				case PERF_RECORD_MMAP3:
+					mmap_filename = event->mmap3.filename;
 				check_bname:
 					bname = strrchr(mmap_filename, '/');
 					if (bname != NULL) {
-- 
2.26.2

