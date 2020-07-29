Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8752A231BEA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 11:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgG2JTW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 29 Jul 2020 05:19:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52380 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727849AbgG2JTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 05:19:22 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-zvOwstDRNwOF9G991N9Nbw-1; Wed, 29 Jul 2020 05:19:14 -0400
X-MC-Unique: zvOwstDRNwOF9G991N9Nbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0A98800597;
        Wed, 29 Jul 2020 09:19:12 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 802F26931E;
        Wed, 29 Jul 2020 09:19:09 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>,
        "Paul A. Clarke" <pc@us.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHv4 00/19] perf metric: Add support to reuse metric
Date:   Wed, 29 Jul 2020 11:18:49 +0200
Message-Id: <20200729091908.1378911-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset is adding the support to reused metric in
another metric.

For example, to define IPC by using CPI with change like:

     {
         "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
-        "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
+        "MetricExpr": "1/CPI",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"
     },

I won't be able to find all the possible places we could
use this at, so I wonder you guys (who was asking for this)
would try it and come up with comments if there's something
missing or we could already use it at some places.

It's based on Arnaldo's tmp.perf/core.

v4 changes:
  - removed acks from patch because it changed a bit
    with the last fixes:
      perf metric: Collect referenced metrics in struct metric_ref_node
  - fixed runtime metrics [Kajol Jain]
  - increased recursion depth [Paul A. Clarke]
  - changed patches due to dependencies:
      perf metric: Collect referenced metrics in struct metric_ref_node
      perf metric: Add recursion check when processing nested metrics
      perf metric: Rename struct egroup to metric
      perf metric: Rename group_list to metric_list

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/metric

thanks,
jirka


---
Jiri Olsa (19):
      perf metric: Fix memory leak in expr__add_id function
      perf metric: Add expr__add_id function
      perf metric: Change expr__get_id to return struct expr_id_data
      perf metric: Add expr__del_id function
      perf metric: Add macros for iterating map events
      perf metric: Add add_metric function
      perf metric: Rename __metricgroup__add_metric to __add_metric
      perf metric: Collect referenced metrics in struct metric_ref_node
      perf metric: Collect referenced metrics in struct metric_expr
      perf metric: Add referenced metrics to hash data
      perf metric: Compute referenced metrics
      perf metric: Add events for the current list
      perf metric: Add cache_miss_cycles to metric parse test
      perf metric: Add DCache_L2 to metric parse test
      perf metric: Add recursion check when processing nested metrics
      perf metric: Make compute_single function more precise
      perf metric: Add metric group test
      perf metric: Rename struct egroup to metric
      perf metric: Rename group_list to metric_list

 tools/perf/tests/parse-metric.c | 206 +++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/expr.c          | 143 ++++++++++++++++++++++++++++++++-----
 tools/perf/util/expr.h          |  30 +++++++-
 tools/perf/util/expr.y          |  16 +++--
 tools/perf/util/metricgroup.c   | 466 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 tools/perf/util/metricgroup.h   |   6 ++
 tools/perf/util/stat-shadow.c   |  20 ++++--
 7 files changed, 751 insertions(+), 136 deletions(-)

