Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D42269C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 05:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgIODSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 23:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgIODS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 23:18:27 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697C8C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:27 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l191so1235499pgd.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 20:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8eWJlS23lXDdfOxnmIsaJG6z5c4e92Yg34rdxNx93sw=;
        b=ZZTQXFhwLLCZ/7ymRjJfYMR+sl/fuyF3PaQASfHVg0CiZylM4cscLcxwATvB8QZ+yz
         ae5Y7+7pQ4yrjBa3sHpRTauDTu7zcA/+zOSW37cv3+ci9gQa9E7V1wQOqseURoAiy5T/
         /OxiB00XJgzddDHFhHFsDwVxehjt0UB2RIM1XZdAY5EU2t3TipWfIJLIpkXdNU+VMAHs
         /QyNJTgxIt7FJ/xMwMnHe3zr9YHEu3pNraQGzYHTGJziTCGG88aZom+jsr92MEG+1LPX
         EkSIMfbIQNAT4aEnm3C28zH1LAKVq8P7rD9GFVxpbqX61HiOvhb8MNfYnF/a5kjwDlXW
         l06w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=8eWJlS23lXDdfOxnmIsaJG6z5c4e92Yg34rdxNx93sw=;
        b=c8RGNmyYKMO+dF6tCLVQva7WQCj9eteAxoRqT+6MKi3bx1CJoF0YyLDbN3rhvpTEDR
         c7kGZFhDL0jBeKxZjT+IElExqJJmldaLfsqbhjYciDXFQ+u40dFxnvnxsAbQG+Y0QQdv
         veMB4FMwwFb4l92VYEtORjv18rs5aWOnm3gLV8tyZzTK9x0Snq7RgYAHRXzZk8uDnr/z
         G0kfkFV694aTMVWYhghSW/lodRMj12g3i3IbYsbgCKGKtI/GlB4VBb6yduouTECDNreD
         02QTP8LmZKlJI9iVWRtnkCZNyy9/Rp5KcDQ6c5ICRGN3edqi1T/qpOIltPTdc+s60Z90
         6G9A==
X-Gm-Message-State: AOAM531+4qIB6W/eoqkh6gL89+DKQfmpRJPgJh0E1lGxws+EWY95XziS
        NaTh9+hSeqcNuhBv62oG6zc=
X-Google-Smtp-Source: ABdhPJy13NZVS5g+bs4u3ayAseXDHnaGn8fhN1VzEPuA/1CU++hPOmfl4A1G31lRZs+2TvbnPvXpVw==
X-Received: by 2002:a63:8e4a:: with SMTP id k71mr12896843pge.326.1600139906149;
        Mon, 14 Sep 2020 20:18:26 -0700 (PDT)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id a24sm10584582pju.25.2020.09.14.20.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 20:18:25 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: [PATCHSET v2 00/11] perf tools: Fix various memory leaks
Date:   Tue, 15 Sep 2020 12:18:08 +0900
Message-Id: <20200915031819.386559-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.28.0.618.gf4bc123cb7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I've found and fixed a bunch of memory leaks during perf pmu and
metric tests with address sanitizer.  Before this, the tests were
mostly failed due to the leaks since ASAN makes it return non-zero.

Now I'm seeing no error with ASAN like below:

  $ ./perf test pmu metric
   9: Parse perf pmu format                                 : Ok
  10: PMU events                                            :
  10.1: PMU event table sanity                              : Ok
  10.2: PMU event map aliases                               : Ok
  10.3: Parsing of PMU event table metrics                  : Skip (some metrics failed)
  10.4: Parsing of PMU event table metrics with fake PMUs   : Ok
  67: Parse and process metrics                             : Ok

The failure in 10.3 seems due to parse errors like below:

  Multiple errors dropping message: unknown term 'filter_opc' for pmu 'uncore_cbox_0'
  (valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
                branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
		nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size)


  Parse event failed metric 'DRAM_Parallel_Reads' id 'arb/event=0x80,umask=0x2,thresh=1/'
    expr 'arb@event\=0x80\,umask\=0x2@ / arb@event\=0x80\,umask\=0x2\,thresh\=1@'
  Error string 'unknown term 'thresh' for pmu 'uncore_arb'' help
    'valid terms: event,edge,inv,umask,cmask,config,config1,config2,name,period,freq,
                  branch_type,time,call-graph,stack-size,no-inherit,inherit,max-stack,
		  nr,no-overwrite,overwrite,driver-config,percore,aux-output,aux-sample-size'


* Changes from v1:
 - Add 'Acked-by: Jiri'


The patches are also available at 'perf/metric-fix-v2' branch on

  git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git

Thanks
Namhyung


Namhyung Kim (11):
  perf metric: Fix some memory leaks
  perf metric: Fix some memory leaks - part 2
  perf evlist: Fix cpu/thread map leak
  perf parse-event: Fix cpu map leaks
  perf parse-event: Fix memory leak in evsel->unit
  perf test: Fix memory leaks in parse-metric test
  perf metric: Release expr_parse_ctx after testing
  perf metric: Free metric when it failed to resolve
  perf metric: Do not free metric when failed to resolve
  perf test: Free aliases for PMU event map aliases test
  perf test: Free formats for perf pmu parse test

 tools/perf/tests/parse-metric.c | 14 ++++++++-----
 tools/perf/tests/pmu-events.c   |  5 +++++
 tools/perf/tests/pmu.c          |  1 +
 tools/perf/util/evlist.c        | 11 ++++++++---
 tools/perf/util/metricgroup.c   | 35 +++++++++++++++++++++++----------
 tools/perf/util/parse-events.c  |  9 +++++++--
 tools/perf/util/pmu.c           | 13 +++++++++++-
 tools/perf/util/pmu.h           |  2 ++
 tools/perf/util/stat-shadow.c   |  8 +++++---
 9 files changed, 74 insertions(+), 24 deletions(-)

-- 
2.28.0.618.gf4bc123cb7-goog

