Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B712C3A06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 08:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727726AbgKYHWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 02:22:33 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:35306 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgKYHWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 02:22:32 -0500
Received: by mail-lf1-f44.google.com with SMTP id a9so1725302lfh.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 23:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pZIqZIlGJn/OymPnQSp5KRFU9tOp32VwHQtRyplJ3/4=;
        b=HRbPo/f7EzqtEssWsZatqok783hGC/PcC/OT1PauRrffUElRl4WMdzAxy8634DBEHr
         1dDIcShymWmolFzubmM3KB7qHdT1jFEAr8BN3MPcF4DzYxzIPmyWFvcn2U8fsZGLJtzt
         hv+GLohOc0eE4vTAwmdDmCSbZ273ctIBFIBqGRhyzHPg7A62p++ClzGMeoOO3DZUyktv
         Jhf50V982hMghQj1olwtXPBS1QR20gZOZh0vKJFhnaCtdvPCz/F0fHWe1dQhZrjPap5m
         GcQvONtQkazkxbvTIcyDhjRvGfVkEfDZcfH/IQI9z5Cax/ugPqcQmL0MeL8tD6qxCn9j
         XOzw==
X-Gm-Message-State: AOAM531oq7mv93+PEB5TAQM/1vstmfRl0ezewUISgBAjUMfxStHMLDFV
        LOyD/z7e4othMekeNaP5hil2MN6BU8Lui69dQcg=
X-Google-Smtp-Source: ABdhPJwHVkHklRcG95MU+YmjjZNGehivJHVaB+N4O6g+qm39P2EDNKRnt9WiX5Ft6N9elJHZB62RMKkniKUCuCDqQfU=
X-Received: by 2002:a19:a48:: with SMTP id 69mr755467lfk.5.1606288940978; Tue,
 24 Nov 2020 23:22:20 -0800 (PST)
MIME-Version: 1.0
References: <20201121025011.227781-1-namhyung@kernel.org> <20201123142321.GP3021@hirez.programming.kicks-ass.net>
 <CAM9d7cji+M+qVm4g48Jcgnfjm-=3HVVtv49ntDpksQx8aBdSyQ@mail.gmail.com> <20201124080951.GE2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201124080951.GE2414@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 25 Nov 2020 16:22:09 +0900
Message-ID: <CAM9d7chpprnGZEOrTGYE1j1+HyCnr6tYC+Upjh06X5JiLp8-UQ@mail.gmail.com>
Subject: Re: [RFC] perf/x86: Fix a warning on x86_pmu_stop()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Sperbeck <jsperbeck@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 5:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Nov 24, 2020 at 02:01:39PM +0900, Namhyung Kim wrote:
>
> > Yes, it's not about __intel_pmu_pebs_event().  I'm looking at
> > intel_pmu_drain_pebs_nhm() specifically.  There's code like
> >
> >         /* log dropped samples number */
> >         if (error[bit]) {
> >             perf_log_lost_samples(event, error[bit]);
> >
> >             if (perf_event_account_interrupt(event))
> >                 x86_pmu_stop(event, 0);
> >         }
> >
> >         if (counts[bit]) {
> >             __intel_pmu_pebs_event(event, iregs, base,
> >                            top, bit, counts[bit],
> >                            setup_pebs_fixed_sample_data);
> >         }
> >
> > There's a path to x86_pmu_stop() when an error bit is on.
>
> That would seem to suggest you try something like this:
>
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 31b9e58b03fe..8c6ee8be8b6e 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1945,7 +1945,7 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
>                 if (error[bit]) {
>                         perf_log_lost_samples(event, error[bit]);
>
> -                       if (perf_event_account_interrupt(event))
> +                       if (iregs && perf_event_account_interrupt(event))
>                                 x86_pmu_stop(event, 0);
>                 }
>

That would work too and much simpler!

Thanks,
Namhyung
