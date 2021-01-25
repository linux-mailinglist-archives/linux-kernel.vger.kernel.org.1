Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786DD302116
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 05:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbhAYE10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jan 2021 23:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbhAYE1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jan 2021 23:27:22 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0F1C061574
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:26:41 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id v67so15816274lfa.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7721dlJPZvDFhnAf95LAPXT+oZp1lxviWE77mw7HK+U=;
        b=SXq9WvCYjx+sURGFGLAN6Wm6XqFMMchLtBACjmn9qBfKXDuuUZ3Fo/ER0ztlotmV/v
         PY0hEUxGJS/NL8sHDk7inym5NljXC56SLvLIAIG1DZHLVAJ2oyZXPDKEW3SgxTcZH1ak
         WuH9jtCc6/IjW2/0Z/HdQUbhnKUOu53QnVcvI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7721dlJPZvDFhnAf95LAPXT+oZp1lxviWE77mw7HK+U=;
        b=JiorfafyYFGfudCeL+w9EBuhWdTAzDlqhgsGCz1qq85zaB5wcsVVVsTkNI5YJ9b1vP
         ADYXrAWHUFicEurYmiqMxAy9Rcx7tYbd8ylFrftvuOmDboYB0diFOfrr6HBY5VBhh765
         YA+WVJq1d//CPeHop2x9mUbJx8KwK9z6UjD8WsthE0jPLF55OsvWAHFJGZTOrnsBKeM/
         ZX84+rQ4K0I+VdUQHHzPBi+rSAfGgIrG3HzEL+RNBcs5M+pouKS6WBpORc1bZ5frXZUs
         UlhManJRz5vgrOAwnsywjgroAfWii6kN0z2N0uAvRudpPZcZZhaWW/QXdwfTvVRXU5QX
         EgXw==
X-Gm-Message-State: AOAM531tCdVfxSda08NuIIHExB0GM55jXpWfBQsKOG60vlTdQZ+PRGd5
        q88ZA7svj4h16oQBGsGuMDt/l/PUwkwH5Q==
X-Google-Smtp-Source: ABdhPJw8sZfOFx8bfCFMev713K0JRjxQkZnlDdyWk2GM9Hw8ohEsz2SgcVDekevFp/Yp8RYV2G9nAw==
X-Received: by 2002:a05:6512:3743:: with SMTP id a3mr303919lfs.8.1611548799436;
        Sun, 24 Jan 2021 20:26:39 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id l1sm1671638lfk.201.2021.01.24.20.26.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Jan 2021 20:26:39 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id l12so11133573ljc.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jan 2021 20:26:39 -0800 (PST)
X-Received: by 2002:adf:8295:: with SMTP id 21mr150008wrc.32.1611548334703;
 Sun, 24 Jan 2021 20:18:54 -0800 (PST)
MIME-Version: 1.0
References: <20201209080102.26626-1-yong.wu@mediatek.com> <20201209080102.26626-7-yong.wu@mediatek.com>
 <X+L9XpkoII7tw/tX@chromium.org> <1608809713.26323.262.camel@mhfsdcap03>
 <CAAFQd5CCJv=0q=V45Z7mtq7FSq1c5TcH6vyqfp3MWxaA=ZexJQ@mail.gmail.com>
 <1610520301.31716.27.camel@mhfsdcap03> <CAAFQd5A26tZo3gpsmqbRSa3x7a1KThzt9Jw74jWsqQGrBsabhw@mail.gmail.com>
 <1611126445.19055.34.camel@mhfsdcap03>
In-Reply-To: <1611126445.19055.34.camel@mhfsdcap03>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 25 Jan 2021 13:18:44 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C3G=eE+dwOK0Vg=tcSR8LFWWG1YDta3=9nZ1G0Bv7dcA@mail.gmail.com>
Message-ID: <CAAFQd5C3G=eE+dwOK0Vg=tcSR8LFWWG1YDta3=9nZ1G0Bv7dcA@mail.gmail.com>
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

On Wed, Jan 20, 2021 at 4:08 PM Yong Wu <yong.wu@mediatek.com> wrote:
>
> On Wed, 2021-01-20 at 13:15 +0900, Tomasz Figa wrote:
> > On Wed, Jan 13, 2021 at 3:45 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > >
> > > On Wed, 2021-01-13 at 14:30 +0900, Tomasz Figa wrote:
> > > > On Thu, Dec 24, 2020 at 8:35 PM Yong Wu <yong.wu@mediatek.com> wrote:
> > > > >
> > > > > On Wed, 2020-12-23 at 17:18 +0900, Tomasz Figa wrote:
> > > > > > On Wed, Dec 09, 2020 at 04:00:41PM +0800, Yong Wu wrote:
> > > > > > > This patch adds decriptions for mt8192 IOMMU and SMI.
> > > > > > >
> > > > > > > mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> > > > > > > table format. The M4U-SMI HW diagram is as below:
> > > > > > >
> > > > > > >                           EMI
> > > > > > >                            |
> > > > > > >                           M4U
> > > > > > >                            |
> > > > > > >                       ------------
> > > > > > >                        SMI Common
> > > > > > >                       ------------
> > > > > > >                            |
> > > > > > >   +-------+------+------+----------------------+-------+
> > > > > > >   |       |      |      |       ......         |       |
> > > > > > >   |       |      |      |                      |       |
> > > > > > > larb0   larb1  larb2  larb4     ......      larb19   larb20
> > > > > > > disp0   disp1   mdp    vdec                   IPE      IPE
> > > > > > >
> > > > > > > All the connections are HW fixed, SW can NOT adjust it.
> > > > > > >
> > > > > > > mt8192 M4U support 0~16GB iova range. we preassign different engines
> > > > > > > into different iova ranges:
> > > > > > >
> > > > > > > domain-id  module     iova-range                  larbs
> > > > > > >    0       disp        0 ~ 4G                      larb0/1
> > > > > > >    1       vcodec      4G ~ 8G                     larb4/5/7
> > > > > > >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> > > > > >
> > > > > > Why do we preassign these addresses in DT? Shouldn't it be a user's or
> > > > > > integrator's decision to split the 16 GB address range into sub-ranges
> > > > > > and define which larbs those sub-ranges are shared with?
> > > > >
> > > > > The problem is that we can't split the 16GB range with the larb as unit.
> > > > > The example is the below ccu0(larb13 port9/10) is a independent
> > > > > range(domain), the others ports in larb13 is in another domain.
> > > > >
> > > > > disp/vcodec/cam/mdp don't have special iova requirement, they could
> > > > > access any range. vcodec also can locate 8G~12G. it don't care about
> > > > > where its iova locate. here I preassign like this following with our
> > > > > internal project setting.
> > > >
> > > > Let me try to understand this a bit more. Given the split you're
> > > > proposing, is there actually any isolation enforced between particular
> > > > domains? For example, if I program vcodec to with a DMA address from
> > > > the 0-4G range, would the IOMMU actually generate a fault, even if
> > > > disp had some memory mapped at that address?
> > >
> > > In this case. we will get fault in current SW setting.
> > >
> >
> > Okay, thanks.
> >
> > > >
> > > > >
> > > > > Why set this in DT?, this is only for simplifying the code. Assume we
> > > > > put it in the platform data. We have up to 32 larbs, each larb has up to
> > > > > 32 ports, each port may be in different iommu domains. we should have a
> > > > > big array for this..however we only use a macro to get the domain in the
> > > > > DT method.
> > > > >
> > > > > When replying this mail, I happen to see there is a "dev->dev_range_map"
> > > > > which has "dma-range" information, I think I could use this value to get
> > > > > which domain the device belong to. then no need put domid in DT. I will
> > > > > test this.
> > > >
> > > > My feeling is that the only part that needs to be enforced statically
> > > > is the reserved IOVA range for CCUs. The other ranges should be
> > > > determined dynamically, although I think I need to understand better
> > > > how the hardware and your proposed design work to tell what would be
> > > > likely the best choice here.
> > >
> > > I have removed the domid patch in v6. and get the domain id in [27/33]
> > > in v6..
> > >
> > > About the other ranges should be dynamical, the commit message [30/33]
> > > of v6 should be helpful. the problem is that we have a bank_sel setting
> > > for the iova[32:33]. currently we preassign this value. thus, all the
> > > ranges are fixed. If you adjust this setting, you can let vcodec access
> > > 0~4G.
> >
> > Okay, so it sounds like we effectively have four 4G address spaces and
> > we can assign the master devices to them. I guess each of these
> > address spaces makes for an IOMMU group.
>
> Yes. Each a address spaces is an IOMMU group.
>
> >
> > It's fine to pre-assign the devices to those groups for now, but it
> > definitely shouldn't be hardcoded in DT, because it depends on the use
> > case of the device. I'll take a look at v6, but it sounds like it
> > should be fine if it doesn't take the address space assignment from DT
> > anymore.
>
> Thanks very much for your review.
>

Hmm, I had a look at v6 and it still has the address spaces hardcoded
in the DTS. Could we move the fixed assignment to the MTK IOMMU driver
code instead, so that it can be easily adjusted as the kernel code
evolves without the need to update the DTS?

> >
> > >
> > > Currently we have no interface to adjust this setting. Suppose we add a
> > > new interface for this. It would be something like:
> > >
> > >    int mtk_smi_larb_config_banksel(struct device *larb, int banksel)
> > >
> > >    Then, all the MM drivers should call it before the HW works every
> > > time, and its implement will be a bit complex since we aren't sure if
> > > the larb has power at that time. the important thing is that the MM
> > > devices have already not known which larb it connects with as we plan to
> > > delete "mediatek,larb" in their dtsi nodes.
> >
> > From the practical point of view, it doesn't look like setting this on
> > a per-larb basis would make much sense. The reason to switch the
> > bank_sel would be to decide which MM devices can share the same
> > address space. This is a security aspect, because it effectively
> > determines which devices are isolated from each other.
> >
> > That said, I agree that for now we can just start with a fixed
> > assignment. We can think of the API if there is a need to adjust the
> > assignment.
>
> Sorry for here. I forgot a thing here. that interface above still will
> not be helpful. If we don't divide the whole 16GB ranges into 4
> regions(let all the other ranges be dynamical), It won't work since we
> can only adjust bank_sel with the larb as unit. This is a problem. there
> are many ports in a larb. Take a example, the address for vcodec read
> port is 32bits while the address for vcodec write port is 33bit, then it
> will fail since we only have one bank_sel setting for one larb.

That's exactly why I proposed to have the API operate based on the
struct device, rather than individual DMA ports. Although I guess the
CCU case is different, because it's the same larb as the camera.

Anyway, I agree that we don't have to come up with such an API right now.

> Thus we
> have to use current design.
>
> >
> > >
> > >    In current design, the MM device don't need care about it and 4GB
> > > range is enough for them.
> > >
> >
> > Actually, is the current assignment correct?
>
> Oh. In the code (patch [32/33] of v6), I put CCU0/1 in the cam/mdp
> region which start at 8G since CCU0/1 is a module of camera.
>
> >
> > domain-id  module     iova-range                  larbs
> >    0       disp        0 ~ 4G                      larb0/1
> >    1       vcodec      4G ~ 8G                     larb4/5/7
> >    2       cam/mdp     8G ~ 12G             larb2/9/11/13/14/16/17/18/19/20
> >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> >
> > Wouldn't CCU0 and CCU1 conflict with disp?
>
> About the conflict, I use patch [29/33] of v6 for this. I will reserve
> this special iova region when the full domain(0-4G in this example)
> initialize.
>
> > Should perhaps disp be assigned 12G ~ 16G instead?
>
> I think no need put it to 12G-16G, In previous SoC, we have only 4GB
> ranges for whole MM engines. currently only cam/mdp domain exclude 128M
> for CCU. it should be something wrong if this is not enough.
>

Indeed, space is not a problem, but from the security point of view
it's undesirable. I believe CCU would be running proprietary firmware,
so it should be isolated as much as possible from other components.
And, after all, why waste the remaining 4G of address space?

Best regards,
Tomasz

> >
> > Best regards,
> > Tomasz
> >
> > > >
> > > > Best regards,
> > > > Tomasz
> > > >
> > > > >
> > > > > Thanks.
> > > > > >
> > > > > > Best regards,
> > > > > > Tomasz
> > > > > >
> > > > > > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > > > > > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > > > > > >
> > > > > > > The iova range for CCU0/1(camera control unit) is HW requirement.
> > > > > > >
> > > > > > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > > ---
> > > > > > >  .../bindings/iommu/mediatek,iommu.yaml        |  18 +-
> > > > > > >  include/dt-bindings/memory/mt8192-larb-port.h | 240 ++++++++++++++++++
> > > > > > >  2 files changed, 257 insertions(+), 1 deletion(-)
> > > > > > >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > > > > > >
> > > > > [snip]
> > >
>
