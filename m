Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ACCC233AEC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 23:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgG3VkK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 30 Jul 2020 17:40:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31269 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbgG3VkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 17:40:10 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-5FNSe_yAOHGp3pluFVWCAw-1; Thu, 30 Jul 2020 17:40:03 -0400
X-MC-Unique: 5FNSe_yAOHGp3pluFVWCAw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA461193F57C;
        Thu, 30 Jul 2020 21:40:00 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.223])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A89B88D40;
        Thu, 30 Jul 2020 21:39:51 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?Genevi=C3=A8ve=20Bastien?= <gbastien@versatic.net>,
        Wang Nan <wangnan0@huawei.com>,
        Jeremie Galarneau <jgalar@efficios.com>
Subject: [PATCH 0/6] perf tools: Add wallclock time conversion support
Date:   Thu, 30 Jul 2020 23:39:44 +0200
Message-Id: <20200730213950.1503773-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jolsa@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
this patchset is based on changes made by David Ahern long time ago.
The perf code moved a lot since then, but the idea is the same.

The patchset is adding the ability to display TOD/wallclock timestamp
in 'perf script' output and in 'perf data convert --to-ctf' subcommand,
so the converted CTF data contain TOD/wallclock timestamps.

It's done by adding new header FEATURE 'CLOCK_DATA' to perf.data, that
stores reference times for both TOD/wallclock time and for the clock that
perf record is configured to use. These reference times are then used to
convert sample's timestamps to TOD/wallclock timestamps.

The feature is available only for recording with clockid specified,
because it's the only case where we can get reference time to TOD/wallclock
time. We can't do that with perf clock yet.

Also available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/abs_time

thanks,
jirka


---
Jiri Olsa (6):
      perf tools: Add clockid_name function
      perf tools: Store clock references for -k/--clockid option
      perf tools: Move clockid_res_ns under clock struct
      perf tools: Add support to store time of day in CTF data conversion
      perf script: Change enum perf_output_field values to be 64 bits
      perf script: Add tod field to display time of day

 tools/perf/Documentation/perf-data.txt             |   3 ++
 tools/perf/Documentation/perf.data-file-format.txt |  13 +++++++
 tools/perf/builtin-data.c                          |   1 +
 tools/perf/builtin-record.c                        |  58 ++++++++++++++++++++++++++++--
 tools/perf/builtin-script.c                        | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------
 tools/perf/util/data-convert-bt.c                  |  56 ++++++++++++++++++-----------
 tools/perf/util/data-convert.h                     |   1 +
 tools/perf/util/env.h                              |  14 +++++++-
 tools/perf/util/header.c                           | 120 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/header.h                           |   1 +
 tools/perf/util/util.h                             |   2 ++
 11 files changed, 371 insertions(+), 93 deletions(-)

