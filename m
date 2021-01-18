Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923212F9A55
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 08:06:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731860AbhARHFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 02:05:07 -0500
Received: from mail-lf1-f44.google.com ([209.85.167.44]:40372 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhARHFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 02:05:01 -0500
Received: by mail-lf1-f44.google.com with SMTP id v24so15896671lfr.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 23:04:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oPwSy7oft+VDkUSBLHsMKUlmCLuusXCOkWMlOuyI7Ro=;
        b=p/yh4Qf8Cn7JgqE/f6P6vHhJoO9CVcmIJVqhng+vQSl5j2RrJYoyJKxYTmriGMi0vq
         DqF+CYh2OC/6DtPu3mb/y5DeTCcPiGHpLFjAs/g11rcRyURK58bOo6kVJKQpHm2V3BFY
         9hJ665bFQ1FkJtSgcTCO7iEXOqYddvSCMvBF/GXNGtEiYhnp+mmqOtJvfcx4/a87b6Wi
         bqf4DCeJYedYHaMLjSbWiWOYhBkSN/rT0qMRYEpU4Ojttt5f3TDMjjGHpAjYbTmNumjG
         5Jt6lJwEuTLSiwXyJbMjwMTsFpyjt7iI8Lo1raorDcwm9L1JHzE7QuZdOuQWQPxNPfAQ
         aZSw==
X-Gm-Message-State: AOAM530uZBUD7L2tBml9KLiXYt/kJIJ1zWnYKjl1prJ9cr6VchTlOzqo
        L22NuUnpIXda3C2i8EkpaiJDFEAMrbVBQ5ffN90=
X-Google-Smtp-Source: ABdhPJxW5SYUDosPvksc5H2uaK10MD4Tmw8YzfmY5K8/mQH6+2OUVH6OvXu1+GvI0qa2CodskCd2aGoVVKVk3f33DOY=
X-Received: by 2002:a05:6512:a8b:: with SMTP id m11mr8720788lfu.112.1610953459180;
 Sun, 17 Jan 2021 23:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20201130193842.10569-1-kan.liang@linux.intel.com>
 <20201130193842.10569-3-kan.liang@linux.intel.com> <20201201172903.GT3040@hirez.programming.kicks-ass.net>
 <CAM9d7ciukm4RAH+44YWhZRummKzk1HTbnZ0Sc4Xd5ZyCo=x0xQ@mail.gmail.com>
 <CAM9d7ciBO=cmgnBVJWpyJ75VHjoxuEA=ck=V1+k8KRBkh23+nw@mail.gmail.com>
 <c868c6f7-c89f-ecc5-b771-2701b6029788@linux.intel.com> <20201210142515.GR2414@hirez.programming.kicks-ass.net>
In-Reply-To: <20201210142515.GR2414@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 18 Jan 2021 16:04:08 +0900
Message-ID: <CAM9d7chme3WFQzsqHeQx+1vaLpCG7qL=D6QO4+_Vnt=byzC5sQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] perf: Optimize sched_task() in a context switch
To:     Peter Zijlstra <peterz@infradead.org>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Gabriel Marin <gmx@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter and Kan,

On Thu, Dec 10, 2020 at 11:25 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Dec 10, 2020 at 08:52:55AM -0500, Liang, Kan wrote:
> >
> >
> > On 12/10/2020 2:13 AM, Namhyung Kim wrote:
> > > Hi Peter and Kan,
> > >
> > > How can we move this forward?
> >
> > Hi Namhyung,
> >
> > Thanks for the test. The changes look good to me.
> >
> > Hi Peter,
> >
> > Should we resend the patch set for further review?
>
> I've not yet seen a coherent replacement of #3, what I send was just a
> PoC.

Any updates?

Thanks,
Namhyung
