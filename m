Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD0AA2EB55A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 23:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730429AbhAEW0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 17:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728623AbhAEW0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 17:26:12 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285EDC061795
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 14:25:32 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 23so2121715lfg.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 14:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FEMLTsW4Oythj14GTJ7jU31wZZ5hKMA2Ny2/8Kp+qyU=;
        b=luuIkypBrdkLIJOh5VdpP1r6bU5h6/MvOS5HZ7fLbk9J2aQRLUvth1Jdm9+VVAqe8C
         U0tkhXeOLewRlAW31feXuG4kPxjy636EfksbkExqGVKVtnX3mfstNWlZSril2qDUb2m6
         GYMkDXMUc/v8/5D94qGgC8qghk3jlabOqKR7kENcAEnBo+nGa5seXF7H3OIVRagD0iBj
         1fFNkZp0UWZABEoRQXFXxdjpDH9TDByAVEnmAyGVda65Ld1hB6f/BctcflMp0ofY3wKy
         7FsivcyPTyk6KgwVfbozByw7W+vR8TliaSm4JBY6zYYJWulq0fDN1J4ziG4c0+BwQf/H
         IEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FEMLTsW4Oythj14GTJ7jU31wZZ5hKMA2Ny2/8Kp+qyU=;
        b=KEq+eeNtnage/vLhFOGYIQpcHfG9L/ikbxyKlyRxsbgy8WuqG1XDfH1siwjGijhOqr
         9WQ2kEa5hleMqSzCZTLfYtmHc5OOz/dbM2yUtLTvsELrHXoaHFbTLw+hp43VMqvh6Uqd
         i6bZT4GoH0gm/VdU9mzV7i0/sDxQdwtggm6xRJi9G3X6br5OiZDSpBLhXIq0QjFH9RVf
         rfbAxgVJq6KOx89DaDLfp+vCs0waaLu72o7eBn8kpGOcay7RSJ3sawp4Ol45TxC8pKp2
         5m9/usQEdJ5AJHVI2DtBJ8jg2ZxBgjOxUceXaNRdO9QasBIYjvRXK+6IcSiimXKIBml+
         sY0w==
X-Gm-Message-State: AOAM531ULe95WEQtNuQrdT3v79nhFuU1W0dooyX7yXE+KEK526M4GfYM
        EzwR6UzGwR6AHJ7/8590ZMWS8jjjqK9MIkCNRBYDqidTy2o=
X-Google-Smtp-Source: ABdhPJzNspcIZCgj+WaYvpSErvdW9Yg+x+bmKacIit/Eo6Mpg+DwDxpilNb61mDmzj/m814bywHFeTHSXkOEdJyUmM0=
X-Received: by 2002:a19:495d:: with SMTP id l29mr544766lfj.465.1609885530724;
 Tue, 05 Jan 2021 14:25:30 -0800 (PST)
MIME-Version: 1.0
References: <20201230154624.714388-1-arnd@kernel.org>
In-Reply-To: <20201230154624.714388-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 5 Jan 2021 23:25:19 +0100
Message-ID: <CACRpkdbTsUtu-eow4iSiD-hWA_t_OAt41PqFMiG30eAfvcwrBA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: nomadik: remove an unused variable
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andrew Halaney <ajhalaney@gmail.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 30, 2020 at 4:46 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> A recent patch added a local variable twice:
>
> drivers/pinctrl/nomadik/pinctrl-nomadik.c:953:8: error: unused variable 'wake' [-Werror,-Wunused-variable]
>
> Remove the unused outer declaration
>
> Fixes: f3925032d7fd ("pinctrl: nomadik: Use irq_has_action()")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I got an identical patch from Nathan Chancellor on dec 29 :D

I'll add your reported-by and Andrews tags.

Yours,
Linus Walleij
