Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14202E2C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 23:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgLYWWP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 25 Dec 2020 17:22:15 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:41521 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726737AbgLYWWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 17:22:15 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-yx8-BJUjMk6W8PL0b8rqLQ-1; Fri, 25 Dec 2020 17:21:17 -0500
X-MC-Unique: yx8-BJUjMk6W8PL0b8rqLQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D664515720;
        Fri, 25 Dec 2020 22:21:14 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5175310013BD;
        Fri, 25 Dec 2020 22:21:10 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Alexei Budankov <abudankov@huawei.com>
Subject: [PATCH] perf tools: Detect when pipe is passed as perf data
Date:   Fri, 25 Dec 2020 23:21:09 +0100
Message-Id: <20201225222109.364465-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we allow pipe input/output only through '-' string
being passed to '-o' or '-i' options, like:

  # mkfifo perf.pipe
  # perf record --no-buffering -e 'sched:sched_switch' -o - > perf.pipe &
  [1] 354406
  # cat perf.pipe | ./perf --no-pager script -i - | head -3
            perf 354406 [000] 168190.164921: sched:sched_switch: perf:354406..
     migration/0    12 [000] 168190.164928: sched:sched_switch: migration/0:..
            perf 354406 [001] 168190.164981: sched:sched_switch: perf:354406..
  ...

This patch detects if given path is pipe and set the perf data
object accordingly, so it's possible now to do above with:

  # mkfifo perf.pipe
  # perf record --no-buffering -e 'sched:sched_switch' -o perf.pipe &
  [1] 360188
  # perf --no-pager script -i ./perf.pipe | head -3
            perf 354442 [000] 168275.464895: sched:sched_switch: perf:354442..
     migration/0    12 [000] 168275.464902: sched:sched_switch: migration/0:..
            perf 354442 [001] 168275.464953: sched:sched_switch: perf:354442..

It's of course possible to combine any of above ways.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/data.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
index f29af4fc3d09..767b6c903cf5 100644
--- a/tools/perf/util/data.c
+++ b/tools/perf/util/data.c
@@ -159,7 +159,7 @@ int perf_data__update_dir(struct perf_data *data)
 	return 0;
 }
 
-static bool check_pipe(struct perf_data *data)
+static int check_pipe(struct perf_data *data)
 {
 	struct stat st;
 	bool is_pipe = false;
@@ -172,6 +172,15 @@ static bool check_pipe(struct perf_data *data)
 	} else {
 		if (!strcmp(data->path, "-"))
 			is_pipe = true;
+		else if (!stat(data->path, &st) && S_ISFIFO(st.st_mode)) {
+			int flags = perf_data__is_read(data) ?
+				    O_RDONLY : O_WRONLY|O_CREAT|O_TRUNC;
+
+			fd = open(data->path, flags);
+			if (fd < 0)
+				return -EINVAL;
+			is_pipe = true;
+		}
 	}
 
 	if (is_pipe) {
@@ -190,7 +199,8 @@ static bool check_pipe(struct perf_data *data)
 		}
 	}
 
-	return data->is_pipe = is_pipe;
+	data->is_pipe = is_pipe;
+	return 0;
 }
 
 static int check_backup(struct perf_data *data)
@@ -344,8 +354,11 @@ static int open_dir(struct perf_data *data)
 
 int perf_data__open(struct perf_data *data)
 {
-	if (check_pipe(data))
-		return 0;
+	int err;
+
+	err = check_pipe(data);
+	if (err || data->is_pipe)
+		return err;
 
 	/* currently it allows stdio for pipe only */
 	data->use_stdio = false;
@@ -410,8 +423,10 @@ int perf_data__switch(struct perf_data *data,
 {
 	int ret;
 
-	if (check_pipe(data))
-		return -EINVAL;
+	ret = check_pipe(data);
+	if (ret || data->is_pipe)
+		return ret;
+
 	if (perf_data__is_read(data))
 		return -EINVAL;
 
-- 
2.26.2

