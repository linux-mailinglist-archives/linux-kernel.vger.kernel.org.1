Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DEF2A00A7
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 10:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgJ3JEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgJ3JED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 05:04:03 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C543AC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:04:01 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id z5so6772447iob.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 02:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GFNKgtyv+YjvpUIi5VQTMsCats/5oFriHfBeWrczXUw=;
        b=SOb95LWKG8hWwp4zxXukSwadzcJB+NJb4FLJzsAwfLWgwRx/3Qtupp7rT140TPVaZl
         odOkqIrTWbQ/gMtlSKmlXldR0DtEd/F7XQJF+ecNLCMfBehm2dxq7l/PtsF0qMrbfuw7
         rUVi4gCzUWU5Jg3OVuy7qaNciDKr3zQnH7ubjoZXK5cMsgJqhhWLuzrkCEoITSvkDNAq
         oni9aVNvCbqZpDqpEQak19kIaNfwwPmp34AiLifYb35gznMDn9j1N9dO2PEsNGxkrhpd
         QleAkeXF9u/g2ABjqmIXBeoO8cfl2NxP8NRjZT4Cp23I8f5smIOphFpNKQS/+4J+V7nn
         L2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GFNKgtyv+YjvpUIi5VQTMsCats/5oFriHfBeWrczXUw=;
        b=Pya0B9zPakxt+CR1u+Sj02guZXGnC3WHlaPihs8mD/aq0WCi4a4OKDFIio5p5LVaeh
         GIJFmxiv3OzQFbnl0vhlkvfw+mJQ91eZLUgZbXOwykCep1hs94UqXsIhF1lSUNi1JC7B
         kcgvvSVwwM94Unt03vWyx8zhYqheBO1uDKcwSZGeMa1MDABYlFLpmdQ7KptQMuhw6w3w
         /1/JqCTjVJFOPus75or2PAcZrASjdmUT8We4oONYjfI2Dsp3rTvmL/wJrdatFXYAAmae
         fn1xYvYGUlKe0p9Jsn4cEF7eu/0TT5AAC14fibRaxw7m0jVaBYBBu9p0ENyCSnFA2mOO
         7GQw==
X-Gm-Message-State: AOAM531ehgGLt/2UE4Vetkq90VkVJtfLLalqNI67ZbZtf63VE2lBTaKn
        miel2iv3ESjiPtJpCsPSr+Rf6BucGHoJruSIV9QURA==
X-Google-Smtp-Source: ABdhPJw0EXyON33UEbRqIa/Rr7OW8BJPaHk84m0yWbGQsBhVVYyd89HRcG5Q2fa8NYKtgxXzFHbVniTWAzpQCedu2+o=
X-Received: by 2002:a6b:f401:: with SMTP id i1mr1047529iog.130.1604048641000;
 Fri, 30 Oct 2020 02:04:01 -0700 (PDT)
MIME-Version: 1.0
References: <20201026122728.8522-1-brgl@bgdev.pl> <20201026131427.GF4077@smile.fi.intel.com>
In-Reply-To: <20201026131427.GF4077@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 30 Oct 2020 10:03:50 +0100
Message-ID: <CAMRc=MfuejMqpcfOedPMMTR3EY6s2K+4whoWyk7RmJYPaB176w@mail.gmail.com>
Subject: Re: [PATCH] devres: zero the memory in devm_krealloc() if needed
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 29, 2020 at 9:05 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Oct 26, 2020 at 01:27:28PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > If we're returning the same pointer (when new size is smaller or equal
> > to the old size) we need to check if the user wants the memory zeroed
> > and memset() it manually if so.
>
> Any use case? Because to me it sounds contradictory to the whole idea of [k]realloc().
>

This is kind of a gray area in original krealloc() too and I want to
submit a patch for mm too. Right now krealloc ignores the __GFP_ZERO
flag if new_size <= old_size but zeroes the memory if new_size >
old_size. This should be consistent - either ignore __GFP_ZERO or
don't ignore it in both cases. I think that not ignoring it is better
- if user passes it then it's for a reason.

Bartosz
