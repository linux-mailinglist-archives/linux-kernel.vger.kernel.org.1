Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165CE28139F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgJBND1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbgJBND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:03:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6A7C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 06:03:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 34so718198pgo.13
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 06:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4xZ5EYYns03kDlVvnSnxF9IyFS/XusvQnaTuU2Hepc=;
        b=CbvuUoEnrk1PA5MQYsauC9+ISrkNCfTuIh4HG4IpQZ3HUdWQxzzI9pfIFhxSuCow8o
         q5u7i8fu8geRhIcqVmMqZQH0WI3U/7bRrr84p0PU1sUEk6yLGEuy2Jkbo+xYSuzzU6Jx
         C+yyOYYZ4Fly+cMwrODGS0fbrar991+/z2O2VgqAby6RKz90DeOGNjOyx6gjelMtwbA1
         IfDXSLwkBdRvg3PRc2JUkhQgKWJhDKEkefhFjYHxN/gJEye0zMi9qJWrPN9ZwI1eS8qe
         KGdSBWqgk5UrwAm0Sd91vcX+eQodnwpLWh6M3vs6COD4MobYMmUaBl/IMoq83AJ4U/6+
         ZVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=U4xZ5EYYns03kDlVvnSnxF9IyFS/XusvQnaTuU2Hepc=;
        b=P2ECVviczUI0X9Ulj1YsIrA5DT+Ttx6cbHAmiI2YY1CrFrotxMLa2cluGZRFr/2oHM
         d3X80xVkp0XvEH4wyDxDi6/x6WwOSq1erQ/p8mmeZegOU47/U5GVavwsmVwh13Ro9fmM
         rwf6l/Q6ahg9gtWHLthHNqSluG8gKYObqulaJsWR5AwKII8I0vK/uh+GDsSWP6wsrlmi
         1jSv1/9sMb6pl4mrrwUoSc2gNk4YqCtljtVVB6WbnHXzgYA7xbL7cXGTfqR4qiZ7zAgP
         PMUwTNQz+3NPXLY+uw63TBBzSTkWOt+YCDvem5oeTWXCIH3Bi99d1stnQDxGn8n1JDUf
         ej2Q==
X-Gm-Message-State: AOAM531hDYWgtkHM4A5LGhaG5pMe/3bFVWBIPGxHk6ip2YGYNTQ+5c5l
        AUcmWaUxstswhaazLJtDHBQ=
X-Google-Smtp-Source: ABdhPJz4aZBYJB5ajlDzO5OIl8xGFGXjXqzQUJNG/XjsTqisBpn7feYqLokrcbqhSfuzfqGV4siHYg==
X-Received: by 2002:a63:4611:: with SMTP id t17mr2035104pga.225.1601643806815;
        Fri, 02 Oct 2020 06:03:26 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id j19sm2001234pfi.51.2020.10.02.06.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 06:03:25 -0700 (PDT)
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
        Ian Rogers <irogers@google.com>,
        Al Grant <al.grant@foss.arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH] perf inject: Flush ordered events on FINISHED_ROUND
Date:   Fri,  2 Oct 2020 22:03:17 +0900
Message-Id: <20201002130317.1356440-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.806.g8561365e88-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf inject just repipes the event without any flush.  It
makes an issue that it changes the order of events processed.

Normally we want to process events in time order, but events are
recorded from several cpus and they weren't sorted with each other.
So we put them into the ordered event queue, sorted by time, and flush
them when we see a next FINISHED_ROUND event.

But this is for events from kernel, user space events (like the
FINISHED_ROUND) are processed without queueing.  So during the perf
inject, it writes all the FINISHED_ROUND events directly while
SAMPLE (and other) events are kept in the queue.  This makes the user
space events are put before any kernel events.

You can see that with the following command:

  $ perf record -a -o- sleep 1 | perf inject -b | perf script -i- --show-round-events
  PERF_RECORD_FINISHED_ROUND
  PERF_RECORD_FINISHED_ROUND
  PERF_RECORD_FINISHED_ROUND
  ...

Omitting perf inject, you can see the events are placed in the middle
of the data.

You might argue that the whole point of the FINISHED_ROUND event is to
sort (kernel) events.  And after perf inject, all events are written
in a proper time order so we don't care about the FINISHED_ROUND event
anymore.

But the problem is we don't know whether the input data is sorted or
not (maybe we can add a feature bit for this?) so it should use an
ordered event queue when processing the input like in perf report.

Remember all the FINISHED_ROUND events now come before other events so
the tool cannot know when it can flush the data so everything will be
queued until it meets the end of the input.  Actually it's same for
perf inject itself as it doesn't flush the queue.

Below measures time and memory usage during the perf inject and
report using ~190MB data file.

Before:
  perf inject:  11.09 s,  382148 KB
  perf report:   8.05 s,  397440 KB

After:
  perf inject:  16.24 s,   83376 KB
  perf report:   7.96 s,  216184 KB

As you can see, it used 2x memory of the input size.  I guess it's
because it needs to keep the copy for the whole input.  But I don't
understand why processing time of perf inject increased..

I'm not sure how it affects the auxtrace, but it should be fine IMHO.

Cc: Al Grant <al.grant@foss.arm.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-inject.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 6d2f410d773a..9fa78a9edfc5 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -79,6 +79,7 @@ static int perf_event__repipe_oe_synth(struct perf_tool *tool,
 				       union perf_event *event,
 				       struct ordered_events *oe __maybe_unused)
 {
+	ordered_events__flush(oe, OE_FLUSH__ROUND);
 	return perf_event__repipe_synth(tool, event);
 }
 
-- 
2.28.0.806.g8561365e88-goog

