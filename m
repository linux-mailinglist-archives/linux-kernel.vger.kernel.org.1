Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56526AB5C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgIORk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 13:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:49958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbgIORP6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:15:58 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FDA820809;
        Tue, 15 Sep 2020 16:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600188731;
        bh=TRdtoop1VJmdXleby80Gzo52XfpAZXVmNoC3tYdvNEk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UEoss78KVLFCCMnEiRW2BWiTvow+cEu9uR6dA8kY8bW26flU8Nx8jv3cjnvMSkYJr
         SoaptaQCJGLi5ipiRysT6+J/RlKcbRlBE9rbKIzHez7Z28nZZYYBBzxu+QJF5b41tf
         aCVW8JrYquK+8/Eva8gLP8p+ybaIlhh3gK0vudPU=
Received: by mail-oi1-f171.google.com with SMTP id x69so4621255oia.8;
        Tue, 15 Sep 2020 09:52:11 -0700 (PDT)
X-Gm-Message-State: AOAM530Roorq8LjTyuV4KbIpdxygzT287QXR97lf8MwXXnreu0hi2cc0
        vFOG8aaFk21w90mSd1zBGVd6QY3G/h0QeJJC+g==
X-Google-Smtp-Source: ABdhPJzLHNlZNoyuZ6Z1PYnZ+IZasQnM2nHLrBajhxJ04YUuo20bpQujO5UgpocSo/Akl/Bzud6CQRQ2IWm7hW5n7x8=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr249688oii.106.1600188730814;
 Tue, 15 Sep 2020 09:52:10 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599214329.git.mchehab+huawei@kernel.org>
 <58d6b31d0134448a35c47e822c887e994164228b.1599214329.git.mchehab+huawei@kernel.org>
 <CAL_Jsq+e44-_AFqKEkUAKKWapMB7wHCPDCtuWrPvn__NMpNxOw@mail.gmail.com> <20200910073738.0d472fde@coco.lan>
In-Reply-To: <20200910073738.0d472fde@coco.lan>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Sep 2020 10:51:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK35cNgibV6ajQABCAMsPe+BvL1nOU51XPW-sdfVMgqDA@mail.gmail.com>
Message-ID: <CAL_JsqK35cNgibV6ajQABCAMsPe+BvL1nOU51XPW-sdfVMgqDA@mail.gmail.com>
Subject: Re: [RFC 03/10] phy: hisilicon: phy-hi3670-usb3: use a consistent namespace
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linuxarm <linuxarm@huawei.com>, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Yu Chen <chenyu56@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 9, 2020 at 11:37 PM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> Em Wed, 9 Sep 2020 14:15:59 -0600
> Rob Herring <robh+dt@kernel.org> escreveu:
>
> > On Fri, Sep 4, 2020 at 4:23 AM Mauro Carvalho Chehab
> > <mchehab+huawei@kernel.org> wrote:
> > >
> > > Rename hikey970 to hi3670, in order to use a namespace
> > > similar to hi3660 driver.
> > >
> > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > ---
> > >  .../bindings/phy/phy-hi3670-usb3.txt          |  4 +-
> >
> > Bindings should be a separate patch.
>
> Ok. I'll split it.
>
> >
> > >  drivers/phy/hisilicon/phy-hi3670-usb3.c       | 98 +++++++++----------
> > >  2 files changed, 51 insertions(+), 51 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> > > index 4cb02612ff23..2fb27cb8beaf 100644
> > > --- a/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> > > +++ b/Documentation/devicetree/bindings/phy/phy-hi3670-usb3.txt
> > > @@ -2,7 +2,7 @@ Hisilicon Kirin970 usb PHY
> > >  -----------------------
> > >
> > >  Required properties:
> > > -- compatible: should be "hisilicon,kirin970-usb-phy"
> > > +- compatible: should be "hisilicon,hi3670-usb-phy"
> >
> > Unless this is unused, we can't just change it. It's an ABI.
>
> From upstream PoV, this binding is for a new driver that will be added
> via this patchset.

Please squash this change then.

Rob
