Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AE4300E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbhAVVBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:01:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730945AbhAVU6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:58:21 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 990C1C0613D6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:57:40 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h7so9418475lfc.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 12:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=raLUB36sAztka1/6R5PBGfhEeAA3qlJwdT1ML+wmZec=;
        b=RAEZ3z6s46P3K6log9ncGo5mPucJj4c+Pt0UwiwW5usuPVFmkT+WBnj4BRttVa0gtp
         ymlzxD4dKC/6WUWyuFs4iqMob6tcX649pXk4T/anBFDEwTuP7AgwhAErH/tWWtRvj914
         af0q/4zvYWlCDwB418HXJXh4cWpi/GCtxvc2cfZG9x13roRXjNRX+VAl4AwX9Ox5yw8N
         2KyKpdMfanRFromoDxJTVayLX5IYzlmMxbJVGgUtykfmS2A7xg0lTHI/VsiHtcn8dv6t
         vQ1npJMvhEAvBq/KzaJWYbd2pV1cIziwPWiuGuKtsIshMtqcArY2CDwzP3+YfTBOAdKH
         3UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=raLUB36sAztka1/6R5PBGfhEeAA3qlJwdT1ML+wmZec=;
        b=ropuS9TdN/WuUFhF/BqZG8eMMcIejk9S7pldfNWQpQGT34pl2h/WQPBEkgXKOQpCam
         L/+1v2LDcsXMK9YPZKVSzdOBeb6Oap4CWomz4c7+t/sETgVodmBLJISWapDMG6dNUN92
         IKpUBu0RvzLShlWO2DwTZk9sMkuVry0mNXjwFRf1hXSkIl9aLRQgAtkzlpyQrdYmV3rF
         qK2XhvKxjcz2+BrxKbTRGN6gSlCBCFurkgZo2NvA/M/XZyuMOXq4RYAVWg5EC2tUfKio
         1uSUVdP60flcQJZ4dx7YUYbgPyRsPrP+9bdR4fPAffxTvQmyPwdQNyIKJvpnZ+hgYpD7
         TKpw==
X-Gm-Message-State: AOAM533eTf+8MI7NKvTpzxSHwm/ywha9ST7XEdHuYfALPoSaJBrpZ11D
        8s0kHKgVABl2Z+yS8hQ2kwofu0zZEZEv62xZJ9kQ8A==
X-Google-Smtp-Source: ABdhPJywRDc2EvPPp6qpBaLo5mECSzVgRlE93fimb5EjNJTJL99ytIrFKEDhRnuwHxHdjaIGo7gFdXjafKbE49P4J4A=
X-Received: by 2002:a19:644b:: with SMTP id b11mr622766lfj.358.1611349058801;
 Fri, 22 Jan 2021 12:57:38 -0800 (PST)
MIME-Version: 1.0
References: <20210122184341.292461-1-hannes@cmpxchg.org>
In-Reply-To: <20210122184341.292461-1-hannes@cmpxchg.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 22 Jan 2021 12:57:26 -0800
Message-ID: <CALvZod5QWBgKzoKbAUgtwU4YwXAQtu1MS_=o_zhyFDCXam4yNA@mail.gmail.com>
Subject: Re: [PATCH] Revert "mm: memcontrol: avoid workload stalls when
 lowering memory.high"
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 10:43 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> This reverts commit 536d3bf261a2fc3b05b3e91e7eef7383443015cf, as it
> can cause writers to memory.high to get stuck in the kernel forever,
> performing page reclaim and consuming excessive amounts of CPU cycles.
>
> Before the patch, a write to memory.high would first put the new limit
> in place for the workload, and then reclaim the requested delta. After
> the patch, the kernel tries to reclaim the delta before putting the
> new limit into place, in order to not overwhelm the workload with a
> sudden, large excess over the limit. However, if reclaim is actively
> racing with new allocations from the uncurbed workload, it can keep
> the write() working inside the kernel indefinitely.
>
> This is causing problems in Facebook production. A privileged
> system-level daemon that adjusts memory.high for various workloads
> running on a host can get unexpectedly stuck in the kernel and
> essentially turn into a sort of involuntary kswapd for one of the
> workloads. We've observed that daemon busy-spin in a write() for
> minutes at a time, neglecting its other duties on the system, and
> expending privileged system resources on behalf of a workload.
>
> To remedy this, we have first considered changing the reclaim logic to
> break out after a couple of loops - whether the workload has converged
> to the new limit or not - and bound the write() call this way.
> However, the root cause that inspired the sequence change in the first
> place has been fixed through other means, and so a revert back to the
> proven limit-setting sequence, also used by memory.max, is preferable.
>
> The sequence was changed to avoid extreme latencies in the workload
> when the limit was lowered: the sudden, large excess created by the
> limit lowering would erroneously trigger the penalty sleeping code
> that is meant to throttle excessive growth from below. Allocating
> threads could end up sleeping long after the write() had already
> reclaimed the delta for which they were being punished.
>
> However, erroneous throttling also caused problems in other scenarios
> at around the same time. This resulted in commit b3ff92916af3 ("mm,
> memcg: reclaim more aggressively before high allocator throttling"),
> included in the same release as the offending commit. When allocating
> threads now encounter large excess caused by a racing write() to
> memory.high, instead of entering punitive sleeps, they will simply be
> tasked with helping reclaim down the excess, and will be held no
> longer than it takes to accomplish that. This is in line with regular
> limit enforcement - i.e. if the workload allocates up against or over
> an otherwise unchanged limit from below.
>
> With the patch breaking userspace, and the root cause addressed by
> other means already, revert it again.
>
> Fixes: 536d3bf261a2 ("mm: memcontrol: avoid workload stalls when lowering memory.high")
> Cc: <stable@vger.kernel.org> # 5.8+
> Reported-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
