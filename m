Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA60278426
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgIYJgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727905AbgIYJgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:36:20 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0722BC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:36:20 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id e2so1010983vsr.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CopwlfwvxR6TDA4NEpPReJrXwzQ2YdaVXCfZyj+KeI8=;
        b=gQDqhM1EBxhhdAdupXGC+mi8HP42zIBAb+/5WouwU0pwYgc43PjnSIDyqhNXoJBgwE
         nA9S7PMscej5cgQCrvf55Dp29QyMHvwUDUtmdsjDRjaEHcRFBhd7dmLwMWl9mvoH7sp/
         4lRasNIvYZAFCtIP9ZaogcqOJXzEYU/4iYpzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CopwlfwvxR6TDA4NEpPReJrXwzQ2YdaVXCfZyj+KeI8=;
        b=hT3A9he7Vo5VPRsRawq+ajUhcWIuyaBV69gMv22EK9iEfzPRCgJFKkDiOYMTsihHru
         TdLgXhIOVOOiJaS2dXWkkltN0vbjDLTirFynE9N0AOVCfv2XFfylbfwf7Daj1zyEM3lo
         T65pTW88ihDqYfCw6xAw8vQqs33z2wfl+6cdFsmISY/9M0NoYD3WHbwFYF9/S+F0afrW
         2zMOe1x5rAo1xMGmvFlP/td76T4dXEcmSMJqvOMO/DxVbZPgnF8In9v7IcgthGBuQGoQ
         TkuTmVXEiu6kyzqSP+QolzIfQ8LtB4StlUzZmVFkoAaZDIz/qPl78yRvZsdN1Eas5Vy5
         as3A==
X-Gm-Message-State: AOAM532vQzTH5Wf3xX5d0uewgpVFU0HhvjHBZpmp1DAnWJ1A5Ona1lzl
        4vBKs0J4iM97G1Qy8r0iDfRM6GnwIJrjzqCvZBAq4A==
X-Google-Smtp-Source: ABdhPJxdJedhGCUBzFfJjDuMt5UWKrHFjl71MnBQbIp5LNRnu+DHrChmvGin2RNOLR4c+TakRNBVwDRVvnRZRQt2lqc=
X-Received: by 2002:a67:b917:: with SMTP id q23mr2061999vsn.37.1601026578879;
 Fri, 25 Sep 2020 02:36:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200925065418.1077472-1-ikjn@chromium.org> <20200925145255.v3.2.I48d59ef5398f3633c6ebbab093da6b4b06495780@changeid>
In-Reply-To: <20200925145255.v3.2.I48d59ef5398f3633c6ebbab093da6b4b06495780@changeid>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 25 Sep 2020 17:36:08 +0800
Message-ID: <CAATdQgB4Z2msO_RuOuVMLaXYrR7WnGsSQbjOWMTFWT7PCjH+PA@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] spi: spi-mtk-nor: fix mishandled logics in
 checking SPI memory operation
To:     Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-spi@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 2:54 PM Ikjoon Jang <ikjn@chromium.org> wrote:
>
> Fix a bug which limits its protocol availability in supports_op().
>
> Fixes: a59b2c7c56bf ("spi: spi-mtk-nor: support standard spi properties")
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> ---

This is also duplicated work of https://patchwork.kernel.org/patch/11797723/,
I'm going to drop this patch in v4.

>
> (no changes since v1)
>
>  drivers/spi/spi-mtk-nor.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
> index 6e6ca2b8e6c8..0f7d4ec68730 100644
> --- a/drivers/spi/spi-mtk-nor.c
> +++ b/drivers/spi/spi-mtk-nor.c
> @@ -211,28 +211,24 @@ static bool mtk_nor_supports_op(struct spi_mem *mem,
>         if (op->cmd.buswidth != 1)
>                 return false;
>
> +       if (!spi_mem_default_supports_op(mem, op))
> +               return false;
> +
>         if ((op->addr.nbytes == 3) || (op->addr.nbytes == 4)) {
> -               switch(op->data.dir) {
> -               case SPI_MEM_DATA_IN:
> -                       if (!mtk_nor_match_read(op))
> -                               return false;
> -                       break;
> -               case SPI_MEM_DATA_OUT:
> -                       if ((op->addr.buswidth != 1) ||
> -                           (op->dummy.nbytes != 0) ||
> -                           (op->data.buswidth != 1))
> -                               return false;
> -                       break;
> -               default:
> -                       break;
> -               }
> +               if ((op->data.dir == SPI_MEM_DATA_IN) && mtk_nor_match_read(op))
> +                       return true;
> +               else if (op->data.dir == SPI_MEM_DATA_OUT)
> +                       return (op->addr.buswidth == 1) &&
> +                              (op->dummy.nbytes == 0) &&
> +                              (op->data.buswidth == 1);
>         }
> +
>         len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
>         if ((len > MTK_NOR_PRG_MAX_SIZE) ||
>             ((op->data.nbytes) && (len == MTK_NOR_PRG_MAX_SIZE)))
>                 return false;
>
> -       return spi_mem_default_supports_op(mem, op);
> +       return true;
>  }
>
>  static void mtk_nor_setup_bus(struct mtk_nor *sp, const struct spi_mem_op *op)
> --
> 2.28.0.681.g6f77f65b4e-goog
>
