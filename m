Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740002E2F5C
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 00:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbgLZXVk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 26 Dec 2020 18:21:40 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:51606 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725881AbgLZXVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 18:21:40 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-291-tP3-julGNSKbuBvy45weLw-1; Sat, 26 Dec 2020 18:20:44 -0500
X-MC-Unique: tP3-julGNSKbuBvy45weLw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8493A1005504;
        Sat, 26 Dec 2020 23:20:42 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.7])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4597560C0F;
        Sat, 26 Dec 2020 23:20:39 +0000 (UTC)
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
Subject: [PATCHv4 0/4] perf tools: Allow to enable/disable events via control pipe
Date:   Sun, 27 Dec 2020 00:20:34 +0100
Message-Id: <20201226232038.390883-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

v4 changes:
  - some of the patches got merged
  - rebased to latest perf/core
  - fixed changelogs
  - added 'ping' command

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
      perf tools: Allow to enable/disable events via control file
      perf tools: Add evlist control command
      perf tools: Add stop control command
      perf tools: Add ping control command

 tools/perf/Documentation/perf-record.txt |  15 ++++++++++++---
 tools/perf/builtin-record.c              |  13 +++++++------
 tools/perf/builtin-stat.c                |   5 +++--
 tools/perf/util/evlist.c                 | 112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/evlist.h                 |   6 ++++++
 tools/perf/util/evsel_fprintf.c          |   2 ++
 tools/perf/util/python-ext-sources       |   1 +
 tools/perf/util/setup.py                 |   2 +-
 8 files changed, 141 insertions(+), 15 deletions(-)

