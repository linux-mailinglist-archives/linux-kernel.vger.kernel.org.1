Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD3E2C26D0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 14:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387814AbgKXNIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 08:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387669AbgKXNIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 08:08:46 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC61C0613D6;
        Tue, 24 Nov 2020 05:08:46 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id v3so5048393ilo.5;
        Tue, 24 Nov 2020 05:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lqNaNlyCWsqnQiMyNMSmSk9+lyPrlpC34lNClH2VPBk=;
        b=VPgob10uvPGhhM2Q/eJ5+M+0zDC4wfaaPqDZtGtPtd0sCX53O1aBXy2270lLE8Su5L
         x2u0axp+y9VoD7brThljKy1XVaFdMPyAV6zl+eJ1IHFPfTM9vIqNGoJMdYrFkHAHqBUz
         etpK7OeDGn1FYlRxDsAS5HVzxOR9HqqJ/JH4Eh0iK8EnyO5z7ygHDRf62HIOBs/k4A/4
         QrpcJ6wXcvSWFcC/CAzfEqRFN8dVI3yw48Zgv3C+NXstnHgWMZ6lnXSiYbUuqhjoGeZw
         EzmfW78Hd84kexi4oaDm/PvuuvrTqnPBeQGeJYpMmc4dqk4rF4voc3ZbhPuxRWc9a2rn
         GfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lqNaNlyCWsqnQiMyNMSmSk9+lyPrlpC34lNClH2VPBk=;
        b=ZmlIO8MFRUOiX0W2M5zJsCIllIlNuxhJspSD0cyDJnruSX/hMDUtFMSlXI17Rb6AT/
         j/CPzLB2V5K36Dxkq8xW49UNBEVza9VJyykAXoSVFu8MvWLFrZe6G4+c+WWvQEVI4chL
         nGeqIfuTf7bDxHp0y+OZeo70cgvanVm3CFsh3uPIMcIvP1Mrbi3ONe5L1/SSU18tZkZr
         4dBblAABHHPAo38Bc7RzPaIFclYN4sJgMtnU316vxieutyVK8FZ4xW0G13p5pQW7+Qhi
         dUJ4aREHB2lf/ARrIF0Yl/TvxlpyYoSkqOkVHb/x6tNfG+Z3XvQa36bbWvfw0xdObxz9
         7tVw==
X-Gm-Message-State: AOAM533b7is7N1k8NqBpudYxwc8dq5Si1cTFWflpNKKf7YezRE7EAaJV
        AgN4vNXrwmZDVqNjes4a9wHTuD/gXoqW9WpE0dDEcV/UAeY=
X-Google-Smtp-Source: ABdhPJyMXKxWGznQOtkmHQ+YyoVZBumfVI7fJ4B7vyP8UL1Si8WDdzm9WOwBiaQMbIKtaNzJWEvRdo9/h2p9kys7czk=
X-Received: by 2002:a92:ae10:: with SMTP id s16mr4190848ilh.142.1606223325423;
 Tue, 24 Nov 2020 05:08:45 -0800 (PST)
MIME-Version: 1.0
References: <20201123125808.50896-1-laoar.shao@gmail.com> <20201123125808.50896-4-laoar.shao@gmail.com>
 <20201124114042.GJ3306@suse.de>
In-Reply-To: <20201124114042.GJ3306@suse.de>
From:   Yafang Shao <laoar.shao@gmail.com>
Date:   Tue, 24 Nov 2020 21:08:09 +0800
Message-ID: <CALOAHbATZWTgg2wH+nTz-btzeUgKgqs9s+pWK1XV0HYwptoKwQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/5] sched: make schedstats helper independent of cfs_rq
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, bristot@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 7:40 PM Mel Gorman <mgorman@suse.de> wrote:
>
> On Mon, Nov 23, 2020 at 08:58:06PM +0800, Yafang Shao wrote:
> > The 'cfs_rq' in these helpers
> > update_stats_{wait_start, wait_end, enqueue_sleeper} is only used to get
> > the rq_clock, so we can pass the rq directly. Then these helpers can be
> > used by all sched class after being moved into stats.h.
> >
> > After that change, the size of vmlinux is increased around 824Bytes.
> >                       w/o this patch, with this patch
> > Size of vmlinux:      78443832        78444656
> >
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
>
> The inline helpers are quite large. When I was suggesting that the overhead
> was minimal, what I expected what that the inline functions would be a
> schedstat_enabled() followed by a real function call. It would introduce
> a small additional overhead when schedstats are enabled but avoid vmlinux
> growing too large
>
> e.g.
>
> static inline void
> update_stats_wait_start(struct cfs_rq *cfs_rq, struct sched_entity *se)
> {
>         if (!schedstat_enabled())
>                 return;
>
>         __update_stats_wait_start(cfs_rq, se);
> }
>
> where __update_stats_wait_start then lives in kernel/sched/stats.c
>

Good idea!  Now I understand what you mean. Thanks for the detailed explanation.
I will update it in the next version.


-- 
Thanks
Yafang
