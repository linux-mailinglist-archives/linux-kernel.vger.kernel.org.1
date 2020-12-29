Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E333C2E71CC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 16:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgL2PYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 10:24:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:42704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbgL2PYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 10:24:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 037D9221F8;
        Tue, 29 Dec 2020 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609255421;
        bh=X6TWp8dtmGsNefHM5i1nqwfEHyC2PBReZvmW2bXfzjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YiK96+qPYqPeQfZbYUCC5myl9I5msotfpsB1XpSD0MI3yAeOItyLc1a5So/p06XLw
         kZ1YsdWfBEOra1Q9hlC9D5BgTeYrox5JqgXx9iw6iF7uULCPEFQE5TPC+6FAFKK0jC
         lDxtiPcDu5rkv2zFo1TRIt1nQ4PhU9Pkg25Oj4MW6ZSN1yJe/yvxlyTuhgSxFqpHwV
         /+PqbfhSUOCGFXKXQh4XOv6RYJ/u7+KPX8eGhIWWGdO9T5xXTZlL8Tvc87aRVV5kYq
         pM9w49egp49Lr0BxicP+ofmhSLy+rD0ocGxjFpZ6f92653v8iMSOKzAfVHFN2QGgzk
         Z4+X63LZTOIHA==
Received: by mail-wm1-f46.google.com with SMTP id g185so2507021wmf.3;
        Tue, 29 Dec 2020 07:23:40 -0800 (PST)
X-Gm-Message-State: AOAM532MNerBagvZXERg9Eb+TKl57H7v0CDGFQLTq9OThB/bxbIVgUWq
        iR/kxtB/YSXb2ZvWaR33dCvh52T4k0McnkI1aw==
X-Google-Smtp-Source: ABdhPJzqoSYiS8eONYJzh10hdAnaMFldS8v6+IVw1T9bzfQwd+ZdVmWEddSO/Y3HQ64cIJxjddzsuEn54GHCRRPwA2w=
X-Received: by 2002:a1c:790f:: with SMTP id l15mr3965420wme.188.1609255419668;
 Tue, 29 Dec 2020 07:23:39 -0800 (PST)
MIME-Version: 1.0
References: <1609144630-14721-1-git-send-email-yongqiang.niu@mediatek.com> <1609144630-14721-5-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1609144630-14721-5-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 29 Dec 2020 23:23:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY_98vrwQrefD9KwvsM+9+tDpNcUwbLoVwu_mXRf17imuTA@mail.gmail.com>
Message-ID: <CAAOTY_98vrwQrefD9KwvsM+9+tDpNcUwbLoVwu_mXRf17imuTA@mail.gmail.com>
Subject: Re: [PATCH v3, 4/8] soc: mediatek: mmsys: add component OVL_2L2
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2020=E5=B9=B412=E6=9C=
=8828=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=884:37=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> This patch add component OVL_2L2

Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>

>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  include/linux/soc/mediatek/mtk-mmsys.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/m=
ediatek/mtk-mmsys.h
> index 4b6c514..42476c2 100644
> --- a/include/linux/soc/mediatek/mtk-mmsys.h
> +++ b/include/linux/soc/mediatek/mtk-mmsys.h
> @@ -29,6 +29,7 @@ enum mtk_ddp_comp_id {
>         DDP_COMPONENT_OVL0,
>         DDP_COMPONENT_OVL_2L0,
>         DDP_COMPONENT_OVL_2L1,
> +       DDP_COMPONENT_OVL_2L2,
>         DDP_COMPONENT_OVL1,
>         DDP_COMPONENT_PWM0,
>         DDP_COMPONENT_PWM1,
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
