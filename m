Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E672B66A2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 15:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgKQOFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 09:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:46320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729377AbgKQOFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 09:05:44 -0500
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF124217A0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 14:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605621944;
        bh=MUSMd6abJAdtwLkhDfU5Mker4vAbz8CcGo3fa144da0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VSYKIA3tpTAqnwTVirfgwxldCpS6alOHqC3N3h606v/9KSio/gNQHpAofIdAaa7u3
         aUSpRPeNaOqDT0ncZoDaDsDhvyRavghafJ8d1/E51O3fbS8QfLy48EkFol1TSTiw6p
         asMeyHLAqNStBSTPB+b8t+111C0ZebFK2IA3TEhI=
Received: by mail-wm1-f45.google.com with SMTP id d142so3362098wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 06:05:43 -0800 (PST)
X-Gm-Message-State: AOAM530lByztw4VsfN3OCcvVk5SmHhZVUkciFIJwDaguwpvPW1PDd0+O
        Eg8Ddi4z32MRMd2ImKnQapsGa//ZTk2n4C8ibA==
X-Google-Smtp-Source: ABdhPJygZ6W6WYu5uc7uhlYwgaHToMSoM6KFGBB0TcyPL934xUgi43XW1SDxnf6FiZEK2/cNMP1hOTWV5/GNpNfg+/Q=
X-Received: by 2002:a1c:4c09:: with SMTP id z9mr4572652wmf.55.1605621942348;
 Tue, 17 Nov 2020 06:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20201116231407.94-1-chunkuang.hu@kernel.org> <20201116231407.94-4-chunkuang.hu@kernel.org>
In-Reply-To: <20201116231407.94-4-chunkuang.hu@kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 17 Nov 2020 22:05:30 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-0eFBVnJ3-Fcv-t9AHJMWFhvgM28cP1ksw5DZ8OKs_gg@mail.gmail.com>
Message-ID: <CAAOTY_-0eFBVnJ3-Fcv-t9AHJMWFhvgM28cP1ksw5DZ8OKs_gg@mail.gmail.com>
Subject: Re: [RESEND PATCH 3/3] MAINTAINERS: add files for Mediatek DRM drivers
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Vinod:

Chun-Kuang Hu <chunkuang.hu@kernel.org> =E6=96=BC 2020=E5=B9=B411=E6=9C=881=
7=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=887:14=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> Mediatek MIPI DSI phy driver is moved from drivers/gpu/drm/mediatek to
> drivers/phy/mediatek, so add the new folder to the Mediatek DRM drivers'
> information.
>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

If you apply this patch, please add acked-by tag of chunfeng [1], thanks.

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2020102915270=
2.533-4-chunkuang.hu@kernel.org/

Regards,
Chun-Kuang.

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
