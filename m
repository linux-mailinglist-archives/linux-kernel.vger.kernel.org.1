Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4191022163A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 22:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgGOU3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 16:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgGOU3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 16:29:10 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE90C061755;
        Wed, 15 Jul 2020 13:29:10 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id g139so1816974lfd.10;
        Wed, 15 Jul 2020 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OG18IIAWdYGY1ved21uUkHlDS0zbB3xs5Z/Iss2A2zY=;
        b=fc+A99XTLJkECSeMIWGgcJvL4X6HZopt8KlhrC+jkKqzA5VNkINaoY9IahPyYSFHNx
         h/FlZ6frj1CnqnUB15AyywUig907vkEcyDbfJAtitC9GylaKvGQ/07hJyxZxBR5wjgV5
         OM1YtvgoPeq7fSCt7vSSsUdgWURkpNW8w/WR0rnv3eGNuCIokKAIPqFGG0zSOJczjE42
         nfvzy08UhB5OAN14gSYM6xI8Yo0EmnHjR8LsVIy55OfBRG5WmCf6Y068oBbNeTW2ZOiO
         5MY1lN9dbfev0+mMn6TLKdXhA44QA5hyrE9ZWSvFzGnmPeia4A2ozvfz+81ySrNv5txK
         Rngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OG18IIAWdYGY1ved21uUkHlDS0zbB3xs5Z/Iss2A2zY=;
        b=rL7IhOIHnpSagpr+Hegjaa207Zqrz8bxD0vThcJ6nh4+oDhQN48xUNeElspueWm+TD
         Kzxlj/2L1aBLO/ibu2NNPVmMjYEGLwsEbTP4Ns4c92AVU5CMYS8s63Lsg0CVxE/XiEoA
         FO4q0EJz8SUDjN9X2Oyx1XK9tePzoHXFhkcNvK0kWveG0kjeAz/AyC5+ET6zWQYeiHKU
         faUwP76OY7DUVPLi1fEOkvwJ7iJK9Ffp9dyjbxlMEQcZV1GVTTSFgK36WpSIDNzx2x6J
         CcF0inrBudHAdOg86eaJHrBta65lJPchNMabomRZxIkhTHyaf6oTzzKRxezXRil87oDA
         e+gw==
X-Gm-Message-State: AOAM531nnXwt+EsbH4sby0yBwdy1yTP6mddANFQlI9DEKtzUbOkp8eMU
        vOkTm0oTXvcEmtZvoAMvk1mEbg0Mf3rPtEwRKtA=
X-Google-Smtp-Source: ABdhPJweCgmYoicpxKKiFHBEvM7lPrf1SLQQAsDeHqPjqYqi28G1zx1pfA/EduU9rdpS47mhUGb/UG6gE5zChOEpotk=
X-Received: by 2002:a19:7e09:: with SMTP id z9mr368732lfc.69.1594844948607;
 Wed, 15 Jul 2020 13:29:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200629114927.17379-1-bruno.thomsen@gmail.com>
 <20200629114927.17379-2-bruno.thomsen@gmail.com> <20200713025246.GY21277@dragon>
 <CAH+2xPAHKY6YfhO-jXfKN+TRN5LDT1Kkn8a8HUj_EOqFt=75nQ@mail.gmail.com>
 <CAOMZO5DsyqRgD8n-w=6OmnXuMX+1T2DDOjQLNK133=FaqtWXVQ@mail.gmail.com> <CAH+2xPD31bdb_ZjAi6qo5n25K469Ak-qt2GJCcppHk4FZChdeg@mail.gmail.com>
In-Reply-To: <CAH+2xPD31bdb_ZjAi6qo5n25K469Ak-qt2GJCcppHk4FZChdeg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 15 Jul 2020 17:28:57 -0300
Message-ID: <CAOMZO5A0QwTsoU1XPHX30r6TqsEBCTj4JLBaBstB1AcLdGURJw@mail.gmail.com>
Subject: Re: [PATCH 2/3] ARM: dts: imx7: add support for kamstrup flex concentrator
To:     Bruno Thomsen <bruno.thomsen@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Bruno Thomsen <bth@kamstrup.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bruno,

On Wed, Jul 15, 2020 at 11:22 AM Bruno Thomsen <bruno.thomsen@gmail.com> wrote:

> Thanks for the hints.
>
> Yes, the address is correct and configured with external resistors,
> but just realised that I wrote the wrong device name in the comment,
> it's actually KSZ8081RNB.
>
> Ethernet has been working with multiple mainline kernel versions
> (latest being 5.7.8)
> for the last year or so when using the DTS in patch. So I am pretty sure
> hardware and setup of mux is correct'ish.
>
> Kernel trace from patch version:
> kernel: Micrel KSZ8081 or KSZ8091 30be0000.ethernet-1:01: attached PHY driver
>  [Micrel KSZ8081 or KSZ8091] (mii_bus:phy_addr=30be0000.ethernet-1:01, irq=POLL)
>
> Error first occurs when switching from fec phy reset to mdio phy reset
> code path,
> I understand that the fec phy reset is obsolete as phy properties was wrongly
> added to the mac and of course should be part of the phy (separate chip).
>
> When debugging it I end up with the get_phy_device() call not working
> inside of_mdiobus_register_phy().

It would be nice if you could report this to the Ethernet PHY folks at
netdev@vger.kernel.org
