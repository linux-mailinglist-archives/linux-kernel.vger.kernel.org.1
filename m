Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 640E02D6FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 06:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389597AbgLKFZk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 00:25:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:33514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387788AbgLKFY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 00:24:57 -0500
Date:   Thu, 10 Dec 2020 21:24:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607664257;
        bh=X53AzlniLOSte9i5RtPLFsZP2tbVbZIA28+RG2pHkeM=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=EvpWLkpe/mzaTNY5Pt29gIGpfOhcqsgZx0Au9kehGorgOEtdCWVeDdZrHdRucV0Ht
         KAzQkO10m4CBZppvwIMAPfr1zHOat36P0wq/aH1vmfY+ZXkFLacekd9YJ6dCqGogqS
         1kB1UVc51vPu68AjpKU4Bfkuz8w06cJDWYiLLox0=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Joe Perches <joe@perches.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
Message-Id: <20201210212416.15d48d2a924f2e73e6bd172b@linux-foundation.org>
In-Reply-To: <CANpmjNN3akp+Npf6tqJR44kn=85WpkRh89Z4BQtBh0nGJEiGEQ@mail.gmail.com>
References: <20201201152017.3576951-1-elver@google.com>
        <CAKwvOdkcv=FES2CXfoY+AFcvg_rbPd2Nk8sEwXNBJqXL4wQGBg@mail.gmail.com>
        <CANpmjNOUHdANKQ6EZEzgbVg0+jqWgBEAuoLQxpzQJkstv6fxBg@mail.gmail.com>
        <CANpmjNOdJZUm1apuEHZz_KYJTEoRU6FVxMwZUrMar021hTd5Cg@mail.gmail.com>
        <CANiq72kwZtBn-YtWhZmewVNXNbjEXwqeWSpU1iLx45TNoLLOUg@mail.gmail.com>
        <CANpmjNN3akp+Npf6tqJR44kn=85WpkRh89Z4BQtBh0nGJEiGEQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Dec 2020 17:25:30 +0100 Marco Elver <elver@google.com> wrote:

> On Thu, 10 Dec 2020 at 14:29, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Thu, Dec 10, 2020 at 11:35 AM Marco Elver <elver@google.com> wrote:
> > >
> > > It looks like there's no clear MAINTAINER for this. :-/
> > > It'd still be good to fix this for 5.11.
> >
> > Richard seems to be the author, not sure if he picks patches (CC'd).
> >
> > I guess Masahiro or akpm (Cc'd) would be two options; otherwise, I
> > could pick it up through compiler attributes (stretching the
> > definition...).
> 
> Thanks for the info. I did find that there's an alternative patch to
> fix _Static_assert() with genksyms that was sent 3 days after mine
> (it's simpler, but might miss cases). I've responded there (
> https://lkml.kernel.org/r/X9JI5KpWoo23wkRg@elver.google.com ).
> 
> Now we have some choice. I'd argue for this patch, because it's not
> doing preprocessor workarounds, but in the end I won't make that call.
> :-)

I have
https://lkml.kernel.org/r/20201203230955.1482058-1-arnd@kernel.org
queued for later this week.

