Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273C825F8D4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Sep 2020 12:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgIGKuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Sep 2020 06:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728757AbgIGKuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:50:14 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EF2C061575
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:50:13 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id w8so12128318ilj.8
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y2WbMMlWb+6LVnmTJRKV9M4FUT+m4Yhxko6TEmzZawo=;
        b=DXXW4y3JIc13ePP4dZs0HPbsWLHy9Mn1p6wfUdlMGf8aqElDxpEmWg3aw+DqpO5ss5
         foGGRIcNDCa/FPVCbUcEvaCUzHTCxoAMw2WYzPuFIY2s9jAQPmONVbR3BKFfH8sYdnsC
         dHQf8ZVmgZZ09vKY3G2gGhvUFZaA4X2zKkdKWKuGjV37gNKiWVSYvcoCZ2xcdpqymaI2
         Ki/4qC6smG9C5a2s0+BXm2TuolTZRs+pubuGVOK46JNqbGNqgWBJVxjQBZuuL0Z2NlQq
         nl1YC4vskdLtvxYJFDRk+G0y4qVL0DYvBbgeYpKCAWy2NhWNlpqcEhF3cdA1L7D1mzrB
         Rgqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y2WbMMlWb+6LVnmTJRKV9M4FUT+m4Yhxko6TEmzZawo=;
        b=DD10u6xVdq2aYlgrTjPbio9OnCbsh+cikXWKaFo6vPb94s5+vigXHQblTwbmih4hJM
         wzvlYJS+FY0Nj3c0HTNtJDY0Kz4OprHtQzKE0nKO+p9RTuI1fAFw3SSK4YWfZwjr4ae8
         +pEFIzCflprMg1IYPS00Hx0m6NDthfRmYO2gvmCgFQ1tAUtLK1WYxewciYpyg0iqlXJS
         qgxd47A7ktumqdPP9drrockHu2nQS2NQFBgCnjhRRZbDQ0JUn12WPgacAVOzhgdkdJvu
         65/NpGAnQfZ1UuzfdII8385/PibxUjOj1u2ygxHa93FIJz23pYOsqSqjjqpaf519tvHe
         ILHw==
X-Gm-Message-State: AOAM533vusHq494/NL4QfxTaVBegS0C+a5WagxDWc00n7Fy0USesfzbM
        49PDC1dhB7jVkRYL6Jcl4tHBORuuTws4CxAudXmqUA==
X-Google-Smtp-Source: ABdhPJynrTfkvCINR4dH6XcXpfLrT9viB5CqRNVONJhEUV5jYmiptH6QUEy6gzaqRlgTPWh+SDbiNtD7xbF8ZAG72hU=
X-Received: by 2002:a92:189:: with SMTP id 131mr19144027ilb.40.1599475813063;
 Mon, 07 Sep 2020 03:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-7-brgl@bgdev.pl>
 <20200904164128.GZ1891694@smile.fi.intel.com>
In-Reply-To: <20200904164128.GZ1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Sep 2020 12:50:01 +0200
Message-ID: <CAMRc=MeYw=tQABZ2ZGbFQC=yc-zzes6ohSzUJLOLBnEGHzeZhg@mail.gmail.com>
Subject: Re: [PATCH 06/23] gpiolib: switch to simpler IDA interface
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 6:41 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:30PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > We don't need to specify any ranges when allocating IDs so we can switch
> > to ida_alloc() and ida_free() instead of the ida_simple_ counterparts.
> >
> > ida_simple_get(ida, 0, 0, gfp) is equivalent to
> > ida_alloc_range(ida, 0, UINT_MAX, gfp) which is equivalent to
> > ida_alloc(ida, gfp). Note: IDR will never actually allocate an ID
> > larger than INT_MAX.
>
> Have you considered switching to XArray API?
>

IDA uses an xarray internally but wraps it in a more straightforward
API. No need to use the low-level API IMO.

Bart
