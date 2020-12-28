Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729D62E66FB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633230AbgL1QTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 11:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633219AbgL1QTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 11:19:10 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3DAC061793
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 08:18:30 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d17so14776546ejy.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 08:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TOPSXu09PYTsiu/Wdh2HSg+eyyVEEi2NvtnN4/vv3Wg=;
        b=SAuHeVN65tID5NqatUXbrkPK84oWTgv369sJyXjv6OiZVCwsjkMvIpx6urKsXLjIvA
         PQnDVKgO3PhNKLa0B0ufpvE0awZxc7LMUvc6WdIy+nHv4t+cl0BMEqVHs/XIWYvjgP4V
         R+oxDoX5BXorOMNmPZRnt9tb/s+Pya8Xd5R4jLKN4+zgZKmZxQDYg1n8+B4M7+boU1Y0
         lkj1lNWzFdiO1rp5Qg0K50xtgz/bmgAttfAWENmENfzfgMBushQR6Xwi59C+dbl5z/gD
         zoSYtGSUlRyyYPb8xlcLyLQK8ImgQEZx+dnEWNxJMA8sr2Dj3PUTNDXLzp6zznbh5XaT
         YFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TOPSXu09PYTsiu/Wdh2HSg+eyyVEEi2NvtnN4/vv3Wg=;
        b=dRVyTPjsOXIpH76PMeB3EljdG/aL2ludt7e50up7UQWwLTjAXS+RbBVRwnI0xR4DRi
         nFAKiEiTa0/iCKzBOdlxVSZXUduqbOPEZyGuEJxyVNhl07+6FoQLWZ9pLPMo99X7uvjr
         DO4lSl5zIWOOLR71aAShF33hNC3FtYdzvCxnS7CnrwcElcFe5foRtw4Hc9+e1LhFP9JL
         qQDNi4XnEnLTPKdBw7voEmVy03Dat3oOKI57GNK4AYcQwlPYwimoSA33mAXOI4TQ3V2O
         NhXZh5hZogF3onelDkMPjRDUzihXkyL0Mw78jLUdWv2WJelGSj7ZGa9wYiUYykM4B4Ti
         yrAw==
X-Gm-Message-State: AOAM532vl5gq3imBYsmXHoRTl3YigaKL1DrRZwc/cHtBrsnn0U4+gUJB
        LeLgu8PrFKxyq4ND3AZ5FXOM2W6SNoIfVYp2Fm8L2Q==
X-Google-Smtp-Source: ABdhPJzpGxgLX1x1kHX5FmBn5e3K0N3tgN2POjPbGkgKYNPn7agrr/SlgWVd+qedEODn+u5XsCI1WNi9lz6D9jhJ8LA=
X-Received: by 2002:a17:907:3e23:: with SMTP id hp35mr42624451ejc.254.1609172308970;
 Mon, 28 Dec 2020 08:18:28 -0800 (PST)
MIME-Version: 1.0
References: <1608762196-29871-1-git-send-email-tharvey@gateworks.com> <20201224112335.GA15628@kozik-lap>
In-Reply-To: <20201224112335.GA15628@kozik-lap>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 28 Dec 2020 08:18:17 -0800
Message-ID: <CAJ+vNU0cEvMMFQXmO9KOG3WR4Cu1E+o1XSWv8xx35ALeZ=pzzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add binding for Gateworks
 boards with IMX8MM
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 3:23 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Wed, Dec 23, 2020 at 02:23:15PM -0800, Tim Harvey wrote:
> > Add bindings for the Gateworks Venice Development kit boards with
> > IMX8MM System on Module.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  Documentation/devicetree/bindings/arm/fsl.yaml | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> > index 1ca9dfa..705c6e8 100644
> > --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> > +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> > @@ -405,6 +405,9 @@ properties:
> >                - beacon,imx8mm-beacon-kit  # i.MX8MM Beacon Development Kit
> >                - fsl,imx8mm-ddr4-evk       # i.MX8MM DDR4 EVK Board
> >                - fsl,imx8mm-evk            # i.MX8MM EVK Board
> > +              - gw,imx8mm-gw71xx-0x       # i.MX8MM Gateworks Development Kit
> > +              - gw,imx8mm-gw72xx-0x       # i.MX8MM Gateworks Development Kit
> > +              - gw,imx8mm-gw73xx-0x       # i.MX8MM Gateworks Development Kit
>
> I think you should skip the wildcards in compatible and choose one
> specific compatible. What if at some point you would like to add gw,imx8mm-gw7113-0x?
>

Krzysztof,

Thanks for the review. I do want the wildcards as above because they
represent model variations that do not affect device-tree such as
component subloads.

Thanks,

Tim
