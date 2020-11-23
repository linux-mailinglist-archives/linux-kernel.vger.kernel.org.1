Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4E32C1949
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 00:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388401AbgKWXIj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 18:08:39 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:33613 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388267AbgKWXGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 18:06:44 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-HeU2SR4oMQW01Wh3ODaRpA-1; Mon, 23 Nov 2020 18:06:36 -0500
X-MC-Unique: HeU2SR4oMQW01Wh3ODaRpA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CAAF1100A241;
        Mon, 23 Nov 2020 23:06:34 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.195.242])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D62AB5D9CA;
        Mon, 23 Nov 2020 23:06:31 +0000 (UTC)
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
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 20/25] perf tools: Add is_perf_data function
Date:   Tue, 24 Nov 2020 00:05:07 +0100
Message-Id: <20201123230512.2097312-21-jolsa@kernel.org>
In-Reply-To: <20201123230512.2097312-1-jolsa@kernel.org>
References: <20201123230512.2097312-1-jolsa@kernel.org>
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

Adding is_perf_data function that returns true if
the given path is perf data file. It will be used
in following patches.

Acked-by: Ian Rogers <irogers@google.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 19 +++++++++++++++++++
 tools/perf/util/data.h |  1 +
 2 files changed, 20 insertions(+)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index 05bbcb663c41..f29af4fc3d09 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -492,3 +492,22 @@ char *perf_data__kallsyms_name(struct perf_data *data)
 
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
index c563fcbb0288..62a3e66fbee8 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -98,4 +98,5 @@ int perf_data__update_dir(struct perf_data *data);
 unsigned long perf_data__size(struct perf_data *data);
 int perf_data__make_kcore_dir(struct perf_data *data, char *buf, size_t buf_sz);
 char *perf_data__kallsyms_name(struct perf_data *data);
+bool is_perf_data(const char *path);
 #endif /* __PERF_DATA_H */
-- 
2.26.2

