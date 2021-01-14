Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B792F57D5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbhANCIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:08:43 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40709 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbhANCGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 21:06:55 -0500
Received: by mail-ot1-f54.google.com with SMTP id j12so3884362ota.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 18:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=19ZI5vNaZSMV5qOXQ4UaWWHPq4LdWixWHPxUm9A8S0w=;
        b=OFHGmB/ctlj87g7ka00nob7on8IGJx6uSqSotQ0uuQkLW8qrm/v63Hvo4swzicWotJ
         0GG35anka0erAHrkeBUM8tgeRXL6uzICKkuuTHaS2g+nxI02X8Chu/r3FEdm/3PX1iBi
         oXEKSA8toIxIJEyYDzP8vI2th+XJQITODxmqfd9PYK/CVUWce5kcSIceVUB8tdQhjpKZ
         z4r8fG96EUhqA1Oxmbbvo0eHEqy0NJCsj+9oEaBYrqA59AZofTJ++hUEmvvc+Mzf8NUG
         m+fh0aVFYfGtME+BDBl9sMzBf+JalOQRy3W8RCOS5IFso97ywNqrE0guxdCNMIZZsCQu
         I09A==
X-Gm-Message-State: AOAM530F5t8CTBzoddFkijBEfU3xCVSr4L/882gYUe9BSJetNS+einlr
        rco9a8nnwOo6ONhaPXNaUA==
X-Google-Smtp-Source: ABdhPJymLqLDbJBmwJ33e5CHUghWSTOxu+smnIRjUXQSiVsLvBX4NlV+hH2yQayb8psjCIbBvmbRYQ==
X-Received: by 2002:a05:6830:1e41:: with SMTP id e1mr3140165otj.143.1610589974132;
        Wed, 13 Jan 2021 18:06:14 -0800 (PST)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id x20sm814272oov.33.2021.01.13.18.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 18:06:13 -0800 (PST)
From:   Rob Herring <robh@kernel.org>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Raphael Gault <raphael.gault@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ian Rogers <irogers@google.com>, honnappa.nagarahalli@arm.com,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: [PATCH v5 4/9] libperf: Add evsel mmap support
Date:   Wed, 13 Jan 2021 20:06:00 -0600
Message-Id: <20210114020605.3943992-5-robh@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210114020605.3943992-1-robh@kernel.org>
References: <20210114020605.3943992-1-robh@kernel.org>
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

The mmapped address is returned by perf_evsel__mmap_base() which
primarily for users/tests to check if userspace access is enabled.

Signed-off-by: Rob Herring <robh@kernel.org>
---
v5:
 - Create an mmap for every underlying event opened. Due to this, we
   need a different way to get the mmap ptr, so perf_evsel__mmap_base()
   is introduced.
v4:
 - Change perf_evsel__mmap size to pages instead of bytes
v3:
 - New patch split out from user access patch
---
 tools/lib/perf/Documentation/libperf.txt |  2 +
 tools/lib/perf/evsel.c                   | 47 +++++++++++++++++++++++-
 tools/lib/perf/include/internal/evsel.h  |  2 +
 tools/lib/perf/include/perf/evsel.h      |  2 +
 tools/lib/perf/libperf.map               |  2 +
 5 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/Documentation/libperf.txt b/tools/lib/perf/Documentation/libperf.txt
index 0c74c30ed23a..a2c73df191ca 100644
--- a/tools/lib/perf/Documentation/libperf.txt
+++ b/tools/lib/perf/Documentation/libperf.txt
@@ -136,6 +136,8 @@ SYNOPSIS
                        struct perf_thread_map *threads);
   void perf_evsel__close(struct perf_evsel *evsel);
   void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+  int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
+  void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
   int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
                        struct perf_counts_values *count);
   int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 4dc06289f4c7..0b5bdf4badae 100644
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
@@ -37,11 +39,17 @@ void perf_evsel__delete(struct perf_evsel *evsel)
 	free(evsel);
 }
 
-#define FD(e, x, y) (*(int *) xyarray__entry(e->fd, x, y))
+struct evsel_fd {
+	int fd;
+	struct perf_mmap mmap;
+};
+
+#define FD(e, x, y) ((struct evsel_fd *) xyarray__entry(e->fd, x, y))->fd
+#define MMAP(e, x, y) (&(((struct evsel_fd *) xyarray__entry(e->fd, x, y))->mmap))
 
 int perf_evsel__alloc_fd(struct perf_evsel *evsel, int ncpus, int nthreads)
 {
-	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(int));
+	evsel->fd = xyarray__new(ncpus, nthreads, sizeof(struct evsel_fd));
 
 	if (evsel->fd) {
 		int cpu, thread;
@@ -156,6 +164,41 @@ void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu)
 	perf_evsel__close_fd_cpu(evsel, cpu);
 }
 
+int perf_evsel__mmap(struct perf_evsel *evsel, int pages)
+{
+	int ret, cpu, thread;
+	struct perf_mmap_param mp = {
+		.prot = PROT_READ | PROT_WRITE,
+		.mask = (pages * page_size) - 1,
+	};
+
+	for (cpu = 0; cpu < xyarray__max_x(evsel->fd); cpu++) {
+		for (thread = 0; thread < xyarray__max_y(evsel->fd); thread++) {
+			int fd = FD(evsel, cpu, thread);
+			struct perf_mmap *map = MMAP(evsel, cpu, thread);
+
+			if (fd < 0)
+				continue;
+
+			perf_mmap__init(map, NULL, false, NULL);
+
+			ret = perf_mmap__mmap(map, &mp, fd, cpu);
+			if (ret)
+				return -1;
+		}
+	}
+
+	return 0;
+}
+
+void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread)
+{
+	if (FD(evsel, cpu, thread) < 0)
+		return NULL;
+
+	return MMAP(evsel, cpu, thread)->base;
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
index c82ec39a4ad0..9f5265f2f39f 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -27,6 +27,8 @@ LIBPERF_API int perf_evsel__open(struct perf_evsel *evsel, struct perf_cpu_map *
 				 struct perf_thread_map *threads);
 LIBPERF_API void perf_evsel__close(struct perf_evsel *evsel);
 LIBPERF_API void perf_evsel__close_cpu(struct perf_evsel *evsel, int cpu);
+LIBPERF_API int perf_evsel__mmap(struct perf_evsel *evsel, int pages);
+LIBPERF_API void *perf_evsel__mmap_base(struct perf_evsel *evsel, int cpu, int thread);
 LIBPERF_API int perf_evsel__read(struct perf_evsel *evsel, int cpu, int thread,
 				 struct perf_counts_values *count);
 LIBPERF_API int perf_evsel__enable(struct perf_evsel *evsel);
diff --git a/tools/lib/perf/libperf.map b/tools/lib/perf/libperf.map
index 7be1af8a546c..0b993de15830 100644
--- a/tools/lib/perf/libperf.map
+++ b/tools/lib/perf/libperf.map
@@ -23,6 +23,8 @@ LIBPERF_0.0.1 {
 		perf_evsel__disable;
 		perf_evsel__open;
 		perf_evsel__close;
+		perf_evsel__mmap;
+		perf_evsel__mmap_base;
 		perf_evsel__read;
 		perf_evsel__cpus;
 		perf_evsel__threads;
-- 
2.27.0

