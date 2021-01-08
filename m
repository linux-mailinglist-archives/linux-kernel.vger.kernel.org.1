Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 302BC2EF16D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 12:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbhAHLfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 06:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727132AbhAHLer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 06:34:47 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B0C0612F4;
        Fri,  8 Jan 2021 03:34:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r7so8669023wrc.5;
        Fri, 08 Jan 2021 03:34:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nEc5wG3dILAGk32bL1jujPzJlzS0QKkC1c/kQMfY5N8=;
        b=hIFrMTB3S+rVuuFdrk8zk/CaNWPHJfeNY7BFvbSSacGai+bOhV7u6eN3HpUjKSV127
         iBBmZipZMLFv0uk96RlbxHnSqrGgR4vDmowkKeHwD3Q+BN4nvNrVaGMCncTjK+b4OK7z
         gl09CRyJ6oCv0zdGqkPx+na5S0dR0YoWaZrgfwWj7fDjnMES7OF8E13zV505q0IyRlwy
         tNyI8+P/Dwylvr92HvYe6+tIIt0WPIM5OEf9k9Nspok89WAZpA3ZZ1S5CxK8c3x6gRjr
         c0P7AghE0+VK/I9JDCCsakvYJgTTqpo4CdzCuBGr2Qbc8DWzrSrD3GS4vOrSNi3ircrt
         Tv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nEc5wG3dILAGk32bL1jujPzJlzS0QKkC1c/kQMfY5N8=;
        b=WGIpptkeN/yeoIPr9adxfpAaVcK01J6a6vSEt0BgCmQxG088HC3sEv1DP2hd0EHgu/
         Pe1neaDzu2YeT1Vmz+0z6DZh8esw96sspLdyOmCtPeuro0ZAowz7WV/DNMDp+iv4RHmK
         RIQ06OLIQSzEF4wCqOqX+w9YDQp/AEPRBAOHms/belNEt1FPXxMMDwn5J/TieleB3BWM
         Wad522Kf1EJKcJCo/7Vf025C3ZRWVO1a6npA+5AIYTgZ1XO21+9Q4UNPV1L9cYDur7GA
         E8g3+5jyvaahCp8tSUTJtPIuKsXWM4w23nFCmbDgc1NpT7oHy/Xkg0i8obBTK+0MmkFm
         t1JA==
X-Gm-Message-State: AOAM532Uw2uII13eznVVCgsddCFBS2vFMonPVu+tZ7fONSlu0url5saV
        OixMaR5uxb8/iVJ7ujo6B5OvnKYbmQMoXR7ICp8=
X-Google-Smtp-Source: ABdhPJxoWjNkep0c2aYKAL7kFh3Z7DoXzlAjVZ7GuVFKaPKYi0xepL6M9O6IiOMlXmnqZPyeYImKYuC4797dnlCDJ60=
X-Received: by 2002:a5d:60c1:: with SMTP id x1mr3214644wrt.271.1610105640518;
 Fri, 08 Jan 2021 03:34:00 -0800 (PST)
MIME-Version: 1.0
References: <20201223111633.1711477-1-zhang.lyra@gmail.com> <20210108022545.GA1744725@robh.at.kernel.org>
In-Reply-To: <20210108022545.GA1744725@robh.at.kernel.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 8 Jan 2021 19:33:24 +0800
Message-ID: <CAAfSe-svn4ACvhk3McO7APLLSKdC=9ei7bvmD9ZhnSosnLQ1AA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
To:     Rob Herring <robh@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org,
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

On Fri, 8 Jan 2021 at 10:25, Rob Herring <robh@kernel.org> wrote:
>
> On Wed, Dec 23, 2020 at 07:16:32PM +0800, Chunyan Zhang wrote:
> > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >
> > This patch only adds bindings to support display iommu, support for others
> > would be added once finished tests with those devices, such as Image
> > codec(jpeg) processor, a few signal processors, including VSP(video),
> > GSP(graphic), ISP(image), and camera CPP, etc.
> >
> > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > ---
> >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > new file mode 100644
> > index 000000000000..4d9a578a7cc9
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > @@ -0,0 +1,44 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright 2020 Unisoc Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Unisoc IOMMU and Multi-media MMU
> > +
> > +maintainers:
> > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - sprd,iommu-disp
>
> Needs to be Soc specific.

All SoCs so far use the same iommu IP, there's a little different
among different iommu users.

> Is this block specific to display subsys or
> that just happens to be where the instance is?

This iommu driver can serve many subsystem devices, such as Video,
Camera, Image, etc., but they have their own iommu module which looks
like a subdevice embedded in the master devices.
I will add more compatible strings for those devices when needed.
For now, only this one was listed here because I just tested this
iommu driver with DPU only.

Thanks for the review.

Chunyan

>
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  "#iommu-cells":
> > +    const: 0
> > +    description:
> > +      Unisoc IOMMUs are all single-master IOMMU devices, therefore no
> > +      additional information needs to associate with its master device.
> > +      Please refer to the generic bindings document for more details,
> > +      Documentation/devicetree/bindings/iommu/iommu.txt
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - "#iommu-cells"
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    iommu_disp: iommu@63000000 {
> > +      compatible = "sprd,iommu-disp";
> > +      reg = <0x63000000 0x880>;
> > +      #iommu-cells = <0>;
> > +    };
> > +
> > +...
> > --
> > 2.25.1
> >
