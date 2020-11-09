Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A670C2AC7C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 22:55:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731850AbgKIVzk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Nov 2020 16:55:40 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:59686 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731787AbgKIVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:55:35 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-LT5BGdzNNqKQgtLRBgii_A-1; Mon, 09 Nov 2020 16:55:33 -0500
X-MC-Unique: LT5BGdzNNqKQgtLRBgii_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B62581007462;
        Mon,  9 Nov 2020 21:55:30 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B0F196EF51;
        Mon,  9 Nov 2020 21:55:27 +0000 (UTC)
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
Subject: [PATCH 19/24] perf tools: Add is_perf_data function
Date:   Mon,  9 Nov 2020 22:54:10 +0100
Message-Id: <20201109215415.400153-20-jolsa@kernel.org>
In-Reply-To: <20201109215415.400153-1-jolsa@kernel.org>
References: <20201109215415.400153-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding is_perf_data function that returns true if
the given path is perf data file. It will be used
in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 19 +++++++++++++++++++
 tools/perf/util/data.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index c47aa34fdc0a..be049e812f5a 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -457,3 +457,22 @@ char *perf_data__kallsyms_name(struct perf_data *data)
 
 	return kallsyms_name;
 }
+
+bool is_perf_data(const char *path)
+{
+	bool ret = false;
+	FILE *file;
+	u64 magic;
+
+	file = fopen(path, "r");
+	if (!file)
+		return false;
+
+	if (fread(&magic, 1, 8, file) < 8)
+		goto out;
+
+	ret = is_perf_magic(magic);
+out:
+	fclose(file);
+	return ret;
+}
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 75947ef6bc17..0ebb1568ca86 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -89,4 +89,5 @@ int perf_data__update_dir(struct perf_data *data);
 unsigned long perf_data__size(struct perf_data *data);
 int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz);
 char *perf_data__kallsyms_name(struct perf_data *data);
+bool is_perf_data(const char *path);
 #endif /* __PERF_DATA_H */
-- 
2.26.2

