Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649392D15D2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 17:19:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbgLGQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 11:18:47 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:39001 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgLGQSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:18:47 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B638C5C0207;
        Mon,  7 Dec 2020 11:17:40 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 07 Dec 2020 11:17:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=sRrMPFmVyOfvaqKLgWHgXcnRZA4
        bk3pBnyNI+Mn38U8=; b=PB/eO/VqZAi7cQpIejRsSaKjcWbDvuTKokDPRrap2L+
        TKgJpGfukeMuxmzU9+ri8NUaD2dB0AUt6cQZoeS+qh003OUhwxHTP4ysKUoVlpqY
        uYlF0FsL9eKUpOqYafNR2iBgYkNReDoIRPsp2ibjNlHIpMM4EPhGM+iRLX2X0QIW
        G0gGmZ/So1HSWORJrDw58pDx5bYhGqRISmlWTAqkg1xqnLHknX3+JyrMjYLUZxvW
        zq7+rZlM1o8H20Z2/Lptz2oO6ihb61Sbe63NF8yrZbn7J0JTEhxEmLYGR4kNjBU4
        0787JrqL/6VwR8+1g0CDl2FiNfU/SOgUXjlzNVZywGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=sRrMPF
        mVyOfvaqKLgWHgXcnRZA4bk3pBnyNI+Mn38U8=; b=q7Iv4wkjtI9C4k0J+fO9Xj
        n/BXyYN8x397cHzQ9q63Iy/+uP9OrRXCgud8pUu4nRauPKd7WojZ2vG57Pp1lpLg
        kmptNuaWfoZoo+ZFHhay/+QusIA5MkJSXHWPox1C3KPkGRKsyEU0JbwWxwa4+B75
        CeUeCnM9MBoUOfjnQOWNfMvYdQzMs9a5lIYnx9WfanDjCapMdBVghYpGat6HNauq
        w0+7cGjl931TAMJL9IIWFE1QzhwFBzJAJMq1mIw7zmu4lGyuIPF/IVG3rxGgLH/i
        hsYOK0Mkzjs+rT3z8Krdq+nldzHsa9AtHQa+nAwTt4CGdBoTMAqgnveiqP/UmI0Q
        ==
X-ME-Sender: <xms:o1XOXw_GCHyXC4Ufsr5hHEd1UxubfXE6sXmD-5piVjZmCXJWnY0c6A>
    <xme:o1XOXxoofk3milzFePojAnaIF3A3Ui8BWx4gKvWvWS4YMURmLYqHr2ADhr0w1dkPv
    D13kJABMDSnwqTGqHk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejgedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:o1XOXxm37zDVn-POxq7-uZNSQuGC5E1d06-Cuz-o5HykG-TFeAcSDw>
    <xmx:o1XOXwitDqWt3boM5KdBBTZFkWI8-WCy2LKHXjBo5D-VDaETP3hO7A>
    <xmx:o1XOXxc32DK9PdrVFqw6FqmnoCGOGmOI6XplyHFPQp4LgX55Y24gSg>
    <xmx:pFXOX7LAUJ0GDfIv7FYrC7ncBo5Ig_6aNSrvvT68xgcjk5DmdjC9-Q>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id D023B1080064;
        Mon,  7 Dec 2020 11:17:38 -0500 (EST)
Date:   Mon, 7 Dec 2020 17:17:37 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Subject: Re: [PATCH v3 2/2] hwspinlock: add sun8i hardware spinlock support
Message-ID: <20201207161737.z75lsqlkfv65krmm@gilmour>
References: <cover.1607353274.git.wilken.gottwalt@posteo.net>
 <296866d054f0373e8af9e3226e59844ebc791a5e.1607353274.git.wilken.gottwalt@posteo.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="x2tmdqfk2zesitko"
Content-Disposition: inline
In-Reply-To: <296866d054f0373e8af9e3226e59844ebc791a5e.1607353274.git.wilken.gottwalt@posteo.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--x2tmdqfk2zesitko
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 07, 2020 at 05:05:34PM +0100, Wilken Gottwalt wrote:
> +	io_base = devm_platform_ioremap_resource(pdev, SPINLOCK_BASE_ID);
> +	if (IS_ERR(io_base)) {
> +		err = PTR_ERR(io_base);
> +		dev_err(&pdev->dev, "unable to request MMIO (%d)\n", err);

There's already a message printed by the core if it fails

> +		return err;
> +	}
> +
> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	err = devm_add_action_or_reset(&pdev->dev, sun8i_hwspinlock_disable, priv);
> +	if (err) {
> +		dev_err(&pdev->dev, "unable to add disable action\n");
> +		return err;
> +	}

If the next call fails, you're going to free some resources that you
haven't taken in the first place.

> +
> +	priv->ahb_clk = devm_clk_get(&pdev->dev, "ahb");
> +	if (IS_ERR(priv->ahb_clk)) {
> +		err = PTR_ERR(priv->ahb_clk);
> +		dev_err(&pdev->dev, "unable to get AHB clock (%d)\n", err);
> +		return err;
> +	}
> +
> +	priv->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");

Your binding has it mandatory, so you don't really need it to be
optional?

> +	if (IS_ERR(priv->reset)) {
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->reset),
> +				     "unable to get reset control\n");
> +	}

You shouldn't have braces on a single line return

> +
> +	err = reset_control_deassert(priv->reset);
> +	if (err) {
> +		dev_err(&pdev->dev, "deassert reset control failure (%d)\n", err);
> +		return err;
> +	}
> +
> +	err = clk_prepare_enable(priv->ahb_clk);
> +	if (err) {
> +		dev_err(&pdev->dev, "unable to prepare AHB clk (%d)\n", err);
> +		return err;
> +	}
> +
> +	/*
> +	 * bit 28 and 29 hold the amount of spinlock banks, but at the same time the datasheet
> +	 * says, bit 30 and 31 are reserved while the values can be 0 to 4, which is not reachable
> +	 * by two bits alone, so the reserved bits are also taken into account
> +	 */
> +	num_banks = readl(io_base + SPINLOCK_SYSSTATUS_REG) >> 28;
> +	switch (num_banks) {
> +	case 1 ... 4:
> +		/*
> +		 * 32, 64, 128 and 256 spinlocks are supported by the hardware implementation,
> +		 * though most of the SoCs support 32 spinlocks only
> +		 */
> +		priv->nlocks = 1 << (4 + num_banks);
> +		break;
> +	default:
> +		dev_err(&pdev->dev, "unsupported hwspinlock setup (%d)\n", num_banks);
> +		return -EINVAL;
> +	}
> +
> +	priv->bank = devm_kzalloc(&pdev->dev, struct_size(priv->bank, lock, priv->nlocks),
> +				  GFP_KERNEL);
> +	if (!priv->bank)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < priv->nlocks; ++i) {
> +		hwlock = &priv->bank->lock[i];
> +		hwlock->priv = io_base + SPINLOCK_LOCK_REGN + sizeof(u32) * i;
> +	}
> +
> +	sun8i_hwspinlock_debugfs_init(priv);
> +	platform_set_drvdata(pdev, priv);
> +
> +	return devm_hwspin_lock_register(&pdev->dev, priv->bank, &sun8i_hwspinlock_ops,
> +					 SPINLOCK_BASE_ID, priv->nlocks);
> +}
> +
> +static const struct of_device_id sun8i_hwspinlock_ids[] = {
> +	{ .compatible = "allwinner,sun8i-hwspinlock", },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, sun8i_hwspinlock_ids);
> +
> +static struct platform_driver sun8i_hwspinlock_driver = {
> +	.probe	= sun8i_hwspinlock_probe,
> +	.driver	= {
> +		.name		= DRIVER_NAME,
> +		.of_match_table	= sun8i_hwspinlock_ids,
> +	},
> +};
> +
> +static int __init sun8i_hwspinlock_init(void)
> +{
> +	return platform_driver_register(&sun8i_hwspinlock_driver);
> +}
> +module_init(sun8i_hwspinlock_init);
> +
> +static void __exit sun8i_hwspinlock_exit(void)
> +{
> +	platform_driver_unregister(&sun8i_hwspinlock_driver);
> +}
> +module_exit(sun8i_hwspinlock_exit);

This can be replaced by module_platform_driver

Maxime

--x2tmdqfk2zesitko
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX85VoQAKCRDj7w1vZxhR
xafyAQDSlcbEH/sGUrnX3FLTGGyaKBHwRW7RNppHhhD0u1H5agD/cq0iEAUXaJBn
slFCixuG1MBgvWXDbf67NKqyFLKm7g0=
=2cdI
-----END PGP SIGNATURE-----

--x2tmdqfk2zesitko--
