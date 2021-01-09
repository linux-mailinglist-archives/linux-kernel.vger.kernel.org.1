Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A48C32EFC50
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 01:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbhAIAqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 19:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbhAIAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 19:46:43 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EEC061573
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 16:46:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id a12so27196397lfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 16:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mw14YzBgd2f4GqS6Ml6tp0mY465YwbvUOhYSkNusrc4=;
        b=u4AGIsz2ZIrp2McYVYJX3vPXdnObweHDpRO5EPmrHdnCSByUodK5p7mw4rmYQt11wl
         yDCeUyreJB8kFyzDyHME2Jus+TYq2cJ3EjqT9ImGXC82ZUe9P0vFNih8X1pbq+GlKQbr
         GxpLHMyV/OpTVnYkw0wzdBfQKBDCcug2bmn70c1KST92CienIY8HMXF8+KOqGcKl3y8+
         KcNLF43pg6A+9KDn7tF+MrADNgK7Sx6R838fK1Vv9bMTt0uvYgdRCgT04W+7ptKKE6hn
         AZtXMq4Qf1KvllXvZapyYldiis/g2KpwDfMDVWzcNj1Iserq8GEafATWocPOEb5hpfCP
         fOQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mw14YzBgd2f4GqS6Ml6tp0mY465YwbvUOhYSkNusrc4=;
        b=iqk6rXdn2qxVw7QzfCchf2KpEPQHjXtiS6+Aou92mSYbCWl5yZ831h7ogBq5yrJEjI
         x/X1Ey2u6ndstxjRWdqkc/XHr5fDHWBjx+AzVbxxLl11MLduJD7sqZ0Y4kaNQREr+d4X
         N5/QtRzbJeXYYzWM09ivRQZj4gnaMb0exGsdlGfK6a9QYKGItt7MVpZQWpYSp/bC+u7t
         4B6UXXkv0V3co3J4QwBBlTfM6qEdJ1LAX7AeEh5wRHPQAk4M3MC2a166bKYoRjg8CTXu
         Y/dDOtCmfuMoXvQpImXokZ/Wfwe/tH4rNMN/OY4fvAGq9bd29jioI9yKR0PhKp6HoM8v
         FVUA==
X-Gm-Message-State: AOAM5319AJ7YYDNE0B462Y/kNk1CAzY3UW4q4fpAcm/zpIaRx9cXK3eU
        W1pYwMBNbAHfZguRcsjKHhJledkpYmvb8s7/+g17iQ==
X-Google-Smtp-Source: ABdhPJxwbE4VMpwSQLOWkl1Ft/NOE4pAAt9s9j7XhgGCTf2jDv5iWwn6iR9DxhOtxZYEUXwockdfw27lp4/vbPA96u4=
X-Received: by 2002:a2e:9dc3:: with SMTP id x3mr2698689ljj.326.1610153161636;
 Fri, 08 Jan 2021 16:46:01 -0800 (PST)
MIME-Version: 1.0
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com> <e7c5919cc0d95aca09807a828fe3c0018af8828b.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
In-Reply-To: <e7c5919cc0d95aca09807a828fe3c0018af8828b.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 9 Jan 2021 01:45:50 +0100
Message-ID: <CACRpkdb4CW0D86dmEOjtuFpTcO2oUZC50MhNQQtfoEQT7G_PFQ@mail.gmail.com>
Subject: Re: [PATCH 09/15] gpio: support ROHM BD71815 GPOs
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-power@fi.rohmeurope.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 2:39 PM Matti Vaittinen
<matti.vaittinen@fi.rohmeurope.com> wrote:

> Support GPO(s) found from ROHM BD71815 power management IC. The IC has two
> GPO pins but only one is properly documented in data-sheet. The driver
> exposes by default only the documented GPO. The second GPO is connected to
> E5 pin and is marked as GND in data-sheet. Control for this undocumented
> pin can be enabled using a special DT property.
>
> This driver is derived from work by Peter Yang <yanglsh@embest-tech.com>
> although not so much of original is left.
>
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Overall this looks good!

> +       depends on MFD_ROHM_BD71828

I suppose this makes i possible to merge out-of-order with the
core patches actually.

> +#define DEBUG

Why? Development artifact?

> +#include <linux/kthread.h>

You certainly do not need this.

> +#include <linux/mfd/rohm-bd71815.h>
> +#include <linux/mfd/rohm-generic.h>

I guess registers come from these? Do you need both?
Add a comment about what they provide.

> +       g->chip.ngpio = 1;
> +       if (g->e5_pin_is_gpo)
> +               g->chip.ngpio = 2;

Overwriting value, how not elegant.

if (g->e5_pin_is_gpo)
  g->chip.ngpio = 2;
else
  g->chip.ngpio = 1;

> +       g->chip.parent = pdev->dev.parent;
> +       g->chip.of_node = pdev->dev.parent->of_node;
> +       g->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +       g->dev = &pdev->dev;
> +
> +       ret = devm_gpiochip_add_data(&pdev->dev, &g->chip, g);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "could not register gpiochip, %d\n", ret);
> +               return ret;
> +       }

It's a bit confusing how you use pdev->dev.parent for some stuff
and &pdev->dev for some.

What about assinging

struct device *dev = pdev->dev.parent;

and use dev for all the calls, it looks like it'd work fine.

Yours,
Linus Walleij
