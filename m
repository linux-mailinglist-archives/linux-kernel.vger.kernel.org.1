Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7BE2AA8FD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 04:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbgKHD2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Nov 2020 22:28:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbgKHD2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Nov 2020 22:28:42 -0500
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AFC420760;
        Sun,  8 Nov 2020 03:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604806121;
        bh=15PLnXybh2lEXrB1xUvGTz2108s9b14lvl6FVOOsnkM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sMoQBj41ddbPFQTcan6DzPGdl1NoHy+EQV286lImAxg0Id1qJpr6o2rqD1S5896F2
         Qy5jqS6bzaaVGf2oANmLFLAci4OFrnv04egdIUEALM93RUdywpy4c6UQXeRL4o9lOE
         fqKyCmm6FX7g/hDnhbcqixNuQoDd6nQW/0Hh2gHM=
Received: by mail-ej1-f44.google.com with SMTP id oq3so7422758ejb.7;
        Sat, 07 Nov 2020 19:28:41 -0800 (PST)
X-Gm-Message-State: AOAM531C/ZcC/oUkFQhWd/l120ONKw/xY4HwyrDFoayisIY8Ad5JQjN1
        8V1zXpNbbp0WTyNkiOWEPAK4amSyneRbUaNOmw==
X-Google-Smtp-Source: ABdhPJyBseDAhXQ/6C9jcMSsrTp+8xbOBCsG2KacXh8VPxOMNSA/zdsBnuqjc6Ef7wdx0UtfJ8yVeN4wasCoPh0S1AU=
X-Received: by 2002:a17:906:5a96:: with SMTP id l22mr9065798ejq.303.1604806120037;
 Sat, 07 Nov 2020 19:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20200917073305.25738-1-jitao.shi@mediatek.com> <20200923201517.GA1226945@bogus>
In-Reply-To: <20200923201517.GA1226945@bogus>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 8 Nov 2020 11:28:29 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8EbbWRzvn3i_a5TjYKuUX7g=EmVNnAVY80OYePr_ndDQ@mail.gmail.com>
Message-ID: <CAAOTY_8EbbWRzvn3i_a5TjYKuUX7g=EmVNnAVY80OYePr_ndDQ@mail.gmail.com>
Subject: Re: [v2 PATCH] dt-bindings: display: mediatek: convert the dpi
 bindings to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Jitao Shi <jitao.shi@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        DTML <devicetree@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        David Airlie <airlied@linux.ie>, huijuan.xie@mediatek.com,
        stonea168@163.com, linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        cawa.cheng@mediatek.com, Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jitao:

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=8824=E6=97=A5 =
=E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, 17 Sep 2020 15:33:05 +0800, Jitao Shi wrote:
> > Convert display/mediatek/mediatek,dpi.txt to display/mediatek/mediatek,=
dpi.yaml
> > and remove the old text bindings.
> >
> > Signed-off-by: Jitao Shi <jitao.shi@mediatek.com>
> > ---
> >  .../bindings/display/mediatek/mediatek,dpi.txt     | 42 ----------
> >  .../bindings/display/mediatek/mediatek,dpi.yaml    | 97 ++++++++++++++=
++++++++
> >  2 files changed, 97 insertions(+), 42 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/display/mediatek/=
mediatek,dpi.txt
> >  create mode 100644 Documentation/devicetree/bindings/display/mediatek/=
mediatek,dpi.yaml
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> __

Applied to mediatek-drm-next [1], thanks.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.git/=
log/?h=3Dmediatek-drm-next

Regards,
Chun-Kuang.

_____________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
