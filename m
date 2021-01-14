Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 061A32F6E38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbhANWaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:30:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:56586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbhANWaT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:30:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EA8723A5E;
        Thu, 14 Jan 2021 22:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610663378;
        bh=hfhWqcDtTP7IYqbullRyMrTJ4FwI6nFHntuaG+R5yWM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FHpNKtw/tUvzI7bPgkJsDyeuR3eL0aD6jZN+X7Gjn7lvnN22N6TP35oKv9rZYX6iX
         4lx2e8hXwnhSEtgOmi+LRj0omTE8Te5twsNjEMvTS+WTPqxxbM/GMl+1A1c4JhUxJK
         xnb4ZYVndERrSFaAPmTatWz2MYKRnafcelc72dCox0YCvqMb45Df2AUfK09lJbOAzz
         yv04Fx9LAabwNWij47SZ2t6vQHlLEBhaNLc15m8sJFjl87hJ36vetsj6QA0SUYpFCw
         WopBKEAasQ2L15xLlVGrlQIegFFQBNNvG2fu9cZdrY1zgYL9fackb8bOmob4AmPfcd
         g0EAXAnuPIBUg==
Received: by mail-ej1-f49.google.com with SMTP id hs11so8227406ejc.1;
        Thu, 14 Jan 2021 14:29:38 -0800 (PST)
X-Gm-Message-State: AOAM531rAkAxnY/1FG7x+oYb8/MUTOe5b7Qo8dT6Qr5S9nFDaaCb2Q13
        xoQovAd0QyHSqv4SXSZu6MdNJIcFo2WtPigPZA==
X-Google-Smtp-Source: ABdhPJxHUpNkN+T/hx5/nLUs2NhEXsLPGFPYkhav/uwL0W2GV8AyJyfJEsMZKL7rtqY1deaxIhopqVVyoecIA3WaRgE=
X-Received: by 2002:a17:906:3753:: with SMTP id e19mr6800550ejc.267.1610663377179;
 Thu, 14 Jan 2021 14:29:37 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
 <1610351031-21133-2-git-send-email-yongqiang.niu@mediatek.com> <20210114191122.GA3394181@robh.at.kernel.org>
In-Reply-To: <20210114191122.GA3394181@robh.at.kernel.org>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 15 Jan 2021 06:29:26 +0800
X-Gmail-Original-Message-ID: <CAAOTY_96hj0SGzSJCzGU7Z0DOFoituLpVOP_UW05E21Pt9QjfA@mail.gmail.com>
Message-ID: <CAAOTY_96hj0SGzSJCzGU7Z0DOFoituLpVOP_UW05E21Pt9QjfA@mail.gmail.com>
Subject: Re: [PATCH v3, 01/15] dt-bindings: mediatek: add description for postmask
To:     Rob Herring <robh@kernel.org>
Cc:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=8815=E6=97=A5 =
=E9=80=B1=E4=BA=94 =E4=B8=8A=E5=8D=883:11=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 11 Jan 2021 15:43:37 +0800, Yongqiang Niu wrote:
> > add description for postmask
> > postmask is used control round corner for display frame
> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt |=
 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
