Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B0F1A85EA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440707AbgDNQvi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440391AbgDNQtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:20 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 567D22076C;
        Tue, 14 Apr 2020 16:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882950;
        bh=kjNU8gkJH0MuwVzru11aJkVZj5ZBZx/fNWrBzMDaFgI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OrlZkcWaTwuSoDJ5Sr0lNxMuyaLW87+joKMjI4013YrfOPVX66DkOznAp6eI+dCFo
         P+vL/+GkMkVw2BUyYT/CITXiZtvsSU42KATNahDIbqh+qj6XiL3p62m5IiEeIAfSEb
         AyTDMFhz45k/YelbeCOLntOoZhoCIfm8fU4xfAWA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/15] perf stat: Fix no metric header if --per-socket and --metric-only set
Date:   Tue, 14 Apr 2020 13:48:42 -0300
Message-Id: <20200414164854.26026-4-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200414164854.26026-1-acme@kernel.org>
References: <20200414164854.26026-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

We received a report that was no metric header displayed if --per-socket
and --metric-only were both set.

It's hard for script to parse the perf-stat output. This patch fixes this
issue.

Before:

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
  ^C
   Performance counter stats for 'system wide':

  S0        8                  2.6

         2.215270071 seconds time elapsed

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
  #           time socket cpus
       1.000411692 S0        8                  2.2
       2.001547952 S0        8                  3.4
       3.002446511 S0        8                  3.4
       4.003346157 S0        8                  4.0
       5.004245736 S0        8                  0.3

After:

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket
  ^C
   Performance counter stats for 'system wide':

                               CPI
  S0        8                  2.1

         1.813579830 seconds time elapsed

  root@kbl-ppc:~# perf stat -a -M CPI --metric-only --per-socket -I1000
  #           time socket cpus                  CPI
       1.000415122 S0        8                  3.2
       2.001630051 S0        8                  2.9
       3.002612278 S0        8                  4.3
       4.003523594 S0        8                  3.0
       5.004504256 S0        8                  3.7

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200331180226.25915-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-shadow.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 0fd713d3674f..03ecb8cd0eec 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -803,8 +803,11 @@ static void generic_metric(struct perf_stat_config *config,
 				     out->force_header ?
 				     (metric_name ? metric_name : name) : "", 0);
 		}
-	} else
-		print_metric(config, ctxp, NULL, NULL, "", 0);
+	} else {
+		print_metric(config, ctxp, NULL, NULL,
+			     out->force_header ?
+			     (metric_name ? metric_name : name) : "", 0);
+	}
 
 	for (i = 1; i < pctx.num_ids; i++)
 		zfree(&pctx.ids[i].name);
-- 
2.21.1

