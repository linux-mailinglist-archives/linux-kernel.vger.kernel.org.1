Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86A127F029
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731218AbgI3RWD convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 13:22:03 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:60271 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726540AbgI3RWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:22:02 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-toMtycdJP2GOtTJAUnDm4w-1; Wed, 30 Sep 2020 13:15:42 -0400
X-MC-Unique: toMtycdJP2GOtTJAUnDm4w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0FC4164082;
        Wed, 30 Sep 2020 17:15:40 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8C23702E7;
        Wed, 30 Sep 2020 17:15:37 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 9/9] perf tools: Align buildid list output for short build ids
Date:   Wed, 30 Sep 2020 19:15:12 +0200
Message-Id: <20200930171512.3986425-10-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-1-jolsa@kernel.org>
References: <20200930171512.3986425-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With shorter md5 build ids we need to align their
paths properly with other build ids:

  $ perf buildid-list
  17f4e448cc746582ea1881528deb549f7fdb3fd5 [kernel.kallsyms]
  a50e350e97c43b4708d09bcd85ebfff7         .../tools/perf/buildid-ex-md5
  1805c738c8f3ec0f47b7ea09080c28f34d18a82b /usr/lib64/ld-2.31.so

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c  | 2 +-
 tools/perf/util/dso.h  | 1 -
 tools/perf/util/dsos.c | 6 ++++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index ca965845b35e..55c11e854fe4 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1369,7 +1369,7 @@ int dso__kernel_module_get_build_id(struct dso *dso,
 	return 0;
 }
 
-size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
+static size_t dso__fprintf_buildid(struct dso *dso, FILE *fp)
 {
 	char sbuild_id[SBUILD_ID_SIZE];
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f926c96bf230..d8cb4f5680a4 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -362,7 +362,6 @@ struct dso *machine__findnew_kernel(struct machine *machine, const char *name,
 
 void dso__reset_find_symbol_cache(struct dso *dso);
 
-size_t dso__fprintf_buildid(struct dso *dso, FILE *fp);
 size_t dso__fprintf_symbols_by_name(struct dso *dso, FILE *fp);
 size_t dso__fprintf(struct dso *dso, FILE *fp);
 
diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index 87161e431830..183a81d5b2f9 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -287,10 +287,12 @@ size_t __dsos__fprintf_buildid(struct list_head *head, FILE *fp,
 	size_t ret = 0;
 
 	list_for_each_entry(pos, head, node) {
+		char sbuild_id[SBUILD_ID_SIZE];
+
 		if (skip && skip(pos, parm))
 			continue;
-		ret += dso__fprintf_buildid(pos, fp);
-		ret += fprintf(fp, " %s\n", pos->long_name);
+		build_id__sprintf(&pos->bid, sbuild_id);
+		ret += fprintf(fp, "%-40s %s\n", sbuild_id, pos->long_name);
 	}
 	return ret;
 }
-- 
2.26.2

