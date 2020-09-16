Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1100426C7F4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgIPShT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbgIPS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:29:13 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1423CC0005BD
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:47:36 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so8579641ioo.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 07:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E5pF9lMmeVoSBJb8mSB6mFtIhSuvd8nIA3BqMoC/eWU=;
        b=SFRo8QQjxsU7yKkA+RZc0YVot3GIsc/FRsrK3XDE3VFi72Otyyfa37isT95eY/1wtq
         MFTg0QpHqZRFvTRFDlrFiSP3PwPeoA+vQWykjFHhcOa6Pt45+MOdLiZIGiWfr/0bBR55
         x6zoBu/4a/uCc2h1Qtdet7tGyDJj6X4suctDKC1q2H1gyhukKXJsDMdlzeuOkJTB1cz5
         NgQ9SfBmbOhIO95vCjqaG5gyoMA2Y5IDj/Ozp7HLnsrr9GeFkW84RSVFeycVMOw3jqL1
         QzlgXVHjwg6JEJ3b7wBa/bDvc3fOnW4NMEdYxIAk4e9E5IXvJM2BaUO/KoEw/9ZXqGVM
         dxvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E5pF9lMmeVoSBJb8mSB6mFtIhSuvd8nIA3BqMoC/eWU=;
        b=AjiA/exGKjJvgDBpfi+Rf6Cy7P3n54zwkAB0oTwjY7Iz2e+I7qdscmlhUgfwsf+ofk
         HI4q3LnXxX/zuL8OlRGI6oY7tC6/EmdwLS2/dQK0t28A4iYvyaw4FLxuMju4ztvZ1y9W
         87NzOHUuOATMuSoA/Bedn88u5pcsh7JitXlbycCQxU3KWp7/EW3aHBnPBX0d5F0r9/wV
         Q8NJQrUN3yvkh4FU0RunNXuWfjJkKafi8pBlBs+VUmA9WhxYcQylnIpcQ92/F20PP5zY
         w76j+nRZ8goO2zJeqQwdj1dOiOajIj78U7r1F6yKjtCpNJLxSbEIuuPPuQ5n++QFkHQO
         3yGw==
X-Gm-Message-State: AOAM5303aSe4wWXIBWfufSLhyHPp1OZDQglUVZaYNtfNXPd5rZmsVK8P
        u6WYIe5+RDVIQIl/IB1NYa7a67XkF4R1iGq7ix03EQ==
X-Google-Smtp-Source: ABdhPJwCfgvVwRMe8qj05bW8NCAyHSJaBHEQTb4Zp/DlvR6q1kq3Dtj8xtOG1GNzb97HgQ8aIB/XjoMexxrp3seDKmM=
X-Received: by 2002:a5e:dc08:: with SMTP id b8mr19358681iok.13.1600267655428;
 Wed, 16 Sep 2020 07:47:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200916134327.3435-1-brgl@bgdev.pl> <20200916142930.GK3956970@smile.fi.intel.com>
In-Reply-To: <20200916142930.GK3956970@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 16 Sep 2020 16:47:24 +0200
Message-ID: <CAMRc=Md5diJd+C2j_sHcZN5tM+r_W0Tz-naK1s=qd1bx-_g0Ng@mail.gmail.com>
Subject: Re: [PATCH next] gpiolib: check for parent device in devprop_gpiochip_set_names()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 16, 2020 at 4:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Sep 16, 2020 at 03:43:27PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > It's possible for a GPIO chip to not have a parent device (whose
> > properties we inspect for 'gpio-line-names'). In this case we should
> > simply return from devprop_gpiochip_set_names(). Add an appropriate
> > check for this use-case.
>
> Ah, nice!
> Can we also add a small comment in the code, b/c w/o it I would stumble over
> and eager to remove looks-as-unneeded check?
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Sure, I'll make a v2 then.

Bart
