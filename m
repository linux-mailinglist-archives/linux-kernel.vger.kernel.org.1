Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B13D229A6C1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394732AbgJ0IlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:41:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:47058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2443768AbgJ0IlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:41:21 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68EDD22263
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603788080;
        bh=773WJDJpADhEjRvR38+Lr1yV8zkX34vnse/AJMhGUZk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IKdAAxYU3adzGJNnwX5HaxYgD8+tccpfF9YwgQETgv1kiRgl0yfZSghigwWgG205/
         CiQIQ6pPwhWAde6M3wbe8qE+ZpJxISLgos5z9bWk1tR2w480ovaUr1lWWgkmLSmd1n
         ++wYqaT72kWh03fkrgnAtg2oX2X51sV3X0KrsqZA=
Received: by mail-qk1-f176.google.com with SMTP id x20so454139qkn.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 01:41:20 -0700 (PDT)
X-Gm-Message-State: AOAM533OSom9B8bNMC96DNudo6RqLCd9iHCnixRi8cFQODxqZdVs/dID
        I/+sHjCxu026ByMFMzXFLFRiRkfWcY4TkXdXGz0=
X-Google-Smtp-Source: ABdhPJyaaRYA2ToOrU7SVnL1LfW8Wy4LZFXX4cy+7GIMN0BrIOHr8+wcWaAP3+xOlOnnhsoKfIUz5xVWQ5rZIQMdn1g=
X-Received: by 2002:a05:620a:b13:: with SMTP id t19mr941271qkg.3.1603788079456;
 Tue, 27 Oct 2020 01:41:19 -0700 (PDT)
MIME-Version: 1.0
References: <20201026215004.3893088-1-arnd@kernel.org> <b185c2d6-e890-6e56-3349-2ab023637af0@kleine-koenig.org>
In-Reply-To: <b185c2d6-e890-6e56-3349-2ab023637af0@kleine-koenig.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 27 Oct 2020 09:41:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a30xWy5nOZqYF16nuODfThsKxjqp6J2-PanKiv09SxVYg@mail.gmail.com>
Message-ID: <CAK8P3a30xWy5nOZqYF16nuODfThsKxjqp6J2-PanKiv09SxVYg@mail.gmail.com>
Subject: Re: [PATCH] printf: fix Woverride-init warning for EDEADLK errno
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <uwe@kleine-koenig.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 27, 2020 at 7:55 AM Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.or=
g> wrote:
> On 10/26/20 10:49 PM, Arnd Bergmann wrote:
> > Make that line conditional on the two values being distinct.
> >
> > Fixes: 57f5677e535b ("printf: add support for printing symbolic error n=
ames")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  lib/errname.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/lib/errname.c b/lib/errname.c
> > index 0c4d3e66170e..6adff0bf2445 100644
> > --- a/lib/errname.c
> > +++ b/lib/errname.c
> > @@ -169,7 +169,9 @@ static const char *names_0[] =3D {
> >       E(ECANCELED), /* ECANCELLED */
> >       E(EAGAIN), /* EWOULDBLOCK */
> >       E(ECONNREFUSED), /* EREFUSED */
> > +#if EDEADLK !=3D EDEADLOCK
> >       E(EDEADLK), /* EDEADLOCK */
> > +#endif
>
> The comments suggest that duplicates are expected. Would it make sense
> to add similar conditions to the other three entries?

The other ones are always aliases, so there is no point in having
an #ifdef. The reason we need to handle EDEADLK separately
is that it's an alias on most architectures but not on on others,
specifically mips, powerpc and sparc.

       Arnd
