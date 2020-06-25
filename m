Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9912099F6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jun 2020 08:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390058AbgFYGqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 02:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389962AbgFYGqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:46:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9E7C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:20 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id r17so4889610ybj.22
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:cc;
        bh=9en45t/QzNaNM6uWfEIwyjVyBid8D5wBKicPYDDrGpo=;
        b=Gc4Yxt3I7/UcYTu0bsH1RFH6diu2RtYT0O5GLSOd5lrZmADKnymrdsOeLqV7AlTUZP
         djUwVJ5/iT8vzS/u1jfong1rtooTiqAFZsJNVZ/160i+YN93vacdCFS1xcNRwfGJX5np
         BfgeCY4eblYzBNNzloHFyKelqnmsz1OWakPsArY7nfTdJSHMhy1F0VirmZLWRc1m9LVu
         5Rb/mm2BR1sZqZ1pSoqr2TPS/SUpYzn3FuzU74kQWex+UPMJZgn0FzjcI9WiuSuEwNNg
         TiZC21Nfi2SFU+LhECZz9cL8/tcQ4maAyHFNYis0t157qx0PFD3Ewl/A6us03VBPRj5u
         fv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:cc;
        bh=9en45t/QzNaNM6uWfEIwyjVyBid8D5wBKicPYDDrGpo=;
        b=k1qf7R3DLc2LWvm8c4nhJlQuYo/+xaSSE1rAYBeZXXpWY/2n4ZWlWzv3shTCSrAU9l
         vNDFHZySP8o0VEMak2fFC5t6Q1aJ+WJO+GE8HIf1vpAoGtCJbMSwe32IZgmvaRb7p6aj
         tjrKU9DiG8z8PR/WekYhd2os2lAVtBFCzzY/Merc6bBCUHX/0UUEXb/xfQPsL4r0t/TA
         9/mBX2kjMa2I4QWVZLO40o3/EJ6MPZ0xgCk1Aultheg6wJjV7dz0DUxgM3ea7vj+uMmU
         vczy2tyxxvDJ7akCSOcbx4PSzXEBsEdnmuOHkwskLyWPq5JQ0maDLc+64sBTH9pcRfXJ
         cVsw==
X-Gm-Message-State: AOAM532GXXypNF8zSHTq8AJK/xQ1HzidpYhjPtSsiOOaoPe9qklfZTNz
        8cUw7/agbhaS4HaWd4dguqiuW6E=
X-Google-Smtp-Source: ABdhPJyvtkM8ik0DG/iBtJ1DhvVo8taVGremx1Ji24BaU8j0zc+CEhOAi7JnDBoNVfaMjxe8JjbuDbE=
X-Received: by 2002:a25:be05:: with SMTP id h5mr49833690ybk.131.1593067579604;
 Wed, 24 Jun 2020 23:46:19 -0700 (PDT)
Date:   Wed, 24 Jun 2020 23:46:14 -0700
Message-Id: <20200625064614.101183-1-wvw@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] cpufreq: schedutil: force frequency update when limits change
From:   Wei Wang <wvw@google.com>
Cc:     wei.vince.wang@gmail.com, dsmythies@telus.net,
        viresh.kumar@linaro.org, Wei Wang <wvw@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid reducing the frequency of a CPU prematurely, we skip reducing
the frequency if the CPU had been busy recently.

This should not be done when the limits of the policy are changed, for
example due to thermal throttling. We should always get the frequency
within the new limits as soon as possible.

There was a fix in
commit 600f5badb78c ("cpufreq: schedutil: Don't skip freq update when
limits change") upstream which introduced another flag. However, the
fix didn't address the case when next_freq is the same as previously
voted, which is then checked in sugov_update_next_freq. As a result, the
frequency would be stuck at low until the high demanding workload quits.

test trace:
  kworker/u19:0-1872  ( 1872) [002] ....   347.878871: cpu_frequency_limits: min=600000 max=2348000 cpu_id=6
         dhry64-11525 (11525) [007] d.h2   347.880012: sugov_should_update_freq: thermal limit on policy6
         dhry64-11525 (11525) [007] d.h2   347.880012: sugov_deferred_update: policy6 skipped update
         dhry64-11525 (11525) [007] d.h2   347.884040: sugov_deferred_update: policy6 skipped update
...

This patch fixes this by skipping the check and forcing an update in
this case. The second flag was kept as the limits_change flag could be
updated in thermal kworker from another CPU.

Fixes: ecd288429126 ("cpufreq: schedutil: Don't set next_freq to UINT_MAX")
Signed-off-by: Wei Wang <wvw@google.com>
---
 kernel/sched/cpufreq_schedutil.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 7fbaee24c824..dc2cd768022e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -102,11 +102,12 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
-	if (sg_policy->next_freq == next_freq)
+	if (!sg_policy->need_freq_update && sg_policy->next_freq == next_freq)
 		return false;
 
 	sg_policy->next_freq = next_freq;
 	sg_policy->last_freq_update_time = time;
+	sg_policy->need_freq_update = false;
 
 	return true;
 }
@@ -178,7 +179,6 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	if (freq == sg_policy->cached_raw_freq && !sg_policy->need_freq_update)
 		return sg_policy->next_freq;
 
-	sg_policy->need_freq_update = false;
 	sg_policy->cached_raw_freq = freq;
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
-- 
2.27.0.212.ge8ba1cc988-goog

