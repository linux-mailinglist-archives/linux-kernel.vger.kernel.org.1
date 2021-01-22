Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A17300C9B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 20:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbhAVT0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 14:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729699AbhAVSka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 13:40:30 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460DC061797
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:38:36 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id p185so6363838ybg.8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 10:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4cM6BTjLehZHKGNxw1eQJuLZGeESJeNzjeqPqEolkPM=;
        b=Ufs/m/pL8sjTm8Fj2vCRs3TnibA1sxGEe4dPJd+5H0G9ieYU57W7PCtQx5hGBou72P
         A3a7/8/0pTFOvir6svQe+xKlvsBJ4kmmmNotqkM8Us3sJCn161AyjxxXkjmxsGwCAgSB
         pf2T2LCk+e1p17hwpyzASuJuQdHcAEyEJKdOrisTvkxOSB92v5nbDYhnA8oDlVOgfaQj
         9/YgejaW/TnSYHJAS03geao+qngv3ZU07lchFtgp8Q4kgJkMLOtSnpzvOdU+8s5oRShD
         Cq6fBTKZu11jAC1Dc+XJDcrSxpHW8RBQJc3dmp8zYhzsJtBfWsoDxYj6ba1wmmnl4Fxm
         y+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4cM6BTjLehZHKGNxw1eQJuLZGeESJeNzjeqPqEolkPM=;
        b=DGyTWt4/lO6YNGEQsvzOS+tug+ZeIf0FPZYKNTbEJVHQ5BfH8SwgMYzzdyQu1hx1L0
         LgIEs4lBRZJc5of9UwIUpJC0ok9c5mfrJn72V9MO2tB+byH2apcmXtPL6ICGRhwsUpHA
         7ph7+zzLaVdVu38yWHhbLg99N17ZoAtuBPv8yhyQqPg3D2JapCyDf9aONNc9WKNCIO7O
         ax8EmrAhNvW9tcxC4tKf7LczhwMahY4/DAEeG/yKpo5p2GrlWX9fM5PZjo6RqUN0LkTh
         5HOtUxRl/YMFpRA+AKhFBd6zvxGh+yn2VzylyOWHXIVCBFI1FSUgTenIIvwM2EUlu0OE
         IVZA==
X-Gm-Message-State: AOAM530Y0Q7Tte3ZLDKjeQbH22PkToD4WEXuV6elvX6iroVokYvTBICW
        FxCYimHYutUWLqZWlo/Xw0Q09QN5REk5nNKneaaqCg==
X-Google-Smtp-Source: ABdhPJwma2AQ4TcVCauJ6+ntaXdFk2dmzYfWyse9LFsVJgMcLBseH2aXLNppZbj8OPYtx1rSNXAHYiXHFAZr0MHN3gM=
X-Received: by 2002:a25:dfcb:: with SMTP id w194mr7774121ybg.346.1611340715341;
 Fri, 22 Jan 2021 10:38:35 -0800 (PST)
MIME-Version: 1.0
References: <20210121223756.1112199-1-saravanak@google.com>
 <CAHp75VcrsVcUWaaE8JZHGDMyX9MKYONoVo+9-rzT7rvnkH5xSg@mail.gmail.com> <CACRpkdYbxrJsaGVskzBjMp05P4NkP5bkReH3TjXJWivG0rFcVw@mail.gmail.com>
In-Reply-To: <CACRpkdYbxrJsaGVskzBjMp05P4NkP5bkReH3TjXJWivG0rFcVw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 22 Jan 2021 10:37:58 -0800
Message-ID: <CAGETcx9EGJi68==uCxrAddZ5GoyNxTKGPxwsqwpv+pzkJ5Uj7A@mail.gmail.com>
Subject: Re: [PATCH v4] gpiolib: Bind gpio_device to a driver to enable
 fw_devlink=on by default
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 22, 2021 at 5:08 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, Jan 22, 2021 at 10:55 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

Andy, I'll address your exit() comments too.

> > On Fri, Jan 22, 2021 at 12:40 AM Saravana Kannan <saravanak@google.com> wrote:
>
> > > @@ -596,6 +596,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
> > >                 gdev->dev.of_node = gc->of_node;
> > >         else
> > >                 gc->of_node = gdev->dev.of_node;
> > > +       gdev->dev.fwnode = of_fwnode_handle(gdev->dev.of_node);
> >
> > This looks like a complete breakage on ACPI enabled systems.
>
> This looks broken to me too, if OF functions are compiled out
> this happens:
>
> include/linux/of.h:#define of_fwnode_handle(node) NULL
>
> And if there is a valid fwnode in the device it gets overwritten
> with NULL.
>
> This is partly why I want the DT code to be in its own file.

Yeah, both of you are right that this is broken.

So all I really need to do to fix this is:
if (gdev->dev.of_node)
    gdev->dev.fwnode = of_fwnode_handle(gdev->dev.of_node);

I don't mind putting this in gpiolib-of.c. It's just kinda weird to me
to call into gpiolib-of.c just for these 2 lines.

I'll just move the entire block inside #ifdef into gpiolib-of.c in the
next version. Let me know how it looks.

-Saravana
