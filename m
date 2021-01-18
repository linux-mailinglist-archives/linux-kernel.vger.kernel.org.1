Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A16B2FA1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:43:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392426AbhARNmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404660AbhARNkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:40:04 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BC3C061574
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:39:24 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id m13so18199346ljo.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 05:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7rCmnKzXpVa20gXpSfmHUH8NWDq8PYAlPBp+23NCeYc=;
        b=T9EUMNeImUwwkD4WyDhF7Kk0NSaYLw80mFsxFto0JPp2Vj3wumv1RBBWA2bDRx0ctb
         gQ9m59tSyu6g0fUCewx6qmixqPDCNmy5Xvn1rmigxBUIJQSoMBim/f7GZY2YN8Sqq/8n
         ijo6r8uXig2cqictwngUdeqLU0rmWPK81JZi3UQ7F8mVvmPBAqQB93ETUbF4UAZunmMz
         r/l+LGZnCjtUpjTKvPiLBxMnllEjn7dxehkBDi0bWv8s2EB0qsgjMFUWAmjq70VKhb/5
         bhcSA2oSOp0aiuu/cdOuMoxHhnKMCqMse84Ju78hLrx+1Y5cNf/gkos8xole5CpCRWI0
         71Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7rCmnKzXpVa20gXpSfmHUH8NWDq8PYAlPBp+23NCeYc=;
        b=IkuvSaSvfn7iFvomO9f6HWli4D9fWN6gnRTddekfVFOwnp/6XF/Pl+jW74ljWOoTjR
         yz5OoI0hpmFzw+7vdDNWMoL1W4DLwc/GP47CmLYBHJGHw6wbgUeRKYnrnBpWNoY0BK+V
         7wX7lq++j8SvBIIv/tfyYJDGUy1GrqD/TLqwJKv4N37zAX7y+MmQRdz2KUi4tQYlXDBt
         1OSj+so2pjRb99pRuE1egxDahSKAh9tuh7OpqYxMqzBS+ldKrXlD7rxquxq9GS2ZTtim
         TyDcgpJnc25885dKi+NZaq9hsOXQ70VsC7QAAbFI1xY6lNIk4qw1NZONBX1e7q8ut1Fi
         EMMg==
X-Gm-Message-State: AOAM531Ra7poiXd5ZtYbMy2b3Sx+P7Fi+MvRlQukZlfPiq6aza1JcGQz
        UQQAikwEp+iRA9n9jhZDnB0GvV4uIUT7UtPxp5vO0Nc3ct4=
X-Google-Smtp-Source: ABdhPJw3FCTQyPsrFGXu0G+vqPN+sHa2TBDw+/GAEnvxRNO83nf1Xwv8q0+VTXNLnEkl0npJzDid86l9ZTjLU5Fifhw=
X-Received: by 2002:a2e:b047:: with SMTP id d7mr10100589ljl.467.1610977162805;
 Mon, 18 Jan 2021 05:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20210112133010.21397-1-digetx@gmail.com>
In-Reply-To: <20210112133010.21397-1-digetx@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jan 2021 14:39:11 +0100
Message-ID: <CACRpkdZtOiWz=FuBTX=uO4LU22d-OE8D1-B6nN-OHYNenMVYGQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpio: tegra: Fix wake interrupt
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

> The GPIO bank wake interrupt setting was erroneously removed after
> conversion to gpio_irq_chip, thus the wake interrupt programming is
> broken now. Secondly, the wake_enb of the GPIO driver should be changed
> only after the successful toggling of the IRQ wake-state. Restore the wake
> interrupt setting and the programming order.
>
> Fixes: efcdca286eef ("gpio: tegra: Convert to gpio_irq_chip")
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
