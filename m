Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C1B2F6EB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 23:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730999AbhANW4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 17:56:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730900AbhANW4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 17:56:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B73EB23A6C;
        Thu, 14 Jan 2021 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610664969;
        bh=uXGJ6xCEysiGL4Hzw3Uu8vrJXyYKiGWf1f8PXzrKYZo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T0OYHM0DE9MxSFhjc+wnS050JkMkxrfkLbuJ9FBqrk4S3OUzL7++4cDszksupy22F
         XJ10HvCzRzb9+VaoeIs9WkDS/CzFm9MI3dd6+4WbZepqbmZXHNHrG6PmMJAPPiYqk5
         II3N6J46S/kljP87jktuL+bZNDH9qImPRcYS0zczAWCgAevk6aPcGt3ajSJijEDVRd
         kHJpf6aIPg9uqKLZxjAMgNqyOOsN9pwJHLM6EaPHZ6ClEd4BVoiLQGW39whevDNNal
         m7PqT0gL5GbK+GjGvMmpedOlNdG/jyBk6UmQskq4Bw+f2FbzX9joKG+XwRWyU8fTce
         5L3lfWBxeBjbA==
Received: by mail-ed1-f46.google.com with SMTP id b2so7511218edm.3;
        Thu, 14 Jan 2021 14:56:08 -0800 (PST)
X-Gm-Message-State: AOAM532ynhoA9jIcl9QEm/xDBZQJKUgYFK0f/G8ekAicmQ0MNw0HyRR3
        oe5XZqfC5Fs/aUtMBzipiDrchYD0EckDT8MKsg==
X-Google-Smtp-Source: ABdhPJzKHMc6mf/hOkNc8AU+Eybq1geWp6Y8iOKubI270z1OJwevJFI1fq4ScBjoTzAbQLMHBTJ9Z/F6mN1e3WoR/rE=
X-Received: by 2002:a50:fc96:: with SMTP id f22mr7742818edq.162.1610664967322;
 Thu, 14 Jan 2021 14:56:07 -0800 (PST)
MIME-Version: 1.0
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com> <1610351031-21133-12-git-send-email-yongqiang.niu@mediatek.com>
In-Reply-To: <1610351031-21133-12-git-send-email-yongqiang.niu@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Fri, 15 Jan 2021 06:55:56 +0800
X-Gmail-Original-Message-ID: <CAAOTY_98=hJvQibAUfk3f9NF+3sEZ4JuANEDgp6WJ7cVAOygQQ@mail.gmail.com>
Message-ID: <CAAOTY_98=hJvQibAUfk3f9NF+3sEZ4JuANEDgp6WJ7cVAOygQQ@mail.gmail.com>
Subject: Re: [PATCH v3, 11/15] drm/mediatek: fix aal size config
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
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Yongqiang:

Yongqiang Niu <yongqiang.niu@mediatek.com> =E6=96=BC 2021=E5=B9=B41=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=883:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> the orginal setting is not correct, fix it follow hardware data sheet.
> if keep this error setting, mt8173/mt8183 display ok
> but mt8192 display abnormal.
>

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

> Fixes: 0664d1392c26 (drm/mediatek: Add AAL engine basic function)
>
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/dr=
m/mediatek/mtk_drm_ddp_comp.c
> index fc01fea..6081800 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
> @@ -174,7 +174,7 @@ static void mtk_aal_config(struct mtk_ddp_comp *comp,=
 unsigned int w,
>                            unsigned int h, unsigned int vrefresh,
>                            unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
>  {
> -       mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_AAL_SIZE);
> +       mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_AAL_SIZE);
>  }
>
>  static void mtk_aal_start(struct mtk_ddp_comp *comp)
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
