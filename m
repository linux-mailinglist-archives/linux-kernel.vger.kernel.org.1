Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900472F43E4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbhAMFbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbhAMFbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:31:22 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78699C061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:30:41 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id i24so546500edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3eSHLU0tsnB/8YZodS1JHYyVuvZP1q+Jh72EF+LlqTo=;
        b=kH9y5HDmn14mKPIgiSh0+j61km8jiNYl7Jz2izQAcbV/5id9R9NlXd1WoPfZ4Cqp12
         DC2YZgYFU3CAG0ZYQdxFQiMKzJqP8Q+nkXFfCI9yrpeJDZ6lzD4Ld6GCkOfgQtLnoGLA
         KxDo2CyZ1EsNF43VAwEawZpbStfqt1FOzQm8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3eSHLU0tsnB/8YZodS1JHYyVuvZP1q+Jh72EF+LlqTo=;
        b=QRxAvFlJKG4D5QDw7Ak+Tl6YNN9LsLNs1UouFPoiv+K/v2yw+gP/1aDYAHcwXVPNgL
         Pjcj8NfaludsjNczE3vZe8I83dGkkxzqaEUuacpq2J0ycbXfOdhfkcoWUlAcoNQb0SXW
         22aYyLK0nAg7Q9SRSueDN0f+HrfJcY0kPtaH8p1lBR3XHpu9fF/Zz/4N1UlNVCSwRPUQ
         kXFLoVBtEu7f0NVS8A3fJd1nmIKCA+yI4c8PVNPdjgyUa70yqX+dpJkK8Bqd5X8yAS8m
         /cw7xkWet16mzRPSCebzZiy9UVG/WiBq5BWYAfQY98T+66Hmi3N0JtnPxjA5ldOPGNbK
         vyDg==
X-Gm-Message-State: AOAM533K4lTnWK/KusZ8U5BVmQeWrO9/1YMEBywEoxzu3vlq0m9pCku6
        WKxUoclYXta3nWw5IYISkjVTmYj2ZCmzwMQC
X-Google-Smtp-Source: ABdhPJwu22VQ66dY4Li1ZSBy5sop6ELXSMgv7DM+eOwDLl0sB2lpLW4Su4FXn1i6zxOQSB2x6YCgzA==
X-Received: by 2002:a50:8387:: with SMTP id 7mr383285edi.131.1610515839860;
        Tue, 12 Jan 2021 21:30:39 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id g17sm112797edb.39.2021.01.12.21.30.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jan 2021 21:30:38 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 3so433510wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 21:30:37 -0800 (PST)
X-Received: by 2002:a7b:c773:: with SMTP id x19mr382042wmk.127.1610515837254;
 Tue, 12 Jan 2021 21:30:37 -0800 (PST)
MIME-Version: 1.0
References: <20201209080102.26626-1-yong.wu@mediatek.com> <20201209080102.26626-7-yong.wu@mediatek.com>
 <X+L9XpkoII7tw/tX@chromium.org> <1608809713.26323.262.camel@mhfsdcap03>
In-Reply-To: <1608809713.26323.262.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 13 Jan 2021 14:30:24 +0900
X-Gmail-Original-Message-ID: <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
Message-ID: <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/27] dt-bindings: mediatek: Add binding for mt8192 IOMMU
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, youlin.pei@mediatek.com,
        linux-devicetree <devicetree@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        chao.hao@mediatek.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>, anan.sun@mediatek.com,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 8:35 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2020-12-23 at 17:18 +0900, Tomasz Figa wrote:
> > On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
> > > This patch adds decriptions for mt8192 IOMMU and SMI.
> > >
> > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > table format. The M4U-SMI HW diagram is as below:
> > >
> > >                           EMI
> > >                            |
> > >                           M4U
> > >                            |
> > >                       ------------
> > >                        SMI Common
> > >                       ------------
> > >                            |
> > >   +-------+------+------+----------------------+-------+
> > >   |       |      |      |       ......         |       |
> > >   |       |      |      |                      |       |
> > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > disp0   disp1   mdp    vdec                   IPE      IPE
> > >
> > > All the connections are HW fixed, SW can NOT adjust it.
> > >
> > > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > > into different iova ranges:
> > >
> > > domain-id  module     iova-range                  larbs
> > >    0       disp        0 ~ 4G                      larb0/1
> > >    1       vcodec      4G ~ 8G                     larb4/5/7
> > >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> >
> > Why do we preassign these addresses in DT? Shouldn't it be a user's or
> > integrator's decision to split the 16 GB address range into sub-ranges
> > and define which larbs those sub-ranges are shared with?
>
> The problem is that we can't split the 16GB range with the larb as unit.
> The example is the below ccu0(larb13 port9/10) is a independent
> range(domain), the others ports in larb13 is in another domain.
>
> disp/vcodec/cam/mdp don't have special iova requirement, they could
> access any range. vcodec also can locate 8G~12G. it don't care about
> where its iova locate. here I preassign like this following with our
> internal project setting.

Let me try to understand this a bit more. Given the split you're
proposing, is there actually any isolation enforced between particular
domains? For example, if I program vcodec to with a DMA address from
the 0-4G range, would the IOMMU actually generate a fault, even if
disp had some memory mapped at that address?

>
> Why set this in DT?, this is only for simplifying the code. Assume we
> put it in the platform data. We have up to 32 larbs, each larb has up to
> 32 ports, each port may be in different iommu domains. we should have a
> big array for this..however we only use a macro to get the domain in the
> DT method.
>
> When replying this mail, I happen to see there is a "dev->dev_range_map"
> which has "dma-range" information, I think I could use this value to get
> which domain the device belong to. then no need put domid in DT. I will
> test this.

My feeling is that the only part that needs to be enforced statically
is the reserved IOVA range for CCUs. The other ranges should be
determined dynamically, although I think I need to understand better
how the hardware and your proposed design work to tell what would be
likely the best choice here.

Best regards,
Tomasz

>
> Thanks.
> >
> > Best regards,
> > Tomasz
> >
> > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > >
> > > The iova range for CCU0/1(camera control unit) is HW requirement.
> > >
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
> > >  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
> > >  2 files changed, 257 insertions(+), 1 deletion(-)
> > >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > >
> [snip]
