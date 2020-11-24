Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89DE92C1B04
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 02:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgKXBdg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 23 Nov 2020 20:33:36 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:45731 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgKXBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 20:33:35 -0500
Received: by mail-oi1-f181.google.com with SMTP id l206so21915488oif.12;
        Mon, 23 Nov 2020 17:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZKs0epO4y0vzJkUpneM2DbUUma/iS5r6bxhuQAlnKhI=;
        b=sadYCxL8CN7XyLfIKVEe6Bb9jBdXBhfoDqn5x3TG8PTPVN29YB8vVht38217K6Ci5s
         OhTZt/3XdmaoeNe78iOf4teZX2pUQ2q57A8lC2GPgUu76+g4ITUGjZNhWBtDSqeCMoUO
         pwyzCe1iyLl5zm3Qr4GstTBXGrORB3v5G+efKuSFkZnQnUuaEF0Yv/jOIMjPgV03qSuD
         MCvW1+v97fhiRib2CpUig65rPA+i/Dj+xfle0IJeu8vTht8c3orTcYaMzoM/1BdnWFDn
         n/7lQLI3cZd/1awY1T+4i3qo2VOWbiF7DXXuOekmjtBwTInnJHT106N1shirc98n7AxY
         Ujrg==
X-Gm-Message-State: AOAM531+wn5BafBQQ2lsjZWnlWuAt0peVsDqReCInEiwipJCWj7o1/Wd
        rLKMouoAe02sK59j6ZDvywNllzVRp10jsA==
X-Google-Smtp-Source: ABdhPJwA0+aHOWjISf64OBhT1xYsQYhUIliJKUDoch9rT4lB+dKORBdYPlaWNhFXFAJ5Dc81Dz8yAw==
X-Received: by 2002:a54:4f90:: with SMTP id g16mr1220317oiy.24.1606181613650;
        Mon, 23 Nov 2020 17:33:33 -0800 (PST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com. [209.85.167.175])
        by smtp.gmail.com with ESMTPSA id s193sm8486968oos.21.2020.11.23.17.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 17:33:32 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id o25so21997424oie.5;
        Mon, 23 Nov 2020 17:33:31 -0800 (PST)
X-Received: by 2002:aca:a896:: with SMTP id r144mr1234282oie.154.1606181610941;
 Mon, 23 Nov 2020 17:33:30 -0800 (PST)
MIME-Version: 1.0
References: <20201027044619.41879-1-biwen.li@oss.nxp.com> <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
 <DB6PR0401MB2438ED1C8F629CA1E1F469768F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB668790304253EAEEBC1B79F48F160@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <DB6PR0401MB2438DCABBF4892ECF599D4528F100@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB6687738526B56F3F0E6812C58F100@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <03dc38bb-b83a-7926-60dc-61152a3ac967@rasmusvillemoes.dk> <VE1PR04MB66876B8AF6F0D3C5A583BBDF8FEE0@VE1PR04MB6687.eurprd04.prod.outlook.com>
In-Reply-To: <VE1PR04MB66876B8AF6F0D3C5A583BBDF8FEE0@VE1PR04MB6687.eurprd04.prod.outlook.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Mon, 23 Nov 2020 19:33:18 -0600
X-Gmail-Original-Message-ID: <CADRPPNTXnRrsRaAX-zBcU9vPo37u7BCKfAtzGG=2_Ut4syZwJA@mail.gmail.com>
Message-ID: <CADRPPNTXnRrsRaAX-zBcU9vPo37u7BCKfAtzGG=2_Ut4syZwJA@mail.gmail.com>
Subject: Re: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 5:04 PM Leo Li <leoyang.li@nxp.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Sent: Tuesday, November 3, 2020 2:03 AM
> > To: Leo Li <leoyang.li@nxp.com>; Biwen Li (OSS) <biwen.li@oss.nxp.com>;
> > shawnguo@kernel.org; robh+dt@kernel.org; mark.rutland@arm.com; Z.q.
> > Hou <zhiqiang.hou@nxp.com>; tglx@linutronix.de; jason@lakedaemon.net;
> > maz@kernel.org
> > Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; Jiafei Pan
> > <jiafei.pan@nxp.com>; Xiaobo Xie <xiaobo.xie@nxp.com>; linux-arm-
> > kernel@lists.infradead.org
> > Subject: Re: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
> > external interrupt
> >
> > On 02/11/2020 22.22, Leo Li wrote:
> > >>>
> > >>> Where did you get this information that the register on LS1043 and
> > >>> LS1046 is bit reversed?  I cannot find such information in the RM.
> > >>> And does this mean all other SCFG registers are also bit reversed?
> > >>> If this is some information that is not covered by the RM, we
> > >>> probably should clarify it in the code and the commit message.
> > >> Hi Leo,
> > >>
> > >> I directly use the same logic to write the bit(field IRQ0~11INTP) of
> > >> the register SCFG_INTPCR in LS1043A and LS1046A.
> > >> Such as,
> > >> if I want to control the polarity of IRQ0(field IRQ0INTP, IRQ0 is
> > >> active low) of LS1043A/LS1046A, then I just need write a value 1 << (31 - 0)
> > to it.
> > >> The logic depends on register's definition in LS1043A/LS1046A's RM.
> > >
> > > Ok.  The SCFG_SCFGREVCR seems to be a one-off fixup only existed on
> > LS1021.  And it is mandatory to be bit_reversed according to the RM which is
> > already taken care of in the RCW.  So the bit reversed case should be the only
> > case supported otherwise a lot of other places for SCFG access should be
> > failed.
> > >
> > > I think we should remove the bit_reverse thing all together from the driver
> > for good.  This will prevent future confusion.  Rasmus, what do you think?
> >
> > Yes, all the ls1021a-derived boards I know of do have something like
> >
> > # Initialize bit reverse of SCFG registers
> > 09570200 ffffffff
> >
> > in their pre-boot-loader config file. And yes, the RM does say
> >
> >   This register must be written 0xFFFF_FFFF as a part of
> >   initialization sequence before writing to any other SCFG
> >   register.
> >
> > but nowhere does it say "or else...", nor a little honest addendum "because
> > we accidentally released broken silicon with this misfeature _and_ wrong
> > POR value".
>
> Yeah.  I do think they messed up at the beginning when trying to integrate the big endian registers on little endian core.  It is good that we are doing it correctly in later SoCs.
>
> >
> > Can we have an official statement from NXP stating that SCFGREVCR is a
> > hardware design bug? And can you send it through a time-machine so I had it
> > three years ago avoiding the whole "fsl,bit-reverse device-tree-property, no,
> > read the register if you're on a ls1021a and decide" hullabaloo.
>
> I'm not sure if it is possible to update the related documents right now for this.  But definitely it was not your fault to have introduced this in the driver due to the confusion from document.  My suggestion to remove it is just to prevent this from causing more confusions in the future as this driver is used on more SoCs.

Hi Biwen,

Would you send a new version of this patch?  Thanks.

Regards,
Leo
