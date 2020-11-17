Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2BA32B5DCF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbgKQLBt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:01:49 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:44056 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727526AbgKQLBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:01:48 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-93oHMsH6N5-Ogo1uGM_CPg-1; Tue, 17 Nov 2020 06:01:40 -0500
X-MC-Unique: 93oHMsH6N5-Ogo1uGM_CPg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8089E83DAA1;
        Tue, 17 Nov 2020 11:01:37 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 10F615C1CF;
        Tue, 17 Nov 2020 11:01:33 +0000 (UTC)
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
Subject: [PATCH 10/24] perf tools: Use struct extra_kernel_map in machine__process_kernel_mmap_event
Date:   Tue, 17 Nov 2020 12:00:39 +0100
Message-Id: <20201117110053.1303113-11-jolsa@kernel.org>
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

Using struct extra_kernel_map in machine__process_kernel_mmap_event,
to pass mmap details. This way we can used single function for all 3
mmap versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/machine.c | 62 +++++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 15385ea00190..1ae32a81639c 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1581,32 +1581,25 @@ static bool machine__uses_kcore(struct machine *machine)
 }
 
 static bool perf_event__is_extra_kernel_mmap(struct machine *machine,
-					     union perf_event *event)
+					     struct extra_kernel_map *xm)
 {
 	return machine__is(machine, "x86_64") &&
-	       is_entry_trampoline(event->mmap.filename);
+	       is_entry_trampoline(xm->name);
 }
 
 static int machine__process_extra_kernel_map(struct machine *machine,
-					     union perf_event *event)
+					     struct extra_kernel_map *xm)
 {
 	struct dso *kernel = machine__kernel_dso(machine);
-	struct extra_kernel_map xm = {
-		.start = event->mmap.start,
-		.end   = event->mmap.start + event->mmap.len,
-		.pgoff = event->mmap.pgoff,
-	};
 
 	if (kernel == NULL)
 		return -1;
 
-	strlcpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
-
-	return machine__create_extra_kernel_map(machine, kernel, &xm);
+	return machine__create_extra_kernel_map(machine, kernel, xm);
 }
 
 static int machine__process_kernel_mmap_event(struct machine *machine,
-					      union perf_event *event)
+					      struct extra_kernel_map *xm)
 {
 	struct map *map;
 	enum dso_space_type dso_space;
@@ -1621,20 +1614,18 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 	else
 		dso_space = DSO_SPACE__KERNEL_GUEST;
 
-	is_kernel_mmap = memcmp(event->mmap.filename,
-				machine->mmap_name,
+	is_kernel_mmap = memcmp(xm->name, machine->mmap_name,
 				strlen(machine->mmap_name) - 1) == 0;
-	if (event->mmap.filename[0] == '/' ||
-	    (!is_kernel_mmap && event->mmap.filename[0] == '[')) {
-		map = machine__addnew_module_map(machine, event->mmap.start,
-						 event->mmap.filename);
+	if (xm->name[0] == '/' ||
+	    (!is_kernel_mmap && xm->name[0] == '[')) {
+		map = machine__addnew_module_map(machine, xm->start,
+						 xm->name);
 		if (map == NULL)
 			goto out_problem;
 
-		map->end = map->start + event->mmap.len;
+		map->end = map->start + xm->end - xm->start;
 	} else if (is_kernel_mmap) {
-		const char *symbol_name = (event->mmap.filename +
-				strlen(machine->mmap_name));
+		const char *symbol_name = (xm->name + strlen(machine->mmap_name));
 		/*
 		 * Should be there already, from the build-id table in
 		 * the header.
@@ -1688,18 +1679,17 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 		if (strstr(kernel->long_name, "vmlinux"))
 			dso__set_short_name(kernel, "[kernel.vmlinux]", false);
 
-		machine__update_kernel_mmap(machine, event->mmap.start,
-					 event->mmap.start + event->mmap.len);
+		machine__update_kernel_mmap(machine, xm->start, xm->end);
 
 		/*
 		 * Avoid using a zero address (kptr_restrict) for the ref reloc
 		 * symbol. Effectively having zero here means that at record
 		 * time /proc/sys/kernel/kptr_restrict was non zero.
 		 */
-		if (event->mmap.pgoff != 0) {
+		if (xm->pgoff != 0) {
 			map__set_kallsyms_ref_reloc_sym(machine->vmlinux_map,
 							symbol_name,
-							event->mmap.pgoff);
+							xm->pgoff);
 		}
 
 		if (machine__is_default_guest(machine)) {
@@ -1708,8 +1698,8 @@ static int machine__process_kernel_mmap_event(struct machine *machine,
 			 */
 			dso__load(kernel, machine__kernel_map(machine));
 		}
-	} else if (perf_event__is_extra_kernel_mmap(machine, event)) {
-		return machine__process_extra_kernel_map(machine, event);
+	} else if (perf_event__is_extra_kernel_mmap(machine, xm)) {
+		return machine__process_extra_kernel_map(machine, xm);
 	}
 	return 0;
 out_problem:
@@ -1735,7 +1725,14 @@ int machine__process_mmap2_event(struct machine *machine,
 
 	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
 	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
-		ret = machine__process_kernel_mmap_event(machine, event);
+		struct extra_kernel_map xm = {
+			.start = event->mmap2.start,
+			.end   = event->mmap2.start + event->mmap2.len,
+			.pgoff = event->mmap2.pgoff,
+		};
+
+		strlcpy(xm.name, event->mmap2.filename, KMAP_NAME_LEN);
+		ret = machine__process_kernel_mmap_event(machine, &xm);
 		if (ret < 0)
 			goto out_problem;
 		return 0;
@@ -1785,7 +1782,14 @@ int machine__process_mmap_event(struct machine *machine, union perf_event *event
 
 	if (sample->cpumode == PERF_RECORD_MISC_GUEST_KERNEL ||
 	    sample->cpumode == PERF_RECORD_MISC_KERNEL) {
-		ret = machine__process_kernel_mmap_event(machine, event);
+		struct extra_kernel_map xm = {
+			.start = event->mmap.start,
+			.end   = event->mmap.start + event->mmap.len,
+			.pgoff = event->mmap.pgoff,
+		};
+
+		strlcpy(xm.name, event->mmap.filename, KMAP_NAME_LEN);
+		ret = machine__process_kernel_mmap_event(machine, &xm);
 		if (ret < 0)
 			goto out_problem;
 		return 0;
-- 
2.26.2

