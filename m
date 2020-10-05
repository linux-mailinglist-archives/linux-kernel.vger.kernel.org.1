Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE73D2836CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 15:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgJENoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 09:44:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbgJENoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 09:44:23 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C983207BC;
        Mon,  5 Oct 2020 13:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601905463;
        bh=Ib7GBdL7Wn9bocJo9NyhUcUy9MsfqzsQOqA6NxORkCs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b7vdGNYeBNhV5kCPpU9VCAAr6jQnSqGyHEL3iKdrOKtJIBiqbytO9h3rUZX6d0zrG
         L2L0zizKezD2U3etwiBVc8DLLjWHXVlZ1pbobjbvzPTmXyxSrXST9oD/iWmykppjxk
         /csmwNNMjYPw1A1qPlX76PJGkaEkGnhAA9sxku3U=
Received: by mail-oi1-f182.google.com with SMTP id u126so8706344oif.13;
        Mon, 05 Oct 2020 06:44:23 -0700 (PDT)
X-Gm-Message-State: AOAM533E3PkQqQyPrROvDS3SapPUZP4QiLqE9JNH4fbv1Xzj+nySji+4
        Rv86lWBr4fhBoW/JXV0jUnfYGBmXUbrHrNKdnA==
X-Google-Smtp-Source: ABdhPJz+mQ/NS0sS4uvyu/c0LAt/s/xUYDXx+vCNQnX96Z0KUl55MOK1OCcrE3Hy8xpROafH3uekNkVrqfJk3kun5m4=
X-Received: by 2002:aca:4c52:: with SMTP id z79mr9074939oia.147.1601905462390;
 Mon, 05 Oct 2020 06:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201004055024.23542-1-phil.chang@mediatek.com>
In-Reply-To: <20201004055024.23542-1-phil.chang@mediatek.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 5 Oct 2020 08:44:11 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ4rTChMpn7F--fh1A6bOTZxR4rEM9bbA1rdetXmPDeVA@mail.gmail.com>
Message-ID: <CAL_JsqJ4rTChMpn7F--fh1A6bOTZxR4rEM9bbA1rdetXmPDeVA@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] of_reserved_mem: Increase the number of reserved regions
To:     Phil Chang <phil.chang@mediatek.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        YJ Chiang <yj.chiang@mediatek.com>,
        Alix Wu <alix.wu@mediatek.com>, Joe Liu <joe.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 4, 2020 at 12:50 AM Phil Chang <phil.chang@mediatek.com> wrote:
>
> Certain SoCs need to support large amount of reserved memory
> regions, especially to follow the GKI rules from Google.
> In MTK new SoC requires more than 68 regions of reserved memory
> for each IP's usage, such as load firmware to specific sapce,

typo

> so that need to reserve more regisions

typo. Missing punctuation.

>
> Signed-off-by: Joe Liu <joe.liu@mediatek.com>
> Signed-off-by: YJ Chiang <yj.chiang@mediatek.com>
> Signed-off-by: Alix Wu <alix.wu@mediatek.com>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>  drivers/of/of_reserved_mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 46b9371c8a33..595f0741dcef 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c
> @@ -22,7 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/memblock.h>
>
> -#define MAX_RESERVED_REGIONS   64
> +#define MAX_RESERVED_REGIONS   128

At some point, this starts to feel like abuse of reserved regions.
Please provide details on what the regions are.

Also, this probably just needs to be dynamic. I think we're at that point.

Rob
