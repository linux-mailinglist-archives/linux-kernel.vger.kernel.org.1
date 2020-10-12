Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0373028BBB9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389866AbgJLPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389142AbgJLPWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:22:35 -0400
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 90343208B8;
        Mon, 12 Oct 2020 15:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602516154;
        bh=5C/jmTpz0PKuGny4/s3SbSc4Irgi9NI62ZqH3ELIX7s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aLX8Vr/+ckwRva0GmI4m4s/4wxSqmx0xqfMUrdDEM+fCprnL6NTcrZ+naQvF0e4eY
         zWkWUxdyTPmg/GLZ1qz0vTlhsD42q25Wl9SQ1DQi3GpB3+NEg6BXYn4jkrbiLaDa5g
         wOpkbxvdAoMzjsEH/3QEXKZ8zv++QgW2Lt0sPrOg=
Received: by mail-ed1-f54.google.com with SMTP id t21so17383564eds.6;
        Mon, 12 Oct 2020 08:22:34 -0700 (PDT)
X-Gm-Message-State: AOAM532T5y4AOnMoTRfDeKLTHFdxVr6x93ltylXKuX9mAxZ54GXkm71f
        Px/xNzbrS3/lxOxBbCYZLde+6qgGlfAkRdAW7Q==
X-Google-Smtp-Source: ABdhPJwu3cOwmieaIPSGaFSoyA4Wc/3ksuAi+VNzjSghjBXRfe60ms0JWtONwlY6z7lgezHab9z1uAotOlywDThS1cE=
X-Received: by 2002:a05:6402:1cbb:: with SMTP id cz27mr14412016edb.38.1602516153075;
 Mon, 12 Oct 2020 08:22:33 -0700 (PDT)
MIME-Version: 1.0
References: <20201010070910.11294-1-jitao.shi@mediatek.com>
In-Reply-To: <20201010070910.11294-1-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Mon, 12 Oct 2020 23:22:21 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-qZni-o11HJeymH74PAFSJw-0Awdz0wdjiQ0u7Ga1MGA@mail.gmail.com>
Message-ID: <CAAOTY_-qZni-o11HJeymH74PAFSJw-0Awdz0wdjiQ0u7Ga1MGA@mail.gmail.com>
Subject: Re: [v4 PATCH 0/2] fix scrolling of panel with small hfp or hbp
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B410=E6=9C=8810=E6=
=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=883:09=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Changes since v3:
>  - Revert v2, for v2 will cause some bridge ic no output. the cause
>    the video linetime doesn't match display mode from get mode.
>  - Make sure the horizontal_frontporch_byte and horizontal_backporch_byte
>    are > 0.

Because v2 is merged into mainline, I think you should merge 1/2 and
2/2 to one patch which fix the problem caused by v2.

Regards,
Chun-Kuang.

>
> Jitao Shi (2):
>   Revert "drm/mediatek: dsi: Fix scrolling of panel with small hfp or
>     hbp"
>   drm/mediatek: dsi: fix scrolling of panel with small hfp or hbp
>
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 65 +++++++++++++++-----------------=
------
>  1 file changed, 25 insertions(+), 40 deletions(-)
>
> --
> 2.12.5
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
