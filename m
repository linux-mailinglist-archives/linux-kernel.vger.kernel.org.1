Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7E7F2AD94C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbgKJOwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 09:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbgKJOwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 09:52:12 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8313FC0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:52:12 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id 7so17964335ejm.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 06:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BiXKJCfFkLckk0QWi3TCRn5PbMUrC26oLIfgwcLzd+Q=;
        b=kcHocmGBBnCROE3rCMMwA6XbZyw9sxTQm85i46syryc6+zXP7qG5PCFcj8yXFM0R9E
         r0qNfpTWPg1RZwPnLteh8uR3IZ4D63vxpoauwJM6tvc+W8QH1yUoT+KmyZg4z/4AHg4Q
         WN5ErfebNRBpIPaNGB4GAsR8PlvR8l4y6CZrCrZVQQf1o0Ws1oQ8cen3pWGZQ1/sPwm0
         krEgCKwYOG+cDqGQep5moWLaZdi+r4EXg9AIZ6oG2AP/YDwJnO3crIR+E9vb35PeXhud
         WXSmQvLG65+sqpZHzcnztgfVgL9oDPiClULfGsRH899OIEKbstG6Y7BFYQ3fgiIcrt1K
         6qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BiXKJCfFkLckk0QWi3TCRn5PbMUrC26oLIfgwcLzd+Q=;
        b=KTDFhx6gNdDhPO03/Hb1K0GMLSO4EkHKqwXEvgnj3ExUlUw+PoKZ1AiuN+fIhnsQPP
         KDrFPqXLLwhgUhO/b+oDPChMpNYfxRPTXHcWqRIz4XNCJz7hpMnskTdUfwD2OYG8NhgR
         X0SVUN1ZVFu9SNZhMJBvY0QomBMyIM4Wpp8aamvN0rcsyQEGkDOV/h2i5/ID7Tkg+En3
         JYNnOQv4XyZtCSH4QRt8uEixa+XO0x3CYaEc8iY90QBSpPY7WJYLJnYKRBjyMmIEC7+4
         drGob4UV+CSOsxiJbW6r7TqUqzvzAPsAmSjRMSzqq95fpVQWN4D0qZRGcuRB6gUl+fsl
         AbiQ==
X-Gm-Message-State: AOAM530UBq4EV6boLKPF6gwh7xHu83LcP/A8mkbHFptAn9yr5snfE4cy
        0wliECbbVa1xt+VkvyUZUfkhcdX2T/wkmdcgi3CuYw==
X-Google-Smtp-Source: ABdhPJwb5wg8E4j2GzK+yVhaJpDJt11UUG8suYNdjcxYau0Bsrh6HKf8xQwFmqxM4fMwYtnpfVCrp5O0WzRnpGSysoc=
X-Received: by 2002:a17:906:1c84:: with SMTP id g4mr21577614ejh.155.1605019931251;
 Tue, 10 Nov 2020 06:52:11 -0800 (PST)
MIME-Version: 1.0
References: <20201110123406.3261-1-brgl@bgdev.pl> <20201110123406.3261-7-brgl@bgdev.pl>
 <20201110142624.GT4077@smile.fi.intel.com> <20201110142750.GU4077@smile.fi.intel.com>
 <CAMpxmJUQ3t02q-Chd-WE+pYRAsOOEnbQ0jB+G_uAGv+sJBK1tg@mail.gmail.com> <a5b0fcd0-eb62-79b3-3f27-6595b9bdb91c@siemens.com>
In-Reply-To: <a5b0fcd0-eb62-79b3-3f27-6595b9bdb91c@siemens.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Tue, 10 Nov 2020 15:52:00 +0100
Message-ID: <CAMpxmJW1j9+KAj12OKs3njUWy+UA5B993Pyd=xmo4k8LM-8GUw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] gpio: exar: switch to using regmap
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        David Laight <David.Laight@aculab.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 3:50 PM Jan Kiszka <jan.kiszka@siemens.com> wrote:
>
>
> On 10.11.20 15:30, Bartosz Golaszewski wrote:
> > On Tue, Nov 10, 2020 at 3:26 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> >>
> >> On Tue, Nov 10, 2020 at 04:26:24PM +0200, Andy Shevchenko wrote:
> >>> On Tue, Nov 10, 2020 at 01:34:05PM +0100, Bartosz Golaszewski wrote:
> >>>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >>>>
> >>>> We can simplify the code in gpio-exar by using regmap. This allows us to
> >>>> drop the mutex (regmap provides its own locking) and we can also reuse
> >>>> regmap's bit operations instead of implementing our own update function.
> >>>
> >>> ...
> >>>
> >>>> +   /*
> >>>> +    * We don't need to check the return values of mmio regmap operations (unless
> >>>> +    * the regmap has a clock attached which is not the case here).
> >>>> +    */
> >>>> +   exar_gpio->regs = devm_regmap_init_mmio(dev, p, &exar_regmap_config);
> >>>> +   if (IS_ERR(exar_gpio->regs))
> >>>> +           return PTR_ERR(exar_gpio->regs);
> >>>>
> >>>>     index = ida_alloc(&ida_index, GFP_KERNEL);
> >>>> -   if (index < 0) {
> >>>> -           ret = index;
> >>>> -           goto err_mutex_destroy;
> >>>> -   }
> >>>> +   if (index < 0)
> >>>> +           return index;
> >>>
> >>> And below you effectively use p as regmap!
> >>> That's what renaming of variable regs -> regmap or map can easily reveal.
> >>>
> >>>       exar_gpio->regs = p;
> >>
> >> Jan, if you remove this line, does it help?
> >>
> >
> > Ha! I guess you were right saying that keeping the name is asking for
> > trouble then. :)
> >
> > I think that may be it but address width should still be changed to 16.
> >
>
> Removing the line that Andy found made things work here. And switching
> to 16 for reg_bits didn't make things worse again.
>
> Jan

Alright! I'll send a v4 with these things fixed then.

Bartosz
