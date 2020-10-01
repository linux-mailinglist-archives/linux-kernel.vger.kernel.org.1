Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5951A2800C3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732708AbgJAOBy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:01:54 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38402 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732631AbgJAOB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:01:28 -0400
Received: by mail-ot1-f65.google.com with SMTP id y5so5473368otg.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dkQF7DvTSC9CPOZZu+OAO4xFJ9IXxZzAk+3xCUAYAZA=;
        b=DohUQOSz28UZcKUVLAv4o3AMYzIoQanQoSRPgynH/Sbo3/S1K93uNRh2nYxPHIkyPP
         Br8L9EiZm+ND4eg64NHmsRkxhMqrVPvClW0E/WgOGq0/oIxxTLakIrS8Z6dyx7FrVFux
         TFGDXZJY7UkftIvUSx9PeTxv7BJISxXtiuK7HXUJl4pcJtvaro1iTOum6L1Y4DxTolEf
         NF46CP7KG+HlqNsjJ/L7l1TM6uPHaBHziW53RXLT2aALyY5+mSHBGOUETIFfQAi1q54Q
         vM465DVCK3hq248VOgqz4/IfZldqjnvEuvyM3Aqde9IdtgV5D7omMj9NOJHYixD5ECnY
         +kTw==
X-Gm-Message-State: AOAM533p0iVnyUNetAt/rXaVZuG5xpRbe/ipTs4zzv95UfXVQI3IbwwK
        21c+cr9LxidCORs05k1C0A==
X-Google-Smtp-Source: ABdhPJybh3/RgITfg8GFa3MCC8rKjgcLOpY9D5WH0zUgt1jM7dKKybQFHCo2h4gdhJT0bCwhtSKbsA==
X-Received: by 2002:a9d:17ed:: with SMTP id j100mr4977798otj.350.1601560884910;
        Thu, 01 Oct 2020 07:01:24 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id q81sm1032138oia.46.2020.10.01.07.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:01:24 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v4 4/9] libperf: Add libperf_evsel__mmap()
Date:   Thu,  1 Oct 2020 09:01:11 -0500
Message-Id: <20201001140116.651970-5-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201001140116.651970-1-robh@kernel.org>
References: <20201001140116.651970-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to support usersapce access, an event must be mmapped. While
there's already mmap support for evlist, the usecase is a bit different
than the self monitoring with userspace access. So let's add a new
perf_evsel__mmap() function to mmap an evsel. This allows implementing
userspace access as a fastpath for perf_evsel__read().

The mmapped address is returned by perf_evsel__mmap() primarily for
users/tests to check if userspace access is enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v4:
 - Change perf_evsel__mmap size to pages instead of bytes
v3:
 - New patch split out from user access patch

mmap fix
---
 tools/lib/perf/Documentation/libperf.txt |  1 +
 tools/lib/perf/evsel.c                   | 31 ++++++++++++++++++++++++
 tools/lib/perf/include/internal/evsel.h  |  2 ++
 tools/lib/perf/include/perf/evsel.h      |  2 ++
 tools/lib/perf/libperf.map               |  1 +
 5 files changed, 37 insertions(+)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 0c74c30ed23a..d2a541e7a7ec 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -136,6 +136,7 @@ SYNOPSIS
                        struct perf_thread_map *threads);
   void perf_evsel__close(struct perf_evsel *evsel);
   void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+  void *perf_evsel__mmap(struct perf_evsel *evsel, int pages);
   int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
                        struct perf_counts_values *count);
   int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 4dc06289f4c7..42eaf3c18981 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -11,10 +11,12 @@
 #include <stdlib.h>
 #include <internal/xyarray.h>
 #include <internal/cpumap.h>
+#include <internal/mmap.h>
 #include <internal/threadmap.h>
 #include <internal/lib.h>
 #include <linux/string.h>
 #include <sys/ioctl.h>
+#include <sys/mman.h>
 
 void perf_evsel__init(struct perf_evsel *evsel, struct perf_event_attr *attr)
 {
@@ -156,6 +158,35 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
 	perf_evsel__close_fd_cpu(evsel, cpu);
 }
 
+void *perf_evsel__mmap(struct perf_evsel *evsel, int pages)
+{
+	int ret;
+	struct perf_mmap *map;
+	struct perf_mmap_param mp = {
+		.prot = PROT_READ | PROT_WRITE,
+	};
+
+	if (FD(evsel, 0, 0) < 0)
+		return NULL;
+
+	mp.mask = (pages * page_size) - 1;
+
+	map = zalloc(sizeof(*map));
+	if (!map)
+		return NULL;
+
+	perf_mmap__init(map, NULL, false, NULL);
+
+	ret = perf_mmap__mmap(map, &mp, FD(evsel, 0, 0), 0);
+	if (ret) {
+		free(map);
+		return NULL;
+	}
+
+	evsel->mmap = map;
+	return map->base;
+}
+
 int perf_evsel__read_size(struct perf_evsel *evsel)
 {
 	u64 read_format = evsel->attr.read_format;
diff --git a/tools/lib/perf/include/internal/evsel.h b/tools/lib/perf/include/internal/evsel.h
index 1ffd083b235e..a7985dbb68ff 100644
--- a/tools/lib/perf/include/internal/evsel.h
+++ b/tools/lib/perf/include/internal/evsel.h
@@ -9,6 +9,7 @@
 
 struct perf_cpu_map;
 struct perf_thread_map;
+struct perf_mmap;
 struct xyarray;
 
 /*
@@ -40,6 +41,7 @@ struct perf_evsel {
 	struct perf_cpu_map	*cpus;
 	struct perf_cpu_map	*own_cpus;
 	struct perf_thread_map	*threads;
+	struct perf_mmap	*mmap;
 	struct xyarray		*fd;
 	struct xyarray		*sample_id;
 	u64			*id;
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index c82ec39a4ad0..1b1534439334 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -3,6 +3,7 @@
 #define __LIBPERF_EVSEL_H
 
 #include <stdint.h>
+#include <stddef.h>
 #include <perf/core.h>
 
 struct perf_evsel;
@@ -27,6 +28,7 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
 				 struct perf_thread_map *threads);
 LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
 LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+LIBPERF_API void *perf_evsel__mmap(struct perf_evsel *evsel, int pages);
 LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 7be1af8a546c..733a0647be8b 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -23,6 +23,7 @@ LIBPERF_0.0.1 {
 		perf_evsel__disable;
 		perf_evsel__open;
 		perf_evsel__close;
+		perf_evsel__mmap;
 		perf_evsel__read;
 		perf_evsel__cpus;
 		perf_evsel__threads;
-- 
2.25.1

