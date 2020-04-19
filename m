Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8D9E1AF5F1
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 02:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgDSAEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 20:04:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725804AbgDSAEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 20:04:49 -0400
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B644821BE5;
        Sun, 19 Apr 2020 00:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587254689;
        bh=v9pZ3WZNZEvx4oF1pGUXqLlB1PXbgAzl0qA9nRFRcew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JmENRTRR/USNvPNYSd3QE4+FFbWum08VUHzVCR0xqqMOsfxlw80sHuQjMYk+IPzxZ
         n7qqO+Oihe+J9oAyE9fSyjASwTbB+Tiex9woMXIlN/R+s9KIN2OJKC9a17yWwWq9nX
         zvhYMZICIRuwvd6QxgYUj61knbarD0zgX9/u1j/o=
Received: by mail-ed1-f44.google.com with SMTP id d16so4171270edv.8;
        Sat, 18 Apr 2020 17:04:48 -0700 (PDT)
X-Gm-Message-State: AGi0Pubf7x68AOgdqcAj01h6e2TmiktTLOvKprOb+c8N0xCaGz3nMsGO
        9fj3sAA+Yj1IfWGbmUbzL1UP1LDEiq+Zz1ryjA==
X-Google-Smtp-Source: APiQypLh2svs6+HFQn0QDrjIM0+ZgyqnnZlhJlt1ICrnKga20H9COUuvFy8z5br34719WC7LFPwgTiemoWhvlZCmvEU=
X-Received: by 2002:aa7:c649:: with SMTP id z9mr8927514edr.288.1587254687117;
 Sat, 18 Apr 2020 17:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200415011319.25559-1-jitao.shi@mediatek.com> <20200415011319.25559-2-jitao.shi@mediatek.com>
In-Reply-To: <20200415011319.25559-2-jitao.shi@mediatek.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 19 Apr 2020 08:04:34 +0800
X-Gmail-Original-Message-ID: <CAAOTY_9szPeYM=pDvC7Q-LheQ1dCvQisK8rAg0K-8a17hnoh=w@mail.gmail.com>
Message-ID: <CAAOTY_9szPeYM=pDvC7Q-LheQ1dCvQisK8rAg0K-8a17hnoh=w@mail.gmail.com>
Subject: Re: [PATCH v15 1/3] dt-bindings: display: mediatek: control dpi pins
 mode to avoid leakage
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        huijuan.xie@mediatek.com, stonea168@163.com,
        cawa.cheng@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, yingjoe.chen@mediatek.com,
        eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Jitao Shi <jitao.shi@mediatek.com> =E6=96=BC 2020=E5=B9=B44=E6=9C=8815=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=889:13=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Add property "pinctrl-names" to swap pin mode between gpio and dpi mode. =
Set
> the dpi pins to gpio mode and output-low to avoid leakage current when dp=
i
> disabled.

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> ---
>  Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt | 6 =
++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,=
dpi.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.t=
xt
> index 58914cf681b8..77def4456706 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt
> @@ -17,6 +17,9 @@ Required properties:
>    Documentation/devicetree/bindings/graph.txt. This port should be conne=
cted
>    to the input port of an attached HDMI or LVDS encoder chip.
>
> +Optional properties:
> +- pinctrl-names: Contain "default" and "sleep".
> +
>  Example:
>
>  dpi0: dpi@1401d000 {
> @@ -27,6 +30,9 @@ dpi0: dpi@1401d000 {
>                  <&mmsys CLK_MM_DPI_ENGINE>,
>                  <&apmixedsys CLK_APMIXED_TVDPLL>;
>         clock-names =3D "pixel", "engine", "pll";
> +       pinctrl-names =3D "default", "sleep";
> +       pinctrl-0 =3D <&dpi_pin_func>;
> +       pinctrl-1 =3D <&dpi_pin_idle>;
>
>         port {
>                 dpi0_out: endpoint {
> --
> 2.12.5
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
