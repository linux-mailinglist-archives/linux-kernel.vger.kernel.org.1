Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0982B5DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728458AbgKQLCb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:02:31 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:49035 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728444AbgKQLCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:02:30 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-Xvf4NYRbNUuyKkuruKdGjQ-1; Tue, 17 Nov 2020 06:02:23 -0500
X-MC-Unique: Xvf4NYRbNUuyKkuruKdGjQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 647441017DCB;
        Tue, 17 Nov 2020 11:02:21 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6205F5C1CF;
        Tue, 17 Nov 2020 11:02:18 +0000 (UTC)
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
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 23/24] perf buildid-list: Add support for mmap2's buildid events
Date:   Tue, 17 Nov 2020 12:00:52 +0100
Message-Id: <20201117110053.1303113-24-jolsa@kernel.org>
In-Reply-To: <20201117110053.1303113-1-jolsa@kernel.org>
References: <20201117110053.1303113-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add buildid-list support for mmap2's build id data, so we can
display build ids for dso objects for data without the build
id cache update.

  $ perf buildid-list
  1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so
  d278249792061c6b74d1693ca59513be1def13f2 /usr/lib64/libc-2.31.so

By default only dso objects with hits are shown.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-buildid-list.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-buildid-list.c b/tools/perf/builtin-buildid-list.c
index e3ef75583514..87f5b1a4a7fa 100644
--- a/tools/perf/builtin-buildid-list.c
+++ b/tools/perf/builtin-buildid-list.c
@@ -77,6 +77,9 @@ static int perf_session__list_build_ids(bool force, bool with_hits)
 	    perf_header__has_feat(&session->header, HEADER_AUXTRACE))
 		with_hits = false;
 
+	if (!perf_header__has_feat(&session->header, HEADER_BUILD_ID))
+		with_hits = true;
+
 	/*
 	 * in pipe-mode, the only way to get the buildids is to parse
 	 * the record stream. Buildids are stored as RECORD_HEADER_BUILD_ID
-- 
2.26.2

