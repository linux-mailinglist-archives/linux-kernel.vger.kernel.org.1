Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 368472F4C72
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 14:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbhAMNsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 08:48:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725772AbhAMNsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 08:48:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E566223339;
        Wed, 13 Jan 2021 13:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610545660;
        bh=c9ZEmZC+OGzOHSTlleqwkNhpgxSo3+qwJ9ptpSoPBMY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FYu658AOWNtizhfGOXbNeL8NnWsMtHC+dTrt2yedfVOtoG8JKtBG1y0MjODTu7GW+
         740oAJD+fJqb5Ts7VVV3U0RQNlu6RbHic5mtnopKPl5jioiqWOOkaKbt2dcLn/u+s7
         rtGUDgKHYO2vy3z9WftyjNDrcEPDtYydLA3YzkWaUcPIt82pnUA9FwbgpXRQXjsmcB
         W0vRdNUQjbeEwzz3seUsYoyKP0i2R+Fd0JWpH/RrqeAmXPff4JzKQiknxZ1BCcrRAj
         IIhLhSyZ2S1JQDGgRP4Zv3xbeB/GUxEAOljYrPV9vib4zsFj0Ixwzj+Ay81CUJHG6E
         IqT8rXjjuXBfA==
Received: by mail-ed1-f46.google.com with SMTP id r5so1940047eda.12;
        Wed, 13 Jan 2021 05:47:39 -0800 (PST)
X-Gm-Message-State: AOAM533YTLpB1UJ406gnZoay+zQciRRzTIJdgzQQfWQeObYCVxLb3q5r
        Q7UlMGN2tqns+A0vpvSgjq/Tlo3W1f6UKvMb7g==
X-Google-Smtp-Source: ABdhPJwFnnxsacTgDF7sATccpJCIWFohXy1lChGnPrWia0Dd45sGfr2h+/uzWLycVLhW0t1rfVN+jlHpRT5er6uxUkA=
X-Received: by 2002:a50:e78b:: with SMTP id b11mr1817862edn.165.1610545658364;
 Wed, 13 Jan 2021 05:47:38 -0800 (PST)
MIME-Version: 1.0
References: <20201223111633.1711477-1-zhang.lyra@gmail.com>
 <20210108022545.GA1744725@robh.at.kernel.org> <CAAfSe-svn4ACvhk3McO7APLLSKdC=9ei7bvmD9ZhnSosnLQ1AA@mail.gmail.com>
In-Reply-To: <CAAfSe-svn4ACvhk3McO7APLLSKdC=9ei7bvmD9ZhnSosnLQ1AA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Jan 2021 07:47:26 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKqi_tngaR0nHpjbQz2Q8QnwJ+Ea=DghT6xqR9U8o-5CQ@mail.gmail.com>
Message-ID: <CAL_JsqKqi_tngaR0nHpjbQz2Q8QnwJ+Ea=DghT6xqR9U8o-5CQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
To:     Chunyan Zhang <zhang.lyra@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        DTML <devicetree@vger.kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Kevin Tang <kevin.tang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 5:34 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
>
> On Fri, 8 Jan 2021 at 10:25, Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, Dec 23, 2020 at 07:16:32PM +0800, Chunyan Zhang wrote:
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > This patch only adds bindings to support display iommu, support for others
> > > would be added once finished tests with those devices, such as Image
> > > codec(jpeg) processor, a few signal processors, including VSP(video),
> > > GSP(graphic), ISP(image), and camera CPP, etc.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > ---
> > >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
> > >  1 file changed, 44 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > new file mode 100644
> > > index 000000000000..4d9a578a7cc9
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > @@ -0,0 +1,44 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright 2020 Unisoc Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Unisoc IOMMU and Multi-media MMU
> > > +
> > > +maintainers:
> > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - sprd,iommu-disp
> >
> > Needs to be Soc specific.
>
> All SoCs so far use the same iommu IP, there's a little different
> among different iommu users.

That's what everyone says. Be warned that you cannot add properties
for any differences that come up whether features or errata.

> > Is this block specific to display subsys or
> > that just happens to be where the instance is?
>
> This iommu driver can serve many subsystem devices, such as Video,
> Camera, Image, etc., but they have their own iommu module which looks
> like a subdevice embedded in the master devices.
> I will add more compatible strings for those devices when needed.
> For now, only this one was listed here because I just tested this
> iommu driver with DPU only.

The iommu binding takes care of what each one is connected to. Is each
instance different in terms of features or programming model? If not,
then you shouldn't have different compatible strings for each
instance.

Rob
