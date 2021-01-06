Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C72B2EBEF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbhAFNk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:40:56 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:33117 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbhAFNkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:40:55 -0500
Received: by mail-ot1-f54.google.com with SMTP id b24so3031170otj.0;
        Wed, 06 Jan 2021 05:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQj0RmesVA+Moy3dDr1aHFZDKWq7ktYXC/4kQJWYQPs=;
        b=aeCQrU5et59rW/P6xnUHvTh9y+ZJTirpswX+H9ZLTG2Cq0lExL0JIa2Rn7X4Nr6cFa
         02nO3+58kPNb9KMIcmubpBLJw5tIspU+oeacT9aQNYvbaLSw3A9kG5vTHKJhKDaxXpBk
         gq/j59u6Mn/WgJlxrQqILUJMceE7dDfMdXZ5t4GtlpG/e2XxoLdffjV+SKYCZ8uYXDLf
         3uOyKea+MA9CW5CqaShSwrBZitn+E+4k73tAbomD9Z+ie5FgJV0NK5QNduut+dR8D+sy
         DkRFZHANS4bmOMnngLks1AUVY+uRaoQVcj3Sn5OyLuALudGIO82oHMuUY7lF2OOcF2IM
         7csA==
X-Gm-Message-State: AOAM532kgxRyPiv8/aWuSuHgexGf1PMm/Gwt3eItdfaZe9ZYKeJXlbr6
        rwmiEvdfeQk6UauZOmPqziJWmP2zUdE+LFJqKok=
X-Google-Smtp-Source: ABdhPJyoRu6s85dm8efDsG2TclWauJNGZuYsx9uJ1FrbsXRVn/0PqVQWIBZEjDRbjsXny73i5dxZdofjxhlfwuGXyBA=
X-Received: by 2002:a9d:c01:: with SMTP id 1mr3183283otr.107.1609940413871;
 Wed, 06 Jan 2021 05:40:13 -0800 (PST)
MIME-Version: 1.0
References: <20210106132006.1036-1-zhengyongjun3@huawei.com>
In-Reply-To: <20210106132006.1036-1-zhengyongjun3@huawei.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 Jan 2021 14:40:02 +0100
Message-ID: <CAMuHMdUno=8mUQ6a=v-uJq6oOmVS7VM=y5bb2o-YhFn+QE2Qyg@mail.gmail.com>
Subject: Re: [PATCH -next] video: fbdev: pxa3xx_gcu: use resource_size
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zheng,

On Wed, Jan 6, 2021 at 2:23 PM Zheng Yongjun <zhengyongjun3@huawei.com> wrote:
> Use resource_size rather than a verbose computation on
> the end and start fields.
>
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>

Thanks for your patch!

But the one-line summary and patch description don't seem to match
with the actual change?

> --- a/drivers/video/fbdev/pxa3xx-gcu.c
> +++ b/drivers/video/fbdev/pxa3xx-gcu.c
> @@ -594,8 +594,8 @@ static int pxa3xx_gcu_probe(struct platform_device *pdev)
>          * container_of(). This isn't really necessary as we have a fixed minor
>          * number anyway, but this is to avoid statics. */
>
> -       priv->misc_dev.minor    = PXA3XX_GCU_MINOR,
> -       priv->misc_dev.name     = DRV_NAME,
> +       priv->misc_dev.minor    = PXA3XX_GCU_MINOR;
> +       priv->misc_dev.name     = DRV_NAME;
>         priv->misc_dev.fops     = &pxa3xx_gcu_miscdev_fops;
>
>         /* handle IO resources */

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
