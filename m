Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A19912AE54E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 02:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbgKKBIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 20:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727275AbgKKBIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 20:08:37 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B44C0613D1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:08:34 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id i6so906980lfd.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 17:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OKnTpb6WDK79h6wzA/BGMIqbAHNaR/GEp/A0ryb8Y1s=;
        b=ST83Kv6mMeTo+80B4tYYL95DnnqVTImdY5ZZb3uEwhr9CRDv2QHlUfRCNcmxIoMHuc
         +kHBzQG7KQA5gBSNNuGb9jqENXxRGimjrlkEkZ0K+lpssMvOVnK4JbS8L4O8wBgq2UNB
         ykrpf8YV4mHTIUtsErKhFjpGIpRNLKk3iIHMa0aXTLWvUqQTOBB8Q/2nbecCIAvjFFTg
         iE2FFBrv3xPe9vSOjZvcNcrzz6G4hA3JcoMq1V3P9wmmp5wy/1JmAhAQQ7FNvkoSk3KG
         TAOKk3y3pJJDeuO8ZU7NgyXI6ByFBJVT5cDcoMLhw1/hDGsL++oo6AgN8wxNZQrUspEh
         18YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OKnTpb6WDK79h6wzA/BGMIqbAHNaR/GEp/A0ryb8Y1s=;
        b=CiOYp6cZTRkVcLKkV3SLdrQdRcyIMGbWkARi7DNmYhQPhIlo2344q0GQIWv8+kZt6L
         yfXFYMnAjcBYV+YQKKApj15kQ8e3R9p/vjQRGBKtb/GY5I+u4VQClMtZMefBvkqphVg4
         8d0+Kn47TBNciHmjE4IXodVyI0DrrDJItMF9LnUJd9Sw8EpfSZH/qAdpAgmOJxO49quZ
         3T+t8Dq7w7Re2clFrhWFp6BWn9agJnB7zgzSWyF78QjS9KEG7zXWTPSCa8fMTppStqby
         NilWmEll6ivbC1NZ4qMMjs8JspanVuKmluDw3k+zo+C/dnmFSwsZ0kjTzyJj5pvQ17tb
         +RVA==
X-Gm-Message-State: AOAM532upZk5bp6g4U8Hle+tnv3/33aPLCTasxZOXgFDB0qi2w6Nuq9J
        6GB+0eTEDzINq7FnjCFHSlCbU1m0sNdLuky1JJrcSw==
X-Google-Smtp-Source: ABdhPJyTz8edr2BkyMyzpSGiwVzBOi5L8wucnKcO8juRdvYXVu85AtYasLPNSH9oTli6dkFHHgq6lfKAkHprd/QE7Bw=
X-Received: by 2002:a19:5e0b:: with SMTP id s11mr7865088lfb.502.1605056907439;
 Tue, 10 Nov 2020 17:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20201106150706.29089-1-TheSven73@gmail.com>
In-Reply-To: <20201106150706.29089-1-TheSven73@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 11 Nov 2020 02:08:16 +0100
Message-ID: <CACRpkdbti4j+oL8=7i=G8YOGjpNre9X5dMs+HH0vLA4QpYPD0A@mail.gmail.com>
Subject: Re: [PATCH v1] spi: fix client driver breakages when using GPIO descriptors
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Simon Han <z.han@kunbus.com>, Lukas Wunner <lukas@wunner.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 6, 2020 at 4:07 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:

> From: Sven Van Asbroeck <thesven73@gmail.com>
>
> Commit f3186dd87669 ("spi: Optionally use GPIO descriptors for CS GPIOs")
> introduced the optional use of GPIO descriptors for chip selects.
>
> A side-effect of this change: when a SPI bus uses GPIO descriptors,
> all its client devices have SPI_CS_HIGH set in spi->mode. This flag is
> required for the SPI bus to operate correctly.
>
> This unfortunately breaks many client drivers, which use the following
> pattern to configure their underlying SPI bus:
>
> static int client_device_probe(struct spi_device *spi)
> {
>         ...
>         spi->mode = SPI_MODE_0;
>         spi->bits_per_word = 8;
>         err = spi_setup(spi);

I feel torn about it, there are so many weird corners of semantics
in this code. The patch makes the code easier to understand
too.

If it provedly fixes more than it breaks:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
