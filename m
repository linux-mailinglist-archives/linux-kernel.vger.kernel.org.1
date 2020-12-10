Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FF02D54FE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733239AbgLJIBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgLJIBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:01:42 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8C5C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 00:01:02 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s11so5659404ljp.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 00:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EaxSgwGc3sav/Jepv9lFlJ7IXr1WPiMxzvqTvfFy4fg=;
        b=Tj1jgPerQPS7CM9LA290bWZTIFQ4w+Enn6sPGDh3Apdb14yarz/+olHKH1AaBJn9zS
         uSI1BOfU+QfyK5gq95ET7abOMKpli0lAZ7lTmp2AWAOa6WDCSludrLgvaXMtWsTb9Qux
         oGdb6Mi2Zgd+wSDVo9eoEbZd2bI5e6D0CsBwjoQqaNDQfW4h8klcxMMtIoDAu1yCQA1x
         ihzBVY1ExV6iDF1oWNduiZphp9hPTfsQWFMbH+HZshAa6E7JSRK3tB4533IwicpYTCLE
         90yGntViPXkVAkqjf+lcETwyWVLXaWl15A/L2ttv84iWxEBI6HIOsc3kJ1slqUGxgpKc
         EbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EaxSgwGc3sav/Jepv9lFlJ7IXr1WPiMxzvqTvfFy4fg=;
        b=YgFkEjNA/5iOokSOTP+c23HGdRbyHzYV4o65OO9HCoOCADac243Hz0Qm4+7RhgDGqd
         24p9MYvKD9Hqcl4k0IGvRQTk1sNJNAu89CXjGxsj/8DZdznJ7Hwkj79HShY5kJbJWR2b
         vCRerZpxtmrA3GNcL4T6iVI1vNdvFxsvPPwtNPY95143levUG/uUDcNd206p0LMbhyed
         A0pQHyIZoh7bgfvhAhEkRRPHQwx9RK5ct9Zy+qPG4BMfmw3rlSZhpf077L5FnS5bhQxP
         McmOpvUv8yaEVzKk3ghutONQeFjrMslTsxBWHUWuSds48XsqK5ZjqesyzA18d8WGBI3r
         Kpng==
X-Gm-Message-State: AOAM533LEoVk2SAymrwAWG+mgmZHUWXmaqGg0QnaILCKFUUC45slZqfZ
        RrqtIPWRmL0nPkIUnsWAhk2mgXBYuETgeEXdGcNxsw==
X-Google-Smtp-Source: ABdhPJzOgUpJG4+fhPdf2F3nwt/AecWP8IsaQZ6IvObBuSiIq5Gd85PVHwbY2ski+RfTwgtHGhE0AeQ/aYZmlUZ7XsA=
X-Received: by 2002:a2e:8396:: with SMTP id x22mr2499130ljg.221.1607587260753;
 Thu, 10 Dec 2020 00:01:00 -0800 (PST)
MIME-Version: 1.0
References: <20201208153501.1467-1-mgorman@techsingularity.net> <20201209143748.GP3371@techsingularity.net>
In-Reply-To: <20201209143748.GP3371@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 10 Dec 2020 09:00:49 +0100
Message-ID: <CAKfTPtCToad1ZwMRi28iC=MQ2D+vnTBLKBU+UOBanTWnuQQzRA@mail.gmail.com>
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

On Wed, 9 Dec 2020 at 15:37, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, Dec 08, 2020 at 03:34:57PM +0000, Mel Gorman wrote:
> > Changelog since v1
> > o Drop single-pass patch                                              (vincent)
> > o Scope variables used for SIS_AVG_CPU                                        (dietmar)
> > o Remove redundant assignment                                         (dietmar
> >
> > This reduces the amount of runqueue scanning in select_idle_sibling in
> > the worst case.
> >
> > Patch 1 removes SIS_AVG_CPU because it's unused.
> >
> > Patch 2 moves all SIS_PROP-related calculations under SIS_PROP
> >
> > Patch 3 improves the hit rate of p->recent_used_cpu to reduce the amount
> >       of scanning. It should be relatively uncontroversial
> >
> > Patch 4 returns an idle candidate if one is found while scanning for a
> >       free core.
> >
>
> Any other objections to the series? Vincent marked 1, 3 and 4 as
> reviewed. While patch 2 had some mild cosmetic concerns, I think the
> version and how it treats SIS_PROP is fine as it is to keep it
> functionally equivalent to !SIS_PROP and without adding too many
> SIS_PROP checks.

while testing your patchset and Aubrey one on top of tip, I'm facing
some perf regression on my arm64 numa system on hackbench and reaim.
The regression seems to comes from your patchset but i don't know
which patch in particular yet

hackbench -l 256000 -g 1

v5.10-rc7 + tip/sched/core 13,255(+/- 3.22%)
with your patchset         15.368(+/- 2.74)  -15.9%

I'm also seeing perf regression on reaim but this one needs more
investigation before confirming

TBH, I was not expecting regressions. I'm running more test to find
which patch is the culprit


>
> --
> Mel Gorman
> SUSE Labs
