Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CE8A27019E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 18:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgIRQIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 12:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgIRQIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 12:08:05 -0400
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D37238E6;
        Fri, 18 Sep 2020 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600445284;
        bh=HsD1zmlNgcDp2ntiGGXDt1Iu4ADx6rxNh/Bto2esBP8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=emUrEqNiAaIypaaqR0DFyojY3bKTuLzedv4LJNpN6r92gOZux9m/t+i1gDj1JpGUw
         XdzfnJhSce31jn8yRunVP1TffGoAH3jyT3yCKqPfFryCodyr5Ku1NvsvKOnpWwHFs+
         9mXeIHyvZEiaP3nGp2V20W14pf9i4HBfMJMoBQV8=
Received: by mail-ot1-f51.google.com with SMTP id u25so5877282otq.6;
        Fri, 18 Sep 2020 09:08:04 -0700 (PDT)
X-Gm-Message-State: AOAM533VSNj/ijoXeEHV4diRaslxHgYQJaDG1LQjeSCoSjFU+0cEtVnv
        oXZfNFot6kvZII9E/Dc75CcNNHuM3pyBL6RUNA==
X-Google-Smtp-Source: ABdhPJwgdQQ94kk1CAJVTaLgyAzK5jSLiZzPbGFE5cSpTlp+14Bb87D1OUAiLGeIZ3x+kwKNZ39GOoJ1D5VzhOMWVEw=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr21705872otp.107.1600445283255;
 Fri, 18 Sep 2020 09:08:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200905080920.13396-1-yong.wu@mediatek.com> <20200905080920.13396-2-yong.wu@mediatek.com>
 <20200914232204.GA457962@bogus> <1600148980.25043.11.camel@mhfsdcap03>
In-Reply-To: <1600148980.25043.11.camel@mhfsdcap03>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Sep 2020 10:07:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKj+-_vvZfoLiJ-ox255cFaAD4SPmrk2qCusGWAs-b+XQ@mail.gmail.com>
Message-ID: <CAL_JsqKj+-_vvZfoLiJ-ox255cFaAD4SPmrk2qCusGWAs-b+XQ@mail.gmail.com>
Subject: Re: [PATCH v2 01/23] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Youlin Pei <youlin.pei@mediatek.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Anan Sun <anan.sun@mediatek.com>,
        Chao Hao <chao.hao@mediatek.com>,
        Ming-Fan Chen <ming-fan.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 11:51 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Mon, 2020-09-14 at 17:22 -0600, Rob Herring wrote:
> > On Sat, Sep 05, 2020 at 04:08:58PM +0800, Yong Wu wrote:
> > > Convert MediaTek IOMMU to DT schema.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > ---
>
> [...]
>
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt2701-m4u #mt2701 generation one HW
> > > +      - mediatek,mt2712-m4u #mt2712 generation two HW
> > > +      - mediatek,mt6779-m4u #mt6779 generation two HW
> > > +      - mediatek,mt7623-m4u, mediatek,mt2701-m4u #mt7623 generation one HW
> >
> > This is not right.
> >
> > items:
> >   - const: mediatek,mt7623-m4u
> >   - const: mediatek,mt2701-m4u
> >
> > And that has to be under a 'oneOf' with the rest of this.
>
> Thanks for the review. Is this OK?
>
>   compatible:
>     oneOf:
>       - const: mediatek,mt2701-m4u # mt2701 generation one HW
>       - const: mediatek,mt2712-m4u # mt2712 generation two HW
>       - const: mediatek,mt6779-m4u # mt6779 generation two HW
>       - const: mediatek,mt8173-m4u # mt8173 generation two HW
>       - const: mediatek,mt8183-m4u # mt8183 generation two HW
>       - const: mediatek,mt8192-m4u # mt8192 generation two HW

It is correct, but I prefer all these to be a single enum. So 'oneOf'
would have 2 entries.

>       - description: mt7623 generation one HW
>         items:
>           - const: mediatek,mt7623-m4u
>           - const: mediatek,mt2701-m4u
>
> >
> > > +      - mediatek,mt8173-m4u #mt8173 generation two HW
> > > +      - mediatek,mt8183-m4u #mt8183 generation two HW
> > > +
> > > +  reg:
> > > +    maxItems: 1
>
> [snip]
