Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3670F283DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728536AbgJERur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgJERur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:50:47 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1D0C0613CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 10:50:47 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h6so5790772pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 10:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iCU2zKb0zX7VUtyH/YPsO2btdqIgnBStO9wEsmNZcvc=;
        b=G2CjPJdLtW9bYCXygsK5KVLzXwZIr++2ioaMkOgjd0A35fAs3R1xUKQouzOe4vCKBk
         yC57ybipQPb9zLfLNvT4qPIY/0wbri/s1zE4zAxtJjZaMgNKLHcquNLbSiHcxOQKcUpa
         1l9KpJ7HQEbjs3U3BY3GhrcGhQobXyVYlKLgR58pPk1fC9ygUgaT5dHSDafMIWNX7Tmv
         VxC+TuyrUjSsdr9NRARL8kDCUiSvYMADpv825AG9I8nu0QCtHf0xeZSuBtKi6v+HUCCL
         LZtLatTyhX1wPsM5QUreU3UdiYib27CXTyaWr7vf+QUc8pIDNXMl5FfOjnTRck+/pDUJ
         fQwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iCU2zKb0zX7VUtyH/YPsO2btdqIgnBStO9wEsmNZcvc=;
        b=lz5AGxhDQB2bwSuEfTbpviL0/WyXfCV7UUKWJXoPHoc4rU5mXpCFyAOJwJwDX5lw5J
         nblkwu1AxF+W8rQsfjpeHzVPIIuN0Mj4zSfQltbjhhgRk59uGT2wq+54KxGVfuDPcQIW
         vU/2Mg6hQPoWIVXzJGdixKug0ia/luFLK9qd4u4Jwu4ogJZDTdOL3DVhe5VeIr14KypY
         JF6oqP036fvkU6lTEf9xb7VzQqhDNaIYTtNbghSORAhga0I9lRyzt7vnsOcOdL6D18/w
         YaquVFD5jl66ziuzxorMxtDS0hgbjhx6sujpGjT12ulZM8qH/2B23c+H4ggWWYN6aukP
         AOyw==
X-Gm-Message-State: AOAM532jEw7OmJcuM9u0aE8YynAOsirNFpofrx+LqQh0si/DCz23JaP8
        byqHtKbviLluu8i6Kcivlj3jat7TrGMawXPwbn38Zg==
X-Google-Smtp-Source: ABdhPJyw9QYWIcwsMIgMJRLPO3IlBN1SounnZcV0Ko0H/hfu5W3D1vtTSNJLn9HPYTolBI274oiCrOXu/7R/AlmGtEI=
X-Received: by 2002:a62:1613:0:b029:152:743c:355c with SMTP id
 19-20020a6216130000b0290152743c355cmr894536pfw.15.1601920246217; Mon, 05 Oct
 2020 10:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdmFm9-FPrqt42NsusWRbDzNx6NF1GeSJhz_9kaAGV8eOA@mail.gmail.com>
 <20200930173719.GE2628@hirez.programming.kicks-ass.net> <CAKwvOdk+Rp0QGJmX07XxD8L7WVgco98LHFTu-R_2R22+UMVerQ@mail.gmail.com>
 <20200930.152652.1530458864962753844.davem@davemloft.net> <CA+icZUXjYTJO4cC1EAhbdqnd19HjAwyFM+iSTW37xJM5dFHQuA@mail.gmail.com>
 <20201002172238.GT28786@gate.crashing.org> <4cf8e2ba-3120-7f25-a9a2-1707d3f88276@infradead.org>
In-Reply-To: <4cf8e2ba-3120-7f25-a9a2-1707d3f88276@infradead.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 5 Oct 2020 10:50:35 -0700
Message-ID: <CAKwvOdktSmMF3PraK25ZKxAyhxrWRXzL74=vf5wf5m+5rBOsVA@mail.gmail.com>
Subject: Re: linux tooling mailing list
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Sedat Dilek <sedat.dilek@gmail.com>,
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

On Fri, Oct 2, 2020 at 10:37 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 10/2/20 10:22 AM, Segher Boessenkool wrote:
> > On Fri, Oct 02, 2020 at 02:01:13PM +0200, Sedat Dilek wrote:
> >> On Thu, Oct 1, 2020 at 12:26 AM David Miller <davem@davemloft.net> wrote:
> >>> From: Nick Desaulniers <ndesaulniers@google.com>
> >>> Date: Wed, 30 Sep 2020 12:29:38 -0700
> >>>> linux-toolchains@vger.kernel.org
> >>>
> >>> Created.
> >>
> >> I am subscribed, too.
> >>
> >> Will there be a(n)...?
> >>
> >> * archive (for example marc.info)
> >
> > A lore archive would be good?
>
> That has already been requested.

Hi David,
Thank you for setting up the mailing list.  I appreciate it.  Now that
the lore archive has been set up
(https://lore.kernel.org/linux-toolchains/), would you mind linking to
it from http://vger.kernel.org/vger-lists.html under archives of
linux-toolchains?

>
> >
> >> * patchwork url
> >
> > We do not have any repositories associated with this list, and there
> > won't be many patches anyway, so patchwork will only be useful as a kind
> > of mail archive.  I can ask to set one up though, if people want that?

Personally, I haven't been using patchwork.  I know some maintainers
use it to keep track of reviews of lots of patches, but other than
that is there a major use case for patchwork I'm missing?

> >
> >
> > Segher
> >
>
>
> --
> ~Randy
>


-- 
Thanks,
~Nick Desaulniers
