Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E55282F0461
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 00:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbhAIXSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 18:18:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:48934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726267AbhAIXSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 18:18:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47D342399A;
        Sat,  9 Jan 2021 23:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610234284;
        bh=ZFBoTC2mgipz/tgDN/qvYeH+VFW/sGoZi+34KvlR5+k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I0KT9ebP3JYEkZCpjp8Yn4cMRbh/Feck/qXNCJS+aTmq9tumgUGPUtVvSAqLFKqvD
         E2ODj/RkFLRTFUetrLComg+T4uVqjtxWfn4z9xXYalgujMJkCsAWkl+NvtnNvQVeVW
         +v9vBnNirkqWBynaUflKvMnVGPYT7LNA4xspiEH/xJmHgqvoYUGc0hcAh+qMT8+3j/
         o1H9f0Wc9Z5S8s3+cKA51+IvA+/vqX0fEpK7LJsavQjgz96MXieGlia/z0RdNtrVjy
         JgJ69hstuGTzFpWOP3RV+Vq2jQeb7CbUixMTF9VMwIgBzuORKsLSMunbrNOrHL/a1k
         BYA4pZm0yJGhw==
Received: by mail-ej1-f50.google.com with SMTP id ce23so19488482ejb.8;
        Sat, 09 Jan 2021 15:18:04 -0800 (PST)
X-Gm-Message-State: AOAM532brzDgqVI85gU1w7pnm7HG7/Ctipkg7aLgYwA1X1t3sZ9C3xyG
        Fa+LHAdYOG8ucLUC7TH7s9lk4LdSIfLXUC6CLA==
X-Google-Smtp-Source: ABdhPJyEdhJ/KO2Xrmr62wf3DDgLFM9nN3Ypr87VG4/eQLxzqqdHSDQinUf89iOl+Vr/SOlXv2uOuoYRofTdbtYL3xI=
X-Received: by 2002:a17:906:a106:: with SMTP id t6mr6745897ejy.63.1610234282909;
 Sat, 09 Jan 2021 15:18:02 -0800 (PST)
MIME-Version: 1.0
References: <20201027160631.608503-1-fparent@baylibre.com> <20201030191714.GA4171611@bogus>
In-Reply-To: <20201030191714.GA4171611@bogus>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sun, 10 Jan 2021 07:17:50 +0800
X-Gmail-Original-Message-ID: <CAAOTY_8LwVDxZnSQAdK7mS8MAFZ1y_0EnSzj3UqeCxq-Tc5FuQ@mail.gmail.com>
Message-ID: <CAAOTY_8LwVDxZnSQAdK7mS8MAFZ1y_0EnSzj3UqeCxq-Tc5FuQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mmsys: add mt1867 binding
To:     Rob Herring <robh@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        DTML <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthias:

Rob Herring <robh@kernel.org> =E6=96=BC 2020=E5=B9=B410=E6=9C=8831=E6=97=A5=
 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:17=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, 27 Oct 2020 17:06:29 +0100, Fabien Parent wrote:
> > Add binding documentation for MT8167 SoC.

Even though the title need to change to 'mt8167', this patch looks
good to me. How do you think about this patch? One drm patch [1]
depend on this patch, if you like this patch, could you applied this
patch first?

[1] https://patchwork.kernel.org/project/linux-mediatek/patch/2020102313313=
0.194140-6-fparent@baylibre.com/

Regards,
Chun-Kuang.

> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > ---
> >  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.txt          | 1 +
> >  1 file changed, 1 insertion(+)
> >
>
> Acked-by: Rob Herring <robh@kernel.org>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
