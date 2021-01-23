Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512BB301193
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 01:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbhAWAU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 19:20:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbhAWATB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 19:19:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB56323B04;
        Sat, 23 Jan 2021 00:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611361099;
        bh=3fmahJcDJaiPzSHyzDHOPcnKdSO+Wsnj9uOP966Bbtk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=liFiRlK1dmu7SXiI7+zgcSv/0yuHKqgSkFQIcahP1Q6k0Na+kN4l3HJahI80wfh/C
         B+jh36ZoQ/LzBZI5yGsYn3rBEttkJCUg3vqTHOGeglGYuiN7b4ZRiaWMaCagAzjDxs
         E0Jnn2mA5Q4DQZwJ8momS8CaNrxpDgMryWBoALPY2tuRZFl9s/UDH9t2H9rkU5mIle
         ZlwaH2eYrT3yiVSHjwb2wi7Wa1ycrE9YwgktV6SsSPUacLZ1JQL5VVqKtjEtuafC1v
         P+e6YUTPpt+F2aUTG5TDMg+NdIvuXw4bbvNSQOH3DaF40bvOOLOdLxnRdNxL3bdYHq
         dztwobXituTLA==
Received: by mail-ej1-f49.google.com with SMTP id g12so10129542ejf.8;
        Fri, 22 Jan 2021 16:18:18 -0800 (PST)
X-Gm-Message-State: AOAM533fVQuPijfb3dni942wx38Npe1tGgQ0srET5l6dDAMWar3IjFk+
        gXKr0HOni/sO9Q1lOMKYMp6cEBQqf/LjAUxndg==
X-Google-Smtp-Source: ABdhPJwyuj40njyUKw3kugLNeH9sj5thS1bwHoAiyYKNnx7M1JVZ8MSIu28ADwY+9e5tY75fquHTE72s0CjW6QlAy/I=
X-Received: by 2002:a17:906:ada:: with SMTP id z26mr102199ejf.127.1611361097488;
 Fri, 22 Jan 2021 16:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20210122120323.4337-1-chunfeng.yun@mediatek.com> <20210122120323.4337-4-chunfeng.yun@mediatek.com>
In-Reply-To: <20210122120323.4337-4-chunfeng.yun@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 23 Jan 2021 08:18:06 +0800
X-Gmail-Original-Message-ID: <CAAOTY_84OF71QK6M5JT1M5YAFKED_xWVpx8B8t859OsVxE0cfQ@mail.gmail.com>
Message-ID: <CAAOTY_84OF71QK6M5JT1M5YAFKED_xWVpx8B8t859OsVxE0cfQ@mail.gmail.com>
Subject: Re: [PATCH next v2 04/17] dt-bindings: phy: mediatek: dsi-phy: add
 optional clock-names
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        DTML <devicetree@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Min Guo <min.guo@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chunfeng:

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=882=
2=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:04=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Add an optional "clock-names" property, it's not used to get the clock,
> but some DTS files (e.g. mt8183) provide it.

I think the logic is that we define property in binding document
first, and then write it in device tree. If a property does not exist
in binding document, we should not write it in device tree. So let's
drop this patch and remove clock-names in mt8183.dtsi.

Regards,
Chun-Kuang.

>
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v2: new patch separated from [3/15] suggested by CK
> ---
>  Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml =
b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> index 6e4d795f9b02..af6e554c5b69 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,dsi-phy.yaml
> @@ -35,6 +35,10 @@ properties:
>      items:
>        - description: PLL reference clock
>
> +  clock-names:
> +    items:
> +      - const: ref
> +
>    clock-output-names:
>      maxItems: 1
>
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
