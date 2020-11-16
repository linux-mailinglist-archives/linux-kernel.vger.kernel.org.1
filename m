Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48D532B4A79
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731737AbgKPQNp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Nov 2020 11:13:45 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34347 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbgKPQNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:13:45 -0500
Received: by mail-wr1-f65.google.com with SMTP id r17so19314880wrw.1;
        Mon, 16 Nov 2020 08:13:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TiBrlRCI15rff/Wy8SUCXOuFom01xos98s3Zf+OsoY8=;
        b=HJ+y021caAvZTeHY6dtcfEWwKhjG8VYA1mhhFYR9zAmA9DPD49fqjlzwn5iVZXM/q0
         /FRLqI49zupNx+94XjeBef7VLPZKxl28ycbZZC2QRWAWvA+XAf2UKRYWzfBhiZtR2ujy
         HZyRBv4VEzekjTAHSQ3xLBUZrTCuZeM38hgnRy7teDs5dnkFZMdAGW7Ysq/9wwlxOngE
         JJ2JOoQosbefQ1WUGkF55BSv2+nXeL7mT9MWUqZReL2KyIucI3gsFR5VLNDYNo1s8I6z
         v13xz20twysGgZWeTH7aQQAYRlKM8nypO7yMHQ4nUXk6GCj/ItQPX7pJEIPFUYi8CT42
         v4Ag==
X-Gm-Message-State: AOAM530FmpGFsZ0/5bMCI+d1GQgJ6uLCT1JYhuykgw0n7NqN67LaizpK
        vmm+tiUXz15+gWgQ1U9NYiI=
X-Google-Smtp-Source: ABdhPJxEVpZHOstjss2BvVmXfoLehvX88HeBMF4Na+y7JvN2fejsZMWwbBwjPSP/WA8Q3bChRxueLw==
X-Received: by 2002:adf:db0f:: with SMTP id s15mr20323116wri.354.1605543222021;
        Mon, 16 Nov 2020 08:13:42 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i11sm24203233wro.85.2020.11.16.08.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 08:13:39 -0800 (PST)
Date:   Mon, 16 Nov 2020 17:13:38 +0100
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
Subject: Re: [EXT] Re: [PATCH v3 4/4] soc: imx8m: change to use platform
 driver
Message-ID: <20201116161338.GB25108@kozik-lap>
References: <20201113110409.13546-1-alice.guo@nxp.com>
 <20201113110409.13546-4-alice.guo@nxp.com>
 <20201114164128.GD14989@kozik-lap>
 <AM6PR04MB6053BFD5462C9AC405962095E2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <AM6PR04MB6053BFD5462C9AC405962095E2E30@AM6PR04MB6053.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 08:18:59AM +0000, Alice Guo wrote:
> 
> 
> > -----Original Message-----
> > From: Krzysztof Kozlowski <krzk@kernel.org>
> > Sent: 2020年11月15日 0:41
> > To: Alice Guo <alice.guo@nxp.com>
> > Cc: robh+dt@kernel.org; shawnguo@kernel.org; s.hauer@pengutronix.de;
> > dl-linux-imx <linux-imx@nxp.com>; Peng Fan <peng.fan@nxp.com>;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH v3 4/4] soc: imx8m: change to use platform driver
> > 
> > Caution: EXT Email
> > 
> > On Fri, Nov 13, 2020 at 07:04:09PM +0800, Alice Guo wrote:
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
> > > Old .dts files can also work.
> > >
> > > Signed-off-by: Alice Guo <alice.guo@nxp.com>
> > > ---
> > >  drivers/soc/imx/soc-imx8m.c | 89
> > > ++++++++++++++++++++++++++++++++-----
> > >  1 file changed, 79 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/drivers/soc/imx/soc-imx8m.c b/drivers/soc/imx/soc-imx8m.c
> > > index cc57a384d74d..af2c0dbe8291 100644
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
> > > +     u32 (*soc_revision)(struct device *dev, int flag);
> > >  };
> > >
> > >  static u64 soc_uid;
> > > @@ -50,7 +52,7 @@ static u32 imx8mq_soc_revision_from_atf(void)
> > >  static inline u32 imx8mq_soc_revision_from_atf(void) { return 0; };
> > > #endif
> > >
> > > -static u32 __init imx8mq_soc_revision(void)
> > > +static u32 __init imx8mq_soc_revision(struct device *dev, int flag)
> > >  {
> > >       struct device_node *np;
> > >       void __iomem *ocotp_base;
> > > @@ -75,9 +77,17 @@ static u32 __init imx8mq_soc_revision(void)
> > >                       rev = REV_B1;
> > >       }
> > >
> > > -     soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> > > -     soc_uid <<= 32;
> > > -     soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> > > +     if (flag) {
> > > +             int ret = 0;
> > > +
> > > +             ret = nvmem_cell_read_u64(dev, "soc_unique_id",
> > &soc_uid);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else {
> > > +             soc_uid = readl_relaxed(ocotp_base + OCOTP_UID_HIGH);
> > > +             soc_uid <<= 32;
> > > +             soc_uid |= readl_relaxed(ocotp_base + OCOTP_UID_LOW);
> > > +     }
> > >
> > >       iounmap(ocotp_base);
> > >       of_node_put(np);
> > > @@ -107,7 +117,7 @@ static void __init imx8mm_soc_uid(void)
> > >       of_node_put(np);
> > >  }
> > >
> > > -static u32 __init imx8mm_soc_revision(void)
> > > +static u32 __init imx8mm_soc_revision(struct device *dev, int flag)
> > >  {
> > >       struct device_node *np;
> > >       void __iomem *anatop_base;
> > > @@ -125,7 +135,15 @@ static u32 __init imx8mm_soc_revision(void)
> > >       iounmap(anatop_base);
> > >       of_node_put(np);
> > >
> > > -     imx8mm_soc_uid();
> > > +     if (flag) {
> > > +             int ret = 0;
> > > +
> > > +             ret = nvmem_cell_read_u64(dev, "soc_unique_id",
> > &soc_uid);
> > > +             if (ret)
> > > +                     return ret;
> > > +     } else {
> > > +             imx8mm_soc_uid();
> > > +     }
> > >
> > >       return rev;
> > >  }
> > > @@ -158,12 +176,21 @@ static __maybe_unused const struct of_device_id
> > imx8_soc_match[] = {
> > >       { }
> > >  };
> > >
> > > +static __maybe_unused const struct of_device_id imx8m_soc_match[] = {
> > 
> > Could this really be unused?
> 
> [Alice Guo] I will delete "__maybe_unused".
> 
> > 
> > > +     { .compatible = "fsl,imx8mq-soc", .data = &imx8mq_soc_data, },
> > > +     { .compatible = "fsl,imx8mm-soc", .data = &imx8mm_soc_data, },
> > > +     { .compatible = "fsl,imx8mn-soc", .data = &imx8mn_soc_data, },
> > > +     { .compatible = "fsl,imx8mp-soc", .data = &imx8mp_soc_data, },
> > > +     { }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, imx8m_soc_match);
> > 
> > You already have "imx8_soc_match" which covers imx8m and now you add
> > "imx8m_soc_match" which also covers imx8m. Such naming is a pure
> > confusion.
> > 
> 
> [Alice Guo] device_initcall is executed earlier than module_platform_driver. imx8_soc_init will judge
> whether there is "fsl,imx8mX-soc" in DTS file. If there is "fsl,imx8mX-soc", it will exit device_initcall and use module_platform_driver. The purpose is to be compatible with the old DTS file which does not have
> "fsl,imx8mX-soc".

I got it, but it's not what I was pointing out. Let me make it simpler:

  static const struct of_device_id imx8m_soc_match;
  static const struct of_device_id imx8_soc_match;

This is pure confusion in naming.

Based on this naming:
1. imx8m_soc_match means "matching only i.MX 8M SoCs",
2. imx8_soc_match means "match all of i.MX 8".

Totally different than what you wrote here and what you intend....

> 
> > > +
> > >  #define imx8_revision(soc_rev) \
> > >       soc_rev ? \
> > >       kasprintf(GFP_KERNEL, "%d.%d", (soc_rev >> 4) & 0xf,  soc_rev &
> > 0xf) : \
> > >       "unknown"
> > >
> > > -static int __init imx8_soc_init(void)
> > > +static int imx8_soc_init_flag(struct platform_device *pdev, int flag)
> > >  {
> > >       struct soc_device_attribute *soc_dev_attr;
> > >       struct soc_device *soc_dev;
> > > @@ -182,7 +209,10 @@ static int __init imx8_soc_init(void)
> > >       if (ret)
> > >               goto free_soc;
> > >
> > > -     id = of_match_node(imx8_soc_match, of_root);
> > > +     if (flag)
> > > +             id = of_match_node(imx8m_soc_match,
> > pdev->dev.of_node);
> > > +     else
> > > +             id = of_match_node(imx8_soc_match, of_root);
> > >       if (!id) {
> > >               ret = -ENODEV;
> > >               goto free_soc;
> > > @@ -192,7 +222,13 @@ static int __init imx8_soc_init(void)
> > >       if (data) {
> > >               soc_dev_attr->soc_id = data->name;
> > >               if (data->soc_revision)
> > > -                     soc_rev = data->soc_revision();
> > > +                     soc_rev = data->soc_revision(&pdev->dev, flag);
> > > +
> > > +             if (flag) {
> > > +                     ret = soc_rev;
> > > +                     if (ret < 0)
> > > +                             goto free_soc;
> > > +             }
> > >       }
> > >
> > >       soc_dev_attr->revision = imx8_revision(soc_rev); @@ -230,4
> > > +266,37 @@ static int __init imx8_soc_init(void)
> > >       kfree(soc_dev_attr);
> > >       return ret;
> > >  }
> > > +
> > > +static int __init imx8_soc_init(void) {
> > > +     int ret = 0, flag = 0;
> > > +
> > > +     if (of_find_compatible_node(NULL, NULL, "fsl,imx8mm-soc") ||
> > > +         of_find_compatible_node(NULL, NULL, "fsl,imx8mn-soc") ||
> > > +         of_find_compatible_node(NULL, NULL, "fsl,imx8mp-soc") ||
> > > +         of_find_compatible_node(NULL, NULL, "fsl,imx8mq-soc"))
> > 
> > Missing puts.
> > 
> > Don't duplicate the compatibles, iterate over existing structure... or see
> > comments below.  Maybe you could simplify it with something like
> > of_find_matching_node_and_match()... but check comments below.
> 
> [Alice Guo] I check comments below.
> 
> > 
> > > +             return 0;
> > > +
> > > +     ret = imx8_soc_init_flag(NULL, flag);
> > > +     return ret;
> > > +}
> > >  device_initcall(imx8_soc_init);
> > 
> > Where is the changelog? This was removed previously, now it stays...
> > 
> > After more thoughs, it looks you have kept it for the purpose of supporting
> > existing DTB, but it is not explained. Neither in the source code (which after
> > applying this patch looks confusing) nor in commit message.
> > 
> > In case of old DTB without fsl,imx8mm-soc-like compatibles, it would be better
> > to still register a platform driver and create a device
> > (of_platform_device_create())). However still this won't solve the problem of
> > actually missing device node... so maybe this double entry point is acceptable,
> > if properly explained.
> 
> [Alice Guo] Sorry, I will add changelog next time. Actually I wrote "Old .dts files can also work." in the commit.
> 
> device_initcall is executed earlier than module_platform_driver. imx8_soc_init will judge
> whether there is "fsl,imx8mX-soc" in DTS file. If there is "fsl,imx8mX-soc", it will exit device_initcall and use module_platform_driver. Can I keep double entry point?

If it is properly explained and there is no other way then yes, you
could. Here, for old DTBs, I would prefer to use
of_platform_device_create() and bind to "soc" node (child of root).
This way you would always have device and exactly one entry point for
the probe.

Best regards,
Krzysztof
