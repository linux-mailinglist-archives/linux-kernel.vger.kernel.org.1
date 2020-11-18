Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7062B7589
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 06:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725800AbgKRFDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 00:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgKRFDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 00:03:39 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8960AC0613D4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 21:03:39 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id w79so475800pfc.14
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 21:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=XHkS0IrFQcowDQBwZTxPmQOZ+zkcfaqHXqP/H07K9L8=;
        b=FC+BZ7DwsOGlR228NtU5hM1UOWWRWd4j2y3XsIXaj+BztrgBkUKQLp5agLO50EuGHK
         VBPShpXThhe/yQIfU4Elk70+vBOiaZdX3PFTH482HLd5av3h8oxYQG3Z8aIxRCC5i9p4
         o1SMwtKq5JPUd82iBg2K4MaqS5eZrmuuwHzQ8wE/aDp/qrZk5OC9nPiC/BRIDmEa1+VT
         IxtL+3d94VngkJBEIjHOXSNF3s4pNlVImhO2uW+kV/McI7EUq5s9sR9pvPqLcbx9uWaF
         tLBeUaVbtsD6gjVqLyG2thxDvkcA1pELbzlm0B/birJ0wEfa0G6/J8VpiP1hlCeotuJO
         W+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=XHkS0IrFQcowDQBwZTxPmQOZ+zkcfaqHXqP/H07K9L8=;
        b=Eyxm5duEnqWYujkf0u3zIv8Bf+BA99VYhOEVurxgkZI2H7GMxHBVyBZcdKzAwmo1fr
         LfS95TlQoGpO/nMfgM/M6RlD3TyD42kQGDJJN4iU8qfR57eBJvwzId3NVYuIOXQIyseO
         UaMAvQQmMhCfqN7iX2kaeMZqswd+095ESzfKOEFGmWkKZ01UiLFqbqrPk2yM/Si+mnha
         RVzjbxvuR4b0RjoqV77BVVLF5RiO2h8oXx67iK7kPx3U5MmbJqiIhyq4P/G9g8kREoUE
         X7QW+Z87J3ChCcMy7QO6dUk8+Tme8rRWEdFyeX9WuSGIxMpCo75kOH3J9F39UU7EnZCK
         6W8g==
X-Gm-Message-State: AOAM530y1bYbw11mXOy6v2z1lp3iZV5e90uElD297oSViejMP3OSrCgI
        iCU+jiWsYW1j/s80YN1nS0mXdT6nUrwY
X-Google-Smtp-Source: ABdhPJy5wv5rrYgY4sH21jS/d/gz+btK3xy7UuenbdxpWfMfNB1LJOXdCr321EkxP2OpB1Yh6BzSnq10jTL5
Sender: "irogers via sendgmr" <irogers@irogers.svl.corp.google.com>
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:2:f693:9fff:fef4:4583])
 (user=irogers job=sendgmr) by 2002:a17:902:8685:b029:d7:bb:aa2 with SMTP id
 g5-20020a1709028685b02900d700bb0aa2mr2808834plo.13.1605675819020; Tue, 17 Nov
 2020 21:03:39 -0800 (PST)
Date:   Tue, 17 Nov 2020 21:03:30 -0800
Message-Id: <20201118050335.2347358-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH v2 0/5] Don't compute events that won't be used in a metric.
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Paul Clarke <pc@us.ibm.com>, kajoljain <kjain@linux.ibm.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Sandeep Dasgupta <sdasgup@google.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

    
For a metric like:
  EVENT1 if #smt_on else EVENT2
    
currently EVENT1 and EVENT2 will be measured and then when the metric
is reported EVENT1 or EVENT2 will be printed depending on the value
from smt_on() during the expr parsing. Computing both events is
unnecessary and can lead to multiplexing as discussed in this thread:
https://lore.kernel.org/lkml/20201110100346.2527031-1-irogers@google.com/

This change modifies expression parsing so that constants are
considered when building the set of ids (events) and only events not
contributing to a constant value are measured.

v2. is a rebase.

Ian Rogers (5):
  perf metric: Restructure struct expr_parse_ctx.
  perf metric: Use NAN for missing event IDs.
  perf metric: Rename expr__find_other.
  perf metric: Add utilities to work on ids map.
  perf metric: Don't compute unused events.

 tools/perf/tests/expr.c       | 148 ++++++++++-----
 tools/perf/tests/pmu-events.c |  42 +++--
 tools/perf/util/expr.c        | 136 ++++++++++++--
 tools/perf/util/expr.h        |  17 +-
 tools/perf/util/expr.l        |   9 -
 tools/perf/util/expr.y        | 343 +++++++++++++++++++++++++++-------
 tools/perf/util/metricgroup.c |  44 +++--
 tools/perf/util/stat-shadow.c |  54 ++++--
 8 files changed, 586 insertions(+), 207 deletions(-)

-- 
2.29.2.299.gdc1121823c-goog

