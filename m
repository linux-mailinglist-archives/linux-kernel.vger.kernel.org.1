Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAE862DF964
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgLUHBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 02:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLUHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:01:38 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B91DC061248
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 23:00:58 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id x18so5134293pln.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 23:00:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zNwWyHkyFILM41lxkbjS+HGdU5eVMTl0rtQqNyOUFp8=;
        b=efhu74cBo8U4zZFq8vaXAmAj+uhQS1onbmxQx9cwTEB1KedauswyIWWDi4UXg1Wycb
         ZJ0wPJSz2Jqyx7LZqJM3ZrLIFJgKQtZA6bUlGdZCW4VXpyx2prF5Lbs+B2xzk4s3IDk3
         lnmYqkjMUjT1WvbRMiAL9dzJcEPIL2viyxprXg0F5QarpkhRiNNMhzZ+1fMPO56YtSWk
         vJD5CD221qun1CTEEttnQ7CAqxxgjk3Mifv79b3U/vxhefr0aUTbRS1IuVlp1upPL4DL
         UDSJ8iWwkv0Nlyh7d6Q7US84gdLg2PKQ5vatToi69wCUkQQM2oTXeK3IJTvXsGpeRY49
         sJjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zNwWyHkyFILM41lxkbjS+HGdU5eVMTl0rtQqNyOUFp8=;
        b=oxDrOEH/oY7xBYvq944DKTg14rYWqtbDlTPC3AHTgwX3WOqCyww+CdbmiTZT/s9wYQ
         vr/DPx1kSMAxeXheeoOys1Brp8jfg9DfbwP+NUsJYiebO/q4YmGX4SRhsXhd2GFq2j3z
         V3UWVkK8OW7P0UbhlrDsuWkIkiXLsVTt0xjFFgGDO6v0WjLhgeHmyyLl69/S4RdFl0Hg
         jWOjA0oAh4BGDwjwbSgiptFemovbRPSIraBg+BOB07/PPZE+hf9SqmkfDv3lolr1YnTz
         vxS37VNQoIRkXjTvOBCwPTs3Al1DO1ectaNc/ObOF3/b5NlROoAmbygj1pB0s+0xou87
         Y5pQ==
X-Gm-Message-State: AOAM531cE+oT8seQZAleHTomSKRHiegYrCudjQ0wYiahfcqmmhN322Xd
        u88aYBhQlQ0PoRQLTN3w/n4=
X-Google-Smtp-Source: ABdhPJzQZOsxZtd1Uyymz9/0Uu1iHNZMJnPSX+GveIY0I3DsKDypcHyxAgxbF/31l25C2QRxeKQcRQ==
X-Received: by 2002:a17:902:eb54:b029:da:29d7:cffd with SMTP id i20-20020a170902eb54b02900da29d7cffdmr15215700pli.28.1608534058075;
        Sun, 20 Dec 2020 23:00:58 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id p22sm16421131pgk.21.2020.12.20.23.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 23:00:57 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCH 3/3] perf tools: Use scandir() to iterate threads
Date:   Mon, 21 Dec 2020 16:00:29 +0900
Message-Id: <20201221070029.1451176-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201221070029.1451176-1-namhyung@kernel.org>
References: <20201221070029.1451176-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like in __event__synthesize_thread(), I think it's better to use
scandir() instead of the readdir() loop.  In case some malicious task
continues to create new threads, the readdir() loop will run over and
over to collect tids.  The scandir() also has the problem but the
window is much smaller since it doesn't do much work during the
iteration.

Also add filter_task() function as we only care the tasks.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 153a822f411a..36cda93318a4 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -664,6 +664,11 @@ int perf_event__synthesize_modules(struct perf_tool *tool, perf_event__handler_t
 	return rc;
 }
 
+static int filter_task(const struct dirent *dirent)
+{
+	return isdigit(dirent->d_name[0]);
+}
+
 static int __event__synthesize_thread(union perf_event *comm_event,
 				      union perf_event *mmap_event,
 				      union perf_event *fork_event,
@@ -672,10 +677,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 				      struct perf_tool *tool, struct machine *machine, bool mmap_data)
 {
 	char filename[PATH_MAX];
-	DIR *tasks;
-	struct dirent *dirent;
+	struct dirent **dirent;
 	pid_t tgid, ppid;
 	int rc = 0;
+	int i, n;
 
 	/* special case: only send one comm event using passed in pid */
 	if (!full) {
@@ -707,18 +712,16 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	snprintf(filename, sizeof(filename), "%s/proc/%d/task",
 		 machine->root_dir, pid);
 
-	tasks = opendir(filename);
-	if (tasks == NULL) {
-		pr_debug("couldn't open %s\n", filename);
-		return 0;
-	}
+	n = scandir(filename, &dirent, filter_task, alphasort);
+	if (n < 0)
+		return n;
 
-	while ((dirent = readdir(tasks)) != NULL) {
+	for (i = 0; i < n; i++) {
 		char *end;
 		pid_t _pid;
 		bool kernel_thread;
 
-		_pid = strtol(dirent->d_name, &end, 10);
+		_pid = strtol(dirent[i]->d_name, &end, 10);
 		if (*end)
 			continue;
 
@@ -751,7 +754,10 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 		}
 	}
 
-	closedir(tasks);
+	for (i = 0; i < n; i++)
+		zfree(&dirent[i]);
+	free(dirent);
+
 	return rc;
 }
 
@@ -936,7 +942,7 @@ int perf_event__synthesize_threads(struct perf_tool *tool,
 		return 0;
 
 	snprintf(proc_path, sizeof(proc_path), "%s/proc", machine->root_dir);
-	n = scandir(proc_path, &dirent, 0, alphasort);
+	n = scandir(proc_path, &dirent, filter_task, alphasort);
 	if (n < 0)
 		return err;
 
-- 
2.29.2.684.gfbc64c5ab5-goog

