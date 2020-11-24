Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215512C1FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 09:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730470AbgKXITr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 03:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730248AbgKXITr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 03:19:47 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1B8C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:19:46 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v92so18513191ybi.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 00:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K3xcx/XNvUUEkkmaeMwDoHzUGPahNqFhDIslBuRSBVM=;
        b=HU5h4FoTU5Rf/b1LZ7w6tJY1r25Jjt3sn4biy8QhE2DKhC7iFKJRIs5VCCaLXaN4Yc
         4UzPVloq754+B+K2VlRUclv8vQSp+qg9brJYKBgUjOmyEv7/rTlcG3pqQqXMXQ8Au3+v
         BlT+d7Yw7uFm36PspPOxSTtO6qlv+e6wf/0YLJFE3VKwVPtGDX9F3x2TNICHWEMYF61e
         PaMUURfE4/FJG1d7KyGal0kxnAatqnV5SIQkQiTSYfEx/ffV/MDa2oalX3/PZ++98YAT
         38BwTxDUklW8VfqT4xD374cajoDRLRa9V74ze2gZbR1HaOt11qkOISy1j2ls0mP3xck2
         UCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K3xcx/XNvUUEkkmaeMwDoHzUGPahNqFhDIslBuRSBVM=;
        b=RiHwUKQ8Kn4NspPTf6+J4q7ocAW1cyb5jKFHWqVgWPZNM8OMSJzyOR+maw725RrByW
         GfIeRTJeyZj66gDW3nuzgwjPYYjfE4ijFRdHlMKv+HT1Lmew8wv5WE2nLw9XxuReAwEq
         3AuAZVskQ7+OCwR0dDe44mFN7QTDBk7mX2FZEj3SIkV0grm9InTcJnl0QS2V00/SZaV0
         sb0laJIm9kBF+C33DkgOsFvBfiUi+Yz9pJkbIXYBBDn5eN5zGkeM5myUsH97P2qR3vAr
         3uW+J5o5HPIa5jfAeRnw1ZjYSMj/oJN14dK/Vs1rL8yvlK7zHe2wGwI7mfZo9EI8emdh
         yaAg==
X-Gm-Message-State: AOAM530PhKCAF6LhBKg5Icq782esOsccWGFxCIHSfEyFQtbYzjp9uyN7
        YLSapuFsB+Yi3gRAhqKgptIh3GO3hzGcgV7Kpy+z1WH2ruQHiA==
X-Google-Smtp-Source: ABdhPJynrjasv5Iv/msugIVqxikOu6T4JLH8WXv4bdjP3xc8owb7i/GIevAjDm5HAfMZ8/sucaWHpwpoxGqUkDkjNFA=
X-Received: by 2002:a25:20d5:: with SMTP id g204mr4012344ybg.136.1606205985906;
 Tue, 24 Nov 2020 00:19:45 -0800 (PST)
MIME-Version: 1.0
References: <20201121025011.227781-1-namhyung@kernel.org> <20201123142321.GP3021@hirez.programming.kicks-ass.net>
 <CAM9d7cji+M+qVm4g48Jcgnfjm-=3HVVtv49ntDpksQx8aBdSyQ@mail.gmail.com> <20201124080951.GE2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201124080951.GE2414@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 24 Nov 2020 00:19:34 -0800
Message-ID: <CABPqkBSvcj1c5-SO4PQLc2KLLf7_0bW4ftUyvFobyd0OVAmLrA@mail.gmail.com>
Subject: Re: [RFC] perf/x86: Fix a warning on x86_pmu_stop()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        John Sperbeck <jsperbeck@google.com>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Another remark on the PEBS drainage code, it seems to me like a test
is not quite correct:
intel_pmu_drain_pebs_nhm()
{
...
               if (p->status != (1ULL << bit)) {
                        for_each_set_bit(i, (unsigned long *)&pebs_status, size)
                                error[i]++;
                        continue;
                }

The kernel cannot disambiguate when 2+ PEBS counters overflow at the
same time. This is what the comment for this code suggests.
However, I see the comparison is done with the unfiltered p->status
which is a copy of  IA32_PERF_GLOBAL_STATUS at the time of
the sample. This register contains more than the PEBS counter overflow
bits. It also includes many other bits which could also be set.

Shouldn't this test use pebs_status instead (which covers only the
PEBS counters)?

          if (pebs_status != (1ULL << bit)) {
          }

Or am I missing something?
Thanks.


On Tue, Nov 24, 2020 at 12:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
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
