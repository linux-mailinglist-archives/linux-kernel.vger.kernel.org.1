Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC9A28D462
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732521AbgJMTYx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 13 Oct 2020 15:24:53 -0400
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:33389 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727499AbgJMTYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:24:53 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-aS9oaGg8PFeZNB5PuUtv5A-1; Tue, 13 Oct 2020 15:24:48 -0400
X-MC-Unique: aS9oaGg8PFeZNB5PuUtv5A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AE9F18BE161;
        Tue, 13 Oct 2020 19:24:46 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.193.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 153C05D9CD;
        Tue, 13 Oct 2020 19:24:42 +0000 (UTC)
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
Subject: [PATCHv2 0/9] perf tools: Add support for build id with different sizes
Date:   Tue, 13 Oct 2020 21:24:32 +0200
Message-Id: <20201013192441.1299447-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

v2 changes:
  - rebased on current perf/core
  - updated test to build its own binaries [Namhyung]

thanks,
jirka


---
Jiri Olsa (9):
      perf tools: Use build_id object in dso
      perf tools: Pass build_id object to filename__read_build_id
      perf tools: Pass build id object to sysfs__read_build_id
      perf tools: Pass build_id object to build_id__sprintf
      perf tools: Pass build_id object to dso__set_build_id
      perf tools: Pass build_id object to dso__build_id_equal
      perf tools: Add size to struct perf_record_header_build_id
      perf tools: Align buildid list output for short build ids
      perf tools: Add build id shell test

 tools/lib/perf/include/perf/event.h                    |  12 +++++++++++-
 tools/perf/bench/inject-buildid.c                      |   4 ++--
 tools/perf/builtin-buildid-cache.c                     |  25 ++++++++++++------------
 tools/perf/builtin-inject.c                            |   4 +---
 tools/perf/tests/pe-file-parsing.c                     |  10 +++++-----
 tools/perf/tests/sdt.c                                 |   6 +++---
 tools/perf/tests/shell/buildid.sh                      | 101 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.c                             |   3 +--
 tools/perf/util/build-id.c                             |  48 +++++++++++++++++++++++++++-------------------
 tools/perf/util/build-id.h                             |   8 +++++++-
 tools/perf/util/dso.c                                  |  23 ++++++++++------------
 tools/perf/util/dso.h                                  |   7 +++----
 tools/perf/util/dsos.c                                 |   9 +++++----
 tools/perf/util/header.c                               |  15 ++++++++++-----
 tools/perf/util/map.c                                  |   4 +---
 tools/perf/util/probe-event.c                          |   9 ++++++---
 tools/perf/util/probe-finder.c                         |   8 +++++---
 tools/perf/util/scripting-engines/trace-event-python.c |   2 +-
 tools/perf/util/symbol-elf.c                           |  35 +++++++++++++++++++--------------
 tools/perf/util/symbol-minimal.c                       |  31 +++++++++++++++---------------
 tools/perf/util/symbol.c                               |  15 +++++++--------
 tools/perf/util/symbol.h                               |   5 +++--
 tools/perf/util/synthetic-events.c                     |   2 +-
 23 files changed, 260 insertions(+), 126 deletions(-)
 create mode 100755 tools/perf/tests/shell/buildid.sh

