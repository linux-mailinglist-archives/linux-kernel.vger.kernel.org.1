Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F82A2EB70A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 01:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbhAFAsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 19:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbhAFAs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 19:48:27 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B86C061796
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 16:47:46 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id s26so2795317lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 16:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMNiD2AYhlcEkCed4y/yG9fQtf+nimzBnHckuWdc+Do=;
        b=Nnsz0TFWUjFmvHF4/2OXj3ES9s++zvfDXtHLLakj8ltds1BgcYY6qfyLQIYXuEg1c6
         Z97RlEwab64WjFoc2dFTEZ/bn/eRI9gfPAQaZ9dZ7o9xfPnL1kKznPBG1OtsdRdWoMxX
         HdB0ET2V4/ZEgBv1P97iJFsf+/o8nwDSKBg7z/oZJiJtRkWzuCRqrXuziAXsud1zbiwK
         GzbVruqbQz8j6FLNhm2XAfRfRk5sjSjZKjJpTU6YWSqBqIDG0++5K/bAMWFzZ0Tnp8GY
         FqEWEdYntA7GqVtk8tMCzJkL7lwIYuqESHrZ+J0h7+Gq30nmwA3haaD9ia6t1gh2CEdc
         BfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMNiD2AYhlcEkCed4y/yG9fQtf+nimzBnHckuWdc+Do=;
        b=m3SmJxWroninmwnrKAsZVifUHjpMgS8/q1XilC761eJMwqx0pxou4ruWDhHlpxRfL3
         F0UNxtLulXoUCKeN8JGlDAcN98cXnRB+9PSE9s6yGMEVSo88TdvHYk3J6iqrs1A5+ybR
         QNSPbEe6NV65k1UDYUedhzrNSYSW6R12J3IIzGUrrZVht7v7xuUNQ5pjtN5H0bxMm/5b
         O4ZPY/soZt5tmb2s0CPeGB0DqTSpC9yQogq79J6OUA67SY4d0gnZUdAlwQOcjrjSh1Ek
         SjFRltnqvlufkEpqYr5cB6vkF2daKZjxDhhNN0EOa4yNgMBoutIgifTwOfc+88VipX58
         ZMoA==
X-Gm-Message-State: AOAM530pCFew77mqJcuE1qIzhucllYlFA/4ESvotBd/t622y3gYOt1Ab
        siBfHISUhGkLqNIonyY8aB2HmY0K9wuDRYLec7xTfN+pTpI=
X-Google-Smtp-Source: ABdhPJx6V+KDy+trQYd0fYxF2cvxQIvtVgVQcRsV69kDDgkZ6IgTLQyoYoxxud9z973lLCD7O1cO4Oge3eTykpa3ksE=
X-Received: by 2002:a05:6512:20c1:: with SMTP id u1mr818859lfr.549.1609894064820;
 Tue, 05 Jan 2021 16:47:44 -0800 (PST)
MIME-Version: 1.0
References: <1609252514-27795-1-git-send-email-feng.tang@intel.com> <1609252514-27795-2-git-send-email-feng.tang@intel.com>
In-Reply-To: <1609252514-27795-2-git-send-email-feng.tang@intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 5 Jan 2021 16:47:33 -0800
Message-ID: <CALvZod5ir6F6BkJiVoXztNu6CancqJ2sNusg_hwTPcEssYkDdQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: memcg: add a new MEMCG_UPDATE_BATCH
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, andi.kleen@intel.com,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Huang Ying <ying.huang@intel.com>, Roman Gushchin <guro@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 6:35 AM Feng Tang <feng.tang@intel.com> wrote:
>
> When profiling memory cgroup involved benchmarking, status update
> sometimes take quite some CPU cycles. Current MEMCG_CHARGE_BATCH
> is used for both charging and statistics/events updating, and is
> set to 32, which may be good for accuracy of memcg charging, but
> too small for stats update which causes concurrent access to global
> stats data instead of per-cpu ones.
>
> So handle them differently, by adding a new bigger batch number
> for stats updating, while keeping the value for charging (though
> comments in memcontrol.h suggests to consider a bigger value too)
>
> The new batch is set to 512, which considers 2MB huge pages (512
> pages), as the check logic mostly is:
>
>     if (x > BATCH), then skip updating global data
>
> so it will save 50% global data updating for 2MB pages
>
> Following are some performance data with the patch, against
> v5.11-rc1, on several generations of Xeon platforms. Each category
> below has several subcases run on different platform, and only the
> worst and best scores are listed:
>
> fio:                             +2.0% ~  +6.8%
> will-it-scale/malloc:            -0.9% ~  +6.2%
> will-it-scale/page_fault1:       no change
> will-it-scale/page_fault2:      +13.7% ~ +26.2%
>
> One thought is it could be dynamically calculated according to
> memcg limit and number of CPUs, and another is to add a periodic
> syncing of the data for accuracy reason similar to vmstat, as
> suggested by Ying.
>

I am going to push back on this change. On a large system where jobs
can run on any available cpu, this will totally mess up the stats
(which is actually what happens on our production servers). These
stats are used for multiple purposes like debugging or understanding
the memory usage of the job or doing data analysis.
