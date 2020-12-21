Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05D42DF962
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgLUHBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 02:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgLUHBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:01:30 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B914FC061282
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 23:00:50 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id j1so5139551pld.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 23:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LbGmfh+nRo/KTGqtMjiPUReI82gu/mZcXbqano76A2o=;
        b=q541JWr6u5Rwjy5rWh/OE9fNlL59nmcKzMt3hOMCwTj4KUkXYAj1OzUclf7lEkYgO9
         6W1FoM2XO6F3lP6CoRPsbDODN8OZ5IyRcOnlHbflIReLxse9UsKn0qQ3rCs6zxHG7dOu
         NEcEHwCgZi2LN2Kg6tYE7fzGmzxf6r58GrxGFn+MlRRJVxrySwmQS0NVbcBray766aUz
         /+b4eswpjEGiQ0aAsEZ6hWMHiDQo5UD9NSlsMt6fP1yc0NtxdPHhS+m6kaHeBgTiehLl
         Ac4S8aCkIsjg7pLDa+mW7QgeZxGHFbJK+OlA1F+1CCoQAolLJ92NE3ZfRzG7qLMxQCba
         zgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LbGmfh+nRo/KTGqtMjiPUReI82gu/mZcXbqano76A2o=;
        b=Sk0KnYYgFNczkz84lRIX3VgZ9zltma1nAR743PJc1L9dLskLYiBpuhjpfftG1iuxhT
         +qtKMnvc3xbKQV6MVWBnBQN3F62iPIoHC0KlCDDMwDeAcykCXsYOofNtZIqm/e30Hfdq
         NqJ9ajmwuqwr903OdNotYvsYj8vWy3q5aoAVSO4RMwQX83fe6FAjhX5KHiNUzkeBAIm2
         R1QMPKIqG8Pzbj7kKMzU0fpAFqZVQRwYKECuzunKPej4l1mwtb3BpjxYYVTiykXYkPfa
         /WlEc5LuNqehW/F97OBc6L0dpyFxkmZcJtn2OMyQsW2uNBPYLjLPmU1T/L4MklzmfgqU
         Ktzg==
X-Gm-Message-State: AOAM5326HZ7fhHcyKccWPbIdiYbMNSw6AYIe8eZGwDGePTPF5nrtoZcd
        g0mymsvxJ1O9bC/EMLG95ks=
X-Google-Smtp-Source: ABdhPJw6/LThwLKV1i8pencELO4lbcdg0MwrDQatGHOeUw8NTNtcrckz+SOFRX/JpOVOQiCpiUrSBw==
X-Received: by 2002:a17:90a:1748:: with SMTP id 8mr15954114pjm.47.1608534050351;
        Sun, 20 Dec 2020 23:00:50 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id p22sm16421131pgk.21.2020.12.20.23.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 23:00:49 -0800 (PST)
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
Subject: [PATCH 1/3] perf tools: Use /proc/<PID>/task/<TID>/status for synthesis
Date:   Mon, 21 Dec 2020 16:00:27 +0900
Message-Id: <20201221070029.1451176-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201221070029.1451176-1-namhyung@kernel.org>
References: <20201221070029.1451176-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To save memory usage, it needs to reduce number of entries in the proc
filesystem.  It's using /proc/<PID>/task directory to traverse threads
in the process and then kernel creates /proc/<PID>/task/<TID> entries.

After that it checks the thread info using the /proc/<TID>/status file
rather than /proc/<PID>/task/<TID>/status.  As far as I can see, they
are the same and contain all the info we need.

Using the latter eliminates the unnecessary /proc/<TID> entry.  This
can be useful especially a large number of threads are used in the
system.  In my experiment around 1KB of memory on average was saved
for each thread (which is not a thread group leader).

To do this, pass both pid and tid to perf_event_prepare_comm() if it
knows them.  In case it doesn't know, passing 0 as pid will do the old
way.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 2947e3f3c6d9..515d145a4303 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -69,7 +69,7 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
  * Assumes that the first 4095 bytes of /proc/pid/stat contains
  * the comm, tgid and ppid.
  */
-static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
+static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len,
 				    pid_t *tgid, pid_t *ppid)
 {
 	char bf[4096];
@@ -81,7 +81,10 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 	*tgid = -1;
 	*ppid = -1;
 
-	snprintf(bf, sizeof(bf), "/proc/%d/status", pid);
+	if (pid)
+		snprintf(bf, sizeof(bf), "/proc/%d/task/%d/status", pid, tid);
+	else
+		snprintf(bf, sizeof(bf), "/proc/%d/status", tid);
 
 	fd = open(bf, O_RDONLY);
 	if (fd < 0) {
@@ -93,7 +96,7 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 	close(fd);
 	if (n <= 0) {
 		pr_warning("Couldn't get COMM, tigd and ppid for pid %d\n",
-			   pid);
+			   tid);
 		return -1;
 	}
 	bf[n] = '\0';
@@ -116,27 +119,32 @@ static int perf_event__get_comm_ids(pid_t pid, char *comm, size_t len,
 		memcpy(comm, name, size);
 		comm[size] = '\0';
 	} else {
-		pr_debug("Name: string not found for pid %d\n", pid);
+		pr_debug("Name: string not found for pid %d\n", tid);
 	}
 
 	if (tgids) {
 		tgids += 5;  /* strlen("Tgid:") */
 		*tgid = atoi(tgids);
+
+		if (pid && pid != *tgid) {
+			pr_debug("Tgid: not match to given pid: %d vs %d\n",
+				 pid, *tgid);
+		}
 	} else {
-		pr_debug("Tgid: string not found for pid %d\n", pid);
+		pr_debug("Tgid: string not found for pid %d\n", tid);
 	}
 
 	if (ppids) {
 		ppids += 5;  /* strlen("PPid:") */
 		*ppid = atoi(ppids);
 	} else {
-		pr_debug("PPid: string not found for pid %d\n", pid);
+		pr_debug("PPid: string not found for pid %d\n", tid);
 	}
 
 	return 0;
 }
 
-static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
+static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t tid,
 				    struct machine *machine,
 				    pid_t *tgid, pid_t *ppid)
 {
@@ -147,7 +155,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
 	memset(&event->comm, 0, sizeof(event->comm));
 
 	if (machine__is_host(machine)) {
-		if (perf_event__get_comm_ids(pid, event->comm.comm,
+		if (perf_event__get_comm_ids(pid, tid, event->comm.comm,
 					     sizeof(event->comm.comm),
 					     tgid, ppid) != 0) {
 			return -1;
@@ -168,7 +176,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid,
 	event->comm.header.size = (sizeof(event->comm) -
 				(sizeof(event->comm.comm) - size) +
 				machine->id_hdr_size);
-	event->comm.tid = pid;
+	event->comm.tid = tid;
 
 	return 0;
 }
@@ -180,7 +188,7 @@ pid_t perf_event__synthesize_comm(struct perf_tool *tool,
 {
 	pid_t tgid, ppid;
 
-	if (perf_event__prepare_comm(event, pid, machine, &tgid, &ppid) != 0)
+	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid) != 0)
 		return -1;
 
 	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
@@ -701,7 +709,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 			continue;
 
 		rc = -1;
-		if (perf_event__prepare_comm(comm_event, _pid, machine,
+		if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
 					     &tgid, &ppid) != 0)
 			break;
 
-- 
2.29.2.684.gfbc64c5ab5-goog

