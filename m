Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260511E03B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 00:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388158AbgEXWm2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 May 2020 18:42:28 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43733 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387850AbgEXWm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:42:28 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-Q_-B61JIPJ25nMAk8hVtzw-1; Sun, 24 May 2020 18:42:24 -0400
X-MC-Unique: Q_-B61JIPJ25nMAk8hVtzw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2EB4D460;
        Sun, 24 May 2020 22:42:23 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.57])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 746F85D788;
        Sun, 24 May 2020 22:42:20 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [RFC 00/14] perf tests: Check on subtest for user specified test
Date:   Mon, 25 May 2020 00:42:05 +0200
Message-Id: <20200524224219.234847-1-jolsa@kernel.org>
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
changes for using metric result in another metric seem
to change lot of core metric code, so it's better we
have some more tests before we do that.

Sending as RFC as it's still alive and you guys might
have some other idea of how to do this.

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/fixes

jirka


---
Jiri Olsa (14):
      perf tests: Check on subtest for user specified test
      perf tools: Do not pass avg to generic_metric
      perf tools: Add struct parse_events_state pointer to scanner
      perf tools: Add fake pmu support
      perf tools: Add parse_events_fake interface
      perf tests: Add another pmu-events tests
      perf tools: Factor out parse_groups function
      perf tools: Add metricgroup__parse_groups_test function
      perf tools: Add fake_pmu to parse_events function
      perf tools: Add map to parse_events function
      perf tools: Factor out prepare_metric function
      perf tools: Add test_generic_metric function
      perf tests: Add parse metric test for ipc metric
      perf tests: Add parse metric test for frontend metric

 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |  38 ++++++++++++++++++++++------
 tools/perf/tests/parse-metric.c | 163 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/pmu-events.c   | 120 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/metricgroup.c   |  53 ++++++++++++++++++++++++++++++---------
 tools/perf/util/metricgroup.h   |   9 +++++++
 tools/perf/util/parse-events.c  |  73 ++++++++++++++++++++++++++++++++++++++---------------
 tools/perf/util/parse-events.h  |   6 ++++-
 tools/perf/util/parse-events.l  |  16 +++++++-----
 tools/perf/util/parse-events.y  |  37 +++++++++++++++++++++++++--
 tools/perf/util/stat-shadow.c   |  77 ++++++++++++++++++++++++++++++++++++--------------------
 tools/perf/util/stat.h          |   3 +++
 13 files changed, 521 insertions(+), 76 deletions(-)
 create mode 100644 tools/perf/tests/parse-metric.c

