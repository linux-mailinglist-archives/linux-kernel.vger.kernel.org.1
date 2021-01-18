Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA82FA1EA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404731AbhARNms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:42:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404706AbhARNk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:40:56 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A58C061757
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:40:06 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id x23so18201888lji.7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=agRpMrek+Sppj7GIr8oRcD/VoAZuQ4C+XG8ubwmjo4k=;
        b=rocze4a/cGqaTl37flewv1kZPlkcZC9Q9GsT3LiMVLV4JD2GajATAopnT7qRD69wU4
         m0KgxlHf3pEq/+MUD29LiuAm+v7BInGssiPywyFKZkz16/+AWlEv13Nt2YprofI2SVxs
         nqlrR7i1XvjYhJJlOeMW7jiRbGy5/e4u8Ed4srNbFCH7mMoCFXr4aFVuQlfSkGbAN5zY
         HIk5z8BBJ+iis8mmOm/OYKMatP40OzQH6ziMc1219ug3iLjnjZy+6LcLmj39a4qZtSUU
         3gJdT9ikQ97hGpsCqXtr924Fc6VPbm27drkGXsnsSrIpheyWNp9j7yP+v+nPjYDPfE/s
         piwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=agRpMrek+Sppj7GIr8oRcD/VoAZuQ4C+XG8ubwmjo4k=;
        b=eYuW/aylJZJI82rs2MlqLC1SnslpqMGDRYziRcSIguRwGXQab+V8FJlhMNbEAk8U0q
         zSommCBQM3mZZwwZu9hBnQUIYz7hfWBm13Q/wRc9gcrXfoAKKgsNR3Si55/hnkf6wLZn
         upoJ1QP64jpFC99qMH4wves13M9vicUrGJNyAsgawDJePaGXC/LWmpE31sNC7v0pBd+3
         pg4m4En1tIMIqGnw3ck3HOGs2Z3Ef4oSMRvmtqW+0gBcJxqFKFt2/24rjQAIe0P4J9C0
         sLpjUIeVgshKIXj4ByfgT5TQNrsa99TTkljNVZl5l4DQv4XBo6ciEv6TKZamimRRxhLz
         loBw==
X-Gm-Message-State: AOAM531k/8+0dBAV5rUu4gvQNQeG6E+bqQYr6eqRi80Fx2A277q+ziNO
        xbXuXd1zqbhBzeMfS3l8ZoOyIPvmD2FHBkKDsF5l/zkH6ag=
X-Google-Smtp-Source: ABdhPJwAvKK/U4EUCHlui/R7DHrDRKoSCCyv/UBKJaKwItG3nr4+TGKZ/eoC10L2NTt8VIP1H8+TMonSXEUM/aAoSCY=
X-Received: by 2002:a2e:3503:: with SMTP id z3mr11263570ljz.74.1610977205079;
 Mon, 18 Jan 2021 05:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20210112133010.21397-1-digetx@gmail.com> <20210112133010.21397-2-digetx@gmail.com>
In-Reply-To: <20210112133010.21397-2-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 14:39:53 +0100
Message-ID: <CACRpkdZunRyQhWcMxKC1qXfO9gni_n_1Hr90C-RA3jSpXcOYzA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] gpio: tegra: Add dependency on GPIOLIB_IRQCHIP
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 2:30 PM Dmitry Osipenko <digetx@gmail.com> wrote:

> Add dependency on GPIOLIB_IRQCHIP in order to fix driver compilation.
>
> Fixes: efcdca286eef ("gpio: tegra: Convert to gpio_irq_chip")
> Reported-by: Matt Merhar <mattmerhar@protonmail.com>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
