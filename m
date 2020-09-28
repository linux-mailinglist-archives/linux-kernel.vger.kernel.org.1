Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FF127AE9D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgI1NEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1NES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:04:18 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FD3C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:04:17 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i1so1242615edv.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0ne+81vxoKb22kRY3AEiPTbS5l+8d315k0Vq1Z+Caj8=;
        b=xLsTUgj+vnYaxnyZmTx6xItsEuEhBMjonEM/I4J2lSETvthslZ9C4+BlMjprjVwZKC
         ez+zjpNX4DyHeK7shz/xwa0i9NOPC0LIkDMRBHelgaWY28lDXynRwPlzjwbg3UImA9gs
         mtTgSsuxZdSA4uxUKBctjRb54UbU3r0FJLx/Q0/OODr3E+E1FaCxPlXJy++BuJD82qb/
         YPZ106ShHqTsFDmRvhoBXaj2i1XbXSeByJzHWm9jLO2dRwwTM3Q4zwgupnd64PnhvjYO
         k+hhc5u3ime9Ll/No6zQBTwPNIK6IJymVkxVIQjNl3/yX3pdtpUAjDNetdQDM/UAsqUi
         NvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0ne+81vxoKb22kRY3AEiPTbS5l+8d315k0Vq1Z+Caj8=;
        b=G9sUIQSCkOgCGWWQPUDYMCn5Ndtqxlc2EjoSOMugZlhIKbIQmG6w2iJoiKd10jWGn9
         7mQe2CMUElmnYQfOynehC2p7/448GFGw53ewOdhbNjw95YJgg6LEZy/9qhSVweiyoQb3
         Xdn2qxfG2lJXjewq6BsOO2oyTW8R2VNRxYsVQheq1qhpPSSwu/4wEPHOCeRiYvMZSDtx
         kQanKv9JzAurbq18ni+M+U70yOl0xwKA5zX5S5IdUjZk/AiNnuhR5NNKJ+4zI55y61ZO
         lZhMNUHlC9O/9OyW3UfWG6mfWBuSeccbv/HSmhvdq1hBieuOIsdrQr+TYqX1N5Gctu4K
         CFPA==
X-Gm-Message-State: AOAM532/+u+fzheWqdyMj6MASrxxE4T5g6KADxLfqRiBeb+/PFh4DDvC
        NFnEjPOR8VYLJJ77m2YYp34+vUz3Wo4aRSlQ/H8Cbw==
X-Google-Smtp-Source: ABdhPJw8HVtmC6lfse2CMPxO6e1wy5KcSGZu2BmULxtP/B5LlTFCaoMu3s/8C+xBwiREBQpN5mdFdDvkyjv0Y+BjdxU=
X-Received: by 2002:a05:6402:a51:: with SMTP id bt17mr1690554edb.186.1601298256459;
 Mon, 28 Sep 2020 06:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200928104155.7385-1-brgl@bgdev.pl> <20200928104155.7385-2-brgl@bgdev.pl>
 <20200928125539.GI3956970@smile.fi.intel.com>
In-Reply-To: <20200928125539.GI3956970@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 28 Sep 2020 15:04:05 +0200
Message-ID: <CAMpxmJWbws62wBcNuTeWr8xr+B0qd40kEtLTVXqxVoOzyUgp9w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] lib: string_helpers: provide kfree_strarray()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 28, 2020 at 2:55 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Sep 28, 2020 at 12:41:47PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > There's a common pattern of dynamically allocating an array of char
> > pointers and then also dynamically allocating each string in this
> > array. Provide a helper for freeing such a string array with one call.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> But see below.
>
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> >  include/linux/string_helpers.h |  2 ++
> >  lib/string_helpers.c           | 25 +++++++++++++++++++++++++
> >  2 files changed, 27 insertions(+)
> >
> > diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> > index 86f150c2a6b6..55b25120a1c6 100644
> > --- a/include/linux/string_helpers.h
> > +++ b/include/linux/string_helpers.h
> > @@ -94,4 +94,6 @@ char *kstrdup_quotable(const char *src, gfp_t gfp);
> >  char *kstrdup_quotable_cmdline(struct task_struct *task, gfp_t gfp);
> >  char *kstrdup_quotable_file(struct file *file, gfp_t gfp);
> >
> > +void kfree_strarray(char **str_array, size_t num_str);
> > +
> >  #endif
> > diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> > index 963050c0283e..bfa4c9f3ca0a 100644
> > --- a/lib/string_helpers.c
> > +++ b/lib/string_helpers.c
> > @@ -649,3 +649,28 @@ char *kstrdup_quotable_file(struct file *file, gfp_t gfp)
> >       return pathname;
> >  }
> >  EXPORT_SYMBOL_GPL(kstrdup_quotable_file);
> > +
> > +/**
> > + * kfree_strarray - free a number of dynamically allocated strings contained
> > + *                  in an array and the array itself
> > + *
> > + * @str_array: Dynamically allocated array of strings to free. If NULL - the
> > + *             function does nothing.
> > + * @num_str: Number of strings (starting from the beginning of the array) to
> > + *           free.
> > + *
> > + * Passing a non-null str_array and num_str == 0 as well as NULL str_array
> > + * are valid use-cases.
> > + */
> > +void kfree_strarray(char **str_array, size_t num_str)
>
> Hmm... I have missed your answer to
>  str_array -> array
>  num_str -> n
>
> The rationale behind dropping str is to avoid duplicates in the name of the
> function and its parameters. 'array' is harder to avoid, but also possible,
> though I leave it to you.
>

Are you fine with me fixing this when applying the patches?

Bart
