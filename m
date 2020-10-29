Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C63629E758
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 10:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbgJ2JaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 05:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgJ2JaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 05:30:16 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE99C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:30:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id b15so2562539iod.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 02:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oOIWI+y7UB+B7mKQ1XejmuEN+uCbdLuLnJkhG+XAUXg=;
        b=sSIrfy0iaFuSgIj5W2Cpey08c3xXHJL+wgY9p1P8vfqd2gEaovPS0nJhbZD/6XTNVx
         uXDhJURp8i399ABaJlBVBOsP3csQDvT/Ud10UohRe7jgBCP3MDCMTngCozrvbefR3P5c
         PJWVVMA3cQhAFn8lt/TsuM/rVLXvWMHuWlW8zJP7yTHH/piCjlgrZycJ2HUGZZWTafQB
         GvkAsjld3/Azyo39WmXhShydky6hx+1CyG5+tSmkg0LC8vN3dW3Z/iJXHzIUSLIHdxOR
         qlsuyGfHXyf2VReQqm/gaDqL2lq7GpZ2ATcGSH/EQ495JpqDmJw2mnVtMgON0VjAZMHz
         FBlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oOIWI+y7UB+B7mKQ1XejmuEN+uCbdLuLnJkhG+XAUXg=;
        b=jD/R/c7lK0jhduFyEV9OiCjq3EJQfTyROilHuaXhDIhjKiS1DFQhzRey6Gac0fT5fS
         mE3IhjrkbQoTYfzzEMEaeFv0RYRAyBHfJB1nyCfGy7tLcXnxqZVgx95v3AlSnXKEunQ2
         lSpDh9ByKhRT6SMmUfrcTMnlTskVhOmJIVJx2Ssb9FJlRlbXw7nAun9rBjRbIT4WH5Zl
         KKIx391jNo0cSBOU3E1vpbakgGm4/xN8YT+6uotSw0IbkAZuXTBp+diCtj/bX4WgJ9rv
         hVKZFZFsZAVLuhnjfXiKIMIEZlNe9bQQIphhaXKxMsoefl/I7SlHGC6vB1JyM9CnMREu
         1Hpw==
X-Gm-Message-State: AOAM533/8rKBMCXOImqDNFDtbfUHjwVpIcWUpO+bff54yuFyw/K43bBM
        7XpjoJcQjF6BBtj1VAtuYlJs+WCMt/KVrNTyx6Zbdg==
X-Google-Smtp-Source: ABdhPJx9zMBHaZw19qpVm06IdHzHPzlUWhcss2G91tMQHwc7bPynPZC7+Obdv2CzznTo5KJeZSt+E0qI4ZiM1o9j8tU=
X-Received: by 2002:a02:8348:: with SMTP id w8mr2775533jag.136.1603963815210;
 Thu, 29 Oct 2020 02:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20201027135325.22235-1-vincent.whitchurch@axis.com>
 <CAMRc=Mdjm8tgxF_76T3f6r3TwghLKtrFtUv7ywtX3-nEQzVGtA@mail.gmail.com> <CAHp75Vff1AyKDb=JiocsAefnft+tcm+BnuWDrxViQqZAQZjuVg@mail.gmail.com>
In-Reply-To: <CAHp75Vff1AyKDb=JiocsAefnft+tcm+BnuWDrxViQqZAQZjuVg@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 29 Oct 2020 10:30:04 +0100
Message-ID: <CAMRc=McfToqJOy6AFGVqUup5b8ED-Ld3e=ZRyW5BG1JtD54M+A@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mockup: Allow probing from device tree
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel@axis.com, devicetree <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 28, 2020 at 9:24 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Oct 28, 2020 at 8:41 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > On Tue, Oct 27, 2020 at 2:54 PM Vincent Whitchurch
> > <vincent.whitchurch@axis.com> wrote:
>
> ...
>
> > > +#include <linux/of.h>
> >
> > Please keep the includes ordered alphabetically.
>
> Besides the fact that that is a wrong header to be included.
> mod_devicetable.h is the correct one.
> (See also below)
>
> ...
>
> > > +#ifdef CONFIG_OF
> > > +static const struct of_device_id gpio_mockup_of_match[] = {
> > > +       { .compatible = "gpio-mockup", },
> > > +       {},
> > > +};
> > > +MODULE_DEVICE_TABLE(of, gpio_mockup_of_match);
> > > +#endif
> >
> > You don't need this ifdef - of_match_ptr() will evaluate to NULL if
> > CONFIG_OF is disabled and the compiler will optimize this struct out.
>
> It's not so. If you drop ugly ifdeffery (and I vote for that, see also
> above) the of_match_ptr() must be dropped as well.
> Otherwise the compiler will issue the warning. So it is either all or none.
>
> --
> With Best Regards,
> Andy Shevchenko

Makes sense, I'll remove this from my tree for now then. Vincent:
please send another iteration.

Bartosz
