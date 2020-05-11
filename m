Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECE61CE605
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 22:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbgEKUxV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 11 May 2020 16:53:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39517 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727873AbgEKUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:53:21 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-RQ4zLB1gNv6FU3FCOjtiRg-1; Mon, 11 May 2020 16:53:13 -0400
X-MC-Unique: RQ4zLB1gNv6FU3FCOjtiRg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B6BAD1005510;
        Mon, 11 May 2020 20:53:11 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D35C6444B;
        Mon, 11 May 2020 20:53:08 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Joe Mario <jmario@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCHv3 0/4] perf tools: Add support for user defined metric
Date:   Mon, 11 May 2020 22:53:03 +0200
Message-Id: <20200511205307.3107775-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
Joe asked for possibility to add user defined metrics. Given that
we already have metrics support, I added --metrics-file option that
allows to specify custom metrics.

  $ cat metrics
  # IPC
  mine1 = instructions / cycles;
  /* DECODED_ICACHE_UOPS% */
  mine2 = 100 * (idq.dsb_uops / \ (idq.ms_uops + idq.mite_uops + idq.dsb_uops + lsd.uops));

  $ sudo perf stat --metrics-file ./metrics -M mine1,mine2 --metric-only -a -I 1000
  #           time       insn per cycle                mine1                mine2
       1.000536263                0.71                   0.7                 41.4
       2.002069025                0.31                   0.3                 14.1
       3.003427684                0.27                   0.3                 14.8
       4.004807132                0.25                   0.2                 12.1
  ...

v3 changes:
  - added doc for metrics file in perf stat man page
  - reporting error line number now
  - changed '#' style comment to C way with '//'

v2 changes:
  - add new --metrics-file option
  - rebased on current perf/core expression bison/flex enhancements

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/metric

thanks,
jirka


---
Jiri Olsa (4):
      perf expr: Add parsing support for multiple expressions
      perf expr: Allow comments in custom metric file
      perf stat: Add --metrics-file option
      perf expr: Report line number with error

 tools/perf/Documentation/perf-stat.txt | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/builtin-stat.c              |  7 +++++--
 tools/perf/tests/expr.c                | 18 ++++++++++++++++++
 tools/perf/util/expr.c                 |  6 ++++++
 tools/perf/util/expr.h                 | 21 +++++++++++++++++++--
 tools/perf/util/expr.l                 | 34 ++++++++++++++++++++++++++++++++++
 tools/perf/util/expr.y                 | 21 +++++++++++++++++----
 tools/perf/util/metricgroup.c          | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 tools/perf/util/metricgroup.h          |  3 ++-
 tools/perf/util/stat.h                 |  1 +
 10 files changed, 242 insertions(+), 16 deletions(-)

