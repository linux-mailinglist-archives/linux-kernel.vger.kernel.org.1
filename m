Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 481472D062C
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 18:06:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgLFRGZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 6 Dec 2020 12:06:25 -0500
Received: from us-smtp-delivery-44.mimecast.com ([207.211.30.44]:41578 "EHLO
        us-smtp-delivery-44.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgLFRGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 12:06:23 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-489-sZ-NFS92Oz6_S7N6Ly45Dg-1; Sun, 06 Dec 2020 12:05:25 -0500
X-MC-Unique: sZ-NFS92Oz6_S7N6Ly45Dg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A6DF1005513;
        Sun,  6 Dec 2020 17:05:23 +0000 (UTC)
Received: from krava.redhat.com (unknown [10.40.192.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B1F3660657;
        Sun,  6 Dec 2020 17:05:20 +0000 (UTC)
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
Subject: [PATCH 0/3] perf tools: Allow to enable/disable events via control pipe
Date:   Sun,  6 Dec 2020 18:05:16 +0100
Message-Id: <20201206170519.4010606-1-jolsa@kernel.org>
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
adding support to enable/disable specific events via control
file via following commands:

    # echo enable-sched:sched_process_fork > control
    # echo disabled-sched:sched_process_fork > control

The code is available in here:
  git://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
  perf/control

thanks,
jirka


---
Jiri Olsa (3):
      perf tools: Add evlist__disable_evsel/evlist__enable_evsel
      perf tools: Allow to enable/disable events via control file
      perf tools: Allow to list events via control file

 tools/perf/builtin-record.c |   3 +++
 tools/perf/builtin-stat.c   |   3 +++
 tools/perf/util/evlist.c    | 105 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/evlist.h    |   8 ++++++++
 4 files changed, 115 insertions(+), 4 deletions(-)

