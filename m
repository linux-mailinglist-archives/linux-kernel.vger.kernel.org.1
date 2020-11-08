Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64EA82AA8F4
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 04:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbgKHDFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 22:05:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:58274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgKHDFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 22:05:12 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 452C32087E
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 03:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604804711;
        bh=HwITghqppKFjK26HFNkFvXzdMOfxOTH9bRWvBg0QmDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=zew6Y5tgnmqimVGmhjui7F7w76KEAdyNu1Za/9t6I8gjZdqmAfTRoPh9BQvwRd2po
         yJBMALuqPFJQq4IejLTs6CIemdiI0+NiWHGJrsSyBjBFZq+AxlZDYivbjT/6BG9QfJ
         wt7WfgSnjIiVG7oFEV59dfnvP1IEeXVLiri1HdoQ=
Received: by mail-ej1-f41.google.com with SMTP id 7so7416357ejm.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 Nov 2020 19:05:11 -0800 (PST)
X-Gm-Message-State: AOAM530dp2m0CXAK2d/Mx32iADlTwcrguj5tK8b+3fhfuNJz1M4SNZk7
        y6p7Lqt3vOzrTVzTxofKN8zI8qvtJfRXKR+/cA==
X-Google-Smtp-Source: ABdhPJzbNJEGNS5slZvCdTXT5PYfqc0qF0yuXh8J6e6Kixynl26cfxzASzgrH63HJNSCBrDaCRKHuQZqNbURrIa1gHw=
X-Received: by 2002:a17:906:6d0:: with SMTP id v16mr8726811ejb.310.1604804709851;
 Sat, 07 Nov 2020 19:05:09 -0800 (PST)
MIME-Version: 1.0
References: <20201029152702.533-1-chunkuang.hu@kernel.org> <20201029152702.533-4-chunkuang.hu@kernel.org>
In-Reply-To: <20201029152702.533-4-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 8 Nov 2020 11:04:59 +0800
X-Gmail-Original-Message-ID: <CAAOTY__ZRLubBfNtMFMax8SubM9f9iKLXGzS+bXseXcd9V0Smg@mail.gmail.com>
Message-ID: <CAAOTY__ZRLubBfNtMFMax8SubM9f9iKLXGzS+bXseXcd9V0Smg@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: add files for Mediatek DRM drivers
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, Vinod Koul <vkoul@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Vinod:

Hi, Chunfeng:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=882=
9=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=8811:28=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Mediatek MIPI DSI phy driver is moved from drivers/gpu/drm/mediatek to
> drivers/phy/mediatek, so add the new folder to the Mediatek DRM drivers'
> information.

Would you like this patch? If so, you could give an acked-by tag on
this patch, so I could applied the whole series into my tree.

Regards,
Chun-Kuang.

>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e73636b75f29..14f5018c01b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5867,6 +5867,7 @@ S:        Supported
>  F:     Documentation/devicetree/bindings/display/mediatek/
>  F:     drivers/gpu/drm/mediatek/
>  F:     drivers/phy/mediatek/phy-mtk-hdmi*
> +F:     drivers/phy/mediatek/phy-mtk-mipi*
>
>  DRM DRIVERS FOR NVIDIA TEGRA
>  M:     Thierry Reding <thierry.reding@gmail.com>
> --
> 2.17.1
>
