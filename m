Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB1972AD9DA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:12:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgKJPMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730594AbgKJPMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:12:50 -0500
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:12:49 -0800 (PST)
Received: by mail-io1-xd43.google.com with SMTP id o11so14434708ioo.11
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1EcXhjJm0xmO4/BQpyPl4PNsAnkq91sHgYel76uboxg=;
        b=kahyF9XWLnwv3uTAdWj+mW1AX9r55HzcKF0ZzDzMUOG/S5Qj9dICZHmEdRmw/I6DCd
         VxqWo6eZppmdBKrAJf9PPwhMMAW5c/s9zNq4TIuSxau+7lS6Z5J/K4oPWYY5yxK+bxjw
         XM0TZMSapxWJcDX8RXy0dDmbirbP7cTg6Kv8TZhpYPK5JczOGypYNQBOtk/dXKGsDzko
         Xrr6g/DZ6jsG/09NGsvT4VcZKLBRnONTvsn3d4X569AX57HGrqg13REHJJ0AmHRdXb6z
         qJl5AW1Gf4ZVMVh9wfPvkEIn3zTlXm6bGB93lFwRpVO86F4YCLZJiTEV+O8LWoN7dHRD
         RXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1EcXhjJm0xmO4/BQpyPl4PNsAnkq91sHgYel76uboxg=;
        b=JQXwBRaKKxLAUiXp9xrXUZhWaAMM/NdJ+cGF5vDoXGNgmRzamS8zLZnltnZbVKvqgO
         cGXH5+svmZcMt9b1gr/wHq92VW86K4PaOSOjpQ4NIIy31CRf+rDlQR+z/SL4zXEHyFWf
         3RxoBWrn7Jc7xMeEJfW2k+WVqWmKBN84x82o7+8pTBrrp9kCgjCMsplFvWanWxkZmDIP
         M8AaGlrUnFtEryQ4jPKL+dJfofvk1FJ/PK9r9b8qx+eYiM8gkCpbT5UUi7uX24Feara5
         cAiJNmQ5MxlkN6M+tEcBgp8CTugkDxLQ7w4uTcjIIZd0sacra3vc/EaXO+5IonXEvQIt
         FB6Q==
X-Gm-Message-State: AOAM533UXeTSUNeUeBw8SrGb1BG26YDS/U1rkn+ksM/FutNXpcsy8Hj1
        eN8pTspQOvfhtwrJCCyyjh3yPbvGOCWTgdIGh6xURA==
X-Google-Smtp-Source: ABdhPJweVNcGFAqZUa5di2TupKTNiWq/CiTK6yIxZ49mSU+ioUdH4pH0B4bwzSIRDRo2+vSySRSiPFV0864/2AavZGw=
X-Received: by 2002:a6b:7c06:: with SMTP id m6mr14851181iok.130.1605021169136;
 Tue, 10 Nov 2020 07:12:49 -0800 (PST)
MIME-Version: 1.0
References: <20201110145552.23024-1-brgl@bgdev.pl> <20201110145552.23024-7-brgl@bgdev.pl>
 <20201110150447.GW4077@smile.fi.intel.com> <20201110151022.GY4077@smile.fi.intel.com>
In-Reply-To: <20201110151022.GY4077@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 10 Nov 2020 16:12:38 +0100
Message-ID: <CAMRc=MfsLc_DKuCaOwq-xDjT0V8yk3rGt8buJ9qgbGNj25youA@mail.gmail.com>
Subject: Re: [PATCH v4 6/7] gpio: exar: switch to using regmap
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        David Laight <David.Laight@aculab.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 4:09 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Nov 10, 2020 at 05:04:47PM +0200, Andy Shevchenko wrote:
> > On Tue, Nov 10, 2020 at 03:55:51PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > We can simplify the code in gpio-exar by using regmap. This allows us to
> > > drop the mutex (regmap provides its own locking) and we can also reuse
> > > regmap's bit operations instead of implementing our own update function.
> >
> > ...
> >
> > > +static const struct regmap_config exar_regmap_config = {
> > > +   .name           = "exar-gpio",
> > > +   .reg_bits       = 16,
> >
> > As per previous version comment.
> >
> > Hold on, the registers are 16-bit wide, but their halves are sparsed!
> > So, I guess 8 and 8 with helpers to get hi and lo parts are essential.
> >
> >
> > TABLE 5: DEVICE CONFIGURATION REGISTERS SHOWN IN BYTE ALIGNMENT
> >
> > > +   .val_bits       = 8,
> > > +};
> >
> > This is basically represents two banks out of 6 8-bit registers each.
>
> ...which makes me wonder if gpio-regmap can be utilized here...
>

But the address width won't affect the actuall accessing of 8 bits
registers in an mmio regmap. Internally the mmio regmap does pretty
much the same thing the previous driver did: call readb()/writeb() on
8-bit "chunks" of the banks.

Bartosz
