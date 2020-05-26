Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F070F1D796E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 May 2020 15:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgERNO5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 18 May 2020 09:14:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726726AbgERNO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:14:57 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-391-gq5wpV5ePDuOeX6TD6W-eQ-1; Mon, 18 May 2020 09:14:51 -0400
X-MC-Unique: gq5wpV5ePDuOeX6TD6W-eQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D0F78015CF;
        Mon, 18 May 2020 13:14:49 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.196.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1BDCF2E162;
        Mon, 18 May 2020 13:14:46 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf stat: Fix duration_time value for higher intervals
Date:   Mon, 18 May 2020 15:14:45 +0200
Message-Id: <20200518131445.3745083-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joakim reported wrong duration_time value for interval bigger
than 4000 [1].

The problem is in the interval value we pass to update_stats
function, which is typed as 'unsigned int' and overflows when
we get over 2^32 (happens between intervals 4000 and 5000).

Retyping the passed value to unsigned long long.

[1] https://www.spinics.net/lists/linux-perf-users/msg11777.html

Reported-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-stat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index e0c1ad23c768..4deb2d46a343 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -367,7 +367,7 @@ static void process_interval(void)
 	}
 
 	init_stats(&walltime_nsecs_stats);
-	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000);
+	update_stats(&walltime_nsecs_stats, stat_config.interval * 1000000ULL);
 	print_counters(&rs, 0, NULL);
 }
 
-- 
2.25.4

