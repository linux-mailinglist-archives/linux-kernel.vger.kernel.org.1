Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4052EFC1B
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbhAIA0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAIA0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:26:44 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1346FC061574
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:26:04 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o19so27160133lfo.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HZWtqqmWXFQF6vFVo5YIcMITV5s0aEkVTtLeRZ9cL6A=;
        b=CwzTe1m7vCRdfJRtlHvio4kU535Zx+X6j1FpPIF968iK7L20sK2yraXj3zQvFYwk+w
         rO0jyCEMRnOY1fXVDCkA/tQB+bksqSmd4NU7VZE7+nwar4RoRFdn0yzS6vylg6U0kkxs
         B+8eZ/wlIVe7AihgRk/Ys7AOcNG28HiPV1LVDKeEyvUvZTTPaGUyNx9gHNElDl2IAnnI
         H1bxeRnoUmcrvxFz8oHzrIlswPCUngUJLz3RbFrQW72vKpkqutOGwBKcY8ZmprevI1gv
         rZm7VH4ly8+L89l0+HoXtamYRo8QKiq30zJ/9xmgPNmCrjmaKYiLwpdCuVgtpqBBJYhU
         rpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HZWtqqmWXFQF6vFVo5YIcMITV5s0aEkVTtLeRZ9cL6A=;
        b=DQbbBNtUhx9Jn/GBBoGdKaxDafKjvRWH606RrNJCiUjpdswhfFPDGYgGnU/hMQ+r/D
         2n8/YBvWIYMTbcKjVwmsyi+4fzzCgouS/yTQOcfIVAvFOBbrZtK4liYwKsd47BBD2AYL
         NUP3qCjHeAFySXuTZ9o/pNN7lWsyHGtR4/PiPOTmbTF5d8LaUftrQI0HISu0oAkfDY5u
         ePwYxcDLZXzSDt4hjrPpZ4p4zrnwmnceVlmaPQ5HxDCN9GDj0rA6WvF3Rvzr9EL8RC7C
         p7i2ri+znyTdpvTMyFT1lZD82difuMSdYZG0pYr2sHlXpRrnM2jcHqsbCFUe9dlo31lR
         eAkg==
X-Gm-Message-State: AOAM530+b5yLq2u7iogzxZ6iz3brWSI5qwdPLQVMPO074u7bgru780Sc
        354ufStt40OZ7oD/kOqsAk8JOOvXKkxRRJZ3b/Tvzw==
X-Google-Smtp-Source: ABdhPJxFGeQMiMGltA1+XUR6U1c+bW+b0MUe71WYtK55yrp/rSp/Fq2uTqRVaEWX8O04VWjZG4bzZfbEPE/TC6VZ/6k=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr2414795ljl.467.1610151962442;
 Fri, 08 Jan 2021 16:26:02 -0800 (PST)
MIME-Version: 1.0
References: <1609936000-28378-1-git-send-email-srinivas.neeli@xilinx.com>
 <1609936000-28378-5-git-send-email-srinivas.neeli@xilinx.com>
 <CACRpkdYLp0uuB-QO5HvLH222TkCjk54JmftveHgpiW1JExF7DQ@mail.gmail.com> <DM6PR02MB538673699067F89F6F167121AFAE0@DM6PR02MB5386.namprd02.prod.outlook.com>
In-Reply-To: <DM6PR02MB538673699067F89F6F167121AFAE0@DM6PR02MB5386.namprd02.prod.outlook.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 9 Jan 2021 01:25:51 +0100
Message-ID: <CACRpkdaD03pfffqiU1wMVRAu4axQL_VNqM6FrpVHxcN6Tn3XrQ@mail.gmail.com>
Subject: Re: [PATCH V4 4/5] gpio: gpio-xilinx: Add support for suspend and resume
To:     Srinivas Neeli <sneeli@xilinx.com>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Michal Simek <michals@xilinx.com>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        Srinivas Goud <sgoud@xilinx.com>,
        Robert Hancock <hancock@sedsystems.ca>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 12:41 PM Srinivas Neeli <sneeli@xilinx.com> wrote:
> > On Wed, Jan 6, 2021 at 1:27 PM Srinivas Neeli <srinivas.neeli@xilinx.com>
> > wrote:

> > >  /**
> > >   * xgpio_remove - Remove method for the GPIO device.
> > >   * @pdev: pointer to the platform device @@ -289,7 +323,10 @@ static
> > > int xgpio_remove(struct platform_device *pdev)  {
> > >         struct xgpio_instance *gpio = platform_get_drvdata(pdev);
> > >
> > > -       clk_disable_unprepare(gpio->clk);
> > > +       if (!pm_runtime_suspended(&pdev->dev))
> > > +               clk_disable_unprepare(gpio->clk);
> > > +
> > > +       pm_runtime_disable(&pdev->dev);
> >
> > This looks complex and racy. What if the device is resumed after you
> > executed the first part of the statement.
>
> Could you please explain more on this.
> What is the need to call pm_runtime_get_sync(); in remove API ?

I explain that on the lines right below your comment ;D

> > The normal sequence is:
> >
> > pm_runtime_get_sync(dev);
> > pm_runtime_put_noidle(dev);
> > pm_runtime_disable(dev);
> >
> > This will make sure the clock is enabled and pm runtime is disabled.
> > After this you can unconditionally call clk_disable_unprepare(gpio->clk);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Yours,
Linus Walleij
