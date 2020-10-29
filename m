Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42F0929F058
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgJ2Poa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728436AbgJ2Po3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:44:29 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF79BC0613D2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:44:28 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id x7so3505483ili.5
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 08:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpb51NZttJBnWnq8Vun1XDmckUzNTkelTT799oXvNiY=;
        b=dBV8ckq27JKU9AIEHEozvDJhyCFmzOwtV42k2yabh4jx+IF/DuIqKRSeVZm6k+1Vdq
         kZoiKuDqGmKHtUDfiG05dX9+7W/mnUJ7WLMnMaQ8YvL6VdCM9Rev3bULxnWR/BTyGCAv
         mFo54ZFJ7pVTncg1dKlQNpmGPMqTvop9Tl118CJ//5qxdpN3K+JrsZ+8jM3MCDQG84UI
         T3M46+pIpf00s8v6uiEpVA3/kxWHyvvjmZCzaoBi023hcWak/+PxjmeM/o9GlGY44s4+
         nPupogTV+ctzhu1OIL79IxOh+TrfjOJJ4bMxaWl0TkRCsmJK2mdg8k2c3FY7Zmr7yGIi
         Mdfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpb51NZttJBnWnq8Vun1XDmckUzNTkelTT799oXvNiY=;
        b=LDNSZ8Zkrabi0m1MfdjbPevYbvYXr8qvD+VLdYPgIMCgenKdiA5m4W+Ks+cwtaaaqa
         NSsehiWiqXQqm1CsHKIgvh3SlYLNp7sDAEWE5miIy9UjmUq2zeUQwKN+l+EPw+Xob0vR
         NyY30+9kAOmXe73WzRnYK2kARBptOFbTgY5v7He+AN8EqtWTzxm7ES+59bADKzyZgNz7
         xgm1artpfXDaPKg9hLqaq9CUmJAorj20uD93fDb/PFXzg0nMZxxR/QMUnYawQgf0CvJy
         bH+fon0cmpLdOdUhydk0M6MbYvRLoxilB1H+MWd65b5UfBQdUkV6efVwDupvfuKq+7nB
         QvzA==
X-Gm-Message-State: AOAM533zEcOhNpTz2ompktThpIXadGUj30K4ia0TFYDBwYWtas/lAWGf
        Mb1S4+7Ke6FsIQwWWLGLpA/RUR9hRf2UiHlzHknYoA==
X-Google-Smtp-Source: ABdhPJyIx2LsZ7uuYaqDTSJbKc7RHQVW5UitdDD5AvE7zZ4BV6sOQhxg0kz+T4oZrz7Ph/p00Sx/c6iGGR3Iw/DBXi8=
X-Received: by 2002:a92:c214:: with SMTP id j20mr3565841ilo.189.1603986267423;
 Thu, 29 Oct 2020 08:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201026151015.15527-1-brgl@bgdev.pl> <20201029151847.GB5042@sirena.org.uk>
In-Reply-To: <20201029151847.GB5042@sirena.org.uk>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 29 Oct 2020 16:44:16 +0100
Message-ID: <CAMRc=MctRhVzmJwquO5pQDjnNP5HTXrG7qLN7r9Ky+aEuSCBDw@mail.gmail.com>
Subject: Re: [PATCH] regmap: provide regmap_assign_bits()
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 4:18 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Oct 26, 2020 at 04:10:15PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Add another bits helper to regmap API: this one sets given bits if value
> > is true and clears them if it's false.
>
> What's the use case?
>

Basically what the function does: set bits if a condition is true,
clear them if false. I think this is a common enough use-case to
warrant a helper.

> > +static inline int regmap_assign_bits(struct regmap *map, unsigned int reg,
> > +                                  unsigned int bits, bool value)
>
> I don't have a great suggestion but this naming feels prone to confusion
> with _update_bits().

This is already used in bitops - we have set_bit(), clear_bit() and
assign_bit(). People are used to it and I thought I'd stay consistent
with this naming.

Bartosz
