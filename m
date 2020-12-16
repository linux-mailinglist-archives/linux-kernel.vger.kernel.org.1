Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C27412DBCCC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 09:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgLPIkQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Dec 2020 03:40:16 -0500
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:38842 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbgLPIkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 03:40:16 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-AFy4c5yuN6aG1gkHhbK_nA-1; Wed, 16 Dec 2020 03:39:21 -0500
X-MC-Unique: AFy4c5yuN6aG1gkHhbK_nA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4F998144E2;
        Wed, 16 Dec 2020 08:39:18 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4A24027C56;
        Wed, 16 Dec 2020 08:39:15 +0000 (UTC)
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
Subject: [PATCHv3 0/4] perf tools: Allow to enable/disable events via control pipe
Date:   Wed, 16 Dec 2020 09:39:10 +0100
Message-Id: <20201216083914.47215-1-jolsa@kernel.org>
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

hi,
adding support to enable/disable specific events via control
file via following commands:

    # echo 'enable sched:sched_process_fork' > control
    # echo 'disabled sched:sched_process_fork' > control

v3 changes:
  - use ' ' instead of '-' in syntax and add command argument
    processing [Arnaldo]
  - add options to evlist [Arnaldo]
  - add man page changes

v2 changes:
  - added acks
  - change list to evlist [Arnaldo]
  - add evlist-verbose command [Arnaldo]
  - add '' to enale-/disable- error message

The code is available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/control

thanks,
jirka


---
Jiri Olsa (4):
      perf tools: Reformat record's control fd man text
      perf tools: Add evlist__disable_evsel/evlist__enable_evsel
      perf tools: Allow to enable/disable events via control file
      perf tools: Add evlist control command

 tools/perf/Documentation/perf-record.txt |  23 +++++++++++----
 tools/perf/builtin-record.c              |   9 ++----
 tools/perf/builtin-stat.c                |   3 +-
 tools/perf/util/evlist.c                 | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/evlist.h                 |   4 +++
 tools/perf/util/evsel_fprintf.c          |   2 ++
 tools/perf/util/python-ext-sources       |   1 +
 tools/perf/util/setup.py                 |   2 +-
 8 files changed, 197 insertions(+), 20 deletions(-)

