Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1BE52B0741
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 15:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbgKLOIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 09:08:49 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46703 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgKLOIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 09:08:48 -0500
Received: by mail-oi1-f195.google.com with SMTP id q206so6434905oif.13;
        Thu, 12 Nov 2020 06:08:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kbihsDClb1B2917jEi922Nsd76R5TECIX8wIsf+GP/4=;
        b=pe5cOLmamkzawbWbytgvHDs6kHvUIq3hkL7itj3DL1INQiecWmXndT9azPbkl7WL9j
         2eTTULoU2My2VaLYhr2ho6HB2zMO+MEoNz5sPzIe96M6/Ubn2m9k4KKJooYwx3Yvmyyd
         gUK+EpHKAK5am781IxkIKUbGyetJBGjBet6lZ3fDDFq2FnFZmvq1F69jBj7oA/Va+8nj
         MgFdF2eUk6hv4SWa829i1bRDNShrX+BI45k1xQroQqcY04rgePh6jralEUFEt3YeY9Ls
         Nxky5RRq9NEs437I2KqxA7xNcqqejzNXuOUDEpTGI8NZpM+MaAdGx+dby7qMmu+YmLvy
         s6lw==
X-Gm-Message-State: AOAM531IGhsnyyonUxffYbhphx//D60DRjY/FbPR8NbCIN6TENlxC6uD
        y0aTUaB3JLiP818HegSX6pO9/Wnq1bUseLM3RrI=
X-Google-Smtp-Source: ABdhPJwq7NBruaHnXszKMr0TlCiN7NsMHhv5ZOBvSSB+qrwM2D5GDCDxKEK8IkAObrwiJw9k0TF9NyjAeUO4yR6sGuY=
X-Received: by 2002:aca:4bc3:: with SMTP id y186mr5372923oia.153.1605190127602;
 Thu, 12 Nov 2020 06:08:47 -0800 (PST)
MIME-Version: 1.0
References: <1595404275-8449-1-git-send-email-chunfeng.yun@mediatek.com> <1595404275-8449-7-git-send-email-chunfeng.yun@mediatek.com>
In-Reply-To: <1595404275-8449-7-git-send-email-chunfeng.yun@mediatek.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Nov 2020 15:08:36 +0100
Message-ID: <CAMuHMdU8ow7J-Db_v3HUM8MmPfYcNpirzpUFmjUQrneeaVGFoA@mail.gmail.com>
Subject: Re: [PATCH 7/7] usb: musb: convert to devm_platform_ioremap_resource_byname
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        USB list <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org, Bin Liu <b-liu@ti.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chunfeng,

On Wed, Jul 22, 2020 at 9:54 AM Chunfeng Yun <chunfeng.yun@mediatek.com> wrote:
> Use devm_platform_ioremap_resource_byname() to simplify code
>
> Cc: Bin Liu <b-liu@ti.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Thanks for your patch, which is now commit 2d30e408a2a6b344 ("usb: musb:
convert to devm_platform_ioremap_resource_byname") in v5.9.

> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -429,12 +429,10 @@ static int dsps_musb_init(struct musb *musb)
>         struct platform_device *parent = to_platform_device(dev->parent);
>         const struct dsps_musb_wrapper *wrp = glue->wrp;
>         void __iomem *reg_base;
> -       struct resource *r;
>         u32 rev, val;
>         int ret;
>
> -       r = platform_get_resource_byname(parent, IORESOURCE_MEM, "control");
> -       reg_base = devm_ioremap_resource(dev, r);
> +       reg_base = devm_platform_ioremap_resource_byname(parent, "control");
>         if (IS_ERR(reg_base))
>                 return PTR_ERR(reg_base);
>         musb->ctrl_base = reg_base;

On Beaglebone Black, where each interface has 2 children:

    musb-dsps 47401c00.usb: can't request region for resource [mem
0x47401800-0x474019ff]
    musb-hdrc musb-hdrc.1: musb_init_controller failed with status -16
    musb-hdrc: probe of musb-hdrc.1 failed with error -16
    musb-dsps 47401400.usb: can't request region for resource [mem
0x47401000-0x474011ff]
    musb-hdrc musb-hdrc.0: musb_init_controller failed with status -16
    musb-hdrc: probe of musb-hdrc.0 failed with error -16

Before, devm_ioremap_resource() was called on "dev" ("musb-hdrc.0" or
"musb-hdrc.1"), after it is called on "&pdev->dev" ("47401400.usb" or
"47401c00.usb"), leading to a duplicate region request, which fails.

I have sent a revert:
https://lore.kernel.org/linux-usb/20201112135900.3822599-1-geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
