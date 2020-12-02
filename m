Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783AD2CCA96
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 00:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbgLBXlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 18:41:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLBXle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 18:41:34 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B9DC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 15:40:54 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v92so325701ybi.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 15:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQR0dYvXVVGwuf8cwqhcQDfB3WAV48KDjEpeGO4rQDg=;
        b=fsgNr5p20rJll8RVZi04Pinsq2mLl5Gxq0js9O8A/+nGsntq8WKJjZzEMvF551ifYn
         faKKI8qUOosRn65yaqMenGJbWkdlROgMkFyqttdKFW1k582DWUzi0jjuYuK+lBITDtgT
         SlP54tHrtSc4Eaw1qufSC0v2fwzl8SkRLYTW3aERtN2DxbNswyh29SwBaVpOCvFbOvo+
         /Kit/WxfB7F2CT63JkmXlA5gTPl4jCntkUpWxkVRebrIDw47y1eSpbBWiVGcFs7TpRjL
         GEtP4oLKRmkKwCCyAbNl7UZwKQg/vOqhE/B0q/uniKWuo2Hch2k/Fu+62byTNH018ept
         5YBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQR0dYvXVVGwuf8cwqhcQDfB3WAV48KDjEpeGO4rQDg=;
        b=pXMwk0goEQUczpLRPGesSYc77b4AbdgTc5vdMi6M/4FjyeEGK4wZ3ENCRq3d6limra
         6uiVCWzJemnXTcUc5RNT8XKSWS4ApOtScxcLK6t5wuzC81LR0FKDoYnfPIvCzhlm+gji
         C0ee6ucy31WCvJF5Y7IuwkvF9IARFLBuwi/CFn3O+1gbej0z3dAdt1SsNunZOSvIjXee
         fZ+XyPW3MHixr4WjikvCHvDVNm7HsvktrJ57r1Bt0CXZR0UoOvutpDeCkdjMjmZBHEBO
         LBykyXuCTEytEJJCoyrHWfzqpz7F0Jm+1vh27QnADhMnDLx81vEYYzw6UyuA4c9IeyrI
         erqg==
X-Gm-Message-State: AOAM530GIMK3mTI5YeexxfjZ2ds22CAGQ4IhxGPsycS0AobWlm6NKGGA
        sNqeeF0ntGPi2m8pgyLwvn42GAxEg1Rp1mzbaFfRKw==
X-Google-Smtp-Source: ABdhPJyqKwInHzRRHo8LQDLzdRDzTGiSRQDr957cvQSh72nCX2L4OLlp3gZy4/fC6N/B/qsor/WbAY8WBAD4nqfh2rE=
X-Received: by 2002:a25:32c9:: with SMTP id y192mr805732yby.211.1606952453178;
 Wed, 02 Dec 2020 15:40:53 -0800 (PST)
MIME-Version: 1.0
References: <20201202150205.35750-1-namhyung@kernel.org> <20201202192828.GG1363814@tassilo.jf.intel.com>
 <CABPqkBR5nCfn756Wb8xQEb9Xse+UQPAbGy969cP4sxO78-Nq4g@mail.gmail.com> <20201202224239.GJ1363814@tassilo.jf.intel.com>
In-Reply-To: <20201202224239.GJ1363814@tassilo.jf.intel.com>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 2 Dec 2020 15:40:42 -0800
Message-ID: <CABPqkBRsS2+gT-792uYq+U84LJepDjY=wwiLku6mtVhgd8mEEA@mail.gmail.com>
Subject: Re: [RFC 1/2] perf core: Add PERF_COUNT_SW_CGROUP_SWITCHES event
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 2:42 PM Andi Kleen <ak@linux.intel.com> wrote:
>
> On Wed, Dec 02, 2020 at 11:47:25AM -0800, Stephane Eranian wrote:
> > On Wed, Dec 2, 2020 at 11:28 AM Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > > +     prev_cgrp = task_css_check(prev, perf_event_cgrp_id, 1)->cgroup;
> > > > +     next_cgrp = task_css_check(next, perf_event_cgrp_id, 1)->cgroup;
> > > > +
> > > > +     if (prev_cgrp != next_cgrp)
> > > > +             perf_sw_event_sched(PERF_COUNT_SW_CGROUP_SWITCHES, 1, 0);
> > >
> > > Seems to be the perf cgroup only, not all cgroups.
> > > That's a big difference and needs to be documented properly.
> > >
> > We care about the all-cgroup case.
>
> Then it's not correct I think. You need a different hook point.
>
I realize that ;-(
