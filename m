Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD5B2A03A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgJ3LDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgJ3LDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:03:48 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F15C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:03:47 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id x1so6210171eds.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 04:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7zx4TIUnsQrrXqxFtOj8pvlioHEXpeSZN5bBWlBEhQ=;
        b=I1/ys+VaHfbBF0QvbBXReAkTl+uttfJMYRAwNaTWWJ2Xhq5RpZIQJU+dabIXeJYNEg
         gx9e6M3AsojMu7eYT8kIT6iIbsdsS5OzdlCsyTYINdsFpETgQ52TYKJzougWeK/8/zPz
         /WvR0po5Z1qlo1angvbFK+TSgtVTus88eT+0dnY7mbUVHXfQ3ssOm4aPMd/OIbmdAlZC
         faQzAhyyyC8v7zrG5MMoYUoQ0LBrQw5IgONUicXEErKEdueLW6tSfpjwVxHLXK3EWSJy
         zisyV0XPls5Hu5ziQTzFZEQ4KFaqaryOisPhL4KToHPYogCAL/LonCdQEbRw/MEwexf5
         cloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7zx4TIUnsQrrXqxFtOj8pvlioHEXpeSZN5bBWlBEhQ=;
        b=GBBoBX5DL/pXsgfTo9kSKWN0qoo1kFN6U39aMc5mkXhNwC/wAncv098FXCVp5z626U
         rK8woTnd+k5S5cQqoUUEh1b+d2HM/QC7rUDh1307HMHmFuq+ScIo2t5G5+pruV7+jvuR
         JPG43wDVC0UO4EcsjYdiVqKXYmNPPTInuDDgL9Egwuvi5KmzNjcWMVYOYtrEMDkVjQZf
         6HHlEeySPFv3WBPNpv5eOSm8cSdOvQJTyigzj6qR/4wRNMsKpAUaKXmmH1Sx9uxLDXVf
         HPuj6yW0cHwMemGkLcLcZ2bXp9ds5EwpGrY7KIMDGVsy8nBv6F9qXcIVmfvNt7kRmA+f
         e6Ow==
X-Gm-Message-State: AOAM533kYQQSuWineIj3p5tXG6ZFJdYZ1QOSaUe2hltBLaSUTg8rOTbA
        RsEDP2Uz/PwWSBCpYwE9otl8gUJA0G82XGnIUg4X+g==
X-Google-Smtp-Source: ABdhPJxXAulAfNy2sLVQ1cI9M14YeFTAZNBUx23QdF/e7fRVyPCsyJ8tC2UtBZr+WKOuySGI2pLEORx1qbFF0NjRZ8E=
X-Received: by 2002:a50:d987:: with SMTP id w7mr1622533edj.113.1604055826484;
 Fri, 30 Oct 2020 04:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201026122728.8522-1-brgl@bgdev.pl> <20201026131427.GF4077@smile.fi.intel.com>
 <CAMRc=MfuejMqpcfOedPMMTR3EY6s2K+4whoWyk7RmJYPaB176w@mail.gmail.com>
 <20201030105706.GK4077@smile.fi.intel.com> <20201030105834.GL4077@smile.fi.intel.com>
In-Reply-To: <20201030105834.GL4077@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Fri, 30 Oct 2020 12:03:35 +0100
Message-ID: <CAMpxmJWxsNY_Eepq2fx0diDr96prBZKGtyb2j43PLe4_vGZAwA@mail.gmail.com>
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

On Fri, Oct 30, 2020 at 11:56 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>

[snip]

> > >
> > > Any use case? Because to me it sounds contradictory to the whole idea of [k]realloc().
> >
> > This is kind of a gray area in original krealloc() too and I want to
> > submit a patch for mm too. Right now krealloc ignores the __GFP_ZERO
> > flag if new_size <= old_size but zeroes the memory if new_size >
> > old_size.
>
> > This should be consistent - either ignore __GFP_ZERO or
> > don't ignore it in both cases. I think that not ignoring it is better
> > - if user passes it then it's for a reason.
>
> Sorry, but I consider in these two choices the best is the former one, i.e.
> ignoring, because non-ignoring for sizes less than current is counter the
> REalloc() by definition.
>
> Reading realloc(3):
>
> "If the new size is larger than the old size, the added memory will not be
> initialized."
>
> So, supports my choice over yours.

Kernel memory management API is not really orthogonal to the one in
user-space. For example: kmalloc() takes the gfp parameter and if you
pass __GFP_ZERO to it, it zeroes the memory even if user-space
malloc() never does.

On Fri, Oct 30, 2020 at 11:57 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>

[snip]

>
> Two notes:
>  - perhaps kzrealloc() for what you want

It could be used as a helper wrapper around krealloc() but kzalloc()
is already a simple kmalloc() with additional __GFP_ZERO flag passed.
This is why I think krealloc() should honor __GFP_ZERO.

>  - there is a library call reallocarray() which supports your idea about
>    krealloc_array() API in kernel.
>

reallocarray() is a bsd extension. I'd stick to krealloc_array()
naming in the kernel.

Bartosz
