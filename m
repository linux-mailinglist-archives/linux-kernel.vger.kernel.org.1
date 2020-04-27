Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451FE1BB05E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 23:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgD0VTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 17:19:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:36028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgD0VTp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 17:19:45 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67D07206D6;
        Mon, 27 Apr 2020 21:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588022385;
        bh=2eV9B0lH9wtd2fce3oEaM3zQI64LFBaJh1We79pc9gY=;
        h=From:To:Cc:Subject:Date:From;
        b=cSROQHuoy4XYwXISvhPQ92GPtZmR2HRr4IX+j8GqHV6Ml9F/gZgneBxp0PTDfac+5
         nwJ42FCINQrFeT6CgXPDA4MOGafND8BqdtdtoWzU/l8EuWWhHdv20SHH1EHV2LFIAs
         GnAVy/iV3maLjputjiCHsDzY0CwdBvdixfWdX2Ls=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Song Liu <songliubraving@fb.com>,
        Wang Nan <wangnan0@huawei.com>
Subject: [RFC PATCHSET] Implement --switch-output-events
Date:   Mon, 27 Apr 2020 18:19:28 -0300
Message-Id: <20200427211935.25789-1-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

	Please take a look, the example provided is too simple, using
'perf probe' to put probes in specific places in some workload to then
get any other event close to the time the trigger hits comes to mind as
well, using the signal was just to reuse the pre-existing logic and keep
the patchkit small.

	Its available at:

  git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/switch-output-event

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (7):
  perf record: Move sb_evlist to 'struct record'
  perf top: Move sb_evlist to 'struct perf_top'
  perf bpf: Decouple creating the evlist from adding the SB event
  perf bpf: Decouple creating the evlist from adding the SB event
  perf parse-events: Add parse_events_option() variant that creates
    evlist
  perf evlist: Allow reusing the side band thread for more purposes
  perf record: Introduce --switch-output-event

 tools/perf/Documentation/perf-record.txt | 13 ++++++
 tools/perf/builtin-record.c              | 55 +++++++++++++++++++++---
 tools/perf/builtin-top.c                 | 20 ++++++---
 tools/perf/util/bpf-event.c              |  3 +-
 tools/perf/util/bpf-event.h              |  7 ++-
 tools/perf/util/evlist.c                 | 39 +++++++++++------
 tools/perf/util/evlist.h                 |  3 +-
 tools/perf/util/parse-events.c           | 23 ++++++++++
 tools/perf/util/parse-events.h           |  1 +
 tools/perf/util/top.h                    |  2 +-
 10 files changed, 133 insertions(+), 33 deletions(-)

-- 
2.21.1

