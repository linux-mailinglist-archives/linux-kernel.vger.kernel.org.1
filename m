Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 978B22AF6EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbgKKQxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:53:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725979AbgKKQxC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:53:02 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C98CF207DE;
        Wed, 11 Nov 2020 16:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605113581;
        bh=JmHvo1SzasskdROAWMoAgJ6ASA6flz7HfKula4/+Rxc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vrWvgsCUe3WUikOynKF6WlqA5l0n3Ae1O6V5ZPQigDunSwUXIaYX8ZofQhXb9U4LG
         Esja9EsroullITulSAV8dkBDv3SOgb7xsRWgGf6oTesxapQG9ngNCNgSOZufBQADRR
         PvjNyIoTkRIvuA/Pa4Or0KVFxrn9OX8zEqdV9Jjg=
Received: by mail-ej1-f44.google.com with SMTP id f20so3693531ejz.4;
        Wed, 11 Nov 2020 08:53:00 -0800 (PST)
X-Gm-Message-State: AOAM530IxLyiKx+XNMeioTQy4gn/3YDS93ei1I0sSRGMJAiC06vExWCr
        F+qqexaCyEm+nX2maf/k+mU8lAHFt6Oy3I1A9g==
X-Google-Smtp-Source: ABdhPJzdRmYGXhqdGMuO0dJRFroeBzeq9MJGO2EU8QQlLa+CkCedj+n4fq3F2ISZsjzb4o981Dy2VwbcJ3xH0AIJoko=
X-Received: by 2002:a17:906:5f8d:: with SMTP id a13mr26062667eju.194.1605113579120;
 Wed, 11 Nov 2020 08:52:59 -0800 (PST)
MIME-Version: 1.0
References: <20201111123838.15682-1-yong.wu@mediatek.com> <20201111123838.15682-25-yong.wu@mediatek.com>
In-Reply-To: <20201111123838.15682-25-yong.wu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Thu, 12 Nov 2020 00:52:48 +0800
X-Gmail-Original-Message-ID: <CAAOTY_85-PWMVh3k+P_984irVVLaEWjPSyw1amFkRaQ+x=wg=A@mail.gmail.com>
Message-ID: <CAAOTY_85-PWMVh3k+P_984irVVLaEWjPSyw1amFkRaQ+x=wg=A@mail.gmail.com>
Subject: Re: [PATCH v4 24/24] MAINTAINERS: Add entry for MediaTek IOMMU
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        DTML <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        chao.hao@mediatek.com, kernel-team@android.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        iommu@lists.linux-foundation.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yong:

Yong Wu <yong.wu@mediatek.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=8811=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:53=E5=AF=AB=E9=81=93=EF=BC=9A
>
> I am the author of MediaTek iommu driver, and will to maintain and
> develop it further.
> Add myself to cover these items.

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..462a87ee19c8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11056,6 +11056,15 @@ S:     Maintained
>  F:     Documentation/devicetree/bindings/i2c/i2c-mt65xx.txt
>  F:     drivers/i2c/busses/i2c-mt65xx.c
>
> +MEDIATEK IOMMU DRIVER
> +M:     Yong Wu <yong.wu@mediatek.com>
> +L:     iommu@lists.linux-foundation.org
> +L:     linux-mediatek@lists.infradead.org (moderated for non-subscribers=
)
> +S:     Supported
> +F:     Documentation/devicetree/bindings/iommu/mediatek*
> +F:     drivers/iommu/mtk-iommu*
> +F:     include/dt-bindings/memory/mt*-larb-port.h
> +
>  MEDIATEK JPEG DRIVER
>  M:     Rick Chang <rick.chang@mediatek.com>
>  M:     Bin Liu <bin.liu@mediatek.com>
> --
> 2.18.0
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
