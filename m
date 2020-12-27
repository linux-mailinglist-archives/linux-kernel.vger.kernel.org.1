Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4222E3306
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgL0ViD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL0ViC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:38:02 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3746AC061794
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:37:22 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id h205so20099849lfd.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+i5gcSrm6q/8nFooRN/AQ71bCz7/QCSgRKeWd4XhemA=;
        b=bQeRFwvT8c9tCXwanLGGjLqZ0d/EnrhH9dwzmzhyS34cOmBIWXgHKX4tqUKrBQgu5c
         ON5sts08nEqoAqnNrpLwkbDxcEpThc17qIM+33kJ5EQkhPOCoHN1S285W46SOjmdGQy8
         ttb9NPM1eMw9RUfQrmxOLwb/9DKioxl3BGxCgZ1S1z0eS3IJVPNgm6GpIrOnWltn8pD2
         OsIX0whzoNDsDNKIpcCnPBn7XFfGBbYtVNtM4LsjPjhIyEvb3baH+o8hKoSSPLkzA9Z9
         Z+xvfQqckTejGcNvN0QyGgdxvn4Qe2ww+zP/I9Oga6Z7loS4s02jlBO/7Jin3t2Qckc6
         AYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+i5gcSrm6q/8nFooRN/AQ71bCz7/QCSgRKeWd4XhemA=;
        b=g5nM7U+zlFRLEfitIBV5Jn9avOwcIZ596zCOA+s65DIqxh25zYlnzn3tHtv4V5BPby
         wFSfzFwemtqdG7yFICyS4sGLj3PMgKPYLRzfqmINPU69OwmTTkHnOasGDW2IIPBHiVAI
         g80PUvediZ3wTEaEB3lAoIV+msmEYnAvHanJpTqaf1c/26AnxwG8E8nOInPKflq7IlBA
         TuZ0osK8YMZ/vdlu7HbTmYwIdN0WWTaqEegRFvMRjW4cazEaEiRZwWUyeloDHK5MemTZ
         gsQP/IA1Xu3BN3iK4LlcnnnNrOJ+tpcj68UKjc4i26wPF0Sh0QRr2nnk9o9M+2RnWuKw
         wSsQ==
X-Gm-Message-State: AOAM5337BmoBZkGd9Bn5SecmNX1kx9lnDN3CuRmIm+Sqe386jn8gEx9N
        rNqa2tJ7df9Oi6YV4+ZbtayVdL2eoDq6id+P1NZL7w==
X-Google-Smtp-Source: ABdhPJz1l0q/Rz6oEDylYqSr4C7rGmi78uW0PNdYU5Ir6hn1cuQIRPrSVr5XZuuUdp1TxdfW+enmU9jJaGU7CnHUxy0=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr19639077ljl.467.1609105040797;
 Sun, 27 Dec 2020 13:37:20 -0800 (PST)
MIME-Version: 1.0
References: <20201227161040.1645545-1-warthog618@gmail.com>
In-Reply-To: <20201227161040.1645545-1-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Dec 2020 22:37:09 +0100
Message-ID: <CACRpkdYk9U_=AOyy7NSKL9+Aoe0+qCdZVN9EXWLn7NUcUajipQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: cdev: fix frame size warning in gpio_ioctl()
To:     Kent Gibson <warthog618@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 5:11 PM Kent Gibson <warthog618@gmail.com> wrote:

> The kernel test robot reports the following warning in [1]:
>
>  drivers/gpio/gpiolib-cdev.c: In function 'gpio_ioctl':
>  >>drivers/gpio/gpiolib-cdev.c:1437:1: warning: the frame size of 1040 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>
> Refactor gpio_ioctl() to handle each ioctl in its own helper function
> and so reduce the variables stored on the stack to those explicitly
> required to service the ioctl at hand.
>
> The lineinfo_get_v1() helper handles both the GPIO_GET_LINEINFO_IOCTL
> and GPIO_GET_LINEINFO_WATCH_IOCTL, as per the corresponding v2
> implementation - lineinfo_get().
>
> [1] https://lore.kernel.org/lkml/202012270910.VW3qc1ER-lkp@intel.com/
>
> Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>

That's an interesting regression.
Anyway the kernel look better after than before the patch, so
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Bartosz will pick patches for Torvalds this kernel cycle.

Yours,
Linus Walleij
