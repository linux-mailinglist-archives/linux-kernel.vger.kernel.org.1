Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7932DF963
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 08:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgLUHBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 02:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgLUHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 02:01:34 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4752C061285
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 23:00:54 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id x1so218214pgh.12
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 23:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqYPBSj9wtFQoEAQnUVXrDYYsikzNSMJn+10PikmMVg=;
        b=HxM2WEcvSvVmBvm7OdKOsjDMmMXlVEUvrQ6r7PHLq5sIh00y/KCzmZh0ECubXrVMzB
         nZ1KFoQOt61QjmUR06ErTvp1PYrBaaLlxKYzrm9e27LTrVrmPaQVlzxeunfjG3AVVOCR
         Lse848vlnA+IvSK5UMwlSjQXuw8di++HWPGaFZWapUQI64uvZ9CRjLaDFn4od2qlr67+
         MiizdWqGNLEtUINalVFldfMc0AxnJzzzMWWTYI+0GwVXUgTKirIdqbYEpwV/csjzD4zB
         GKdck2EcN9rqcQPOCHbvfYfAuQqkJ60MDlOFR2bkVUmdV/SBqcGyMPody10Pt9yBt+d9
         gWvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EqYPBSj9wtFQoEAQnUVXrDYYsikzNSMJn+10PikmMVg=;
        b=RTmhDDx9F+HX6GZmqqixVvKqkWaqUjrU5UsEcp908yyPdQawn598exRv/yJjlUaLBd
         O7h948qM6GhmPBaSPJsSo+kMCftPpxHqQgWMatCw/qHPYxc3d3x5UmcKjvuYZtT5I3r8
         9dT3DnfZ1VRB9GfFwIJzsWJ7uJPM8kH1c3XlYjMz711nOB4VzWghyN8ZX9166NcY8XbX
         JT8IZs+75riLzQDm51TbCo0I6apU5b+0TQaF4/3rT0ElDlMnom8xjabRLoKqk1wRNR+8
         96UPxlTQAZNfIZwOuKCWJsXQmvIdxxiFm5LpONuUmDl3KE6bnjdnsAJbU2ceWAERabNF
         P3Lg==
X-Gm-Message-State: AOAM5333ZClvxQsDfbBfbPkM5bRheZe7ThqXoOhmnLVqEcups2Bz700P
        TIOIyso6FYh3W87Bd/wPCYg=
X-Google-Smtp-Source: ABdhPJyqViDgvO5ExQetwSl/ViYwxFNZnZ5WT+KjshyexZ5Fc3oIZASgk9no3iON0es/PeH6p0Tijg==
X-Received: by 2002:aa7:954c:0:b029:1a6:2130:db4f with SMTP id w12-20020aa7954c0000b02901a62130db4fmr14268872pfq.68.1608534054296;
        Sun, 20 Dec 2020 23:00:54 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id p22sm16421131pgk.21.2020.12.20.23.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Dec 2020 23:00:53 -0800 (PST)
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
Subject: [PATCH 2/3] perf tools: Skip MMAP record synthesis for kernel threads
Date:   Mon, 21 Dec 2020 16:00:28 +0900
Message-Id: <20201221070029.1451176-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.2.684.gfbc64c5ab5-goog
In-Reply-To: <20201221070029.1451176-1-namhyung@kernel.org>
References: <20201221070029.1451176-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To synthesize information to resolve sample IPs, it needs to scan task
and mmap info from the /proc filesystem.  For each process, it
opens (and reads) status and maps file respectively.  But as kernel
threads don't have memory maps so we can skip the maps file.

To find kernel threads, check "VmPeak:" line in /proc/<PID>/status
file.  It's about the peak virtual memory usage so only user-level
tasks have that.  Also check "Threads:" line (which follows the VmPeak
line whether or not it exists) to be sure it's read enough data - just
in case of deeply nested pid namespaces or large number of
supplementary groups are involved.

This is for user process:

  $ head -40 /proc/1/status
  Name:	systemd
  Umask:	0000
  State:	S (sleeping)
  Tgid:	1
  Ngid:	0
  Pid:	1
  PPid:	0
  TracerPid:	0
  Uid:	0	0	0	0
  Gid:	0	0	0	0
  FDSize:	256
  Groups:
  NStgid:	1
  NSpid:	1
  NSpgid:	1
  NSsid:	1
  VmPeak:	  234192 kB           <-- here
  VmSize:	  169964 kB
  VmLck:	       0 kB
  VmPin:	       0 kB
  VmHWM:	   29528 kB
  VmRSS:	    6104 kB
  RssAnon:	    2756 kB
  RssFile:	    3348 kB
  RssShmem:	       0 kB
  VmData:	   19776 kB
  VmStk:	    1036 kB
  VmExe:	     784 kB
  VmLib:	    9532 kB
  VmPTE:	     116 kB
  VmSwap:	    2400 kB
  HugetlbPages:	       0 kB
  CoreDumping:	0
  THP_enabled:	1
  Threads:	1                     <-- and here
  SigQ:	1/62808
  SigPnd:	0000000000000000
  ShdPnd:	0000000000000000
  SigBlk:	7be3c0fe28014a03
  SigIgn:	0000000000001000

And this is for kernel thread:

  $ head -20 /proc/2/status
  Name:	kthreadd
  Umask:	0000
  State:	S (sleeping)
  Tgid:	2
  Ngid:	0
  Pid:	2
  PPid:	0
  TracerPid:	0
  Uid:	0	0	0	0
  Gid:	0	0	0	0
  FDSize:	64
  Groups:
  NStgid:	2
  NSpid:	2
  NSpgid:	0
  NSsid:	0
  Threads:	1                     <-- here
  SigQ:	1/62808
  SigPnd:	0000000000000000
  ShdPnd:	0000000000000000

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/synthetic-events.c | 32 +++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synthetic-events.c
index 515d145a4303..153a822f411a 100644
--- a/tools/perf/util/synthetic-events.c
+++ b/tools/perf/util/synthetic-events.c
@@ -70,13 +70,13 @@ int perf_tool__process_synth_event(struct perf_tool *tool,
  * the comm, tgid and ppid.
  */
 static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len,
-				    pid_t *tgid, pid_t *ppid)
+				    pid_t *tgid, pid_t *ppid, bool *kernel)
 {
 	char bf[4096];
 	int fd;
 	size_t size = 0;
 	ssize_t n;
-	char *name, *tgids, *ppids;
+	char *name, *tgids, *ppids, *vmpeak, *threads;
 
 	*tgid = -1;
 	*ppid = -1;
@@ -102,8 +102,14 @@ static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len
 	bf[n] = '\0';
 
 	name = strstr(bf, "Name:");
-	tgids = strstr(bf, "Tgid:");
-	ppids = strstr(bf, "PPid:");
+	tgids = strstr(name ?: bf, "Tgid:");
+	ppids = strstr(tgids ?: bf, "PPid:");
+	vmpeak = strstr(ppids ?: bf, "VmPeak:");
+
+	if (vmpeak)
+		threads = NULL;
+	else
+		threads = strstr(ppids ?: bf, "Threads:");
 
 	if (name) {
 		char *nl;
@@ -141,12 +147,17 @@ static int perf_event__get_comm_ids(pid_t pid, pid_t tid, char *comm, size_t len
 		pr_debug("PPid: string not found for pid %d\n", tid);
 	}
 
+	if (!vmpeak && threads)
+		*kernel = true;
+	else
+		*kernel = false;
+
 	return 0;
 }
 
 static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t tid,
 				    struct machine *machine,
-				    pid_t *tgid, pid_t *ppid)
+				    pid_t *tgid, pid_t *ppid, bool *kernel)
 {
 	size_t size;
 
@@ -157,7 +168,7 @@ static int perf_event__prepare_comm(union perf_event *event, pid_t pid, pid_t ti
 	if (machine__is_host(machine)) {
 		if (perf_event__get_comm_ids(pid, tid, event->comm.comm,
 					     sizeof(event->comm.comm),
-					     tgid, ppid) != 0) {
+					     tgid, ppid, kernel) != 0) {
 			return -1;
 		}
 	} else {
@@ -187,8 +198,10 @@ pid_t perf_event__synthesize_comm(struct perf_tool *tool,
 					 struct machine *machine)
 {
 	pid_t tgid, ppid;
+	bool kernel_thread;
 
-	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid) != 0)
+	if (perf_event__prepare_comm(event, 0, pid, machine, &tgid, &ppid,
+				     &kernel_thread) != 0)
 		return -1;
 
 	if (perf_tool__process_synth_event(tool, event, machine, process) != 0)
@@ -703,6 +716,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 	while ((dirent = readdir(tasks)) != NULL) {
 		char *end;
 		pid_t _pid;
+		bool kernel_thread;
 
 		_pid = strtol(dirent->d_name, &end, 10);
 		if (*end)
@@ -710,7 +724,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 
 		rc = -1;
 		if (perf_event__prepare_comm(comm_event, pid, _pid, machine,
-					     &tgid, &ppid) != 0)
+					     &tgid, &ppid, &kernel_thread) != 0)
 			break;
 
 		if (perf_event__synthesize_fork(tool, fork_event, _pid, tgid,
@@ -728,7 +742,7 @@ static int __event__synthesize_thread(union perf_event *comm_event,
 			break;
 
 		rc = 0;
-		if (_pid == pid) {
+		if (_pid == pid && !kernel_thread) {
 			/* process the parent's maps too */
 			rc = perf_event__synthesize_mmap_events(tool, mmap_event, pid, tgid,
 						process, machine, mmap_data);
-- 
2.29.2.684.gfbc64c5ab5-goog

