Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 557A02F5C77
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 09:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbhANIcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 03:32:10 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:23306 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbhANIcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 03:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610613128; x=1642149128;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JdFPeE/l+6oVP52mWPfJv7T665TGCntZYpFZmlJQSeE=;
  b=Bvn+/V1SyENSYSWfARlWwDgH2aGF387oZTVy+yaNvrfvi3AKJHpA3w7Z
   aSaf9sqClDspO0nnVtzJRXXVehN/p6NwmwZ9nXitI/P+pU3mFu0cOxOEE
   LwCnf+S5OLtxBMSN38YlRpOBTNXxqMxLBh6wCSaIP0EmQq3jF5RqEqnwF
   GrRpCTeMH+g+gy4GP/hleBP8KDnWiRhPxsmEV2yFl4SL+lg7y9fmFSGT8
   vpAHu50Jf449PlNcTGlkhSRIay46H9QvzUlunwsCJx3WoRd4CIkB1xpZ4
   p+nfRUJtrd+H+w8Qhp7SK1MkM6Ylj5nTx+GXOqFHw1D0tE6a32jmu45k1
   A==;
IronPort-SDR: dXauAlr+AXgzq2eYLiqHwHSVeD9fp5GC37v27LFnQ1H6RVE0S6qTA+ZlvvNY2S76gg2AH+d4/6
 EtbZZ4uPmT55SKOBAPKm8wctTSNxlAhSc7JJ1mvLLq7xxnVrIEdYqvLew7HHBag2bJSnMV2ptN
 Yi4/rmX/WtYp1GQ6jBuUTtw+3azrPbfFm29rHonDSLEobbgRxQ/Z7snUl6ljXr6EWATDv/3UQF
 5YLjWniCCJhuSwPbBPzxw1OhqQoKLkBUh9tjCstu6zY6J/Kmt7xMfZz87cqEetCyHiukn8Zqkf
 Xwc=
X-IronPort-AV: E=Sophos;i="5.79,346,1602572400"; 
   d="scan'208";a="105945136"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jan 2021 01:30:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 14 Jan 2021 01:30:53 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 14 Jan 2021 01:30:51 -0700
Message-ID: <da90b66306269564b5e7dc0c4c5fde9c087bb1c4.camel@microchip.com>
Subject: Re: [PATCH 2/3] reset: mchp: sparx5: add switch reset driver
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Andrew Lunn <andrew@lunn.ch>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        "Microchip Linux Driver Support" <UNGLinuxDriver@microchip.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Thu, 14 Jan 2021 09:30:50 +0100
In-Reply-To: <X/+BBaYqLciJ5PsA@lunn.ch>
References: <20210113201915.2734205-1-steen.hegelund@microchip.com>
         <20210113201915.2734205-3-steen.hegelund@microchip.com>
         <X/+BBaYqLciJ5PsA@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-01-14 at 00:23 +0100, Andrew Lunn wrote:
> EXTERNAL EMAIL: Do not click links or open attachments unless you
> know the content is safe
> 
> > +static int sparx5_switch_reset(struct reset_controller_dev *rcdev,
> > +                                   unsigned long id)
> > +{
> > +     struct mchp_reset_context *ctx =
> > +             container_of(rcdev, struct mchp_reset_context,
> > reset_ctrl);
> > +     u32 val;
> > +
> > +     /* Make sure the core is PROTECTED from reset */
> > +     regmap_update_bits(ctx->cpu_ctrl, PROTECT_REG, PROTECT_BIT,
> > PROTECT_BIT);
> > +
> > +     dev_info(ctx->dev, "soft reset of switchcore\n");
> 
> dev_dbg()?

I will remove that.
> 
> > +
> > +     /* Start soft reset */
> > +     regmap_write(ctx->gcb_ctrl, SOFT_RESET_REG, SOFT_RESET_BIT);
> > +
> > +     /* Wait for soft reset done */
> > +     return read_poll_timeout(sparx5_read_soft_rst, val,
> > +                              (val & SOFT_RESET_BIT) == 0,
> > +                              1, 100, false,
> > +                              ctx);
> > +}
> 
> > +static int mchp_sparx5_reset_config(struct platform_device *pdev,
> > +                                 struct mchp_reset_context *ctx)
> > +{
> > +     struct device_node *dn = pdev->dev.of_node;
> > +     struct regmap *cpu_ctrl, *gcb_ctrl;
> > +     struct device_node *syscon_np;
> > +     int err;
> > +
> > +     syscon_np = of_parse_phandle(dn, "syscons", 0);
> > +     if (!syscon_np)
> > +             return -ENODEV;
> > +     cpu_ctrl = syscon_node_to_regmap(syscon_np);
> > +     if (IS_ERR(cpu_ctrl))
> > +             goto err_cpu;
> > +     of_node_put(syscon_np);
> > +
> > +     syscon_np = of_parse_phandle(dn, "syscons", 1);
> > +     if (!syscon_np)
> > +             return -ENODEV;
> > +     gcb_ctrl = syscon_node_to_regmap(syscon_np);
> > +     if (IS_ERR(gcb_ctrl))
> > +             goto err_gcb;
> > +     of_node_put(syscon_np);
> > +
> > +     ctx->cpu_ctrl = cpu_ctrl;
> > +     ctx->gcb_ctrl = gcb_ctrl;
> > +
> > +     ctx->reset_ctrl.owner = THIS_MODULE;
> > +     ctx->reset_ctrl.nr_resets = 1;
> > +     ctx->reset_ctrl.ops = &sparx5_reset_ops;
> > +     ctx->reset_ctrl.of_node = dn;
> > +
> > +     err = devm_reset_controller_register(&pdev->dev, &ctx-
> > >reset_ctrl);
> > +     if (err)
> > +             dev_err(&pdev->dev, "could not register reset
> > controller\n");
> > +     pr_info("%s:%d\n", __func__, __LINE__);
> > +     return err;
> > +err_cpu:
> > +     of_node_put(syscon_np);
> > +     dev_err(&pdev->dev, "No cpu syscon map\n");
> > +     return PTR_ERR(cpu_ctrl);
> > +err_gcb:
> > +     of_node_put(syscon_np);
> > +     dev_err(&pdev->dev, "No gcb syscon map\n");
> > +     return PTR_ERR(gcb_ctrl);
> 
> It would be normal to put the dev_err() before the goto, set err =
> PTR_ERR() and then goto out;

OK. I will change that.

> 
> 
> > +}
> > +
> > +static int mchp_sparx5_reset_probe(struct platform_device *pdev)
> > +{
> > +     struct device *dev = &pdev->dev;
> > +     struct mchp_reset_context *ctx;
> > +
> > +     pr_info("%s:%d\n", __func__, __LINE__);
> 
> More left over debug.

Yes. That will have to go.

> 
> > +     ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> > +     if (!ctx)
> > +             return -ENOMEM;
> > +     ctx->dev = dev;
> > +     return mchp_sparx5_reset_config(pdev, ctx);
> > +}
> > +
> > +static const struct of_device_id mchp_sparx5_reset_of_match[] = {
> > +     {
> > +             .compatible = "microchip,sparx5-switch-reset",
> > +     },
> > +     { /*sentinel*/ }
> > +};
> 
> > +static int __init mchp_sparx5_reset_init(void)
> > +{
> > +     return platform_driver_register(&mchp_sparx5_reset_driver);
> > +}
> > +
> > +postcore_initcall(mchp_sparx5_reset_init);
> 
> Does it actually need to be postcore? The users of the reset should
> look for -EPROBE_DEFER and try again later. And this then becomes
> just
> a normal driver.

I tried using that, but the SGPIO driver bailed out after 3 DEFER
attempts, so that is why I changed it to use the postcore_initcall.
Maybe it is because the SGPIO driver is a builtin_platform_driver?

> 
>   Andrew


