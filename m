Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBFC526813F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgIMVEN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:04:13 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60442 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgIMVDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:03:51 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249--FsyTEmQP2ut0tesaM59gA-1; Sun, 13 Sep 2020 17:03:49 -0400
X-MC-Unique: -FsyTEmQP2ut0tesaM59gA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7657E802B6A;
        Sun, 13 Sep 2020 21:03:46 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A0CE01002393;
        Sun, 13 Sep 2020 21:03:37 +0000 (UTC)
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
Subject: [PATCH 05/26] perf tools: Add build_id__is_defined function
Date:   Sun, 13 Sep 2020 23:02:52 +0200
Message-Id: <20200913210313.1985612-6-jolsa@kernel.org>
In-Reply-To: <20200913210313.1985612-1-jolsa@kernel.org>
References: <20200913210313.1985612-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding build_id__is_defined helper to check build id
is defined and is != zero build id.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 11 +++++++++++
 tools/perf/util/build-id.h |  1 +
 2 files changed, 12 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 31207b6e2066..bdee4e08e60d 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -902,3 +902,14 @@ bool perf_session__read_build_ids(struct perf_session *session, bool with_hits)
 
 	return ret;
 }
+
+bool build_id__is_defined(const u8 *build_id)
+{
+	static u8 zero[BUILD_ID_SIZE];
+	int err = 0;
+
+	if (build_id)
+		err = memcmp(build_id, &zero, BUILD_ID_SIZE);
+
+	return err ? true : false;
+}
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index aad419bb165c..1ceede45c231 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -14,6 +14,7 @@ extern struct perf_tool build_id__mark_dso_hit_ops;
 struct dso;
 struct feat_fd;
 
+bool build_id__is_defined(const u8 *build_id);
 int build_id__sprintf(const u8 *build_id, int len, char *bf);
 int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id);
 int filename__sprintf_build_id(const char *pathname, char *sbuild_id);
-- 
2.26.2

