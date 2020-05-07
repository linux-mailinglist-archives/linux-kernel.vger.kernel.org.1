Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3140A1C861A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 11:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbgEGJue convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 May 2020 05:50:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46915 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgEGJud (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:50:33 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-q6wu39kwO9S6RlXaw1RTZA-1; Thu, 07 May 2020 05:50:29 -0400
X-MC-Unique: q6wu39kwO9S6RlXaw1RTZA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 91E50100CCC3;
        Thu,  7 May 2020 09:50:27 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44FD110013BD;
        Thu,  7 May 2020 09:50:25 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, Paul Khuong <pvk@pvk.ca>
Subject: [PATCH 0/5] perf tools: Pipe fixes
Date:   Thu,  7 May 2020 11:50:19 +0200
Message-Id: <20200507095024.2789147-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
sending changes that allows callchain detection in pipe mode,
fixing followign use case:

  # perf record --no-buffering --call-graph dwarf -e sdt_rtld:init_start -a -o - | perf --no-pager script -i -

plus change that allows to read pipe data from file:

  # perf record -o - sleep 1 > /tmp/perf.pipe.data
  # perf report -i /tmp/perf.pipe.data

plus unrelated build fix.

Also reachable in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/pipe

thanks,
jirka


---
Jiri Olsa (5):
      perf tools: Do not display extra info when there is nothing to build
      perf tools: Do not seek in pipe fd during tracing data processing
      perf session: Try to read pipe data from file
      perf tools: Setup callchain properly in pipe mode
      perf script: Enable IP fields for callchains

 tools/perf/Makefile.perf    |  8 +++++---
 tools/perf/builtin-report.c | 33 ++++++++++++++++++++++-----------
 tools/perf/builtin-script.c | 23 +++++++++++++++++++----
 tools/perf/util/callchain.c | 14 ++++++++++++++
 tools/perf/util/callchain.h |  1 +
 tools/perf/util/header.c    | 34 ++++++++++++++++++++++++++--------
 tools/perf/util/session.c   |  9 +++++++--
 7 files changed, 94 insertions(+), 28 deletions(-)

