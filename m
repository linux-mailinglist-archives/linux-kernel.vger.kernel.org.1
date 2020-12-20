Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59D922DF687
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 19:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgLTSnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 13:43:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:33850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726470AbgLTSnt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 13:43:49 -0500
Content-Type: text/plain; charset="utf-8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608489788;
        bh=txSTanMz3B5hhIJNGnxdQxcgi9WHUwPCFDYaxgyHtRk=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DqtoSip1NMQMUegw2fUCkTL2siK7AAoyOsUAmB5h43wPqRsOl07+T+QGR7i9rbxNz
         0l1I8cDu3MwquECrhY4ShrShPSTGsmHQ+dwNKO1LDGq5JVJvtex9cZgQBpIz6CBnGK
         D/Db15kvrE8nvuPnTnbNKipQKdcLl2oaX7QqftQ54Uwswy+mJB65GwGDfqMdB+V50L
         WLEdcL+NMpOhZNT6Tf6PYuNWog4adpIlTYRv302XNQ4CrRpp4eURJVYCLm7HXzV6B6
         S77MnsO3OyjJeO8gJpqL0NlQV/3KASQwuKoVQmHVhbBR3Yp1zWPsRQ4WMuIIBn4vAP
         PuRCHLzkbV7/A==
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAFr9PXmAe9o5KtTG58twpumWi3A=7YfsM7b7pOwRTk1f=jCKQQ@mail.gmail.com>
References: <20201114135044.724385-1-daniel@0x0f.com> <20201114135044.724385-4-daniel@0x0f.com> <160843899675.1580929.13271525932327387602@swboyd.mtv.corp.google.com> <CAFr9PXmAe9o5KtTG58twpumWi3A=7YfsM7b7pOwRTk1f=jCKQQ@mail.gmail.com>
Subject: Re: [PATCH 3/6] clk: mstar: MStar/SigmaStar MPLL driver
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     DTML <devicetree@vger.kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
To:     Daniel Palmer <daniel@0x0f.com>
Date:   Sun, 20 Dec 2020 10:43:07 -0800
Message-ID: <160848978734.1580929.11702930284423878688@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Palmer (2020-12-19 22:42:40)
> > > +
> > > +static int msc313_mpll_remove(struct platform_device *pdev)
> > > +{
> > > +       struct msc313_mpll *mpll =3D platform_get_drvdata(pdev);
> > > +       int i;
> > > +
> > > +       for (i =3D 0; i < ARRAY_SIZE(output_dividers); i++)
> > > +               clk_hw_unregister_fixed_factor(to_divider_hw(mpll, i)=
);
> >
> > Maybe add a devm_ for this if it doesn't exist.
>=20
> I did think about adding this. Would I need to do that in a separate
> series or would it be ok to roll it into this one?
>=20

Can be part of the same series.
