Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B3C27F008
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 19:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731113AbgI3RPY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 30 Sep 2020 13:15:24 -0400
Received: from us-smtp-delivery-44.mimecast.com ([205.139.111.44]:38230 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725799AbgI3RPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 13:15:24 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-PLQ0aYZ-NAG8Onx47_p6kQ-1; Wed, 30 Sep 2020 13:15:17 -0400
X-MC-Unique: PLQ0aYZ-NAG8Onx47_p6kQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77BDA800683;
        Wed, 30 Sep 2020 17:15:15 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.194.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EC02D702E7;
        Wed, 30 Sep 2020 17:15:12 +0000 (UTC)
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
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 0/9] perf tools: Add support for build id with different sizes
Date:   Wed, 30 Sep 2020 19:15:03 +0200
Message-Id: <20200930171512.3986425-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
currently we support only one storage size (20 bytes) for build
ids. That fits for SHA1 build ids, but there can in theory be
any size. The gcc linker supports also MD5, which is 16 bytes.

Currently the MD5 build id will be stored in .debug cache with
additional zeros, like:

  $ find ~/.debug
  .../.debug/.build-id/a5/0e350e97c43b4708d09bcd85ebfff700000000
  ...
  .../buildid-ex-md5/a50e350e97c43b4708d09bcd85ebfff700000000
  .../buildid-ex-md5/a50e350e97c43b4708d09bcd85ebfff700000000/elf
  .../buildid-ex-md5/a50e350e97c43b4708d09bcd85ebfff700000000/probes

And the same reflected in buildid-list as well:

  $ perf buildid-list
  17f4e448cc746582ea1881528deb549f7fdb3fd5 [kernel.kallsyms]
  a50e350e97c43b4708d09bcd85ebfff700000000 .../buildid-ex-md5

This will cause problems in future when we will ask debuginfod
for binaries/debuginfo based on build id.

This patchset is adding 'struct build_id' object, that holds
the build id data and size and use it to store build ids and
changes all related functions to use it.

Also available in:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/build_id_size

thanks,
jirka


---
Jiri Olsa (9):
      perf tools: Add build id shell test
      perf tools: Use build_id object in dso
      perf tools: Pass build_id object to filename__read_build_id
      perf tools: Pass build id object to sysfs__read_build_id
      perf tools: Pass build_id object to build_id__sprintf
      perf tools: Pass build_id object to dso__set_build_id
      perf tools: Pass build_id object to dso__build_id_equal
      perf tools: Add size to struct perf_record_header_build_id
      perf tools: Align buildid list output for short build ids

 tools/lib/perf/include/perf/event.h                    | 12 +++++++++++-
 tools/perf/Makefile.perf                               | 14 ++++++++++++++
 tools/perf/builtin-buildid-cache.c                     | 25 ++++++++++++-------------
 tools/perf/builtin-inject.c                            |  3 +--
 tools/perf/tests/pe-file-parsing.c                     | 10 +++++-----
 tools/perf/tests/sdt.c                                 |  6 +++---
 tools/perf/tests/shell/buildid.sh                      | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.c                             |  3 +--
 tools/perf/util/build-id.c                             | 48 ++++++++++++++++++++++++++++--------------------
 tools/perf/util/build-id.h                             |  8 +++++++-
 tools/perf/util/dso.c                                  | 23 ++++++++++-------------
 tools/perf/util/dso.h                                  |  7 +++----
 tools/perf/util/dsos.c                                 |  9 +++++----
 tools/perf/util/header.c                               | 15 ++++++++++-----
 tools/perf/util/map.c                                  |  4 +---
 tools/perf/util/probe-event.c                          |  9 ++++++---
 tools/perf/util/probe-finder.c                         |  8 +++++---
 tools/perf/util/scripting-engines/trace-event-python.c |  2 +-
 tools/perf/util/symbol-elf.c                           | 35 +++++++++++++++++++++--------------
 tools/perf/util/symbol-minimal.c                       | 31 ++++++++++++++++---------------
 tools/perf/util/symbol.c                               | 15 +++++++--------
 tools/perf/util/symbol.h                               |  5 +++--
 tools/perf/util/synthetic-events.c                     |  2 +-
 23 files changed, 261 insertions(+), 123 deletions(-)
 create mode 100755 tools/perf/tests/shell/buildid.sh

