Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67C1A2FC9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 05:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbhATEUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 23:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbhATEQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 23:16:48 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00683C061757
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:16:07 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id n6so9064352edt.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DElroZXqfZUzJiCy4GvfhlQ6Pr1cbFqqFOvRYsAmCIE=;
        b=OblYYCNmg5zZTCNBSzDbZHagyqynBaBFSzHAzAzlPf3qWXDhDC5msudJrwBT91Qx2S
         mQUrHC7cSqEqEIqEUDRWmmrYBB4g2P4jKj9w+AETapmBPDWf9/I3P3EP/KDlF9/IXPux
         Mj8zgvgF7Upr6GY3oRkafTWjfJgRlkCiEmZI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DElroZXqfZUzJiCy4GvfhlQ6Pr1cbFqqFOvRYsAmCIE=;
        b=ex69pBT0iIBdUQtM5XuTanohPNBxFfUKbFtPfQW1fJFwBi9RdKvGEPEPz3VFrNE+xf
         GxtCiJGViFrF1idAP0sgV4/e64vEyCSh8vprCjqw378HnUz7HHUaYtjVhHCKjG5NJB14
         jF9PbLYKvQHo8aagwTgVf6df/iFf69GsQyRRxHKhxx4fzsFSBoJpHjK0Lloj3LlScUIC
         fYCtQYDIRK1QGXl4mSwLTImErWCD5Sw2JmzxJRHdqCPwNM2JKjJl8Bx7fLZV1jzAlD4C
         dT53Gdd9D2l1P/TIYeTHg/ipYagXbwommkgpH4W6cKOeRmU4arqyUgSPk1YPZdZJywtJ
         pwqw==
X-Gm-Message-State: AOAM533bNa5rcfXnbTlBuaxw1slIhw55TS2m7YPVUQXwJnpmRYtfuvpc
        OR1CiAuzHVRbHr97rHAeAhhxhXPzxmkdtw==
X-Google-Smtp-Source: ABdhPJyiigk+y8eeA7X7eABDZVT9HKCuJ8/e6RA3dX5uzcVzgQ15GpNcKsqA/FvjifZBYJhi0U0aEA==
X-Received: by 2002:a05:6402:268a:: with SMTP id w10mr5829391edd.331.1611116166412;
        Tue, 19 Jan 2021 20:16:06 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id m22sm383190edp.81.2021.01.19.20.16.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jan 2021 20:16:05 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id 6so14465499wri.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 20:16:04 -0800 (PST)
X-Received: by 2002:a5d:6209:: with SMTP id y9mr7158775wru.197.1611116164105;
 Tue, 19 Jan 2021 20:16:04 -0800 (PST)
MIME-Version: 1.0
References: <20201209080102.26626-1-yong.wu@mediatek.com> <20201209080102.26626-7-yong.wu@mediatek.com>
 <X+L9XpkoII7tw/tX@chromium.org> <1608809713.26323.262.camel@mhfsdcap03>
 <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com> <1610520301.31716.27.camel@mhfsdcap03>
In-Reply-To: <1610520301.31716.27.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 20 Jan 2021 13:15:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5A26tZo3gpsmqbRSa3x7a1KThzt9Jw74jWsqQGrBsabhw@mail.gmail.com>
Message-ID: <CAAFQd5A26tZo3gpsmqbRSa3x7a1KThzt9Jw74jWsqQGrBsabhw@mail.gmail.com>
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

On Wed, Jan 13, 2021 at 3:45 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2021-01-13 at 14:30 +0900, Tomasz Figa wrote:
> > On Thu, Dec 24, 2020 at 8:35 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > On Wed, 2020-12-23 at 17:18 +0900, Tomasz Figa wrote:
> > > > On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
> > > > > This patch adds decriptions for mt8192 IOMMU and SMI.
> > > > >
> > > > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > > > table format. The M4U-SMI HW diagram is as below:
> > > > >
> > > > >                           EMI
> > > > >                            |
> > > > >                           M4U
> > > > >                            |
> > > > >                       ------------
> > > > >                        SMI Common
> > > > >                       ------------
> > > > >                            |
> > > > >   +-------+------+------+----------------------+-------+
> > > > >   |       |      |      |       ......         |       |
> > > > >   |       |      |      |                      |       |
> > > > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > > > disp0   disp1   mdp    vdec                   IPE      IPE
> > > > >
> > > > > All the connections are HW fixed, SW can NOT adjust it.
> > > > >
> > > > > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > > > > into different iova ranges:
> > > > >
> > > > > domain-id  module     iova-range                  larbs
> > > > >    0       disp        0 ~ 4G                      larb0/1
> > > > >    1       vcodec      4G ~ 8G                     larb4/5/7
> > > > >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> > > >
> > > > Why do we preassign these addresses in DT? Shouldn't it be a user's or
> > > > integrator's decision to split the 16 GB address range into sub-ranges
> > > > and define which larbs those sub-ranges are shared with?
> > >
> > > The problem is that we can't split the 16GB range with the larb as unit.
> > > The example is the below ccu0(larb13 port9/10) is a independent
> > > range(domain), the others ports in larb13 is in another domain.
> > >
> > > disp/vcodec/cam/mdp don't have special iova requirement, they could
> > > access any range. vcodec also can locate 8G~12G. it don't care about
> > > where its iova locate. here I preassign like this following with our
> > > internal project setting.
> >
> > Let me try to understand this a bit more. Given the split you're
> > proposing, is there actually any isolation enforced between particular
> > domains? For example, if I program vcodec to with a DMA address from
> > the 0-4G range, would the IOMMU actually generate a fault, even if
> > disp had some memory mapped at that address?
>
> In this case. we will get fault in current SW setting.
>

Okay, thanks.

> >
> > >
> > > Why set this in DT?, this is only for simplifying the code. Assume we
> > > put it in the platform data. We have up to 32 larbs, each larb has up to
> > > 32 ports, each port may be in different iommu domains. we should have a
> > > big array for this..however we only use a macro to get the domain in the
> > > DT method.
> > >
> > > When replying this mail, I happen to see there is a "dev->dev_range_map"
> > > which has "dma-range" information, I think I could use this value to get
> > > which domain the device belong to. then no need put domid in DT. I will
> > > test this.
> >
> > My feeling is that the only part that needs to be enforced statically
> > is the reserved IOVA range for CCUs. The other ranges should be
> > determined dynamically, although I think I need to understand better
> > how the hardware and your proposed design work to tell what would be
> > likely the best choice here.
>
> I have removed the domid patch in v6. and get the domain id in [27/33]
> in v6..
>
> About the other ranges should be dynamical, the commit message [30/33]
> of v6 should be helpful. the problem is that we have a bank_sel setting
> for the iova[32:33]. currently we preassign this value. thus, all the
> ranges are fixed. If you adjust this setting, you can let vcodec access
> 0~4G.

Okay, so it sounds like we effectively have four 4G address spaces and
we can assign the master devices to them. I guess each of these
address spaces makes for an IOMMU group.

It's fine to pre-assign the devices to those groups for now, but it
definitely shouldn't be hardcoded in DT, because it depends on the use
case of the device. I'll take a look at v6, but it sounds like it
should be fine if it doesn't take the address space assignment from DT
anymore.

>
> Currently we have no interface to adjust this setting. Suppose we add a
> new interface for this. It would be something like:
>
>    int mtk_smi_larb_config_banksel(struct device *larb, int banksel)
>
>    Then, all the MM drivers should call it before the HW works every
> time, and its implement will be a bit complex since we aren't sure if
> the larb has power at that time. the important thing is that the MM
> devices have already not known which larb it connects with as we plan to
> delete "mediatek,larb" in their dtsi nodes.

From the practical point of view, it doesn't look like setting this on
a per-larb basis would make much sense. The reason to switch the
bank_sel would be to decide which MM devices can share the same
address space. This is a security aspect, because it effectively
determines which devices are isolated from each other.

That said, I agree that for now we can just start with a fixed
assignment. We can think of the API if there is a need to adjust the
assignment.

>
>    In current design, the MM device don't need care about it and 4GB
> range is enough for them.
>

Actually, is the current assignment correct?

domain-id  module     iova-range                  larbs
   0       disp        0 ~ 4G                      larb0/1
   1       vcodec      4G ~ 8G                     larb4/5/7
   2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
   3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
   4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5

Wouldn't CCU0 and CCU1 conflict with disp? Should perhaps disp be
assigned 12G ~ 16G instead?

Best regards,
Tomasz

> >
> > Best regards,
> > Tomasz
> >
> > >
> > > Thanks.
> > > >
> > > > Best regards,
> > > > Tomasz
> > > >
> > > > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > > > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > > > >
> > > > > The iova range for CCU0/1(camera control unit) is HW requirement.
> > > > >
> > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > ---
> > > > >  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
> > > > >  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
> > > > >  2 files changed, 257 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > > > >
> > > [snip]
>
