Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80ABF29FD6A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 06:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725801AbgJ3Frv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 01:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgJ3Fru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 01:47:50 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5F1C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 22:47:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w65so4330578pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 22:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VwnyTi8kxdkRo7/vSuTUmIBcN5cf25ftuWDugLxHeh0=;
        b=DqjaKi0RtuB9U3JZhNu39YuM7ZL1YkfgGZbezJe8Ttsk2RQGEHEJiYypiakgDGyZRV
         nUksCdNG7frWMo7BVFugaVDkKJQjpRBo2L849F1HfHxd9PTRnMuCMurgU42e7QEJ8OXc
         bLDhreyO1++9QAY7jXTSxadd19FtRNeTBx+m5qiRijNfcctE67Ez7jFXtxHyhoHoJtgP
         EO1iNFrkFzlrZ4BL3zydu00Srk3MIG3cOV9Rl68bfIbGgpE1Wjxbki771+t3H91ejtYl
         d4dmSl+jpoDFj7wrRxq4xITTp9gtj9aeRLdVzkAeRPugdrSBPUO/Hr4UgFhB+17ndPNB
         iUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VwnyTi8kxdkRo7/vSuTUmIBcN5cf25ftuWDugLxHeh0=;
        b=Q2rfvfQDH6ivSSSj3TLUNCHpawMFqCqC9/HeB9T6zH4qmGcfjiJlEYotZrKMJ/pQto
         r9/l19t2r2eD6X7rhu1LD02SwLFaKZBq09MMqz50eTNzI64yRW9Mnz2g51u3aX3rUPnf
         pdwdRrcvZ80aHAMODYnIoAsmGetyX3Dmdogs9lgoc4oRq7WDljr61AC696scPQwb/EtV
         g7Hs4XAbZ33M7Ttuf/Jr5LfI8RgsmIapfNUBcEEi8jviN5Lncv7RS2FaVDeM/QOfqUqE
         17XPHA61WK+CHwmpd+2GfBxzNkn1wiEur0BOpisWJJa0tH+i+3fT1b7aAOx8nVzEG+Q9
         R97Q==
X-Gm-Message-State: AOAM532kTgm5oNukB451nBAie2heRys14ICCbOTtKiS/TXWLBl5zETuD
        Av8XixHUQ3QZVugjzAfSVt/szr5IVh0=
X-Google-Smtp-Source: ABdhPJxB6Dhu17Ri0BrKymGe3JOfLCEMtAVV+2hKoZT3edM8JD4f+xKSvc2HUQG11lAnSC7KBsMJuA==
X-Received: by 2002:a17:90a:6c61:: with SMTP id x88mr890841pjj.13.1604036868732;
        Thu, 29 Oct 2020 22:47:48 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id b3sm4539653pfd.66.2020.10.29.22.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 22:47:47 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH v2] perf data: Allow to use stdio functions for pipe mode
Date:   Fri, 30 Oct 2020 14:47:42 +0900
Message-Id: <20201030054742.87740-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When perf data is in a pipe, it reads each event separately using
read(2) syscall.  This is a huge performance bottleneck when
processing large data like in perf inject.  Also perf inject needs to
use write(2) syscall for the output.

So convert it to use buffer I/O functions in stdio library for pipe
data.  This makes inject-build-id bench time drops from 20ms to 8ms.

  $ perf bench internals inject-build-id
  # Running 'internals/inject-build-id' benchmark:
    Average build-id injection took: 8.074 msec (+- 0.013 msec)
    Average time per event: 0.792 usec (+- 0.001 usec)
    Average memory usage: 8328 KB (+- 0 KB)
    Average build-id-all injection took: 5.490 msec (+- 0.008 msec)
    Average time per event: 0.538 usec (+- 0.001 usec)
    Average memory usage: 7563 KB (+- 0 KB)

This patch enables it just for perf inject when used with pipe (it's a
default behavior).  Maybe we could do it for perf record and/or report
later..

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
v2: check result of fdopen()

 tools/perf/builtin-inject.c |  2 ++
 tools/perf/util/data.c      | 41 ++++++++++++++++++++++++++++++++++---
 tools/perf/util/data.h      | 11 +++++++++-
 tools/perf/util/header.c    |  8 ++++----
 tools/perf/util/session.c   |  7 ++++---
 5 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 452a75fe68e5..14d6c88fed76 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -853,10 +853,12 @@ int cmd_inject(int argc, const char **argv)
 		.output = {
 			.path = "-",
 			.mode = PERF_DATA_MODE_WRITE,
+			.use_stdio = true,
 		},
 	};
 	struct perf_data data = {
 		.mode = PERF_DATA_MODE_READ,
+		.use_stdio = true,
 	};
 	int ret;
 
diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index c47aa34fdc0a..05bbcb663c41 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -174,8 +174,21 @@ static bool check_pipe(struct perf_data *data)
 			is_pipe = true;
 	}
 
-	if (is_pipe)
-		data->file.fd = fd;
+	if (is_pipe) {
+		if (data->use_stdio) {
+			const char *mode;
+
+			mode = perf_data__is_read(data) ? "r" : "w";
+			data->file.fptr = fdopen(fd, mode);
+
+			if (data->file.fptr == NULL) {
+				data->file.fd = fd;
+				data->use_stdio = false;
+			}
+		} else {
+			data->file.fd = fd;
+		}
+	}
 
 	return data->is_pipe = is_pipe;
 }
@@ -334,6 +347,9 @@ int perf_data__open(struct perf_data *data)
 	if (check_pipe(data))
 		return 0;
 
+	/* currently it allows stdio for pipe only */
+	data->use_stdio = false;
+
 	if (!data->path)
 		data->path = "perf.data";
 
@@ -353,7 +369,21 @@ void perf_data__close(struct perf_data *data)
 		perf_data__close_dir(data);
 
 	zfree(&data->file.path);
-	close(data->file.fd);
+
+	if (data->use_stdio)
+		fclose(data->file.fptr);
+	else
+		close(data->file.fd);
+}
+
+ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size)
+{
+	if (data->use_stdio) {
+		if (fread(buf, size, 1, data->file.fptr) == 1)
+			return size;
+		return feof(data->file.fptr) ? 0 : -1;
+	}
+	return readn(data->file.fd, buf, size);
 }
 
 ssize_t perf_data_file__write(struct perf_data_file *file,
@@ -365,6 +395,11 @@ ssize_t perf_data_file__write(struct perf_data_file *file,
 ssize_t perf_data__write(struct perf_data *data,
 			      void *buf, size_t size)
 {
+	if (data->use_stdio) {
+		if (fwrite(buf, size, 1, data->file.fptr) == 1)
+			return size;
+		return -1;
+	}
 	return perf_data_file__write(&data->file, buf, size);
 }
 
diff --git a/tools/perf/util/data.h b/tools/perf/util/data.h
index 75947ef6bc17..c563fcbb0288 100644
--- a/tools/perf/util/data.h
+++ b/tools/perf/util/data.h
@@ -2,6 +2,7 @@
 #ifndef __PERF_DATA_H
 #define __PERF_DATA_H
 
+#include <stdio.h>
 #include <stdbool.h>
 
 enum perf_data_mode {
@@ -16,7 +17,10 @@ enum perf_dir_version {
 
 struct perf_data_file {
 	char		*path;
-	int		 fd;
+	union {
+		int	 fd;
+		FILE	*fptr;
+	};
 	unsigned long	 size;
 };
 
@@ -26,6 +30,7 @@ struct perf_data {
 	bool			 is_pipe;
 	bool			 is_dir;
 	bool			 force;
+	bool			 use_stdio;
 	enum perf_data_mode	 mode;
 
 	struct {
@@ -62,11 +67,15 @@ static inline bool perf_data__is_single_file(struct perf_data *data)
 
 static inline int perf_data__fd(struct perf_data *data)
 {
+	if (data->use_stdio)
+		return fileno(data->file.fptr);
+
 	return data->file.fd;
 }
 
 int perf_data__open(struct perf_data *data);
 void perf_data__close(struct perf_data *data);
+ssize_t perf_data__read(struct perf_data *data, void *buf, size_t size);
 ssize_t perf_data__write(struct perf_data *data,
 			      void *buf, size_t size);
 ssize_t perf_data_file__write(struct perf_data_file *file,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index be850e9f8852..d9a70154426b 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3652,7 +3652,8 @@ static int perf_file_section__process(struct perf_file_section *section,
 }
 
 static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
-				       struct perf_header *ph, int fd,
+				       struct perf_header *ph,
+				       struct perf_data* data,
 				       bool repipe)
 {
 	struct feat_fd ff = {
@@ -3661,7 +3662,7 @@ static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
 	};
 	ssize_t ret;
 
-	ret = readn(fd, header, sizeof(*header));
+	ret = perf_data__read(data, header, sizeof(*header));
 	if (ret <= 0)
 		return -1;
 
@@ -3684,8 +3685,7 @@ static int perf_header__read_pipe(struct perf_session *session)
 	struct perf_header *header = &session->header;
 	struct perf_pipe_file_header f_header;
 
-	if (perf_file_header__read_pipe(&f_header, header,
-					perf_data__fd(session->data),
+	if (perf_file_header__read_pipe(&f_header, header, session->data,
 					session->repipe) < 0) {
 		pr_debug("incompatible file format\n");
 		return -EINVAL;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7a5f03764702..f901a09a58e4 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1923,7 +1923,6 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
 	struct perf_tool *tool = session->tool;
-	int fd = perf_data__fd(session->data);
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
 	void *buf = NULL;
@@ -1943,7 +1942,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	ordered_events__set_copy_on_queue(oe, true);
 more:
 	event = buf;
-	err = readn(fd, event, sizeof(struct perf_event_header));
+	err = perf_data__read(session->data, event,
+			      sizeof(struct perf_event_header));
 	if (err <= 0) {
 		if (err == 0)
 			goto done;
@@ -1975,7 +1975,8 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	p += sizeof(struct perf_event_header);
 
 	if (size - sizeof(struct perf_event_header)) {
-		err = readn(fd, p, size - sizeof(struct perf_event_header));
+		err = perf_data__read(session->data, p,
+				      size - sizeof(struct perf_event_header));
 		if (err <= 0) {
 			if (err == 0) {
 				pr_err("unexpected end of event stream\n");
-- 
2.29.1.341.ge80a0c044ae-goog

