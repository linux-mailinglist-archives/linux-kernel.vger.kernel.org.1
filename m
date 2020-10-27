Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5229AB83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 13:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750734AbgJ0MMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 08:12:12 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43244 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750496AbgJ0MMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 08:12:12 -0400
Received: by mail-vk1-f194.google.com with SMTP id d125so293071vkh.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V3hdAD2/SfSVH7mLkNbOazbZ1K7Ev/XT9ONQ25TQSDM=;
        b=PDTzx3wAmjvtMIqJLQf55wBX3zV38/E1NKQ5hbF9J37P08tWIczYGfMiDSri4xIg9+
         D9gol1nV6KVYi6Khf2wEMy5sYHrpUr86+CdjE4fqGO/REJGVUHnZUXG5c6vNYAxLrYwy
         3IoFi5UPd8B2S77Jp9ejkSanfGhEY8mCZhKnaNEp285Gp8oHExqo54MoOfC2hGyT7ghA
         lDgQ8iHU5tPmPNjJaCcADMi2qU3OqvBBPliNvYl52SLhS2icaiKPhg5V8e/LmAvonKhX
         x6e9HDTk4W8radGJrKEUVq1y91uAunqgLpmeNau7FcOO19Njbz7l1MaIDoV9Q3NDvpwu
         WMsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V3hdAD2/SfSVH7mLkNbOazbZ1K7Ev/XT9ONQ25TQSDM=;
        b=e5PMhqQbT1sxaFRTQq7SQHjGdDpL6XK2Tu58c4KYDhUgGu/xWl0/IY4yEVQ1YQxgRo
         GAaLYEInWlclSFCKS/qr8dKs29lC/mFP8411UCnhHFBHARMfp8auldcZ4eAgW+sAxHXz
         MTzoUycLdWfROtPgrBGM6wvmAR2J2iNa12en9QWcTiBaf52eo6Q2nz1krdPi3etO4KXv
         MBe23tgBxrSXRLtn07xnXvYCmbLVN2yiALMIpKKsrXqBrZl4AO970lYzR0Shtc1yCNYz
         I2lXWlQqxv7VzPhMH0okslnnJzB6FQ2Qa+BAnyNgDIT7P/J7mQIsJ8lgQzck0U6I7tmn
         53Lg==
X-Gm-Message-State: AOAM531LaOwn8pzxF+qM+GeCa9YV1S39IlK9ZNNZi61JIz9gkvRGl9BP
        iThPMmEX6goDFK4TytoL1v3PygQK3R6mrVvcFOvIzA==
X-Google-Smtp-Source: ABdhPJz9LZoiTJhx1SHZvE2wOEztXoNObRC3nyLzZpkAJKjEOp/2NEgP80ioL4M98sMqoh79lv2vrnEnNPppto8YuAU=
X-Received: by 2002:ac5:c1ca:: with SMTP id g10mr1144150vkk.6.1603800731083;
 Tue, 27 Oct 2020 05:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201023122950.60903-1-fparent@baylibre.com>
In-Reply-To: <20201023122950.60903-1-fparent@baylibre.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 27 Oct 2020 13:11:34 +0100
Message-ID: <CAPDyKFrMwLeuQoFDgXYo_-T_e2AzfqM-rgp3-SgeuC6Qn6rxMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: host: mtk-sd: enable recheck_sdio_irq for MT8516 SoC
To:     Fabien Parent <fparent@baylibre.com>,
        Yong Mao <yong.mao@mediatek.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Yong Mao, Chaotian Jing

On Fri, 23 Oct 2020 at 14:29, Fabien Parent <fparent@baylibre.com> wrote:
>
> MT8516 SoC suffers from sometimes losing SDIO IRQs, this makes SDIO
> devices sometimes unstable. Make use of the new property
> recheck_sdio_irq to fix the SDIO stability issues on MT8516.
>
> Signed-off-by: Fabien Parent <fparent@baylibre.com>

Maybe this is a common problem, thus I am thinking that potentially we
should enable the workaround for all variants?

I have looped in Yong Mao (who invented the workaround) and Chaotian
Jing, to see if they can advise us how to proceed.

In any case, I think we should add a stable tag and a fixes tag.

Kind regards
Uffe

> ---
>  drivers/mmc/host/mtk-sd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
> index a704745e5882..3dc102eefe49 100644
> --- a/drivers/mmc/host/mtk-sd.c
> +++ b/drivers/mmc/host/mtk-sd.c
> @@ -524,7 +524,7 @@ static const struct mtk_mmc_compatible mt7622_compat = {
>
>  static const struct mtk_mmc_compatible mt8516_compat = {
>         .clk_div_bits = 12,
> -       .recheck_sdio_irq = false,
> +       .recheck_sdio_irq = true,
>         .hs400_tune = false,
>         .pad_tune_reg = MSDC_PAD_TUNE0,
>         .async_fifo = true,
> --
> 2.28.0
>
