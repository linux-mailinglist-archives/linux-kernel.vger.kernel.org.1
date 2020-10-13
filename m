Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF3A28D468
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732609AbgJMTZV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Oct 2020 15:25:21 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:54864 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732547AbgJMTZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:25:17 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-qp1AB-nlOGGEbAWQXua_eA-1; Tue, 13 Oct 2020 15:25:12 -0400
X-MC-Unique: qp1AB-nlOGGEbAWQXua_eA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35E0818BE16B;
        Tue, 13 Oct 2020 19:25:11 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 664B15D9D3;
        Tue, 13 Oct 2020 19:25:08 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 6/9] perf tools: Pass build_id object to dso__build_id_equal
Date:   Tue, 13 Oct 2020 21:24:38 +0200
Message-Id: <20201013192441.1299447-7-jolsa@kernel.org>
In-Reply-To: <20201013192441.1299447-1-jolsa@kernel.org>
References: <20201013192441.1299447-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Passing build_id object to dso__build_id_equal, so we can
properly check build id with different size than sha1.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c        | 5 +++--
 tools/perf/util/dso.h        | 2 +-
 tools/perf/util/symbol-elf.c | 8 ++++++--
 tools/perf/util/symbol.c     | 2 +-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 4415ce83150b..ca965845b35e 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1332,9 +1332,10 @@ void dso__set_build_id(struct dso *dso, struct build_id *bid)
 	dso->has_build_id = 1;
 }
 
-bool dso__build_id_equal(const struct dso *dso, u8 *build_id)
+bool dso__build_id_equal(const struct dso *dso, struct build_id *bid)
 {
-	return memcmp(dso->bid.data, build_id, sizeof(dso->bid.data)) == 0;
+	return dso->bid.size == bid->size &&
+	       memcmp(dso->bid.data, bid->data, dso->bid.size) == 0;
 }
 
 void dso__read_running_kernel_build_id(struct dso *dso, struct machine *machine)
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index 5a5678dbdaa5..f926c96bf230 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -261,7 +261,7 @@ void dso__set_sorted_by_name(struct dso *dso);
 void dso__sort_by_name(struct dso *dso);
 
 void dso__set_build_id(struct dso *dso, struct build_id *bid);
-bool dso__build_id_equal(const struct dso *dso, u8 *build_id);
+bool dso__build_id_equal(const struct dso *dso, struct build_id *bid);
 void dso__read_running_kernel_build_id(struct dso *dso,
 				       struct machine *machine);
 int dso__kernel_module_get_build_id(struct dso *dso, const char *root_dir);
diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index 97a55f162ea5..44dd86a4f25f 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -834,13 +834,17 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 	/* Always reject images with a mismatched build-id: */
 	if (dso->has_build_id && !symbol_conf.ignore_vmlinux_buildid) {
 		u8 build_id[BUILD_ID_SIZE];
+		struct build_id bid;
+		int size;
 
-		if (elf_read_build_id(elf, build_id, BUILD_ID_SIZE) < 0) {
+		size = elf_read_build_id(elf, build_id, BUILD_ID_SIZE);
+		if (size <= 0) {
 			dso->load_errno = DSO_LOAD_ERRNO__CANNOT_READ_BUILDID;
 			goto out_elf_end;
 		}
 
-		if (!dso__build_id_equal(dso, build_id)) {
+		build_id__init(&bid, build_id, size);
+		if (!dso__build_id_equal(dso, &bid)) {
 			pr_debug("%s: build id mismatch for %s.\n", __func__, name);
 			dso->load_errno = DSO_LOAD_ERRNO__MISMATCHING_BUILDID;
 			goto out_elf_end;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 976632d0baa0..6138866665df 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2136,7 +2136,7 @@ static char *dso__find_kallsyms(struct dso *dso, struct map *map)
 	}
 
 	if (sysfs__read_build_id("/sys/kernel/notes", &bid) == 0)
-		is_host = dso__build_id_equal(dso, bid.data);
+		is_host = dso__build_id_equal(dso, &bid);
 
 	/* Try a fast path for /proc/kallsyms if possible */
 	if (is_host) {
-- 
2.26.2

