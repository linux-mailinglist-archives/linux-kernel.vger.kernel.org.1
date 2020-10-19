Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAF9292520
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 12:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgJSKC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 06:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728206AbgJSKC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 06:02:56 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FD8C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:02:56 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e7so5696102pfn.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=8GirbwszR7YZrylfYQ7BLEF5mp8hG8uh7OjZ4+CW064=;
        b=s+mWp2mKFtUQ7UbBVqis1phmbpKy1z6JJZzCz6SOQh/EOYBbIk0nVk/38do755/JXT
         SU96Bi7lqNF/rBajnYlc8A5gymgZIg/Wtg/k99O/F86In08eB5KQpBP7Y39aPvyglqmC
         RuvB2p5cVBI2JimnHXl7r0coRwC3Tq3r9TXg227jyhhvkrj06XP2JwqqRp/EcHyCyFJX
         f65znWWhoDDHoQBhABvcqijFARzUl1oEAWDkfcdpaWgKIIKwB3v3ESEjim0zHJIU0d+Z
         urV24gNbaiEamWmpFVGl72W2fThDzOst34ADaj+BZH5tJBBnRDqCjtrRta4V3QbbF3jv
         Qv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=8GirbwszR7YZrylfYQ7BLEF5mp8hG8uh7OjZ4+CW064=;
        b=FcVzhJgOZwZZXPZT5e7Wax8Gs8Z9174b564Flha4B1nbxu2y0gm8kiSRqR6hgeOBfW
         wIg3//tB3KHmqAOlvZnhbeQsAhEnSnGT+eoqllqeYT4vZwmSi3y1mrm9c+YxaHELKqD8
         P6jGz4ki8dxnp5PBcQfdo0B7xenh8s1cJFpmMtXXXBxTssHJmpzsQa0+Xob8pru0a5+f
         HU1ZipftEwpnkESzlV5K+55sA7/KD29E+jJuwDezwRyrpFkl/sY16il+2+KdY7i/fL7J
         5yS/yx7QFf+MFGitDjGo03YAd7sx8+KfbmVy6EU01mRe3olSutBcdODUpBWC9Pkd2CB2
         Ob7g==
X-Gm-Message-State: AOAM5321fMbeKd0OUCvgnL6hdodDrZu3NvU8S4z60CHH0D6EN0lxTU1C
        KoYdJcybBwSR5MBHtUQ975fmSA==
X-Google-Smtp-Source: ABdhPJzrGkRlr+XF8eYNdnMWCfFNebdBjNb1KKAK6BrEnb/F1xfGmit6+P9v0+lEDhW6GF8uHZ2sbg==
X-Received: by 2002:a62:ce08:0:b029:156:4427:4b29 with SMTP id y8-20020a62ce080000b029015644274b29mr16212537pfg.70.1603101775730;
        Mon, 19 Oct 2020 03:02:55 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id h6sm7466070pfk.212.2020.10.19.03.02.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Oct 2020 03:02:55 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Nick Gasson <nick.gasson@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v6 0/2] perf: Make tsc testing as a common testing case
Date:   Mon, 19 Oct 2020 18:02:34 +0800
Message-Id: <20201019100236.23675-1-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set is to move tsc testing from x86 specific to common
testing case.  Since Arnaldo found the building failure for patch set
v4 [1], the first four patches have been merged but the last two patches
were left out; this patch set is to resend the last two patches with
fixed the building failure (by removing the header "arch-tests.h" from the
testing code).

These two patches have been tested on x86_64 and Arm64.  Though I don't
test them on archs MIPS, PowerPC, etc, I tried to search every header so
ensure included headers are supported for all archs.

These two patches have been rebased on the perf/core branch with its
latest commit 744aec4df2c5 ("perf c2c: Update documentation for metrics
reorganization").

Changes from v5:
* Found the merging confliction on latest perf/core, so rebased it.

[1] https://lore.kernel.org/patchwork/cover/1305382/#1505752


Leo Yan (2):
  perf tests tsc: Make tsc testing as a common testing
  perf tests tsc: Add checking helper is_supported()

 tools/perf/arch/x86/include/arch-tests.h      |  1 -
 tools/perf/arch/x86/tests/Build               |  1 -
 tools/perf/arch/x86/tests/arch-tests.c        |  4 ----
 tools/perf/tests/Build                        |  1 +
 tools/perf/tests/builtin-test.c               |  5 +++++
 .../{arch/x86 => }/tests/perf-time-to-tsc.c   | 19 +++++++++++++++----
 tools/perf/tests/tests.h                      |  2 ++
 7 files changed, 23 insertions(+), 10 deletions(-)
 rename tools/perf/{arch/x86 => }/tests/perf-time-to-tsc.c (92%)

-- 
2.17.1

