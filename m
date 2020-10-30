Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C03FD2A053F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgJ3MWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgJ3MVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:21:13 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B459C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 05:21:13 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s15so8294972ejf.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 05:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yCKWkz6WsiFrJUW0f9hCTQKUvyKMyz6Kme4fPCErzMk=;
        b=HELDt+tcVG9L3FE/J2f9SWBNccZarXz9UfbOm7YD1rQwIjLP/0vg56ErKLexeBW8sm
         mAFVsZjE5XfkAO1q88Vixk09s/9NonMe/UM+n+F9G8KT6d8OjomKa6v2ECYUGTAJfgN3
         A5E5H/CZNDC+752lzKX+wzbF+GPu2Q2GBEH7ssg4mchVzX/OK0cXurqHBOMXs/kxRclm
         ILLLQ5jvR68/BTTmyCqbp6P8v2+nSBO0Oyax+QsxmCZgXdKHxu7z0wiI3VRwksT01jv7
         Sk7yuWkl+MiEdmDuA+Mzuhb4nLUAAmQZoKRso/Oh8J0v/k/C5nG/OeR4jegW8HRSeuCV
         sKKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yCKWkz6WsiFrJUW0f9hCTQKUvyKMyz6Kme4fPCErzMk=;
        b=Je8X/xcf/ABBORmHPV+00+mAvyShZELdks2Va69PBS0uqbtR+IU7TKc8/O+CwdZcu8
         h5owylLUorkpNABVOgqLAt09xLdWpjXFt+s5o8wrqKzXbF0faGzdPwGNoIxBD/U9i2UC
         Sd+5Za0VgJjIC76X2nM1gBEpPi1EsNu4QthGQtYlBPgNkOOog1SivgRtuCvE/v6Z1Y8K
         4fy/KMhpluE80fFqAIx3FGxqlHLcQejWy3wXzVICClnZPAmIH1NSuPp6CBYMR/GMdE9F
         H1dqDupvWDWzQG4MWSzOFCJ+OkY1mOl4oS9EBwrEYK2mjFRy1n1mCtnKD3+qGuGlejUr
         Yjzw==
X-Gm-Message-State: AOAM530MzWYTt32doHncV1fUe8RQgGNbC+x7qHkN8jMXhaZVhiyYtW5O
        Eb8GV9zYB9SZH/VAYpmktDyqaUYkjXqcsQjwcH4v1Q==
X-Google-Smtp-Source: ABdhPJxnQljVKJszeD8urGRCQBiLaoP1QQuhatJDvcsf8NS/HjBn9WiJd+WA6s5d90ZqXyp+cs4xMg8CILkelzMooZA=
X-Received: by 2002:a17:906:b009:: with SMTP id v9mr2291539ejy.155.1604060471862;
 Fri, 30 Oct 2020 05:21:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201026122728.8522-1-brgl@bgdev.pl> <20201026131427.GF4077@smile.fi.intel.com>
 <CAMRc=MfuejMqpcfOedPMMTR3EY6s2K+4whoWyk7RmJYPaB176w@mail.gmail.com>
 <20201030105706.GK4077@smile.fi.intel.com> <20201030105834.GL4077@smile.fi.intel.com>
 <CAMpxmJWxsNY_Eepq2fx0diDr96prBZKGtyb2j43PLe4_vGZAwA@mail.gmail.com>
In-Reply-To: <CAMpxmJWxsNY_Eepq2fx0diDr96prBZKGtyb2j43PLe4_vGZAwA@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 30 Oct 2020 13:21:00 +0100
Message-ID: <CAMpxmJV43KqQEdY1MfgsXn_uvNqewDGZJkPXDU+0jOkG=2wTbg@mail.gmail.com>
Subject: Re: [PATCH] devres: zero the memory in devm_krealloc() if needed
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 12:03 PM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Fri, Oct 30, 2020 at 11:56 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
>
> [snip]
>
> > > >
> > > > Any use case? Because to me it sounds contradictory to the whole idea of [k]realloc().
> > >
> > > This is kind of a gray area in original krealloc() too and I want to
> > > submit a patch for mm too. Right now krealloc ignores the __GFP_ZERO
> > > flag if new_size <= old_size but zeroes the memory if new_size >
> > > old_size.
> >
> > > This should be consistent - either ignore __GFP_ZERO or
> > > don't ignore it in both cases. I think that not ignoring it is better
> > > - if user passes it then it's for a reason.
> >
> > Sorry, but I consider in these two choices the best is the former one, i.e.
> > ignoring, because non-ignoring for sizes less than current is counter the
> > REalloc() by definition.
> >
> > Reading realloc(3):
> >
> > "If the new size is larger than the old size, the added memory will not be
> > initialized."
> >
> > So, supports my choice over yours.
>
> Kernel memory management API is not really orthogonal to the one in
> user-space. For example: kmalloc() takes the gfp parameter and if you
> pass __GFP_ZERO to it, it zeroes the memory even if user-space
> malloc() never does.
>

Ok so I was wrong - it turns out that krealloc() is consistent in
ignoring __GFP_ZERO after all. In that case this patch can be dropped.

Bartosz
