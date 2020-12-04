Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D6F2CF1F2
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 17:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbgLDQax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 11:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDQax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 11:30:53 -0500
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B454C061A52;
        Fri,  4 Dec 2020 08:30:07 -0800 (PST)
Received: by mail-yb1-xb44.google.com with SMTP id r127so5893694yba.10;
        Fri, 04 Dec 2020 08:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=o0E9hyMQegMY7y2Xt42JrjVSKmSCRAPkJTu26LA8WAc=;
        b=DzLSDdyrj4yjyeId9YHJfRbDYKi7bAAdduRGLMcoCSNeLSg6qWYRaRcyJX94pk0ArO
         wBV8wO7+OLxQHTJHyxRD3MehAqiL9oEpcxLsHAbktrr5HdM1+9CwAwGsWwPFrBeZKel2
         50cV3wyqcQ9kYEEAO0SYiF4EH9MdahWejtcgE/4X4RZApNkoI36tOrUrqSfYptbbrRZo
         Dmp36nxkxN+sqOznaodpvEUk+wQXvKAyT2zvD2uFdc+P/FUheiUnS99w2BP+/Zon4SIn
         jFapG9AyDeqscWPRbRM0qOVljlCwRHPCZVffo79DYh79OuXBtKg/KfS0gDl8ndIfxH2H
         x7ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=o0E9hyMQegMY7y2Xt42JrjVSKmSCRAPkJTu26LA8WAc=;
        b=W8RtjQxacY11mgn5wM0zA3w68MORvskbVnO3rNkCBC7XODQhPrLtJv+pNFE5vtIF6W
         SjR2fbB/YUDQcEV8dfVc0GZqd6AcbEQfTvFB4jbpHwuIy4bQeF4PzDDnRZjOu3Sx0OJ6
         AYv1bFqUBJ1XIczaIGECzZsi5M5xzcL7MNH+Z0NCAmHbSp3feT8P75Gp8O40cwbtYC5U
         TShV9X1o5TBSy4JfwkjK204HShXPgJf0fFyFjeuj6FgKXtzA0MM2Qd27EncCFjlaUhb/
         LylDqkGnzTtadJaEDGYJ2FMwNXuWZwx3RmgX7a9Reto2RZrBFSth6B+xwi/OJ8+lO+rN
         sQcQ==
X-Gm-Message-State: AOAM530BfbQsRC0IdBHw3qof521bQPPwl5E6TsDSmCiEGLUVZw3iB/zC
        3Dvqh1HA0v0i6NNo2X83IthmdYULwweeFBGtszE=
X-Google-Smtp-Source: ABdhPJxilDCvcpVXLLdZ5kaZls0WGugTJrFBRW2YCYq1ZWHNsUGMW4t+LoWx02LcCI6pY8h87SEMxUVbD6E1pKvzOOA=
X-Received: by 2002:a25:4943:: with SMTP id w64mr6969708yba.317.1607099406430;
 Fri, 04 Dec 2020 08:30:06 -0800 (PST)
MIME-Version: 1.0
References: <20201204093704.11359-1-zajec5@gmail.com> <20201204093704.11359-2-zajec5@gmail.com>
 <f620c4aa8ca3ed10701c5fe050a2bed04ff759db.camel@pengutronix.de>
In-Reply-To: <f620c4aa8ca3ed10701c5fe050a2bed04ff759db.camel@pengutronix.de>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Fri, 4 Dec 2020 17:29:55 +0100
Message-ID: <CACna6rx16dkktfyESPNriwV1VQLYLw6sJPQjS8YQDMFey_zXzA@mail.gmail.com>
Subject: Re: [PATCH 2/2] reset: bcm4908-usb: add driver for BCM4908 USB reset controller
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Dec 2020 at 17:13, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> On Fri, 2020-12-04 at 10:37 +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> > From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> >
> > This controller is responsible for OHCI, EHCI, XHCI and PHYs setup that
> > has to be handled in the proper order.
> >
> > One unusual thing about this controller is that is provides access to
> > the MDIO bus. There are two registers (in the middle of block space)
> > responsible for that. For that reason this driver initializes regmap so
> > a proper MDIO driver can use them.
> >
> > Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> This doesn't look like a reset controller to me, but rather like
> something that belongs in drivers/usb.

I think I found the reset API to match the best setup requirements and
assumed it should be treated as a reset controller.

Any advice, idea, how should I integrate this driver with the USB
subsystem? Rested made it easy as all I needed was:

usb@c300 {
    compatible =3D "generic-ehci";
    reg =3D <0xc300 0x100>;
    interrupts =3D <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
    resets =3D <&usb_reset>;
};

--=20
Rafa=C5=82
