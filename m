Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2B92A9E72
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 21:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728361AbgKFUH7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Nov 2020 15:07:59 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:37751 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFUH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 15:07:58 -0500
Received: by mail-ej1-f65.google.com with SMTP id gn41so3615432ejc.4;
        Fri, 06 Nov 2020 12:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=miMzAdzK7l/VDCyRoAtX/qCr20WyKkc7f4KwRBZjnb0=;
        b=EyvgqKEBP1lnrwuJwMmoRyciklOA/hCMai+cvjXmFUzQ49IksjaAo3/T5sbXW3faVD
         xXPDlUhqQ+Bsws4p8vgW7x3p432ArGunPsiVi889lXIdkgyFklH+nlcV2Tg98F+1fJhS
         V0ej7RHJsAsc/MwuaegXaREwkjvgvMMBxT1u0alxKnbKPbBiER3wd7DEWWYkDrX4kHsE
         XOoTqfh0e1kRIOFZu82+faNJaRw+XI7myvdH/kgVJDCmFqS1inxKEU0G62jb2nMmMpxj
         w5gwz2WZ2Fz7A+/YGAXrcD8StyTr0+jK/BMCOopZj62Fd+hUNWaUi4r0gwelyrVncFAq
         CKNw==
X-Gm-Message-State: AOAM533FZlD5dklvxOwKjWYJ839uqRacd6ffGj53Q+qaoaoruiWjK6so
        CnwjGrCrR1d53nUWkStW0u8=
X-Google-Smtp-Source: ABdhPJwpubBCR0SJXLyJzTUHxD1rZSvTYVYQ8PyWvCJFuE8mKBbtWV8AQBWgL/7N0a3+qpV6JCuOyQ==
X-Received: by 2002:a17:906:1a0b:: with SMTP id i11mr3894421ejf.404.1604693276162;
        Fri, 06 Nov 2020 12:07:56 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id a1sm1814522edk.52.2020.11.06.12.07.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 12:07:55 -0800 (PST)
Date:   Fri, 6 Nov 2020 21:07:53 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Alice Guo <alice.guo@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [EXT] Re: [PATCH v2 4/4] soc: imx8m: change to use platform
 driver
Message-ID: <20201106200753.GA332342@kozik-lap>
References: <20201105072629.24175-1-alice.guo@nxp.com>
 <20201105072629.24175-4-alice.guo@nxp.com>
 <20201105090628.GA75895@kozik-lap>
 <DB8PR04MB70652AFEF3A44361F5EE1E9DE2ED0@DB8PR04MB7065.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <DB8PR04MB70652AFEF3A44361F5EE1E9DE2ED0@DB8PR04MB7065.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 10:35:35AM +0000, Alice Guo wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年11月5日 17:06
> > To: Alice Guo <alice.guo@nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v2 4/4] soc: imx8m: change to use platform driver
> > 
> > Caution: EXT Email
> > 
> > On Thu, Nov 05, 2020 at 03:26:29PM +0800, Alice Guo wrote:
> > > Directly reading ocotp register depends on that bootloader enables
> > > ocotp clk, which is not always effective, so change to use nvmem API.
> > > Using nvmem API requires to support driver defer probe and thus change
> > > soc-imx8m.c to use platform driver.
> > >
> > > The other reason is that directly reading ocotp register causes kexec
> > > kernel hang because the 1st kernel running will disable unused clks
> > > after kernel boots up, and then ocotp clk will be disabled even if
> > > bootloader enables it. When kexec kernel, ocotp clk needs to be
> > > enabled before reading ocotp registers, and nvmem API with platform
> > > driver supported can accomplish this.
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > >  drivers/soc/imx/soc-imx8m.c | 75
> > > +++++++++++++++++++++----------------
> > >  1 file changed, 42 insertions(+), 33 deletions(-)
> > >
> > > diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> > > index cc57a384d74d..83f3297509be 100644
> > > --- a/drivers/soc/imx/soc-imx8m.c
> > > +++ b/drivers/soc/imx/soc-imx8m.c
> > > @@ -5,6 +5,8 @@
> > >
> > >  #include <linux/init.h>
> > >  #include <linux/io.h>
> > > +#include <linux/module.h>
> > > +#include <linux/nvmem-consumer.h>
> > >  #include <linux/of_address.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/sys_soc.h>
> > > @@ -29,7 +31,7 @@
> > >
> > >  struct imx8_soc_data {
> > >       char *name;
> > > -     u32 (*soc_revision)(void);
> > > +     u32 (*soc_revision)(struct device *dev);
> > >  };
> > >
> > >  static u64 soc_uid;
> > > @@ -50,12 +52,15 @@ static u32 imx8mq_soc_revision_from_atf(void)
> > >  static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
> > > #endif
> > >
> > > -static u32 __init imx8mq_soc_revision(void)
> > > +static u32 __init imx8mm_soc_uid(struct device *dev);
> > > +
> > > +static u32 __init imx8mq_soc_revision(struct device *dev)
> > >  {
> > >       struct device_node *np;
> > >       void __iomem *ocotp_base;
> > >       u32 magic;
> > >       u32 rev;
> > > +     int ret = 0;
> > >
> > >       np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-ocotp");
> > >       if (!np)
> > > @@ -75,9 +80,9 @@ static u32 __init imx8mq_soc_revision(void)
> > >                       rev = REV_B1;
> > >       }
> > >
> > > -     soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> > > -     soc_uid <<= 32;
> > > -     soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> > > +     ret = imx8mm_soc_uid(dev);
> > > +     if (ret)
> > > +             return ret;
> > >
> > >       iounmap(ocotp_base);
> > >       of_node_put(np);
> > > @@ -85,33 +90,20 @@ static u32 __init imx8mq_soc_revision(void)
> > >       return rev;
> > >  }
> > >
> > > -static void __init imx8mm_soc_uid(void)
> > > +static u32 __init imx8mm_soc_uid(struct device *dev)
> > >  {
> > > -     void __iomem *ocotp_base;
> > > -     struct device_node *np;
> > > -     u32 offset = of_machine_is_compatible("fsl,imx8mp") ?
> > > -                  IMX8MP_OCOTP_UID_OFFSET : 0;
> > > -
> > > -     np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-ocotp");
> > > -     if (!np)
> > > -             return;
> > > -
> > > -     ocotp_base = of_iomap(np, 0);
> > > -     WARN_ON(!ocotp_base);
> > > -
> > > -     soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH + offset);
> > > -     soc_uid <<= 32;
> > > -     soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW + offset);
> > > +     int ret = 0;
> > >
> > > -     iounmap(ocotp_base);
> > > -     of_node_put(np);
> > > +     ret = nvmem_cell_read_u64(dev, "soc_unique_id", &soc_uid);
> > > +     return ret;
> > >  }
> > >
> > > -static u32 __init imx8mm_soc_revision(void)
> > > +static u32 __init imx8mm_soc_revision(struct device *dev)
> > >  {
> > >       struct device_node *np;
> > >       void __iomem *anatop_base;
> > >       u32 rev;
> > > +     int ret;
> > >
> > >       np = of_find_compatible_node(NULL, NULL, "fsl,imx8mm-anatop");
> > >       if (!np)
> > > @@ -125,7 +117,9 @@ static u32 __init imx8mm_soc_revision(void)
> > >       iounmap(anatop_base);
> > >       of_node_put(np);
> > >
> > > -     imx8mm_soc_uid();
> > > +     ret = imx8mm_soc_uid(dev);
> > > +     if (ret)
> > > +             return ret;
> > 
> > I think this breaks old existing DTBs. If applied on separate branch than DTS
> > patches, it will cause bisect regressions. Regardless of it, all out-of-tree
> > (customer DTBs) will start failing here as well.
> > 
> > Best regards,
> > Krzysztof
> > 
> > 
> [Alice Guo] Compatible with old existing DTBs, I did not find a good solution. I want to use soc device to match this driver. Do you have some suggestions? Thank you.

How the change above (returning imx8mm_soc_uid error value) and few
others similar are related to topic mentioned in commit msg?

The patch should implement only one thing (one feature or fix one bug)
and then it is easier to manage ABI breakage.

For the ABI breakage, the usual solution is to support old DTBs.

Best regards,
Krzysztof
