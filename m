Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 403A92DBCCD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgLPIkV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Dec 2020 03:40:21 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:49869 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726230AbgLPIkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:40:21 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-423-jJGH1L-GPQegysLIIHqAUw-1; Wed, 16 Dec 2020 03:39:24 -0500
X-MC-Unique: jJGH1L-GPQegysLIIHqAUw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77E5B9CDA2;
        Wed, 16 Dec 2020 08:39:22 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71E4F27C5D;
        Wed, 16 Dec 2020 08:39:19 +0000 (UTC)
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
Subject: [PATCH 1/4] perf tools: Reformat record's control fd man text
Date:   Wed, 16 Dec 2020 09:39:11 +0100
Message-Id: <20201216083914.47215-2-jolsa@kernel.org>
In-Reply-To: <20201216083914.47215-1-jolsa@kernel.org>
References: <20201216083914.47215-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding available control commands in separate paragraph,
so it's more readable and easier to add new commands.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-record.txt | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 768888b9326a..f896c4b791e1 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -634,11 +634,17 @@ endif::HAVE_LIBPFM[]
 --control=fifo:ctl-fifo[,ack-fifo]::
 --control=fd:ctl-fd[,ack-fd]::
 ctl-fifo / ack-fifo are opened and used as ctl-fd / ack-fd as follows.
-Listen on ctl-fd descriptor for command to control measurement ('enable': enable events,
-'disable': disable events, 'snapshot': AUX area tracing snapshot). Measurements can be
-started with events disabled using --delay=-1 option. Optionally send control command
-completion ('ack\n') to ack-fd descriptor to synchronize with the controlling process.
-Example of bash shell script to enable and disable events during measurements:
+Listen on ctl-fd descriptor for command to control measurement.
+
+Available commands:
+  'enable'  : enable events
+  'disable' : disable events
+  'snapshot': AUX area tracing snapshot).
+
+Measurements can be started with events disabled using --delay=-1 option. Optionally
+send control command completion ('ack\n') to ack-fd descriptor to synchronize with the
+controlling process.  Example of bash shell script to enable and disable events during
+measurements:
 
  #!/bin/bash
 
-- 
2.26.2

