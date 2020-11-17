Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 565592B5DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728419AbgKQLCR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Nov 2020 06:02:17 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:30489 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728244AbgKQLCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:02:16 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-331-VvHP7QTLOOWQG62JG5JpHQ-1; Tue, 17 Nov 2020 06:02:10 -0500
X-MC-Unique: VvHP7QTLOOWQG62JG5JpHQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F0CF6188C122;
        Tue, 17 Nov 2020 11:02:07 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.215])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F04FF5C1CF;
        Tue, 17 Nov 2020 11:02:04 +0000 (UTC)
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
Date:   Tue, 17 Nov 2020 12:00:48 +0100
Message-Id: <20201117110053.1303113-20-jolsa@kernel.org>
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

