Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CA72817A3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 18:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbgJBQSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 12:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBQSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 12:18:08 -0400
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 183342085B;
        Fri,  2 Oct 2020 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601655487;
        bh=qKotbjg9kcKQ9kFUjGcF4Wc0HsTaB353+5mrYaSDDCQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KTqcRmGIxuBsugsYc3QNXyB43KgLKQ9zy7a0ZL2VLKTac+57x7+Da+cQjG5EWi9W5
         5RjT/V3wWUwLHhRblDOh0yp1QEVbVh2jNWWOyaFL3bJ+FgSncjBolK/2wF6P9ZP8Al
         Ga22xMjFzSc5fNnLr2MM9JAT+b9yEgFgZf1nBvwM=
Received: by mail-ed1-f41.google.com with SMTP id dn5so2224469edb.10;
        Fri, 02 Oct 2020 09:18:07 -0700 (PDT)
X-Gm-Message-State: AOAM533O9fmXzY2gkzaMXJkZ2HzcIc2LWQF2zIV/EV2dkPOgdAKSfsIt
        MoRDRK1d2VotZ+sqJ04402Do2SVkOnrrEO/jHg==
X-Google-Smtp-Source: ABdhPJyafmj/u0SG8QNpaP1VvSH+STsRaizRRbacdoCZ2+w+W/LvGvkYpsx/bWsJ+8QEICEnsr4GD7tdYTR68Pb/FQk=
X-Received: by 2002:a05:6402:d09:: with SMTP id eb9mr3131896edb.219.1601655485577;
 Fri, 02 Oct 2020 09:18:05 -0700 (PDT)
MIME-Version: 1.0
References: <1598497593-15781-1-git-send-email-neal.liu@mediatek.com>
 <1599028813.32069.1.camel@mtkswgap22> <1599640627.6370.3.camel@mtkswgap22>
 <1600246737.14155.3.camel@mtkswgap22> <1600758789.19001.4.camel@mtkswgap22> <1601449808.7564.2.camel@mtkswgap22>
In-Reply-To: <1601449808.7564.2.camel@mtkswgap22>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Sat, 3 Oct 2020 00:17:54 +0800
X-Gmail-Original-Message-ID: <CAAOTY__HA9W9jXSFTmZPxPeO_f1580ARDLcZO1hpX1p0a3+oUA@mail.gmail.com>
Message-ID: <CAAOTY__HA9W9jXSFTmZPxPeO_f1580ARDLcZO1hpX1p0a3+oUA@mail.gmail.com>
Subject: Re: [PATCH v7] Add MediaTek MT6779 devapc driver
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Neal:

You may find Matthias in IRC [1], the channel name is #linux-mediatek

[1] https://webchat.freenode.net/

Neal Liu <neal.liu@mediatek.com> =E6=96=BC 2020=E5=B9=B49=E6=9C=8830=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=883:10=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Hi Matt,
>
> Hope this mail could find you well.
> Is everything okay?
> It would be glad if you could reply me no matter the review status.
>
> Thanks
>
> -Neal
>
> On Tue, 2020-09-22 at 15:13 +0800, Neal Liu wrote:
> > Hi Matthias,
> >
> > We need this driver supported on main-line.
> > Could you save your time for us to review it?
> > Thanks
> >
> > -Neal
> >
> > On Wed, 2020-09-16 at 16:58 +0800, Neal Liu wrote:
> > > Hi Rob, Matthias, Chun-Kuang,
> > >
> > > Sorry for pushing you so hard.
> > > May I know is this patch set is comfortable to apply on latest kernel=
?
> > > Thanks
> > >
> > > -Neal
> > >
> > > On Wed, 2020-09-09 at 16:37 +0800, Neal Liu wrote:
> > > > Hi Rob, Matthias, Chun-Kuang,
> > > >
> > > > Please kindly let me know your comments about this patch set.
> > > > Thanks
> > > >
> > > > -Neal
> > > >
> > > > On Wed, 2020-09-02 at 14:40 +0800, Neal Liu wrote:
> > > > > Hi Rob, Matthias, Chun-Kuang,
> > > > >
> > > > > Gentle ping for this patch set.
> > > > > Thanks
> > > > >
> > > > > -Neal
> > > > >
> > > > > On Thu, 2020-08-27 at 11:06 +0800, Neal Liu wrote:
> > > > > > These patch series introduce a MediaTek MT6779 devapc driver.
> > > > > >
> > > > > > MediaTek bus fabric provides TrustZone security support and dat=
a protection to prevent slaves from being accessed by unexpected masters.
> > > > > > The security violation is logged and sent to the processor for =
further analysis or countermeasures.
> > > > > >
> > > > > > Any occurrence of security violation would raise an interrupt, =
and it will be handled by mtk-devapc driver.
> > > > > > The violation information is printed in order to find the murde=
rer.
> > > > > >
> > > > > > changes since v6:
> > > > > > - remove unnecessary mask/unmask module irq during ISR.
> > > > > >
> > > > > > changes since v5:
> > > > > > - remove redundant write reg operation.
> > > > > > - use static variable of vio_dbgs instead.
> > > > > > - add stop_devapc() if driver is removed.
> > > > > >
> > > > > > changes since v4:
> > > > > > - refactor data structure.
> > > > > > - merge two simple functions into one.
> > > > > > - refactor register setting to prevent too many function call o=
verhead.
> > > > > >
> > > > > > changes since v3:
> > > > > > - revise violation handling flow to make it more easily to unde=
rstand
> > > > > >   hardware behavior.
> > > > > > - add more comments to understand how hardware works.
> > > > > >
> > > > > > changes since v2:
> > > > > > - pass platform info through DT data.
> > > > > > - remove unnecessary function.
> > > > > > - remove slave_type because it always equals to 1 in current su=
pport SoC.
> > > > > > - use vio_idx_num instread of list all devices' index.
> > > > > > - add more comments to describe hardware behavior.
> > > > > >
> > > > > > changes since v1:
> > > > > > - move SoC specific part to DT data.
> > > > > > - remove unnecessary boundary check.
> > > > > > - remove unnecessary data type declaration.
> > > > > > - use read_poll_timeout() instread of for loop polling.
> > > > > > - revise coding style elegantly.
> > > > > >
> > > > > >
> > > > > > *** BLURB HERE ***
> > > > > >
> > > > > > Neal Liu (2):
> > > > > >   dt-bindings: devapc: add bindings for mtk-devapc
> > > > > >   soc: mediatek: add mt6779 devapc driver
> > > > > >
> > > > > >  .../bindings/soc/mediatek/devapc.yaml         |  58 ++++
> > > > > >  drivers/soc/mediatek/Kconfig                  |   9 +
> > > > > >  drivers/soc/mediatek/Makefile                 |   1 +
> > > > > >  drivers/soc/mediatek/mtk-devapc.c             | 305 ++++++++++=
++++++++
> > > > > >  4 files changed, 373 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/soc/media=
tek/devapc.yaml
> > > > > >  create mode 100644 drivers/soc/mediatek/mtk-devapc.c
> > > > > >
> > > > >
> > > > >
> > > >
> > > >
> > >
> > >
> >
> >
>
