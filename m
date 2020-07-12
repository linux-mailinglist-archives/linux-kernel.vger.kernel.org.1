Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07921C96B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jul 2020 15:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgGLN0t convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 12 Jul 2020 09:26:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:48916 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728852AbgGLN0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 09:26:48 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-VRxbgCoXNuOq8qkexqad2g-1; Sun, 12 Jul 2020 09:26:41 -0400
X-MC-Unique: VRxbgCoXNuOq8qkexqad2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B97B10059AF;
        Sun, 12 Jul 2020 13:26:39 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01E171944D;
        Sun, 12 Jul 2020 13:26:35 +0000 (UTC)
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
Subject: [PATCH 00/18] perf metric: Add support to reuse metric
Date:   Sun, 12 Jul 2020 15:26:16 +0200
Message-Id: <20200712132634.138901-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset is adding the support to reused metric in another 
metric. The metric needs to be referenced by 'metric:' prefix.

For example, to define IPC by using CPI with change like:

         "BriefDescription": "Instructions Per Cycle (per Logical Processor)",
 -       "MetricExpr": "INST_RETIRED.ANY / CPU_CLK_UNHALTED.THREAD",
 +       "MetricExpr": "1/metric:CPI",
         "MetricGroup": "TopDownL1",
         "MetricName": "IPC"

I won't be able to find all the possible places we could
use this at, so I wonder you guys (who was asking for this)
would try it and come up with comments if there's something
missing or we could already use it at some places.

It's based on Arnaldo's tmp.perf/core.

v2 changes:
  - collected Ian's acks for few patches [Ian]
  - renamed expr__add_id to expr__add_id_val [Ian]
  - renamed expr_parse_data to expr_id_data [Ian]
  - added recursion check [Ian]
  - added metric test for DCache_L2 metric [Ian]
  - added some renames as discussed in review [Ian]

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/metric

thanks,
jirka


---
Jiri Olsa (18):
      perf metric: Rename expr__add_id to expr__add_val
      perf metric: Add struct expr_id_data to keep expr value
      perf metric: Add expr__add_id function
      perf metric: Change expr__get_id to return struct expr_id_data
      perf metric: Add expr__del_id function
      perf metric: Add find_metric function
      perf metric: Add add_metric function
      perf metric: Rename __metricgroup__add_metric to __add_metric
      perf metric: Collect referenced metrics in struct metric_ref_node
      perf metric: Collect referenced metrics in struct metric_expr
      perf metric: Add referenced metrics to hash data
      perf metric: Compute referenced metrics
      perf metric: Add events for the current group
      perf metric: Add cache_miss_cycles to metric parse test
      perf metric: Add DCache_L2 to metric parse test
      perf metric: Add recursion check when processing nested metrics
      perf metric: Rename struct egroup to metric
      perf metric: Rename group_list to list

 tools/perf/tests/expr.c         |   7 +-
 tools/perf/tests/parse-metric.c | 131 +++++++++++++++++++++++++++++++++++-
 tools/perf/tests/pmu-events.c   |   4 +-
 tools/perf/util/expr.c          | 130 ++++++++++++++++++++++++++++++------
 tools/perf/util/expr.h          |  34 +++++++++-
 tools/perf/util/expr.y          |  16 +++--
 tools/perf/util/metricgroup.c   | 435 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------
 tools/perf/util/metricgroup.h   |   6 ++
 tools/perf/util/stat-shadow.c   |  24 ++++---
 9 files changed, 644 insertions(+), 143 deletions(-)

