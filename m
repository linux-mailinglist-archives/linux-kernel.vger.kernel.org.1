Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3263429249F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 11:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgJSJbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 05:31:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51391 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727010AbgJSJbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 05:31:52 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6AAD55C0102;
        Mon, 19 Oct 2020 05:31:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 19 Oct 2020 05:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Qy3EhE4WvPN35PbmCI7zNQb9z6L
        zpkSSm6PPBLBVmys=; b=TJ6qDxKQ3LgRTuPmKOu2UQQbd2cNak1yZSqvzgFRHyQ
        EytWydY+fSfV8xcJe+X1tB04tLeMdMVdaUjyIekwN9SxXwhk8tHXQW/kwtuDjRu/
        d92yjLNYDoYYvDG+9o+7b60DmOFqd7/vjdO9ArkSFYgdya6dPa9og6Jz6bgAxp2u
        Jlhi34XfZq5SRYxOu0K2mHAZ6BbsrRNYmR/cKCWn3nyWzmBW4wa3pHyIed+ws6XP
        zVI2PojmFRyozJb/f15fUFcz+N29ChPIH07LIUD1+m/TnUtoqhPRTnxtBhsTBhfK
        3LA5cv69Lyr39xszcu3kOInUW7BohmT9U5oTZv+nWhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Qy3EhE
        4WvPN35PbmCI7zNQb9z6LzpkSSm6PPBLBVmys=; b=Nu/FQqRYzlGiqvPfGreCkL
        eu8iNQ7sZ+EriKsjoefE7dAFVPp0H1gsBJzcPOhij0d93ccL/xxrdmzNPxP/w0Zz
        UKgWr+ggOKuC8ls3Foj2snq8Nebk9p82+i1JIEnvpP+H3DuL1Si/mUkqFhmQTV+G
        J+r1wU3sP/lBYbYICltGJzDmcxP4BJgeAIunJRD4JrSl2KHqBmfUjr2qDaFGo6IX
        0M+n47uk74TErhkAIyjysCCuz6wHCXnTuo2NRUBW6vuSRAOC/dmu6Brm47OIy2wE
        5PFHEND43UoZDKWS67t5JLpW0BBojsdr35EQWNesvSa4/ldPgBQKmUOVZwexnjZg
        ==
X-ME-Sender: <xms:A12NX-pc8qh6bJrnzJ_-Gp4NOsyqUkp3vmJneACVT-uzrQjVIjopeg>
    <xme:A12NX8rnWYp-0q7QMy9rrG22W3_ZNSSAcerPeFbJ59rLuBK1827_v8zKOORVSGNLY
    9t4RL7Scf62DAGAcOE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpeforgigihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghr
    nhhordhtvggthheqnecuggftrfgrthhtvghrnhepleekgeehhfdutdeljefgleejffehff
    fgieejhffgueefhfdtveetgeehieehgedunecukfhppeeltddrkeelrdeikedrjeeinecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrgihimh
    gvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:A12NXzOFH4DNsiP2z1hcWfMLZ4Su9XLfieFvl9rJgpA4_fJjYTel1Q>
    <xmx:A12NX970_ihOWEWdjH_xha5CpfauNosvB0TzcJPkL4TLhQBHPrXfCA>
    <xmx:A12NX956eQGsuELt-0KRYonui-iFN5WuVluKRXSDowuyjz2ZSJ0x6w>
    <xmx:B12NXw1ebEU88oqpZSeUUAt_aUvRF6I0pSLrIVrhd-ss6yGw7CZHWw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7F0E33280065;
        Mon, 19 Oct 2020 05:31:47 -0400 (EDT)
Date:   Mon, 19 Oct 2020 11:31:46 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     wuyan <wuyan@allwinnertech.com>
Cc:     daniel.lezcano@linaro.org, tglx@linutronix.de, wens@csie.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        frank@allwinnertech.com
Subject: Re: [PATCH 1/1] clocksource: sun4i: Save and restore timer registers
 before and after sleeping
Message-ID: <20201019093146.purztwtytlozva3t@gilmour.lan>
References: <20201010104603.26646-1-wuyan@allwinnertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tkf76euvx6cfjewc"
Content-Disposition: inline
In-Reply-To: <20201010104603.26646-1-wuyan@allwinnertech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tkf76euvx6cfjewc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Sat, Oct 10, 2020 at 06:46:03PM +0800, wuyan wrote:
> Signed-off-by: wuyan <wuyan@allwinnertech.com>

A commit log would be welcome here. Also, the last time you contributed
you used the name Martin Wu in your Signed-off-by, it would be nice to
be consistent there.

> Change-Id: I7edbc00fd0968d0301757f5a75dbd6f53d6a7cd7

This should be removed

> ---
>  drivers/clocksource/timer-sun4i.c | 45 +++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/clocksource/timer-sun4i.c b/drivers/clocksource/time=
r-sun4i.c
> index 0ba8155b8287..49fb6b90ec15 100644
> --- a/drivers/clocksource/timer-sun4i.c
> +++ b/drivers/clocksource/timer-sun4i.c
> @@ -29,6 +29,7 @@
>  #define TIMER_IRQ_EN_REG	0x00
>  #define TIMER_IRQ_EN(val)		BIT(val)
>  #define TIMER_IRQ_ST_REG	0x04
> +#define TIMER_IRQ_CLEAR(val)		BIT(val)
>  #define TIMER_CTL_REG(val)	(0x10 * val + 0x10)
>  #define TIMER_CTL_ENABLE		BIT(0)
>  #define TIMER_CTL_RELOAD		BIT(1)
> @@ -41,6 +42,19 @@
> =20
>  #define TIMER_SYNC_TICKS	3
> =20
> +/* Registers which needs to be saved and restored before and after sleep=
ing */
> +static u32 regs_offset[] =3D {

It would be better to have a prefix (like sun4i_timer to be consistent)
there so that we know it's less confusing and we know it's not some
generic thing.

> +	TIMER_IRQ_EN_REG,
> +	TIMER_IRQ_ST_REG,

Why do you need to save the interrupt status register?

> +	TIMER_CTL_REG(0),
> +	TIMER_INTVAL_REG(0),
> +	TIMER_CNTVAL_REG(0),
> +	TIMER_CTL_REG(1),
> +	TIMER_INTVAL_REG(1),
> +	TIMER_CNTVAL_REG(1),
> +};
> +static u32 regs_backup[ARRAY_SIZE(regs_offset)];

We should store this one in the timer_of struct so that we don't have
any issue if there's two timers at some point.

>  /*
>   * When we disable a timer, we need to wait at least for 2 cycles of
>   * the timer source clock. We will use for that the clocksource timer
> @@ -82,10 +96,37 @@ static void sun4i_clkevt_time_start(void __iomem *bas=
e, u8 timer,
>  	       base + TIMER_CTL_REG(timer));
>  }
> =20
> +static inline void save_regs(void __iomem *base)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(regs_offset); i++)
> +		regs_backup[i] =3D readl(base + regs_offset[i]);
> +}
> +
> +static inline void restore_regs(void __iomem *base)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(regs_offset); i++)
> +		writel(regs_backup[i], base + regs_offset[i]);
> +}
> +

Same thing here, using the prefix would be nice for those two functions
name.

>  static int sun4i_clkevt_shutdown(struct clock_event_device *evt)
>  {
>  	struct timer_of *to =3D to_timer_of(evt);
> =20
> +	save_regs(timer_of_base(to));
> +	sun4i_clkevt_time_stop(timer_of_base(to), 0);
> +
> +	return 0;
> +}
> +
> +static int sun4i_tick_resume(struct clock_event_device *evt)
> +{
> +	struct timer_of *to =3D to_timer_of(evt);
> +
> +	restore_regs(timer_of_base(to));
>  	sun4i_clkevt_time_stop(timer_of_base(to), 0);
> =20
>  	return 0;
> @@ -126,7 +167,7 @@ static int sun4i_clkevt_next_event(unsigned long evt,
> =20
>  static void sun4i_timer_clear_interrupt(void __iomem *base)
>  {
> -	writel(TIMER_IRQ_EN(0), base + TIMER_IRQ_ST_REG);
> +	writel(TIMER_IRQ_CLEAR(0), base + TIMER_IRQ_ST_REG);
>  }

This is mostly a cosmetic change right? Either way, it should be in a
separate patch.

Thanks!
Maxime

--tkf76euvx6cfjewc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX41dAgAKCRDj7w1vZxhR
xfCvAP0Rtv2pSUsj2pyjj+65b5vCRFx16+iV7x4D6wowwVcrUQD+J1wKjxZ7HkIl
MbJqTArXh05tmfqxxUwqK5h3/3UrVAQ=
=pp98
-----END PGP SIGNATURE-----

--tkf76euvx6cfjewc--
