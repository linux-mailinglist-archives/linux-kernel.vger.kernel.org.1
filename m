Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C634C2F64F8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 16:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbhANPpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 10:45:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727954AbhANPpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 10:45:39 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDA6C061574
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:44:59 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id p13so6982588ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 07:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GtCP+Ok1DvRmbjCcccGM/bJZ3mfMPFPc2QuZ+61hC3g=;
        b=otpOKbI4XDtf+VZvSZHELbWhdVXbuSe6TbNl+rYPERXwQvFdNf+aD9uuRS2AvpqQL7
         aoeVeyNHbP6FLqLCXl4HxZLxFhj+YmnlMTs5IzdOnfR2+6l2d853NEjSIzbH3JqrfcFW
         30TEfLwp0RaLvdy3ml3P1itgTAYd6hQlZ0AL3E4xIga0g817yDWm7yayaMUBt30gQ2wF
         dHxA7RXLGU6PhMxmqxfNr1Q5Tyc4tlp2PJUwtT93UHc6F7YxPW/DoJziHm0QoJq2it09
         caaWgAvSZ29THvPCzY1LNPntfOGCXIcSJ9Pbq9QsnX+qvAdyorr+J+a9ggmjQK4Z6GXm
         MdVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GtCP+Ok1DvRmbjCcccGM/bJZ3mfMPFPc2QuZ+61hC3g=;
        b=sNerGrXKwqTXaSIgToHmGU0t2XmUIgfye82CcVhqLBBct7hJ55qKjXJdiO1I8oMtBg
         H5hEGvcmAwODpW6uenb3sllp/Ii6+CvlmRegw7UHHcmFDWzemWLDeePrPTNXMNKVRV2s
         SJ6r9YPdU9ECBKsTH+Oxl1clH75YradQFmMIatUdzY3ZOt5+vhKuFrKMBeIelKsigpgR
         ktmbWHyjhGywBnSRDuaqoB+pUWnYIkEtFqTia6SV5WJjxJ4Qfse7i9OTqChbifk2zbCZ
         J/nmq/0WF8FD1LRUdUCYaFtFk0OWS8DC9qp3smRXNzsWoKQhI7CYOMZzN1JhteNJYlS3
         h/qw==
X-Gm-Message-State: AOAM533EI4Cta7bvFdnp7yKTJadNVfRj10l8pLKIqIw/rU23i10jRDRR
        GM5LF1Akerb6SyYicRrELHhq5vHPJzXIDVejEgsDUQ==
X-Google-Smtp-Source: ABdhPJy75ujCVH/z5FgU6xRFD0CjIvG9m62zwBroAxtka3puhw+nUH7QW71q99FNtBCs4zWWav1N/nfZd2MaQzUfmq4=
X-Received: by 2002:a2e:7613:: with SMTP id r19mr3593806ljc.284.1610639097584;
 Thu, 14 Jan 2021 07:44:57 -0800 (PST)
MIME-Version: 1.0
References: <20210111155047.10657-1-mgorman@techsingularity.net>
 <20210111155047.10657-6-mgorman@techsingularity.net> <CAKfTPtDPZA1CdE_t+co4DmvfEUys9OiUdgtessFdQe6dYjo4pg@mail.gmail.com>
 <20210114093543.GM3592@techsingularity.net> <CAKfTPtAbQLYgjRTqdpDPwA+1ff2cUtNqOVbd5cGz_cHpZO=9WA@mail.gmail.com>
 <20210114135328.GN3592@techsingularity.net>
In-Reply-To: <20210114135328.GN3592@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 14 Jan 2021 16:44:46 +0100
Message-ID: <CAKfTPtCCjsJG8G5EQfdyLgiaQUqZFiapRGtrP8wTP7k-6qvSxQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] sched/fair: Merge select_idle_core/cpu()
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Li Aubrey <aubrey.li@linux.intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 at 14:53, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Thu, Jan 14, 2021 at 02:25:32PM +0100, Vincent Guittot wrote:
> > On Thu, 14 Jan 2021 at 10:35, Mel Gorman <mgorman@techsingularity.net> wrote:
> > >
> > > On Wed, Jan 13, 2021 at 06:03:00PM +0100, Vincent Guittot wrote:
> > > > > @@ -6159,16 +6171,29 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> > > > >         for_each_cpu_wrap(cpu, cpus, target) {
> > > > >                 if (!--nr)
> > > > >                         return -1;
> > > > > -               if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
> > > > > -                       break;
> > > > > +               if (smt) {
> > > >
> > > > If we want to stay on something similar to the previous behavior, we
> > > > want to check on all cores if test_idle_cores is true so nr should be
> > > > set to number of cores
> > > >
> > >
> > > I don't think we necessarily want to do that. has_idle_cores is an
> > > effective throttling mechanism but it's not perfect. If the full domain
> > > is always scanned for a core then there can be excessive scanning in
> >
> > But that's what the code is currently doing. Can this change be done
> > in another patch so we can check the impact of each change more
> > easily?
>
> Ok, when looking at this again instead of just the mail, the flow is;
>
>         int i, cpu, idle_cpu = -1, nr = INT_MAX;
>         ...
>         if (sched_feat(SIS_PROP) && !smt) {
>                 /* recalculate nr */
>         }
>
> The !smt check should mean that core scanning is still scanning the entire

yes good point. I missed  this change.

> domain. There is no need to make it specific to the core account and we
> are already doing the full scan. Throttling that would be a separate patch.
>
> > This patch 5 should focus on merging select_idle_core and
> > select_idle_cpu so we keep (almost) the same behavior but each CPU is
> > checked only once.
> >
>
> Which I think it's already doing. Main glitch really is that
> __select_idle_cpu() shouldn't be taking *idle_cpu as it does not consume
> the information.

 don't really like the if (smt) else in the for_each_cpu_wrap(cpu,
cpus, target) loop  because it just looks like we fail to merge idle
core and idle cpu search loop at the end.

But there is probably not much we can do without changing what is
accounted idle core  search in the avg_scan_cost


>
> > > workloads like hackbench which tends to have has_idle_cores return false
> > > positives. It becomes important once average busy CPUs is over half of
> > > the domain for SMT2.
> > >
> > > At least with the patch if that change was made, we still would not scan
> > > twice going over the same runqueues so it would still be an improvement
> >
> > yeah, it's for me the main goal of this patchset with the calculation
> > of avg_can_cost being done only when SIS_PROP is true and the remove
> > of SIS_AVG
> >
> > any changes in the number of cpu/core to loop on is sensitive to
> > regression and should be done in a separate patch IMHO
> >
>
> Understood.
>
> --
> Mel Gorman
> SUSE Labs
