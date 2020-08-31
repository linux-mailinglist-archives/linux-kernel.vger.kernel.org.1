Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD265257E22
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 18:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbgHaQCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 12:02:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727019AbgHaQCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 12:02:50 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB459214D8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 16:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598889770;
        bh=iE2JfXtNRXcBePxejNj2vUktxPmSGqItV3WCiVQWgHE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aG0DDdc9WaflHUKr1gprlR4aRG0QzH6Q6MUeJfGvbWfxmHwwKuo2S5hQ5lOU5zwSr
         P8el1/7aCTUfpMUAoqct3NYExCyvx69iQwp0jNGmv6za6vsPngXGkRmEcgr1vBEY25
         Dk1pPChAxZINkzT6av+40EEyJ2Exv+pCnZp0AkTk=
Received: by mail-ej1-f46.google.com with SMTP id q13so5741974ejo.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 09:02:49 -0700 (PDT)
X-Gm-Message-State: AOAM530xbWynGAUEITas1s/VVyfGjkV33oIeQyv0YdIj/5BYBJ+zzpyh
        ApvPS/vKv8M10XvVB8cQRzFdkClWVrnA/Tu5Cg==
X-Google-Smtp-Source: ABdhPJzVfg2VBCCh3cFVWTXiqVCWpKgkXDpTn86toFw+LFgxINOPaV80H9SEI6gSfpVAinA9c18C4USSDNd1DJAwL8w=
X-Received: by 2002:a17:906:1909:: with SMTP id a9mr1679553eje.127.1598889768317;
 Mon, 31 Aug 2020 09:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200823014830.15962-1-chunkuang.hu@kernel.org>
 <20200823014830.15962-5-chunkuang.hu@kernel.org> <1598838539.7054.9.camel@mhfsdcap03>
In-Reply-To: <1598838539.7054.9.camel@mhfsdcap03>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 1 Sep 2020 00:02:36 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9hZgLGSiqCA6a1Ea+TjGZAH4-t4DFS9jCz3nEXNJY1zg@mail.gmail.com>
Message-ID: <CAAOTY_9hZgLGSiqCA6a1Ea+TjGZAH4-t4DFS9jCz3nEXNJY1zg@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] MAINTAINERS: add files for Mediatek DRM drivers
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Chunfeng:

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=883=
1=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8A=E5=8D=889:50=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Sun, 2020-08-23 at 09:48 +0800, Chun-Kuang Hu wrote:
> > Mediatek HDMI phy driver is moved from drivers/gpu/drm/mediatek to
> > drivers/phy/mediatek, so add the new folder to the Mediatek DRM drivers=
'
> > information.
> >
> > Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index deaafb617361..191bacf02209 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -5793,6 +5793,7 @@ L:      dri-devel@lists.freedesktop.org
> >  S:   Supported
> >  F:   Documentation/devicetree/bindings/display/mediatek/
> >  F:   drivers/gpu/drm/mediatek/
> > +F:   drivers/phy/mediatek/phy-mtk-hdmi*
> >
> >  DRM DRIVERS FOR NVIDIA TEGRA
> >  M:   Thierry Reding <thierry.reding@gmail.com>
>
> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>

Could you give an 'Acked-by' tag on this patch? So I could apply the
whole series into my tree.

Regards,
Chun-Kuang.

> Thanks
>
>
>
