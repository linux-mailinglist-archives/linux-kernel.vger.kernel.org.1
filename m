Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872C626813C
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 23:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725986AbgIMVDs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 13 Sep 2020 17:03:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33758 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725968AbgIMVDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 17:03:42 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-KDjRN5-RMfKk6dQltk75jw-1; Sun, 13 Sep 2020 17:03:34 -0400
X-MC-Unique: KDjRN5-RMfKk6dQltk75jw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 554C6185A0E5;
        Sun, 13 Sep 2020 21:03:32 +0000 (UTC)
Received: from krava.redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CAC471002393;
        Sun, 13 Sep 2020 21:03:27 +0000 (UTC)
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
Subject: [PATCH 03/26] tools headers uapi: Sync tools/include/uapi/linux/perf_event.h
Date:   Sun, 13 Sep 2020 23:02:50 +0200
Message-Id: <20200913210313.1985612-4-jolsa@kernel.org>
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

Sync uapi header with kernel version for mmap3 support.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/include/uapi/linux/perf_event.h | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 3e5dcdd48a49..84a0cbdab1ef 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -384,7 +384,8 @@ struct perf_event_attr {
 				aux_output     :  1, /* generate AUX records instead of events */
 				cgroup         :  1, /* include cgroup events */
 				text_poke      :  1, /* include text poke events */
-				__reserved_1   : 30;
+				mmap3          :  1, /* include bpf events */
+				__reserved_1   : 29;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -1060,6 +1061,30 @@ enum perf_event_type {
 	 */
 	PERF_RECORD_TEXT_POKE			= 20,
 
+	/*
+	 * The MMAP3 records are an augmented version of MMAP2, they add
+	 * build id value to identify the exact binary behind map
+	 *
+	 * struct {
+	 *	struct perf_event_header	header;
+	 *
+	 *	u32				pid, tid;
+	 *	u64				addr;
+	 *	u64				len;
+	 *	u64				pgoff;
+	 *	u32				maj;
+	 *	u32				min;
+	 *	u64				ino;
+	 *	u64				ino_generation;
+	 *	u32				prot, flags;
+	 *	u32				reserved;
+	 *	u8				buildid[20];
+	 *	char				filename[];
+	 *	struct sample_id		sample_id;
+	 * };
+	 */
+	PERF_RECORD_MMAP3			= 21,
+
 	PERF_RECORD_MAX,			/* non-ABI */
 };
 
-- 
2.26.2

