Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 333631F90FD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgFOIGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 04:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgFOIGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 04:06:04 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC93C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:06:04 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id y1so11868724qtv.12
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 01:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y7uJRbGGvdP4YgJCKlTTB04yoKIdbZ44XdVpkWA4eLo=;
        b=mJP006ALkTf6tZMnk0CVb/lK0d+Kiphgow+YqE9InaHh6PwPBjimUFuooivb+XgO/z
         YJP2VsyWT6TJbHKlDdKIeAEg8Yui6RwoVxXhpfOmdRuZkqmL/Zxl18t51xd47VPlUOsd
         QL3d86JyiZYbt5UOla/FE5BccZnXY97vwK3Ek1zSKpxuiMPjau4NLcpKgk1eYngggqXO
         7lQBbV7aA2+JZf2K7oENSOGFTEt8iGsWY2X3AvnsMf8QE8tn7Ry/SFd3Qozyy/jQ8+tE
         EAtylBk66FAHxyL6n0lFBxmRFF+oiqOtYrDIxl45Nv5BwHheeu4B6S+06mKi1YVckaI6
         uQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y7uJRbGGvdP4YgJCKlTTB04yoKIdbZ44XdVpkWA4eLo=;
        b=lghBZ86QPoSSSntwAmwOy8Srk7Xjymdf98O079pcdPoGiVkZcLbwwwWmkXU3gb1nx7
         ykNyN8jSWDMaqgILsDC9Wns34T4+2xvvPkbBR0JqQfAAXiGHmSr0++lxmRA5Xktub7v/
         kbMjWrMAi9qKbm6/SJBG90OVF+FzNhuzZbK5JQ/IC8u4hH7tRFe2yFOr54T4wLnDa0mf
         3jRxIgdBJElVuaRCaDfaw9TJQzF6NBOvXr6TvRH+Ks5BJUUTEB6JZaE5RieZNdtEm/QJ
         u4T+3bpqi/HcSdLJTJRZmZVpV68vjV82ZPZbn7dVjZAs9pfhDchDowLOl1Vbm2Y9V8QJ
         kyPA==
X-Gm-Message-State: AOAM532l8Omr2HZrLfXdqHSBn1Vz15guuOJSUo/hR+o937Zugjx2f0gy
        0sQAXl1o9qVGmxO4Q38FaGUp8m8jIy2wgPRkTjfXLA==
X-Google-Smtp-Source: ABdhPJzuVatKjvfNPfptZxy9khtOlStDT/4TZpiCuQrHEGqM5lJmhBgrRKpjXG+7iknxfcdBL4pKYW0yuMxvK9LiYt4=
X-Received: by 2002:ac8:1bc1:: with SMTP id m1mr14067075qtk.57.1592208362743;
 Mon, 15 Jun 2020 01:06:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592203542.git.mchehab+huawei@kernel.org> <97beeedde507eaeea189ae955c9f35ecf1563d6d.1592203542.git.mchehab+huawei@kernel.org>
In-Reply-To: <97beeedde507eaeea189ae955c9f35ecf1563d6d.1592203542.git.mchehab+huawei@kernel.org>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 15 Jun 2020 10:05:51 +0200
Message-ID: <CAMpxmJUyOfM3hqqEzeHzQxOYG57+ZZD-wLVYbtOaRsiNDiEfYg@mail.gmail.com>
Subject: Re: [PATCH 08/29] gpio: driver.h: fix kernel-doc markup
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 15 cze 2020 o 08:47 Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> napisa=C5=82(a):
>
> There is one parameter with a wrong name at kernel-doc macro:
>
> ./include/linux/gpio/driver.h:499: warning: Function parameter or member =
'gc' not described in 'gpiochip_add_data'
> ./include/linux/gpio/driver.h:499: warning: Excess function parameter 'ch=
ip' description in 'gpiochip_add_data'
>
> Fix it.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/linux/gpio/driver.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index c4f272af7af5..c11261f3c724 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -481,7 +481,7 @@ extern int gpiochip_add_data_with_key(struct gpio_chi=
p *gc, void *data,
>
>  /**
>   * gpiochip_add_data() - register a gpio_chip
> - * @chip: the chip to register, with chip->base initialized
> + * @gc: the chip to register, with chip->base initialized
>   * @data: driver-private data associated with this chip
>   *
>   * Context: potentially before irqs will work
> --
> 2.26.2
>

Patch applied, thanks!

Bartosz
