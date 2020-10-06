Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92457284706
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbgJFHTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:19:53 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37884 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727147AbgJFHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:19:52 -0400
Received: by mail-wr1-f66.google.com with SMTP id h7so8576970wre.4;
        Tue, 06 Oct 2020 00:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tLX8MUE8fMwR/rmRJeOX+yduwkBmzQAbVy+FfpGJiXk=;
        b=IQkUow2A72wwA3evUgti8ZMeixfLqTTKuXMTifLwGorPIqwsRDa3dXCTOCcZo898L6
         Oj7SH4kZvauw718wccnL8+gkI03nVKtNG8lfog3j5/6cI+syhpAVe6/RMuiZXjIN08SU
         Bz/hlX2E1sYomlRiO3k9C5Ih5bX/QCl4rsJmApdErGXKTfQx83EXsnO/uORS7lOq8plh
         Tphaw+Bhc4XOWFby9c2voerwOOm3Fvtbk1RUTju9Ddl50Ab3d/W9zOkCZE7KVmvQsGNC
         aP9RdtKG3X3vchG3iuoKP6yTgPjeI74l/ksNLCDKvd1ecFgiUx8BJrX5OK9L4nBp0CKv
         vUfg==
X-Gm-Message-State: AOAM531GYauyqZZKpacfAiHXuTndSE4KqtBgPbyTVvdJK/TjHE2rjsEf
        4eqM38nTE115eOi0VI/X8Ag=
X-Google-Smtp-Source: ABdhPJwcFPFaKk+kQGjarLysXTsJkvJxJ59r7qmNrLo/3p1ufBJ3CMZyj51pjjHZbxZ26R5kk8lplA==
X-Received: by 2002:adf:9461:: with SMTP id 88mr3236215wrq.307.1601968790024;
        Tue, 06 Oct 2020 00:19:50 -0700 (PDT)
Received: from kozik-lap ([194.230.155.194])
        by smtp.googlemail.com with ESMTPSA id f63sm2746288wme.38.2020.10.06.00.19.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 06 Oct 2020 00:19:48 -0700 (PDT)
Date:   Tue, 6 Oct 2020 09:19:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        chao.hao@mediatek.com, ming-fan.chen@mediatek.com,
        Greg Kroah-Hartman <gregkh@google.com>, kernel-team@android.com
Subject: Re: [PATCH v3 06/24] dt-bindings: mediatek: Add binding for mt8192
 IOMMU
Message-ID: <20201006071946.GA5759@kozik-lap>
References: <20200930070647.10188-1-yong.wu@mediatek.com>
 <20200930070647.10188-7-yong.wu@mediatek.com>
 <20201002111014.GE6888@pi3>
 <1601958405.26323.24.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1601958405.26323.24.camel@mhfsdcap03>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 06, 2020 at 12:26:45PM +0800, Yong Wu wrote:
> Hi Krzysztof,
> 
> On Fri, 2020-10-02 at 13:10 +0200, Krzysztof Kozlowski wrote:
> > On Wed, Sep 30, 2020 at 03:06:29PM +0800, Yong Wu wrote:
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
> > >    3       CCU0    0x4000_0000 ~ 0x43ff_ffff     larb13: port 9/10
> > >    4       CCU1    0x4400_0000 ~ 0x47ff_ffff     larb14: port 4/5
> > > 
> > > The iova range for CCU0/1(camera control unit) is HW requirement.
> > > 
> > > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/iommu/mediatek,iommu.yaml        |   9 +-
> > >  .../mediatek,smi-common.yaml                  |   5 +-
> > >  .../memory-controllers/mediatek,smi-larb.yaml |   3 +-
> > >  include/dt-bindings/memory/mt8192-larb-port.h | 239 ++++++++++++++++++
> > >  4 files changed, 251 insertions(+), 5 deletions(-)
> > >  create mode 100644 include/dt-bindings/memory/mt8192-larb-port.h
> > 
> > I see it depends on previous patches but does it have to be within one
> > commit? Is it not bisectable? The memory changes/bindings could go via
> > memory tree if this is split.
> 
> Thanks for the view.
> 
> I can split this into two patchset in next version, one is for iommu and
> the other is for smi.
> 
> Only the patch [18/24] change both the code(iommu and smi). I don't plan
> to split it, and the smi patch[24/24] don't depend on it(won't
> conflict).

It got too late in the cycle, so I am not going to take the 24/24 now.

> 
> since 18/24 also touch the smi code, I expect it could get Acked-by from
> you or Matthias, then Joerg could take it.

Sure. I acked it.

Best regards,
Krzysztof
