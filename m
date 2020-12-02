Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32E2CC6DB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 20:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731206AbgLBTlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 14:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbgLBTlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 14:41:23 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DA6C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 11:40:36 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id x16so6163603ejj.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 11:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=crULYJi4p/jXVyQA1BkXPNgMIZow3ARS4CNmHCzqmJc=;
        b=ZSuUGYB0kHb0yqllOF/t0iSz7mdjhDvc5DJIkARoUHChyNOJ4jDODNv/pogZvAEryd
         uB0laNfGz9U8oPPH7fYIdwztuItcVQluyJ5iVN8HI/BoQraKou8yadTdsC+6xW34axb4
         YAUbe3Pj6CrVjiR/lw7n7lsd+cbk4cNzAzm9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=crULYJi4p/jXVyQA1BkXPNgMIZow3ARS4CNmHCzqmJc=;
        b=o3pndApsWd3hWQSw/oC0A+/vT0X6s3khrPoYvGb+R1WDeoJGSOT68s6CRZiiJdj1ez
         v+roG2ZVLoLgAsoXi6I/KW+kACCmPKWoof7NXGpxAdl+riJ/5h9pS3rSJfPVVl9lBbrI
         JKbCllF8OwHSjyAbizRQB/p4ZRn3gHfnnGQYTTJo/+y44krTkw1a6Pj5Ho5tDB7ujz3N
         djJMuP1ImrVgz9XtQ/iWWVlKTcrmeGFSiT0YnLbvJ0dhCdIkOSjAYP+QROngPRC0iy50
         9DmbEhOJ0LxMNFYd4n1Xyf/oauBKffbuDMUeY668bBp4QN64plsVs7dzINPLXS71zeKw
         6Ygw==
X-Gm-Message-State: AOAM532QUXBeJjtbv0LufI9OIgBQzLwfcO8US8/U5GYGK5INo5EO11t2
        UcKJv6bqGVfIZVqt5YcmZHOrgHDI3uRzW7xQI3x92g==
X-Google-Smtp-Source: ABdhPJygob7NkjDHQyc9hGDXqpbedbGxN5jEXIyTbuxo+xEJ4+KCXFP86EL12XQitzoHNDS3gBb/87gWmLTneXNACY8=
X-Received: by 2002:a17:906:7d91:: with SMTP id v17mr1335587ejo.522.1606938035623;
 Wed, 02 Dec 2020 11:40:35 -0800 (PST)
MIME-Version: 1.0
References: <20201202121241.109952-1-jagan@amarulasolutions.com>
 <20201202121241.109952-5-jagan@amarulasolutions.com> <20201202173405.GD3490@kozik-lap>
 <CAMty3ZDg-7J9zk14Y-L1LBJsVnoK7KvposzBNnDP7gRdR3NHEQ@mail.gmail.com> <20201202193724.GB85884@kozik-lap>
In-Reply-To: <20201202193724.GB85884@kozik-lap>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 3 Dec 2020 01:10:24 +0530
Message-ID: <CAMty3ZC-4LTn8RKaRpb6YNogYMgkdopnohEL46P78-XSys48aQ@mail.gmail.com>
Subject: Re: [PATCH 04/10] arm64: dts: imx8mm: Add Engicam i.Core MX8M Mini SOM
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Matteo Lisi <matteo.lisi@engicam.com>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 1:07 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, Dec 03, 2020 at 01:00:59AM +0530, Jagan Teki wrote:
> > Hi Krzysztof,
> >
> > On Wed, Dec 2, 2020 at 11:04 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Wed, Dec 02, 2020 at 05:42:35PM +0530, Jagan Teki wrote:
> > > > i.Core MX8M Mini is an EDIMM SOM based on NXP i.MX8MM from Engicam.
> > >
> > > s/SOM/SoM/
> > >
> > > >
> > > > General features:
> > > > - NXP i.MX8MM
> > >
> > > i.MX 8M Mini
> > > as named by NXP:
> > > https://www.nxp.com/products/processors-and-microcontrollers/arm-processors/i-mx-applications-processors/i-mx-8-processors/i-mx-8m-mini-arm-cortex-a53-cortex-m4-audio-voice-video:i.MX8MMINI
> > >
> > > > - Up to 2GB LDDR4
> > > > - 8/16GB eMMC
> > > > - Gigabit Ethernet
> > > > - USB 2.0 Host/OTG
> > > > - PCIe Gen2 interface
> > > > - I2S
> > > > - MIPI DSI to LVDS
> > > > - rest of i.MX8MM features
> > >
> > > Ditto
> > >
> > > >
> > > > i.Core MX8M Mini needs to mount on top of Engicam baseboards for
> > > > creating complete platform boards.
> > > >
> > > > Possible baseboards are,
> > > > - EDIMM2.2
> > > > - C.TOUCH 2.0
> > >
> > > Don't describe baseboards. You add here only SoM.
> >
> > It's just information on how this SoM is being used. Let me know any
> > issues while explaining the combinations being used here.
>
> Don't describe baseboards. No point to blow up description. Include only
> information relevant to this patch.

It was my basic practice to include combination so-that users or
others can get to know. ie what I did for other SoC's. Yes, will
update here next versions.

Jagan.
