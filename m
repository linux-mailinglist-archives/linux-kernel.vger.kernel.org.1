Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE4328D467
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbgJMTZS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Oct 2020 15:25:18 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:60460 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727873AbgJMTZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:25:15 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-lONjhXiKOVO4sCkXn96Yzw-1; Tue, 13 Oct 2020 15:25:10 -0400
X-MC-Unique: lONjhXiKOVO4sCkXn96Yzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1468A18BE181;
        Tue, 13 Oct 2020 19:25:08 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54A175D9CD;
        Tue, 13 Oct 2020 19:25:02 +0000 (UTC)
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
Subject: [PATCH 5/9] perf tools: Pass build_id object to dso__set_build_id
Date:   Tue, 13 Oct 2020 21:24:37 +0200
Message-Id: <20201013192441.1299447-6-jolsa@kernel.org>
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

Passing build_id object to dso__set_build_id, so it's easier
to initialize dos's build id object.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/dso.c            | 4 ++--
 tools/perf/util/dso.h            | 2 +-
 tools/perf/util/header.c         | 4 +++-
 tools/perf/util/symbol-minimal.c | 2 +-
 tools/perf/util/symbol.c         | 2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 2f7f01ead9a1..4415ce83150b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1326,9 +1326,9 @@ void dso__put(struct dso *dso)
 		dso__delete(dso);
 }
 
-void dso__set_build_id(struct dso *dso, void *build_id)
+void dso__set_build_id(struct dso *dso, struct build_id *bid)
 {
-	memcpy(dso->bid.data, build_id, sizeof(dso->bid.data));
+	dso->bid = *bid;
 	dso->has_build_id = 1;
 }
 
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index eac004210b47..5a5678dbdaa5 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -260,7 +260,7 @@ bool dso__sorted_by_name(const struct dso *dso);
 void dso__set_sorted_by_name(struct dso *dso);
 void dso__sort_by_name(struct dso *dso);
 
-void dso__set_build_id(struct dso *dso, void *build_id);
+void dso__set_build_id(struct dso *dso, struct build_id *bid);
 bool dso__build_id_equal(const struct dso *dso, u8 *build_id);
 void dso__read_running_kernel_build_id(struct dso *dso,
 				       struct machine *machine);
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index fe220f01fc94..21243adbb9fd 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2082,8 +2082,10 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
 	dso = machine__findnew_dso(machine, filename);
 	if (dso != NULL) {
 		char sbuild_id[SBUILD_ID_SIZE];
+		struct build_id bid;
 
-		dso__set_build_id(dso, &bev->build_id);
+		build_id__init(&bid, bev->build_id, BUILD_ID_SIZE);
+		dso__set_build_id(dso, &bid);
 
 		if (dso_space != DSO_SPACE__USER) {
 			struct kmod_path m = { .name = NULL, };
diff --git a/tools/perf/util/symbol-minimal.c b/tools/perf/util/symbol-minimal.c
index dba6b9e5d64e..f9eb0bee7f15 100644
--- a/tools/perf/util/symbol-minimal.c
+++ b/tools/perf/util/symbol-minimal.c
@@ -349,7 +349,7 @@ int dso__load_sym(struct dso *dso, struct map *map __maybe_unused,
 		dso->is_64_bit = ret;
 
 	if (filename__read_build_id(ss->name, &bid) > 0)
-		dso__set_build_id(dso, bid.data);
+		dso__set_build_id(dso, &bid);
 	return 0;
 }
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 369cbad09f0d..976632d0baa0 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1818,7 +1818,7 @@ int dso__load(struct dso *dso, struct map *map)
 	    is_regular_file(dso->long_name)) {
 	    __symbol__join_symfs(name, PATH_MAX, dso->long_name);
 		if (filename__read_build_id(name, &bid) > 0)
-			dso__set_build_id(dso, bid.data);
+			dso__set_build_id(dso, &bid);
 	}
 
 	/*
-- 
2.26.2

