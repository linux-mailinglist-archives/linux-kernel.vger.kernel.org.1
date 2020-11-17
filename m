Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF5F2B5DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgKQLBa convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:01:30 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:28093 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728026AbgKQLB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:01:29 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-VOUGYnBFOsyn05T99MvNxg-1; Tue, 17 Nov 2020 06:01:25 -0500
X-MC-Unique: VOUGYnBFOsyn05T99MvNxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8046880ED92;
        Tue, 17 Nov 2020 11:01:23 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85C3A5C1CF;
        Tue, 17 Nov 2020 11:01:20 +0000 (UTC)
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
Subject: [PATCH 06/24] perf tools: Add build_id__is_defined function
Date:   Tue, 17 Nov 2020 12:00:35 +0100
Message-Id: <20201117110053.1303113-7-jolsa@kernel.org>
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

Adding build_id__is_defined helper to check build id
is defined and is != zero build id.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/build-id.c | 7 +++++++
 tools/perf/util/build-id.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index 6b410c3d52dc..7d9ecc37849c 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -912,3 +912,10 @@ void build_id__init(struct build_id *bid, const u8 *data, size_t size)
 	memcpy(bid->data, data, size);
 	bid->size = size;
 }
+
+bool build_id__is_defined(const struct build_id *bid)
+{
+	static u8 zero[BUILD_ID_SIZE];
+
+	return bid && bid->size ? memcmp(bid->data, &zero, bid->size) : false;
+}
diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
index f293f99d5dba..d53415feaf69 100644
--- a/tools/perf/util/build-id.h
+++ b/tools/perf/util/build-id.h
@@ -21,6 +21,7 @@ struct feat_fd;
 
 void build_id__init(struct build_id *bid, const u8 *data, size_t size);
 int build_id__sprintf(const struct build_id *build_id, char *bf);
+bool build_id__is_defined(const struct build_id *bid);
 int sysfs__sprintf_build_id(const char *root_dir, char *sbuild_id);
 int filename__sprintf_build_id(const char *pathname, char *sbuild_id);
 char *build_id_cache__kallsyms_path(const char *sbuild_id, char *bf,
-- 
2.26.2

