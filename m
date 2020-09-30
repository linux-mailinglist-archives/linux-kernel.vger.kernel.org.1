Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2FE27F00C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbgI3RPn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 13:15:43 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:31699 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731381AbgI3RPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:15:42 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-YGlB20FQMrGkdTvBwTCCdA-1; Wed, 30 Sep 2020 13:15:39 -0400
X-MC-Unique: YGlB20FQMrGkdTvBwTCCdA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 751EA1040C23;
        Wed, 30 Sep 2020 17:15:37 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37269702E7;
        Wed, 30 Sep 2020 17:15:35 +0000 (UTC)
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
Subject: [PATCH 8/9] perf tools: Add size to struct perf_record_header_build_id
Date:   Wed, 30 Sep 2020 19:15:11 +0200
Message-Id: <20200930171512.3986425-9-jolsa@kernel.org>
In-Reply-To: <20200930171512.3986425-1-jolsa@kernel.org>
References: <20200930171512.3986425-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not store size with build ids in perf data,
but there's enough space to do it. Adding misc bit
PERF_RECORD_MISC_BUILD_ID_SIZE to mark build id event
with size.

With this fix the dso with md5 build id will have correct
build id data and will be usable for debuginfod processing
if needed (coming in following patches).

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/lib/perf/include/perf/event.h | 12 +++++++++++-
 tools/perf/util/build-id.c          |  8 +++++---
 tools/perf/util/header.c            | 10 +++++++---
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index a6dbba6b9073..988c539bedb6 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -201,10 +201,20 @@ struct perf_record_header_tracing_data {
 	__u32			 size;
 };
 
+#define PERF_RECORD_MISC_BUILD_ID_SIZE (1 << 15)
+
 struct perf_record_header_build_id {
 	struct perf_event_header header;
 	pid_t			 pid;
-	__u8			 build_id[24];
+	union {
+		__u8		 build_id[24];
+		struct {
+			__u8	 data[20];
+			__u8	 size;
+			__u8	 reserved1__;
+			__u16	 reserved2__;
+		};
+	};
 	char			 filename[];
 };
 
diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
index b5648735f01f..8763772f1095 100644
--- a/tools/perf/util/build-id.c
+++ b/tools/perf/util/build-id.c
@@ -296,7 +296,7 @@ char *dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
 			continue;		\
 		else
 
-static int write_buildid(const char *name, size_t name_len, u8 *build_id,
+static int write_buildid(const char *name, size_t name_len, struct build_id *bid,
 			 pid_t pid, u16 misc, struct feat_fd *fd)
 {
 	int err;
@@ -307,7 +307,9 @@ static int write_buildid(const char *name, size_t name_len, u8 *build_id,
 	len = PERF_ALIGN(len, NAME_ALIGN);
 
 	memset(&b, 0, sizeof(b));
-	memcpy(&b.build_id, build_id, BUILD_ID_SIZE);
+	memcpy(&b.data, bid->data, bid->size);
+	b.size = (u8) bid->size;
+	misc |= PERF_RECORD_MISC_BUILD_ID_SIZE;
 	b.pid = pid;
 	b.header.misc = misc;
 	b.header.size = sizeof(b) + len;
@@ -354,7 +356,7 @@ static int machine__write_buildid_table(struct machine *machine,
 		in_kernel = pos->kernel ||
 				is_kernel_module(name,
 					PERF_RECORD_MISC_CPUMODE_UNKNOWN);
-		err = write_buildid(name, name_len, pos->bid.data, machine->pid,
+		err = write_buildid(name, name_len, &pos->bid, machine->pid,
 				    in_kernel ? kmisc : umisc, fd);
 		if (err)
 			break;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 21243adbb9fd..8da3886f10a8 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2083,8 +2083,12 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
 	if (dso != NULL) {
 		char sbuild_id[SBUILD_ID_SIZE];
 		struct build_id bid;
+		size_t size = BUILD_ID_SIZE;
 
-		build_id__init(&bid, bev->build_id, BUILD_ID_SIZE);
+		if (bev->header.misc & PERF_RECORD_MISC_BUILD_ID_SIZE)
+			size = bev->size;
+
+		build_id__init(&bid, bev->data, size);
 		dso__set_build_id(dso, &bid);
 
 		if (dso_space != DSO_SPACE__USER) {
@@ -2098,8 +2102,8 @@ static int __event_process_build_id(struct perf_record_header_build_id *bev,
 		}
 
 		build_id__sprintf(&dso->bid, sbuild_id);
-		pr_debug("build id event received for %s: %s\n",
-			 dso->long_name, sbuild_id);
+		pr_debug("build id event received for %s: %s [%lu]\n",
+			 dso->long_name, sbuild_id, size);
 		dso__put(dso);
 	}
 
-- 
2.26.2

