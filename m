Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC529816E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 12:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415373AbgJYLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415365AbgJYLMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 07:12:53 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C83EC0613CE;
        Sun, 25 Oct 2020 04:12:53 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id n6so6948353ioc.12;
        Sun, 25 Oct 2020 04:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TFkX+ZerAmd8hm3G9ObErPm+YgVkEx8CRGWjFIckLIQ=;
        b=f3NbGeK+6ZtbJFn78qe4TBYAxMxAh1+TJc804ela0OLJTQw2JEKf1SkDA8eVf9brkR
         mkLQeYkcGVKrjSHSDPcgQfXWRVFBd3xw1z55/3d2QdheAA0lxY+MqSwtS1VWDMkU6gfi
         POo9W4DMsNEsyMHN8QHjPnd88b/qTMU1mts1m8Y911y/G1rceY85Trw6aiqI3lezE6ex
         ybrLhG4vEq7vy3JKBwPWAMPRF7h53KM55YZ8Pdu1XY+9KaTq4z8mfpSTzlF0l7fl5UQk
         qeM8+X0riyiWK+c6Bn5smz3P9q9uSyVC73BxA7j+VYtPw+51XiuQJw2T6feDufCAZBsv
         xO0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TFkX+ZerAmd8hm3G9ObErPm+YgVkEx8CRGWjFIckLIQ=;
        b=fmI9FyvhHXxrOJt1RnoFD5s7TIIK/9hCf57nFMHGIFzu3x4Vp/+kgSq0sA6gkhhwGo
         cO8JTKZ+puvRJ8XD1XHHmBwWnqW9oKqCGuZIJKMfm8CLzpFlrjZqGaa+vc+H+ySIlZRc
         wYyPytEksAUa3BGxEdIW7qqZULOyb/ine2LvB9h0bbLvCCSnHz4Z1bNGfJ2+8TBOhfKP
         fureky5uCV2tjCAh1KPeRtdBiQpLfOtMPSwPC17cVwYvDz7e/pAREVvmVnBaMTrwxu8Y
         dRy1ldG4jx0+1WH7Pu80cFUx20jnaFjHY15bfBztGdOZhbfIn+6nsCqrbYImVa7bgv1E
         9nUA==
X-Gm-Message-State: AOAM532ZQ6/FWfhVjSSdVh83fyWNKwaBc1NprRn95NZZu6GYekr/mdGv
        rt6SYL55cYZkM3/BoGX8TuObh5Xigl42BgQ5jw==
X-Google-Smtp-Source: ABdhPJyZD9Zz+IOM7rNg+RoAMaAduHW8YbNrNxUEVG0hEHoPcu1GLzdc08/YxotEW1/Ji2X/IlcELqgPdfyTZiD8Hfo=
X-Received: by 2002:a6b:8b95:: with SMTP id n143mr7598620iod.36.1603624372449;
 Sun, 25 Oct 2020 04:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <1603346163-21645-1-git-send-email-kernelfans@gmail.com> <871rhq7j1h.fsf@nanos.tec.linutronix.de>
In-Reply-To: <871rhq7j1h.fsf@nanos.tec.linutronix.de>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Sun, 25 Oct 2020 19:12:41 +0800
Message-ID: <CAFgQCTvFwvvtPE0Eow4cebCEe5OD5OhgAQarckpbFc38Bphaag@mail.gmail.com>
Subject: Re: [PATCH 0/3] warn and suppress irqflood
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        afzal mohammed <afzal.mohd.ma@gmail.com>,
        Lina Iyer <ilina@codeaurora.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Maulik Shah <mkshah@codeaurora.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Oliver Neukum <oneukum@suse.com>, linux-doc@vger.kernel.org,
        Kexec Mailing List <kexec@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 4:37 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Oct 22 2020 at 13:56, Pingfan Liu wrote:
> > I hit a irqflood bug on powerpc platform, and two years ago, on a x86 platform.
> > When the bug happens, the kernel is totally occupies by irq.  Currently, there
> > may be nothing or just soft lockup warning showed in console. It is better
> > to warn users with irq flood info.
> >
> > In the kdump case, the kernel can move on by suppressing the irq flood.
>
> You're curing the symptom not the cause and the cure is just magic and
> can't work reliably.
Yeah, it is magic. But at least, it is better to printk something and
alarm users about what happens. With current code, it may show nothing
when system hangs.
>
> Where is that irq flood originated from and why is none of the
> mechanisms we have in place to shut it up working?
The bug originates from a driver tpm_i2c_nuvoton, which calls i2c-bus
driver (i2c-opal.c). After i2c_opal_send_request(), the bug is
triggered.

But things are complicated by introducing a firmware layer: Skiboot.
This software layer hides the detail of manipulating the hardware from
Linux.

I guess the software logic can not enter a sane state when kernel crashes.

Cc Skiboot and ppc64 community to see whether anyone has idea about it.

Thanks,
Pingfan
