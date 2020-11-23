Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 465A72C12F7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbgKWSRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:17:20 -0500
Received: from mout01.posteo.de ([185.67.36.65]:56793 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730411AbgKWSRU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:17:20 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 52C7A160062
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 19:17:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1606155436; bh=uM4mhoEXL0X55Ea62u8P7JUtCQuPczUSf74FTKMSTfg=;
        h=Date:From:To:Cc:Subject:From;
        b=hoBZ/Y7VgULw7p4J/qCy/XXKIXDXwZW4dnPWBfZhQJ7fCpA22cCZbSX0061UYCA6w
         NGNEK4XYkm0haO5tJElHKv6FrwBRvjedy+VwoMt1n1LcKnzudnowZSOwXtBP9pAeAS
         0w8wk1C4bDkCGFAkBOswbAuB9D1ir5A9TCVyQ0HvARRLzKdw10jiKL2+sTLcSUdFh9
         LxXSKo2BpXI+a86rBfhY3egUqUp254tk/mET1in/GteLfJ+4bTQTqLQ/O6Y5isLDU2
         UFj9B+mumfTuk6dYkABX2pXCbA1Vhve8hXo6w8xedRSSte8O09rAgYc5Hh4l5YbaSj
         TwT3SrQHUC3ng==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4CfwNV0GnZz9rxV;
        Mon, 23 Nov 2020 19:17:13 +0100 (CET)
Date:   Mon, 23 Nov 2020 19:17:12 +0100
From:   Wilken Gottwalt <wilken.gottwalt@posteo.net>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH 2/2] hwspinlock: add sunxi hardware spinlock support
Message-ID: <20201123191712.72484b19@monster.powergraphx.local>
In-Reply-To: <20201122051900.GH807@yoga>
References: <cover.1605693132.git.wilken.gottwalt@posteo.net>
        <149526a0ba8d18ebb68baa24e95d946ede90b4c0.1605693132.git.wilken.gottwalt@posteo.net>
        <20201122051900.GH807@yoga>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Nov 2020 23:19:00 -0600
Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> > +static int hwlocks_inuse_show(struct seq_file *seqf, void *unused)
> > +{
> > +	struct sunxi_hwspinlock_data *priv = seqf->private;
> > +	int inuse;
> > +
> > +	/* getting the status of only the main 32 spinlocks is supported */
> > +	inuse = hweight32(readl(priv->io_base + SPINLOCK_STATUS_REG));
> 
> So this returns how many of the locks are taken? How is that useful?

It is a way to see if locks were taken from linux or the arisc core without
touching the actual hwspinlock abi or the locks. So it is a nice way to debug
hwspinlocks, hence it is part of debugfs.

> > +	seq_printf(seqf, "%d\n", inuse);
> > +
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(hwlocks_inuse);
> > +
> > +static void sunxi_hwspinlock_debugfs_init(struct sunxi_hwspinlock_data *priv)
> > +{
> > +	char name[32];
> > +
> > +	scnprintf(name, sizeof(name), "%s", DRIVER_NAME);
> 
> Why not just pass DRIVER_NAME directly to debugfs_create_dir()?

Uuuh, you're right, that wasn't very clever. I think I changed the name creation
to something simpler and and just missed most obvious one.

> > +static int sunxi_hwspinlock_probe(struct platform_device *pdev)
> > +{
> > +	struct device_node *node = pdev->dev.of_node;
> 
> I don't see a need for this, or the check to fail if it's NULL. Please
> remove it.

Yeah, will remove it.

> > +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> > +	if (!priv)
> > +		return -ENOMEM;
> > +
> > +	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
> 
> Please use devm_platform_ioremap_resource() instead.

Hmm, so there is a platform version of it, too. Will change it.

> > +	priv->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
> > +	if (IS_ERR(priv->reset)) { > +		err = PTR_ERR(priv->reset);
> > +		if (err == -EPROBE_DEFER)
> > +			return err;
> > +
> > +		dev_info(&pdev->dev, "no optional reset control available (%d)\n", err);
> 
> In the even that no "ahb" reset is specified priv->reset is NULL, as
> such if you get here there's something wrong - so it's better to fail
> here.
> 
> And you can use the convenient dev_err_probe() function to deal with the
> EPROBE_DEFER.
> 
> > +		priv->reset = NULL;
> > +	}
> > +
> > +	if (priv->reset) {
> 
> It's perfectly fine to call reset_control_deassert(NULL); so you can
> omit this check.

Also will update these.

> > +	/* bit 28 and 29 hold the amount of spinlock banks */
> > +	num_banks = (readl(priv->io_base + SPINLOCK_SYSSTATUS_REG) >> 28) & 0x03;
> > +	switch (num_banks) {
> > +	case 1 ... 4:
> 
> But the comment above says...and num_banks was & 0x3, so how can it be ...4?
>
> > +		/*
> > +		 * 32, 64, 128 and 256 spinlocks are supported by the hardware implementation,
> > +		 * though most only support 32 spinlocks
> > +		 */
> > +		priv->nlocks = 1 << (4 + num_banks);
> > +		break;
> > +	default:
> 
> Given the mask above I believe this would only happen if bits 28 and 29
> are both 0...
> 
> Regardless I think that this would be better written as a
> 
> if (num_banks == invalid) {
> 	...
> 	goto fail;
> }
> 
> priv->nlocks = ...;

This one is a really odd one I noticed right after I submitted the patch. I
added the & 0x03 after reading the datasheets again. But I think the datasheets
are not fully correct here. The datasheets say, 0-4 represent 0, 32, 64, 128 and
256 locks and at the same time say, bits 28/29 are used for this and bits 30/31
are reserved. But you can't represent 5 values with 2 bits. So I'm pretty sure
these reserved bits are also used for it, at least bit 30. I will change this to
something which is more clear. It's weird, the H3, H5 and H6 datasheet state
exactly the same issue.

> > +		dev_err(&pdev->dev, "unsupported hwspinlock setup (%d)\n", num_banks);
> > +		err = -EINVAL;
> > +		goto fail;
> > +	}
> > +
> > +	/*
> > +	 * the Allwinner hwspinlock device uses 32bit registers for representing every single
> > +	 * spinlock, which is a real waste of space
> > +	 */
> 
> Might be a waste, but having them be the natural write size in hardware
> makes sense. I'm however not sure what this comment has to do with the
> following allocation.
> 
> > +	priv->bank = devm_kzalloc(&pdev->dev, priv->nlocks * sizeof(*hwlock) +
> > sizeof(*priv->bank),
> 
> Consider using struct_size() here.
>
> > +				  GFP_KERNEL);
> > +	if (!priv->bank) {
> > +		err = -ENOMEM;
> > +		goto fail;
> 
> If you do this allocation before you start the clock and deassert the
> reset you can just return -ENOMEM here, instead of the goto.
> 
> > +	}
> > +
> > +	for (i = 0, hwlock = &priv->bank->lock[0]; i < priv->nlocks; ++i, ++hwlock) {
> > +		hwlock->priv = devm_kzalloc(&pdev->dev, sizeof(struct sunxi_hwspinlock),
> > +					    GFP_KERNEL);
> 
> 		hwpriv = devm_kzalloc(&pdev->dev, sizeof(*hwpriv), GFP_KERNEL);
> 		if (!hwpriv)
> 			return -ENOMEM;
> 
> 		hwpriv->io_base = ...;
> 		priv->bank->lock[i].priv = hwpriv;
> 
>

You're right, I will update this.

> > +		if (!hwlock->priv) {
> > +			err = -ENOMEM;
> > +			goto fail;
> > +		}
> > +
> > +		hwpriv = hwlock->priv;
> > +		hwpriv->io_base = priv->io_base + SPINLOCK_LOCK_REGN + sizeof(u32) * i;
> > +	}
> > +
> > +	err = hwspin_lock_register(priv->bank, &pdev->dev, &sunxi_hwspinlock_ops,
> > SPINLOCK_BASE_ID,
> > +				   priv->nlocks);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "unable to register hwspinlocks (%d)\n", err);
> > +		goto fail;
> > +	}
> > +
> > +	sunxi_hwspinlock_debugfs_init(priv);
> > +
> > +	dev_dbg(&pdev->dev, "SUNXI hardware spinlock driver enabled (%d locks)\n",
> > priv->nlocks); +
> > +	return 0;
> > +
> > +fail:
> > +	clk_disable_unprepare(priv->ahb_clock);
> > +
> > +reset_fail:
> > +	if (priv->reset)
> > +		reset_control_assert(priv->reset);
> > +
> > +	return err;
> > +}
> > +
> > +static int sunxi_hwspinlock_remove(struct platform_device *pdev)
> > +{
> > +	struct sunxi_hwspinlock_data *priv = platform_get_drvdata(pdev);
> > +	int err;
> > +
> > +	debugfs_remove_recursive(priv->debugfs);
> > +
> > +	err = hwspin_lock_unregister(priv->bank);
> > +	if (err) {
> > +		dev_err(&pdev->dev, "unregister device failed (%d)\n", err);
> > +		return err;
> > +	}
> > +
> > +	if (priv->reset)
> > +		reset_control_assert(priv->reset);
> > +
> > +	clk_disable_unprepare(priv->ahb_clock);
> 
> By using devm_add_action_or_reset() to set up an "assert and unprepare"-
> function you can use devm_hwspin_lock_register(), you can drop the
> remove function and you can clean up your sunxi_hwspinlock_data (e.g.
> you no longer need a pointer to priv->bank).

I'm not very used to these devm_* functions yet, but will try to use these.

> > +
> > +	return 0;
> > +}
> > +
> > +static const struct of_device_id sunxi_hwspinlock_ids[] = {
> > +	{ .compatible = "allwinner,sun8i-hwspinlock", },
> > +	{ .compatible = "allwinner,sun50i-hwspinlock", },
> > +	{},
> > +};
> > +MODULE_DEVICE_TABLE(of, sunxi_hwspinlock_ids);
> > +
> > +static struct platform_driver sunxi_hwspinlock_driver = {
> > +	.probe	= sunxi_hwspinlock_probe,
> > +	.remove	= sunxi_hwspinlock_remove,
> > +	.driver	= {
> > +		.name		= DRIVER_NAME,
> > +		.of_match_table	= of_match_ptr(sunxi_hwspinlock_ids),
> 
> Please avoid of_match_ptr, as this will cause warnings about unused
> variables when COMPILE_TEST without OF.

So did you mean to leave it out completely?

Thanks for looking through this, this really helps a lot. :-)

greetings,
Wilken

> Regards,
> Bjorn
> 
> > +	},
> > +};
> > +
> > +static int __init sunxi_hwspinlock_init(void)
> > +{
> > +	return platform_driver_register(&sunxi_hwspinlock_driver);
> > +}
> > +postcore_initcall(sunxi_hwspinlock_init);
> > +
> > +static void __exit sunxi_hwspinlock_exit(void)
> > +{
> > +	platform_driver_unregister(&sunxi_hwspinlock_driver);
> > +}
> > +module_exit(sunxi_hwspinlock_exit);
> > +
> > +MODULE_LICENSE("GPL");
> > +MODULE_DESCRIPTION("SUNXI hardware spinlock driver");
> > +MODULE_AUTHOR("Wilken Gottwalt <wilken.gottwalt@posteo.net>");
> > -- 
> > 2.29.2
> > 

