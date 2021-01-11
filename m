Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42EB2F0FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 11:13:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbhAKKMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 05:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728762AbhAKKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 05:12:13 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87ED5C061794
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:11:32 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id w1so23780309ejf.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 02:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DzSq10+w9uGbouK/0N/k/Vyq9HI+oX+c5Bfx1maAHnk=;
        b=brKNTh29fweEfuS7wgq5tVU7Zox/66VxMuF0fPbTJ6B0iOTekE8JiQ0ChdjK165R8S
         1Ku+FXvjag1mGTx5kLLtuq+6JZ+5VEKaReKXGtiYYwAoe69Tz3rkaq9Xn6R3zhEYMFkB
         2JzuJJOQUU7LyUTdENSO6Pi3mkDQMGc/cpoD3r+bJo9Rx16iin6ZScdkBgRfnXTHuiWv
         rIrEgzKkLKL98GGxdFiMri/U3KQmi49J700/znPeKpI1VIwD3Xu9idqOuYQAjHB78UtO
         5FNRTglPy3U5YF/iFswc3yeMpRGPasK4Vb8vgdKF33I7Nf1Ie07zsDwCReqW58APyFOE
         9uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DzSq10+w9uGbouK/0N/k/Vyq9HI+oX+c5Bfx1maAHnk=;
        b=s68yW957onZaAzH1yjvCI2/3Wc0vRjV4RvSXca7W5H+SE8iGCrZRT2jITwIUwBK0xY
         XLBbDcGu2kWOvuGRvrYwDHPikZVk8Eo5R+rT0gFSamnV2EpgczntxOjSwpMx/sciUbjm
         TnkhzWk/4zgheQT3Q1foVNX27VaXR1qZP0VKE/2gNbNSg7oWxKekrCfrSeGJO2gK7vJx
         bF/DvvaF8e8mRgr7DUxm/jjPqtejzmgUKUeQ/+jYe0CtRg/fZnIMr8eLJixfghjc8pwg
         8O+ZWs9j7Ex4Mm2H9hkLJzK5SO92xyR6kzXqPlL3wATXeA0aatu9AvLzBMHh4fvsHzTy
         L3lQ==
X-Gm-Message-State: AOAM531zG9yHPMSaTrj2bGLd65UNeryTuwebhMPGRG/1kvZKSmLpaYz0
        saVJDNl2B2Wu0HkfRCkHiOFgwvWh8SBX7AW3o4NAng==
X-Google-Smtp-Source: ABdhPJy6BAGaxo9ow37JgvNCEtTIWZ6DevYVOAPVrh5msYMf4oLqwqvTx+sKPHhMSvbD1Yo57et1/lMYJHV8uQwa0FY=
X-Received: by 2002:a17:906:3513:: with SMTP id r19mr10055190eja.445.1610359891259;
 Mon, 11 Jan 2021 02:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20210108092334.19101-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210108092334.19101-1-zhengyongjun3@huawei.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 11 Jan 2021 11:11:20 +0100
Message-ID: <CAMpxmJV=k7bWC5xNNmk1rHXwCQUX=c1qEQ6gm6xU24zE70Hymg@mail.gmail.com>
Subject: Re: [PATCH v2 -next] gpio: convert comma to semicolon
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 10:23 AM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
>
> Replace a comma between expression statements by a semicolon.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/gpio/gpio-mc33880.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpio/gpio-mc33880.c b/drivers/gpio/gpio-mc33880.c
> index f8194f7c6186..704cd4e6171f 100644
> --- a/drivers/gpio/gpio-mc33880.c
> +++ b/drivers/gpio/gpio-mc33880.c
> @@ -99,7 +99,7 @@ static int mc33880_probe(struct spi_device *spi)
>
>         mc->spi = spi;
>
> -       mc->chip.label = DRIVER_NAME,
> +       mc->chip.label = DRIVER_NAME;
>         mc->chip.set = mc33880_set;
>         mc->chip.base = pdata->base;
>         mc->chip.ngpio = PIN_NUMBER;
> --
> 2.22.0
>

Why does the tag mention -next when this has been like this for a long
time? The subject should also be: gpio: <driver name>: something
something.

Bartosz
