Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD1F2FE480
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbhAUH6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbhAUHwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:52:47 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41218C0613D3;
        Wed, 20 Jan 2021 23:52:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id c12so745822wrc.7;
        Wed, 20 Jan 2021 23:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8oRMVgXTTtZZl0t+edBJix5UUYLc6dLj900da8EQmuk=;
        b=G55vCALv8HZuSXjR6w5mk5061SvQLWids/qXihhGmJ3EiU+cWG204AmSAari+vlK9G
         hwQrAc3zhnu4MdfWqvQoe0pZm9zW5RqEJtQiIU43lVH83Lp5fkOVBwdSqg0rUitA3jWX
         nxkj0Z/OKkUGaWDChzM7byFm9Lv7FBiEgIFNF2kmEI3fcwuHpVCxdFMtZA6ZIf8wUh9j
         /gQehFw+Vxgoel92e6O5vmFJMXm3m91SPcNw7l6By+Hu4fGAHQUepdIBYoAuDXkDP4Wu
         R+L+0zxviiyaIluotT8zMRptqqZCg5cDzA1bLqPQZAwuVghY0qBgYE1ckvPOwsW9hUhL
         yBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8oRMVgXTTtZZl0t+edBJix5UUYLc6dLj900da8EQmuk=;
        b=Rr5BiZdxuzOtcyX0Pyq2WMbO+BiqqJkxb2+LO0H+gAvva3sRVV4KzZ0ShaCzxQS/Re
         2mat1vzmTY10pAziQGYPfaeUsUZr3qaa3Thqiq7u9ti/os70diUOv0W57hVqYJLrZSHQ
         dLGIbzg8pabspM+32C345qxiDmNMdBvjlHFvF+lQUESQ3ZZx1MKj2Zu+z7L+oEXC1fg2
         e99K6k50WGpGY1bwjAhDdJqVZmBoLxGMWVIpUO8+EED1BkKhYxGMDVHn7R1VGFn3J9UK
         juO2eG7RJgNFYejSin33xj2GMtti1sVK3MYePKLDVdl+3XxvXZ5l92d4Xu0XdZRKqO9W
         z8dA==
X-Gm-Message-State: AOAM533AKkC7iRxvFYroDBwI17Fbg+dhyYAG/44Eg3rIW7nCu0g0H2Bw
        Z59M/3XJP+8tSXs+1aKP6ko3b8BFSHGUPL/hEkc=
X-Google-Smtp-Source: ABdhPJwD87R3jYKAxjc1cN8PtBV0u9ziqbJf5lJT4+qMB0LSpMtCa5lHXnxg5FFoaDXZq0JeoPao7VnAoAQN4bkmn/w=
X-Received: by 2002:adf:9427:: with SMTP id 36mr12865530wrq.271.1611215524060;
 Wed, 20 Jan 2021 23:52:04 -0800 (PST)
MIME-Version: 1.0
References: <20201223111633.1711477-1-zhang.lyra@gmail.com>
 <20210108022545.GA1744725@robh.at.kernel.org> <CAAfSe-svn4ACvhk3McO7APLLSKdC=9ei7bvmD9ZhnSosnLQ1AA@mail.gmail.com>
 <CAL_JsqKqi_tngaR0nHpjbQz2Q8QnwJ+Ea=DghT6xqR9U8o-5CQ@mail.gmail.com>
In-Reply-To: <CAL_JsqKqi_tngaR0nHpjbQz2Q8QnwJ+Ea=DghT6xqR9U8o-5CQ@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 21 Jan 2021 15:51:27 +0800
Message-ID: <CAAfSe-vxkbmubYMbP+mvj9wUrrfjcoOCXyzo2VSVn4eanK1niA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: iommu: add bindings for sprd iommu
To:     Rob Herring <robh@kernel.org>
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

On Wed, 13 Jan 2021 at 21:47, Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Jan 8, 2021 at 5:34 AM Chunyan Zhang <zhang.lyra@gmail.com> wrote:
> >
> > On Fri, 8 Jan 2021 at 10:25, Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, Dec 23, 2020 at 07:16:32PM +0800, Chunyan Zhang wrote:
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > This patch only adds bindings to support display iommu, support for others
> > > > would be added once finished tests with those devices, such as Image
> > > > codec(jpeg) processor, a few signal processors, including VSP(video),
> > > > GSP(graphic), ISP(image), and camera CPP, etc.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > ---
> > > >  .../devicetree/bindings/iommu/sprd,iommu.yaml | 44 +++++++++++++++++++
> > > >  1 file changed, 44 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > > new file mode 100644
> > > > index 000000000000..4d9a578a7cc9
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iommu/sprd,iommu.yaml
> > > > @@ -0,0 +1,44 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +# Copyright 2020 Unisoc Inc.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iommu/sprd,iommu.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Unisoc IOMMU and Multi-media MMU
> > > > +
> > > > +maintainers:
> > > > +  - Chunyan Zhang <zhang.lyra@gmail.com>
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    enum:
> > > > +      - sprd,iommu-disp
> > >
> > > Needs to be Soc specific.
> >
> > All SoCs so far use the same iommu IP, there's a little different
> > among different iommu users.
>
> That's what everyone says. Be warned that you cannot add properties
> for any differences that come up whether features or errata.

Ok, I will use a version specific compatible string.

>
> > > Is this block specific to display subsys or
> > > that just happens to be where the instance is?
> >
> > This iommu driver can serve many subsystem devices, such as Video,
> > Camera, Image, etc., but they have their own iommu module which looks
> > like a subdevice embedded in the master devices.
> > I will add more compatible strings for those devices when needed.
> > For now, only this one was listed here because I just tested this
> > iommu driver with DPU only.
>
> The iommu binding takes care of what each one is connected to. Is each
> instance different in terms of features or programming model? If not,

The one difference so far is the register offset which is not the same
for different instances.

Thanks for the review.
Chunyan

> then you shouldn't have different compatible strings for each
> instance.
>
> Rob
