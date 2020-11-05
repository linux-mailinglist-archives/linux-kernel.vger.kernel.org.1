Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C242A7648
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 05:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgKEEOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 23:14:50 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51925 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726225AbgKEEOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 23:14:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EC9C65C00F9;
        Wed,  4 Nov 2020 23:14:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 04 Nov 2020 23:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        to:cc:references:from:subject:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=f
        JwbcwXPY3l7mC3CKsfGxtk7DwZ8F+yxs7HUMg4dBoo=; b=ee5InBpauKyoj6Hli
        XGUDsBjjSWn0H/Kigzlptzd8wf4B/DVphlLZaPxX9cFIxGG8FFpuglH90DZbttPN
        Z6WsbWPt+WCqvQdsvhyOteY5Pvjqd0yO5QhEF/oIztFuL6zxr0hJ9EQggcWAIyIc
        6iFD++fPbEHMW+3vx5+IhoTJsXoG0TSXgyMSl9OPU24yWzkCqcYVT1K54skO8Kj4
        8C0T6EbAoZ9f+6vPTHV3CsRNdM1KAT4+QDBll+YmZAQ5EymnSBDf8gsNi9H6KzQm
        rbbZh1d8Iw8g8t+qWk39D1sPqYY4ljYaFAieqApm7RybzE8gmVPhmvAoViZtpbQj
        F7Fug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=fJwbcwXPY3l7mC3CKsfGxtk7DwZ8F+yxs7HUMg4dB
        oo=; b=goD7YzrUgOWmd+pHLJ+XHw7AxiaDaIjJW9vkJc0R+bMb2ECRbyQ0t6w8H
        TbGjHRGp4KcnseJwCVM461q1wHM+ct9EHBYOLgSs2d8RgqLQrLkMDP933XU/mX1m
        gkxP5Nz7lT/H7GZlCF5Jqp84uWY5rPClvKfYaciqUEy+QCT4pbmtyNh+bvnrtk/8
        9MRzWeVocZDK6sStYQmtuL77rLmBZH9NWlTXBi8HHu99Oqy43mF+JutQDjCoYvMK
        9t69gcD1FQrd/6ytXgy+Q1qrsrynP0Peib3SCOYmW2nr8dLityPYlAjJAa6lYXXx
        DyLqbjp2/Y50z9Z7jCQpJG9gjpw6A==
X-ME-Sender: <xms:OHyjX49AflmvpRAFK4qY8duxKHXkNFodQcM5j3ZwW6MD-ovNKH25MA>
    <xme:OHyjXwsTjFZGG61O4rm7nBE1Hh4rGTMqRRc1KE_2vAMDtZGCTdjB29jPtOg_YIvG2
    BC_xJVYmX3JZr46nA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepvfhfhffukffffgggjggtgfesthekredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvddttdejieduudfgffevteekffegffeguddtgfefkeduvedukeff
    hedtfeevuedvnecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:OHyjX-BVRMLE2LRruB5x0YmesdMSQ0l0VIaupaaoGfcM_4v7nhV5dw>
    <xmx:OHyjX4c8o8uvtN5unD6dzf9c9jLRmEs1HrvZuwG36WB1OD4Mn3NLSw>
    <xmx:OHyjX9PTmXcEqPQ5wlmVhfpLlbwF3oAaTBOK79BSt3dPPyYjJpOTzA>
    <xmx:OHyjX5DnyEHntW2hVDJal0PWHk7OPh4FIdlPnqTu_mjqHhbggysWkA>
Received: from [70.135.148.151] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id D1A11306005E;
        Wed,  4 Nov 2020 23:14:47 -0500 (EST)
To:     Paul Kocialkowski <contact@paulk.fr>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Matteo Scordino <matteo.scordino@gmail.com>
References: <20201103205058.435207-1-contact@paulk.fr>
 <20201103205058.435207-3-contact@paulk.fr>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 2/6] irqchip/sunxi-nmi: Add support for the V3s NMI
Message-ID: <85d40081-2dd1-3a0c-15ad-a58ce866700f@sholland.org>
Date:   Wed, 4 Nov 2020 22:14:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux ppc64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201103205058.435207-3-contact@paulk.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/3/20 2:50 PM, Paul Kocialkowski wrote:
> The V3s/V3 has a NMI IRQ controller, which is mainly used for the AXP209
> interrupt. In great wisdom, Allwinner decided to invert the enable and
> pending register offsets, compared to the A20.
> 
> As a result, a specific compatible and register description is required
> for the V3s. This was tested with an AXP209 on a V3 board.
> 
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
> ---
>  drivers/irqchip/irq-sunxi-nmi.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
> index a412b5d5d0fa..59e0e4612ef7 100644
> --- a/drivers/irqchip/irq-sunxi-nmi.c
> +++ b/drivers/irqchip/irq-sunxi-nmi.c
> @@ -44,6 +44,10 @@
>  #define SUN7I_NMI_PENDING	0x04
>  #define SUN7I_NMI_ENABLE	0x08
>  
> +#define SUN8I_V3S_NMI_CTRL	0x00
> +#define SUN8I_V3S_NMI_ENABLE	0x04
> +#define SUN8I_V3S_NMI_PENDING	0x08
> +
>  #define SUN9I_NMI_CTRL		0x00
>  #define SUN9I_NMI_ENABLE	0x04
>  #define SUN9I_NMI_PENDING	0x08

These two sets of definitions are the same. So it would make sense for
V3S and sun9i to share a configuration, instead of creating a copy.

> @@ -79,6 +83,12 @@ static const struct sunxi_sc_nmi_reg_offs sun7i_reg_offs __initconst = {
>  	.enable	= SUN7I_NMI_ENABLE,
>  };
>  
> +static const struct sunxi_sc_nmi_reg_offs sun8i_v3s_reg_offs __initconst = {
> +	.ctrl	= SUN8I_V3S_NMI_CTRL,
> +	.pend	= SUN8I_V3S_NMI_PENDING,
> +	.enable	= SUN8I_V3S_NMI_ENABLE,
> +};
> +
>  static const struct sunxi_sc_nmi_reg_offs sun9i_reg_offs __initconst = {
>  	.ctrl	= SUN9I_NMI_CTRL,
>  	.pend	= SUN9I_NMI_PENDING,
> @@ -165,7 +175,6 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
>  	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
>  	int ret;
>  
> -
>  	domain = irq_domain_add_linear(node, 1, &irq_generic_chip_ops, NULL);
>  	if (!domain) {
>  		pr_err("Could not register interrupt domain.\n");
> @@ -254,6 +263,13 @@ static int __init sun7i_sc_nmi_irq_init(struct device_node *node,
>  }
>  IRQCHIP_DECLARE(sun7i_sc_nmi, "allwinner,sun7i-a20-sc-nmi", sun7i_sc_nmi_irq_init);
>  
> +static int __init sun8i_v3s_sc_nmi_irq_init(struct device_node *node,
> +					    struct device_node *parent)
> +{
> +	return sunxi_sc_nmi_irq_init(node, &sun8i_v3s_reg_offs);
> +}
> +IRQCHIP_DECLARE(sun8i_v3s_sc_nmi, "allwinner,sun8i-v3s-sc-nmi", sun8i_v3s_sc_nmi_irq_init);
> +
>  static int __init sun9i_nmi_irq_init(struct device_node *node,
>  				     struct device_node *parent)
>  {
> 

