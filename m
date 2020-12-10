Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF23D2D575D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgLJJjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbgLJJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:39:31 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD266C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:38:50 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id a12so7262893lfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 01:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ImcFzCrnXSeqVzvHwfZmCFw8Oi+DLIx66uAizMiWYA=;
        b=BB8VAe/nMcQm8Ldsi7p1z2+svu2GOnIZuDD+/nOviN6tZAXnU/Hj3oo4OEOug9D4Hv
         Teq+xaVOWYmQab2dwSQUyx0SPIpMCE0rj80Qlg4ELPRNj93oXffwlRirs8FSYp8Xm9f4
         uA4emHsJ3mYKvMdT3yIAU+aplo+w0l0rmTtKU1VA+xdjWdDC2SwYTnXo4SVoFV5eciGO
         FLQvN7hrX+qbisiDalB2pnsdgkPQSrTKj8anNme+TB0/E/57CCOnNyW+LOXuqkqUmzI9
         LXeyJHkkAxz7Z+3HvkObvlsEFxCSfgTp+ValY57v0TDVmyRSX2jBWsYewVm0PNXJhSjb
         y2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ImcFzCrnXSeqVzvHwfZmCFw8Oi+DLIx66uAizMiWYA=;
        b=UQ/gRHkkTBI2UyIGynV4eF4FS2DFih5UM9CAIWyxxTdXyt188Tm6dQXD1glA2fgpwN
         9ZoYAvWJCYvfrThC7jSsAQICcjvV456QI9crbVDWDiJ/K52Ttg2CEbdDrYVmjP4FlKZ2
         fuk/XQm2Eq9z+Qdg8HLsr87VVfYOz2I3az6Ntc2NlZ7MYfysDzjKcNEzPls1/wrZrLZf
         fUR0qW5HrzcfKLFufXPN2aZhU8uuKyNh68FNBtYdIlrrHwrB1+nUDK/nFr6Nw5w3/aLI
         UlyntaeAGVDodAme2aPPHdwdp8eOcPZYYBRz2U/zdsCWxmq03RPfFDzFltIdalFpAQ0x
         WvdQ==
X-Gm-Message-State: AOAM5321pkKaBcoYlNCFgnYtRyjrysnzhxcRoKcugZ1PWpGh3vFLToGX
        2bp/LOaOwvknXzH0nosIYz8qxMI5inUeQaD/D9IK+w==
X-Google-Smtp-Source: ABdhPJzt2J/FMVBQhTPWl3llvZCXPFtMrTVBVzfhNtBv8NNaB0Q7Wc5Jc7fun/kTeWUwlO9bPzBgRg/gAJOUb7K+5QA=
X-Received: by 2002:ac2:5442:: with SMTP id d2mr2479137lfn.154.1607593129175;
 Thu, 10 Dec 2020 01:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20201208153501.1467-1-mgorman@techsingularity.net>
 <20201209143748.GP3371@techsingularity.net> <CAKfTPtCToad1ZwMRi28iC=MQ2D+vnTBLKBU+UOBanTWnuQQzRA@mail.gmail.com>
In-Reply-To: <CAKfTPtCToad1ZwMRi28iC=MQ2D+vnTBLKBU+UOBanTWnuQQzRA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Dec 2020 10:38:37 +0100
Message-ID: <CAKfTPtBigdckTCpYyVD9R0U9Mm+ENX7BJ3gqrTkPW3m64iPCVA@mail.gmail.com>
Subject: Re: [PATCH 0/4] Reduce scanning of runqueues in select_idle_sibling
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Ziljstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Linux-ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 at 09:00, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Wed, 9 Dec 2020 at 15:37, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Tue, Dec 08, 2020 at 03:34:57PM +0000, Mel Gorman wrote:
> > > Changelog since v1
> > > o Drop single-pass patch                                              (vincent)
> > > o Scope variables used for SIS_AVG_CPU                                        (dietmar)
> > > o Remove redundant assignment                                         (dietmar
> > >
> > > This reduces the amount of runqueue scanning in select_idle_sibling in
> > > the worst case.
> > >
> > > Patch 1 removes SIS_AVG_CPU because it's unused.
> > >
> > > Patch 2 moves all SIS_PROP-related calculations under SIS_PROP
> > >
> > > Patch 3 improves the hit rate of p->recent_used_cpu to reduce the amount
> > >       of scanning. It should be relatively uncontroversial
> > >
> > > Patch 4 returns an idle candidate if one is found while scanning for a
> > >       free core.
> > >
> >
> > Any other objections to the series? Vincent marked 1, 3 and 4 as
> > reviewed. While patch 2 had some mild cosmetic concerns, I think the
> > version and how it treats SIS_PROP is fine as it is to keep it
> > functionally equivalent to !SIS_PROP and without adding too many
> > SIS_PROP checks.
>
> while testing your patchset and Aubrey one on top of tip, I'm facing
> some perf regression on my arm64 numa system on hackbench and reaim.
> The regression seems to comes from your patchset but i don't know
> which patch in particular yet
>
> hackbench -l 256000 -g 1
>
> v5.10-rc7 + tip/sched/core 13,255(+/- 3.22%)
> with your patchset         15.368(+/- 2.74)  -15.9%
>
> I'm also seeing perf regression on reaim but this one needs more
> investigation before confirming
>
> TBH, I was not expecting regressions. I'm running more test to find
> which patch is the culprit

The regression comes from patch 3: sched/fair: Do not replace
recent_used_cpu with the new target


>
>
> >
> > --
> > Mel Gorman
> > SUSE Labs
