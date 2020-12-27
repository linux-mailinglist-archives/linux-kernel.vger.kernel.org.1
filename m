Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF882E32EE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 22:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726350AbgL0VXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 16:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgL0VXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 16:23:36 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AD2C061795
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:22:55 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 23so20003468lfg.10
        for <linux-kernel@vger.kernel.org>; Sun, 27 Dec 2020 13:22:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWNvqT718TtFHxxL1hVou0I3CjOu5jdAB/yTtW9J2ac=;
        b=Qj1Y7TvpDFDZOd7YVj9PzhP38t+aoI+cYPF0ZIcFaRId6RMD8qDrMj4k5lp1vjTCFd
         VRxTyfnsiolX+d6zJekiX6uEgXrHMzZFULyePSvS/a+PO6RDIixGXjtyD6wFDccRXnmJ
         3beoeQTsQT//OecH1tCf9I+AZwnaWhGFODhEH8qrkiHXzpcYxUO0jIQfNLDf8ayhPXes
         WYxjiku0ut/LlFMhjaFLPT8cGXP4jLnXEIlHOiRWMNpaSGA1FVygjdJXMuJQV/jVIxCo
         slxjaFCpWJkafsLrUVZjvBR4AjigxgK8/+nwm3So3zsiGY0nmKJ4pKJlW/N1em39VR2F
         a5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QWNvqT718TtFHxxL1hVou0I3CjOu5jdAB/yTtW9J2ac=;
        b=U27QPqBzBqvXEbsg+gRjZyYUbTvHBTn0LyUuRngLyaFhr0olTJpjyZp4cJC7I+0ME5
         iDGQAV9pnEpC+AMkDpgK5hs8RX+cIpWaNu6+yArg2GwxZF57+XTg98gqJEPAG02SCcVn
         +cX0A+KnWlxr9KYcRAyczbU9Ev/98w2CW9pghdr//trT9ROW6zIDDV3L+11gIJNvk+nk
         BGeZJV5/EHAfvgMMm9y37MsR6b9KsD2j6BqfMsO8yrtpXEA5hqjcknnErk7GQtuk4qhZ
         Ra6262eezbjTDUrNNWZudCFo2kWvp6Tdbc66jXWk6v+RPw9OWBXPpayEDClwJf7g860U
         wXCg==
X-Gm-Message-State: AOAM530KcXXMvdAWEONMmxdQtPPQWwUeBQI4uCu26R9CYUc5Dm1YtwlG
        Sk9L0ioxjkGPyyb8JbTFGu+Z0Bn5EIfh0040qe1JzQ==
X-Google-Smtp-Source: ABdhPJw7AJsmxtGqtNjd1OluKJUYV+CiQlo3p+CbhgWibggLiv2sZvQOt2AiqsV3sbfqS/R4yPu+yV4pxMlSXJKtj+I=
X-Received: by 2002:a05:6512:3238:: with SMTP id f24mr17645305lfe.29.1609104174071;
 Sun, 27 Dec 2020 13:22:54 -0800 (PST)
MIME-Version: 1.0
References: <20201224112203.7174-1-nikita.shubin@maquefel.me> <20201224112203.7174-4-nikita.shubin@maquefel.me>
In-Reply-To: <20201224112203.7174-4-nikita.shubin@maquefel.me>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Dec 2020 22:22:43 +0100
Message-ID: <CACRpkdaB2OXrVo+8cEMY_vLODnQXsuv72bu12qBusxFj++H9HA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] gpio: ep93xx: specify gpio_irq_chip->first
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 12:22 PM Nikita Shubin
<nikita.shubin@maquefel.me> wrote:

> Port F irq's should be statically mapped to EP93XX_GPIO_F_IRQ_BASE.
>
> So we need to specify girq->first otherwise:
>
> "If device tree is used, then first_irq will be 0 and
> irqs get mapped dynamically on the fly"
>
> And that's not the thing we want.
>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

We can only fix this properly once we convert the platform
to device tree. (Along with making the irqchip hierarchical.)

Yours,
Linus Walleij
