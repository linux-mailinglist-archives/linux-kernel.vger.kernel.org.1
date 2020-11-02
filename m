Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9E82A2D65
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 15:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgKBOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 09:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbgKBOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 09:52:36 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B3C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 06:52:36 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id i7so9032281pgh.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 06:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bz1Rc3Jl83H8W0pctcm5gAymVZkHmWDSrja1VX9h4tE=;
        b=B0nDLJ0mfaKxdC4vcyJLDQazaTRVag5+aV5jIzIyx/IO3gLV2cUxNDkQqY5TnA5gqe
         hJsJu5sJEEJW/CuDzy6VYP1LVPcwOU9H7KxVoUHUAqEcPeiwZczkXE6lQzdHL6YlLdpk
         BuFNCUVvH4JHodmVfYXBvMbkDOKZQsVSXj1v4caNZ8OI6aTiS2zCcr6U44UboBezGXG4
         GoV2YOwWqEiif+rdVaQ7VCkXvRUTpvT7RdcMwfbX55E6wKegNCOE+vEE3hGYdm622Uf0
         QTsMtWLpu/wtYBSu4uZeGwXALrujr+C5zmGMIbZ8R9CvBRL46M9nh/qxvvXuIKSN1EZC
         819g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Bz1Rc3Jl83H8W0pctcm5gAymVZkHmWDSrja1VX9h4tE=;
        b=JRdKpmYDvqfvkODnT/jmDwPxe9g8bWaXXXXrnd7a5c3bR+ykLx3e5rpbXohfcUmMXT
         oRI+haT6+mNVDrcKHvCkehjZ522Oyp/8beNKUiItVW02Nued8saQ7Wpya6YZEGSXgA9r
         AL9KM/EAGEoZQY2qOp/n9uulCppN9Ec4i+ya+fAnijVnnp/Z/V3E0QoJphQ8DERo+nxs
         Za1XWkxTVDhq9skwZ52MJ7+n4toahCER5tM0drvEL6nx2O0R0AFTQhfsusKP9gbOeWAL
         W390UDkfDr4krk3wLA0qwAtsKI1T3tpXoCkhFFGrauOMQu6kJzo9QP9yKP7XjBv79GG/
         8qhw==
X-Gm-Message-State: AOAM531J+vRjZDqJ/Fcb/I4GWkPiki085Tyaqaoj5DEc9o2YMRqwEvYy
        FiGDSkUywd6CfF3kSJwejwc=
X-Google-Smtp-Source: ABdhPJyVo8tYairShASG7znv3zV5M8rRUHKxCMav7Zq/nbMyQ+mLYPGuRbhfUSumexxK4K307W0i5A==
X-Received: by 2002:a17:90a:fd08:: with SMTP id cv8mr11897585pjb.203.1604328756282;
        Mon, 02 Nov 2020 06:52:36 -0800 (PST)
Received: from balhae.roam.corp.google.com ([101.235.31.111])
        by smtp.gmail.com with ESMTPSA id y4sm13513091pjc.53.2020.11.02.06.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 06:52:35 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Gabriel Marin <gmx@google.com>
Subject: [RFC 1/2] perf/core: Enable sched_task callbacks if PMU has it
Date:   Mon,  2 Nov 2020 23:52:20 +0900
Message-Id: <20201102145221.309001-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
In-Reply-To: <20201102145221.309001-1-namhyung@kernel.org>
References: <20201102145221.309001-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an event associated with a PMU which has a sched_task callback,
it should be called regardless of cpu/task context.  For example,
a per-cpu event might enable large PEBS buffers so it needs to flush
the buffer whenever task scheduling happens.

The underlying PMU may or may not require this for the given event,
but it will be handled in the pmu::sched_task() callback anyway.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 kernel/events/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b458ed3dc81b..aaa0155c4142 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -4696,6 +4696,8 @@ static void unaccount_event(struct perf_event *event)
 		dec = true;
 	if (has_branch_stack(event))
 		dec = true;
+	if (event->pmu->sched_task)
+		dec = true;
 	if (event->attr.ksymbol)
 		atomic_dec(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
@@ -11225,6 +11227,8 @@ static void account_event(struct perf_event *event)
 		inc = true;
 	if (is_cgroup_event(event))
 		inc = true;
+	if (event->pmu->sched_task)
+		inc = true;
 	if (event->attr.ksymbol)
 		atomic_inc(&nr_ksymbol_events);
 	if (event->attr.bpf_event)
-- 
2.29.1.341.ge80a0c044ae-goog

