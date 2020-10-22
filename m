Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 526272963A7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 19:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899696AbgJVRYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 13:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899680AbgJVRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 13:24:47 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F15C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 10:24:46 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id l15so2289838ybp.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N6+g/VPwDF/Bbb0Srbs12JB5dodNmqkh4SiLTD3jZCA=;
        b=Fc1cMgwi7DWsPbulB4HF7w/lueTlXI46WazZlLUj79KApbT99YIPhqEOdqYslKkjLb
         Q9wLKo+pQ0XgThc0CevNDaFjIGoCghH9X+qV6qwiutVesVYuNw2sKh2dpTCywDVxjYjS
         R9Vu+8QMJ7FV6OVKYkPi7wOSyrd5ig6eo5hH9ZsyW+zUv4qDA0+/fb5FVOacevHZ3NU2
         +rXSS4i0d8ScISfiQukFxAB5WEVSAOodAz7OtlHeLAz7yygE7GZOXvI+0nC9i9+TZsU/
         iOtqwmNSIK2hFR34FZHjiZWZGFGOV9myC1GrP3eh5lY0XVinQ5KApgDBgh6x/AwCUHXx
         /Wag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N6+g/VPwDF/Bbb0Srbs12JB5dodNmqkh4SiLTD3jZCA=;
        b=KocRp5q+SpUgCjVOlQE4LhKhs5lj8Q+b1X3vvUO+D+ygdNhs/rwxudEqvRKmNnuVG4
         aCDUu4FzEVyx2nZInRgXqnih7frS1LIrgwDyBCMAcz8bkYOlmC8DfwTD8p1vMoe0rPUj
         rF6sylGYqFk80vNgeUYAeCqWVEYTV8IjgPCpcIxGF+WaYxvsysr55SGf/JgTVJ5cn71h
         euiVaYTeYih/V9kSSIp1jvo5/Y7ZmAk+lB+tuo1XJ2WHakoWTKVZ+cPxcVuT3u5lktj5
         RnhZGaXVOwRM51V6PFHqzyi76qrm7sKEGctxCnzIEZ7QpS0CyR+X1AqQHNp5K3wufIh4
         Y8UA==
X-Gm-Message-State: AOAM531M0TQhCbzrnSMIripnbHD7Hl/jpQRIzrZsfzhnuEn2kU6BSMoC
        LuRGhdZjxC+10ir/Fk1QWxIjDcgA+93kYCpqZOQHcS7Z48M=
X-Google-Smtp-Source: ABdhPJyH/T63GxSjCjoQd+h02EpwDCYKC79rOTcmyl/r6ONUukk3X0YYWsr8XEV21pR8d7AVScBUGpOTfCx4STS9I40=
X-Received: by 2002:a25:61d6:: with SMTP id v205mr4814341ybb.294.1603387485785;
 Thu, 22 Oct 2020 10:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201021211612.2026234-1-eranian@google.com> <20201022080003.GR2628@hirez.programming.kicks-ass.net>
In-Reply-To: <20201022080003.GR2628@hirez.programming.kicks-ass.net>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 22 Oct 2020 10:24:34 -0700
Message-ID: <CABPqkBRjKXtpijMnPE-eho+tQtYmgRs2OQe_5u52HxOx-QRq_A@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: make anythread filter support conditional
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Liang, Kan" <kan.liang@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        mingo@elte.hu, Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 1:00 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 21, 2020 at 02:16:12PM -0700, Stephane Eranian wrote:
> > Starting with Arch Perfmon v5, the anythread filter on generic counters may be
> > deprecated. The current kernel was exporting the any filter without checking.
> > On Icelake, it means you could do cpu/event=0x3c,any/ even though the filter
> > does not exist. This patch corrects the problem by relying on the CPUID 0xa leaf
> > function to determine if anythread is supported or not as described in the
> > Intel SDM Vol3b 18.2.5.1 AnyThread Deprecation section.
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> > ---
> >  arch/x86/events/intel/core.c      | 20 ++++++++++++++++++++
> >  arch/x86/events/perf_event.h      |  1 +
> >  arch/x86/include/asm/perf_event.h |  4 +++-
> >  arch/x86/kvm/cpuid.c              |  4 +++-
> >  4 files changed, 27 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> > index f1926e9f2143..65bf649048a6 100644
> > --- a/arch/x86/events/intel/core.c
> > +++ b/arch/x86/events/intel/core.c
> > @@ -4220,6 +4220,16 @@ static struct attribute *intel_arch3_formats_attr[] = {
> >       NULL,
> >  };
> >
> > +static struct attribute *intel_arch5_formats_attr[] = {
> > +     &format_attr_event.attr,
> > +     &format_attr_umask.attr,
> > +     &format_attr_edge.attr,
> > +     &format_attr_pc.attr,
> > +     &format_attr_inv.attr,
> > +     &format_attr_cmask.attr,
> > +     NULL,
> > +};
>
> Instead of adding yet another (which is an exact duplicate of the
> existing intel_arch_formats_attr BTW), can't we clean this up and use
> is_visible() as 'demanded' by GregKH and done by Jiri here:
>
>   3d5672735b23 ("perf/x86: Add is_visible attribute_group callback for base events")
>   b7c9b3927337 ("perf/x86/intel: Use ->is_visible callback for default group")
>   baa0c83363c7 ("perf/x86: Use the new pmu::update_attrs attribute group")
>
> And only have "any" visible for v3,v4

Sure, let me resubmit with these changes.
