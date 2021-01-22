Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F753003D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 14:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbhAVNJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 08:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbhAVNIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 08:08:53 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4B3C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:08:13 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id j3so6437212ljb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 05:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pqbgbuupJ6YRo4yM4nlPb/XZOmzm//nHXWr+3gjw64c=;
        b=Ajt8rKN2KW1S1sLsIadPmAQEP+1A0NTg/t19H0R8JX0CPQvyuQLA0QynFcjja5exJl
         u0O+PWNzII6aok5wdVdeCeDIcFSMVNbJzqhYcFv/z7BKi3Ls1mSeg+A4aUWrTOdAG5aQ
         2QBWkwz6+6TxmuqS7/wjIV0Gcfk4cr9F6Za7i8PZGEt0KzumyGUwjMCXM2qpxUwv0iua
         IL+hbMQf5rHN7R6I72yXF7/p3V0hVntkCe429mmQsOXGGQaJl4+xvQJUAAj9anGDD6t/
         4Jm3J46fyodYOkQem3Akgahdtcn5waV8YPJrvdnSZjUQevfLPpiLau9NG+RI5hov1y+8
         pMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pqbgbuupJ6YRo4yM4nlPb/XZOmzm//nHXWr+3gjw64c=;
        b=J4HNt0sG3eutc7nIuPXrO/zZQ/19iUncQLdr7dYUFoO+K9TAJKofXDm8VZovziJ5Jy
         jqZxcD4Vtq9q3O122cROkXORJ5WCipqzNpUn4iKdvS9/j8asnuKf1V9jrfekV2Q8qQl8
         TfuWOAjlxcY2nCycw80xcxRgXKacVvpLXelUdOUdtfmm/Q8rHKB4DpHAFqLh59cWbt+0
         g9K3GhcY8wgdMhvBywUdIN1FShtQQeM97jexdLpDA8g6rS1Af9R3aov+u6KpI54CnbAs
         AKiJ1puO2UUGuN8AdZIQe0ZetRrzpEYJdKoWtK1FLwHw3LXbNcyJG9ENi3rSSevwmQOM
         zQvA==
X-Gm-Message-State: AOAM530Cr3AIrV2vGAwW3TBY4+oa3CKD5YUTEfoYG8v3A58URVygOGwo
        X7eFhCjjLS4pTYZHy3tPTzcvJUK9wmquVY3zBSx/sA==
X-Google-Smtp-Source: ABdhPJwK6aDRKF8coJzfBbb01pE6jH1d1hiwvfPbp93jmF30rLIOwCNMyRrSNUDDnN3vCDDzqsJyZdfQ4iNf5kMJPr8=
X-Received: by 2002:a2e:88c1:: with SMTP id a1mr647295ljk.74.1611320891999;
 Fri, 22 Jan 2021 05:08:11 -0800 (PST)
MIME-Version: 1.0
References: <20210121223756.1112199-1-saravanak@google.com> <CAHp75VcrsVcUWaaE8JZHGDMyX9MKYONoVo+9-rzT7rvnkH5xSg@mail.gmail.com>
In-Reply-To: <CAHp75VcrsVcUWaaE8JZHGDMyX9MKYONoVo+9-rzT7rvnkH5xSg@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jan 2021 14:08:00 +0100
Message-ID: <CACRpkdYbxrJsaGVskzBjMp05P4NkP5bkReH3TjXJWivG0rFcVw@mail.gmail.com>
Subject: Re: [PATCH v4] gpiolib: Bind gpio_device to a driver to enable
 fw_devlink=on by default
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
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

On Fri, Jan 22, 2021 at 10:55 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Jan 22, 2021 at 12:40 AM Saravana Kannan <saravanak@google.com> wrote:

> > @@ -596,6 +596,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
> >                 gdev->dev.of_node = gc->of_node;
> >         else
> >                 gc->of_node = gdev->dev.of_node;
> > +       gdev->dev.fwnode = of_fwnode_handle(gdev->dev.of_node);
>
> This looks like a complete breakage on ACPI enabled systems.

This looks broken to me too, if OF functions are compiled out
this happens:

include/linux/of.h:#define of_fwnode_handle(node) NULL

And if there is a valid fwnode in the device it gets overwritten
with NULL.

This is partly why I want the DT code to be in its own file.

Yours,
Linus Walleij
