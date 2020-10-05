Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C661283DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgJER5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgJER5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:57:43 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BD0C0613CE;
        Mon,  5 Oct 2020 10:57:43 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id u9so8616386ilj.7;
        Mon, 05 Oct 2020 10:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=nNid7HYJ8WI2NlxwB4VddDH9u7bC1gHnaATJfb5dWa4=;
        b=tqPhbNqPLtkEOsB5HriwtDUTChXkeE3ahNYggJHEfnOtoJ2R/UCj0gLpSoms/b+tZ3
         rXOS++NLRTwHYLJOhqlXocRAQPRFaxStX4GwTuP+/NRV7fr4h1EgGijLqC5bVeyhn2s9
         MTww1eCbdnCYn6uG7BB1bUmQ3YQ5/JIIOQT9XnPra9EzIvGKR/j4ZKxyMgwL6dc4ePeF
         RN6oxEhFyZvNTkC9lFJLUgHlvCvyVFvf+1nCudyblgRvQ8tBvU8PomJOmYNiDHydzVsU
         6P0TT4AVmM2/G0u9E7WQ9G2DfQDw5/NoNk4XlS7VEYdxbW0JdKZmC4ezR4AOpDolsjS7
         0ILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=nNid7HYJ8WI2NlxwB4VddDH9u7bC1gHnaATJfb5dWa4=;
        b=HcrThniv8yZ8vExVCmA08bu0t+h3A1OQlmGF6Q3Mv7g3JW5L/weFN9X6ylbtInAa2I
         VSRVo9gNMSbHSOS6RHVbBma5H15nV3U00YYRkBOIPTbS0uBwrYw8PnVy6dkv3QtmSJFm
         no2Ni/E6w+dtJURU0MFceBXa71AxLOFeKI3pjJvZH7po0BCMYYkPjf5ZYKIg0GX6oo4u
         2RsEqLoOjPIxgQ8H1uDkBbHi6Ue6dOgDBwmeF7uJFX6AUe7vxer1xSYgO/eXaup1JN1T
         /eVUJwWk2skYHCMWwnl6ddIDTTUg36XQzhPy+6hkUOKgTQ/kP5smO85cxJmuBb7Y4BMB
         mkDA==
X-Gm-Message-State: AOAM532G1zKIpJk6Rym0Km/WVTBCQBMaQEVBhs+srA9BpwSxp/JgQXmQ
        N7B9V4BwZrCStdZhLetznSJFtiJVCe9zEcDdlek=
X-Google-Smtp-Source: ABdhPJxPoJs2LEaePwe96riHWPU4sTA3wdwIBJU4UWPcS9uDBgbFHMtsOhQ+j0vgeLCPidt3l9/rMfCFe6tf1Y46Kjk=
X-Received: by 2002:a92:c986:: with SMTP id y6mr475624iln.10.1601920662654;
 Mon, 05 Oct 2020 10:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmFm9-FPrqt42NsusWRbDzNx6NF1GeSJhz_9kaAGV8eOA@mail.gmail.com>
 <20200930173719.GE2628@hirez.programming.kicks-ass.net> <CAKwvOdk+Rp0QGJmX07XxD8L7WVgco98LHFTu-R_2R22+UMVerQ@mail.gmail.com>
 <20200930.152652.1530458864962753844.davem@davemloft.net> <CA+icZUXjYTJO4cC1EAhbdqnd19HjAwyFM+iSTW37xJM5dFHQuA@mail.gmail.com>
 <20201002172238.GT28786@gate.crashing.org> <4cf8e2ba-3120-7f25-a9a2-1707d3f88276@infradead.org>
 <CAKwvOdktSmMF3PraK25ZKxAyhxrWRXzL74=vf5wf5m+5rBOsVA@mail.gmail.com>
In-Reply-To: <CAKwvOdktSmMF3PraK25ZKxAyhxrWRXzL74=vf5wf5m+5rBOsVA@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 5 Oct 2020 19:57:31 +0200
Message-ID: <CA+icZUXZeKi5fpF1hx_-q9aT6h7RTzMLBvZWsOMdqqDV5WzeXQ@mail.gmail.com>
Subject: Re: linux tooling mailing list
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Nick Clifton <nickc@redhat.com>,
        Fangrui Song <maskray@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, postmaster@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Behan Webster <behanw@converseincode.com>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 5, 2020 at 7:50 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
>
> On Fri, Oct 2, 2020 at 10:37 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> > On 10/2/20 10:22 AM, Segher Boessenkool wrote:
> > > On Fri, Oct 02, 2020 at 02:01:13PM +0200, Sedat Dilek wrote:
> > >> On Thu, Oct 1, 2020 at 12:26 AM David Miller <davem@davemloft.net> wrote:
> > >>> From: Nick Desaulniers <ndesaulniers@google.com>
> > >>> Date: Wed, 30 Sep 2020 12:29:38 -0700
> > >>>> linux-toolchains@vger.kernel.org
> > >>>
> > >>> Created.
> > >>
> > >> I am subscribed, too.
> > >>
> > >> Will there be a(n)...?
> > >>
> > >> * archive (for example marc.info)
> > >
> > > A lore archive would be good?
> >
> > That has already been requested.
>
> Hi David,
> Thank you for setting up the mailing list.  I appreciate it.  Now that
> the lore archive has been set up
> (https://lore.kernel.org/linux-toolchains/), would you mind linking to
> it from http://vger.kernel.org/vger-lists.html under archives of
> linux-toolchains?
>

Updating MAINTAINERS file came to my mind... Dunno where ro place the
new ML info?

- Sedat -

> >
> > >
> > >> * patchwork url
> > >
> > > We do not have any repositories associated with this list, and there
> > > won't be many patches anyway, so patchwork will only be useful as a kind
> > > of mail archive.  I can ask to set one up though, if people want that?
>
> Personally, I haven't been using patchwork.  I know some maintainers
> use it to keep track of reviews of lots of patches, but other than
> that is there a major use case for patchwork I'm missing?
>
> > >
> > >
> > > Segher
> > >
> >
> >
> > --
> > ~Randy
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
