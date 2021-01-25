Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7479630245E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 12:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbhAYLFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 06:05:32 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:50741 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727667AbhAYK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:57:34 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 81850C94;
        Mon, 25 Jan 2021 05:56:28 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 25 Jan 2021 05:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=giywbTdzkGwixTIPyZn+CKrGjsS
        8u+GMH7bvqQezP/w=; b=lj8l6n6k+m4GCen06yUSgFqcRv62lImUqGBSlMc/Qq8
        IZENWWsttIMjDGM7xPVtxDS38KuzJQKOq+eUTQPCTWz3NYOYJDO2VVbfYs31tn/T
        hMrtGnOjEKxGAVHyNhCwJMF/QcXfwltPSmQBdlNa1KTP43a04ofp4n3kpsbWdsBQ
        St1K7EtVwY3B0JK74ZdSO6eivRG9D0RFjPzlaBLjmLyu9escmlN9X3XgSzs3d0tr
        MowhUiNTx/JFpmbPeUnihd7S8SqDo5VvsWR0A6SmvtCS2OPugkJnW/YdZVmrvNXj
        sFRGpjcmDZ2uvAJXIgCndXj9PXdi9vz5r3mfOZ9BCLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=giywbT
        dzkGwixTIPyZn+CKrGjsS8u+GMH7bvqQezP/w=; b=T3X6teYyRO1kXbKsCjvtiJ
        rPcJjcWFJjsf9vStgkwd4ujyOyNPX8bjZ+Q6sdHL81FwM8yLO8zmadkscnbngnn5
        Hv38bp0geRGuV9PJOZoGiPWUoI0Mal3lkdsJVdPQ4Utx6ZGI1/2wz9W2sHdOJB5p
        9SkLZ2gICKgYnOIw9d3A1FCmoXTAZNeiGnDV8TNPIaPqnptxSVk/X0Xvksz69Uxg
        tLyciOGM9S2OCHSJaAeOgLb2CZxHmgCRNThxL6Xm00lSVok7Yt3/0zN07ww3ci8t
        4POuAQvsWodaTPgnwqnFO8xqW7DO/NyT8mRyM0QcGCxvTembvbbs9+yq/7v9Ow0A
        ==
X-ME-Sender: <xms:26MOYJhd_ZzUmZXGk4HUPXT8GrJSQWCUwvQEkdYrI1-wbbk1GpIKdg>
    <xme:26MOYOCFDdpqel7llnnh9FwxRk2kSIJ4Z_fBvGG1rEiUGDMk5kufUd3lnDGuSvmAL
    BSkexACE0t4MpJVX_A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdefgddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomhepofgrgihimhgv
    ucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtffrrghtth
    gvrhhnpeelkeeghefhuddtleejgfeljeffheffgfeijefhgfeufefhtdevteegheeiheeg
    udenucfkphepledtrdekledrieekrdejieenucevlhhushhtvghrufhiiigvpedunecurf
    grrhgrmhepmhgrihhlfhhrohhmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:26MOYJGY6Z-lFe-RLbBbHtQSb-4PuuVwayBrSgUko4R2v0ADKnfESg>
    <xmx:26MOYOSnF55TzH8473JPEhKhHi6ByApBzJs6CIVBx-I_leEGLqycdA>
    <xmx:26MOYGwYXUt0Yt1Qx0I0OAEasO8Wm3QgzAM0kZXu9vFAPjOLYNA_Ag>
    <xmx:3KMOYBxIZBQr3Z7TD0aymHcctv3miIglavLdKRDG30HW2kQRXWcuuQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 165521080059;
        Mon, 25 Jan 2021 05:56:27 -0500 (EST)
Date:   Mon, 25 Jan 2021 11:56:26 +0100
From:   Maxime Ripard <maxime@cerno.tech>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Ondrej Jirman <megous@megous.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 00/10] sunxi: Support IRQ wakeup from deep sleep
Message-ID: <20210125105626.fz75dxhi6f7jtcqm@gilmour>
References: <20210118055040.21910-1-samuel@sholland.org>
 <161126112131.135928.7664552660827790510.b4-ty@kernel.org>
 <08e9bc97-c18d-9b8f-28be-3892d77730bf@sholland.org>
 <20210122104705.bo2x22ef56hdj26q@gilmour>
 <52b9c9bb-ff75-d1e6-e198-0d388d1c6d73@sholland.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="67rbkf5xfhl6dmyc"
Content-Disposition: inline
In-Reply-To: <52b9c9bb-ff75-d1e6-e198-0d388d1c6d73@sholland.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--67rbkf5xfhl6dmyc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 23, 2021 at 12:26:26AM -0600, Samuel Holland wrote:
> On 1/22/21 4:47 AM, Maxime Ripard wrote:
> > On Thu, Jan 21, 2021 at 07:33:54PM -0600, Samuel Holland wrote:
> >> On 1/21/21 2:35 PM, Marc Zyngier wrote:
> >>> On Sun, 17 Jan 2021 23:50:30 -0600, Samuel Holland wrote:
> >>>> Allwinner sun6i/sun8i/sun50i SoCs (A31 and newer) have two interrupt
> >>>> controllers: GIC and R_INTC. GIC does not support wakeup. R_INTC han=
dles
> >>>> the external NMI pin, and provides 32+ IRQs to the ARISC. The first =
16
> >>>> of these correspond 1:1 to a block of GIC IRQs starting with the NMI.
> >>>> The last 13-16 multiplex the first (up to) 128 GIC SPIs.
> >>>>
> >>>> This series replaces the existing chained irqchip driver that could =
only
> >>>> control the NMI, with a stacked irqchip driver that also provides wa=
keup
> >>>> capability for those multiplexed SPI IRQs. The idea is to preconfigu=
re
> >>>> the ARISC's IRQ controller, and then the ARISC firmware knows to wak=
e up
> >>>> as soon as it receives an IRQ. It can also decide how deep it can
> >>>> suspend based on the enabled wakeup IRQs.
> >>>>
> >>>> [...]
> >>>
> >>> Applied to irq/irqchip-5.12, thanks!
> >>>
> >>> [01/10] dt-bindings: irq: sun6i-r: Split the binding from sun7i-nmi
> >>>         commit: ad6b47cdef760410311f41876b21eb0c6fda4717
> >>> [02/10] dt-bindings: irq: sun6i-r: Add a compatible for the H3
> >>>         commit: 6436eb4417094ea3308b33d8392fc02a1068dc78
> >>> [03/10] irqchip/sun6i-r: Use a stacked irqchip driver
> >>>         commit: 4e34614636b31747b190488240a95647c227021f
> >>> [04/10] irqchip/sun6i-r: Add wakeup support
> >>>         commit: 7ab365f6cd6de1e2b0cb1e1e3873dbf68e6f1003
> >>>
> >>> Please route the dts patches via the soc tree. Also, I had to
> >>> manually fix the first patch as it wouldn't apply on top of
> >>> 5.11-rc4 (which tree has it been diffed against?). Please
> >>> check that the resolution is correct.
> >>
> >> This series was based on sunxi/for-next, which contains commit
> >> 752b0aac99c7 ("dt-bindings: irq: sun7i-nmi: Add binding documentation
> >> for the V3s NMI")[1].
> >=20
> > I assume merging the DT bits alone would break things? If so, I guess we
> > can wait for 5.12 to be released before merging it
>=20
> Patch 5 does not depend on the new driver, so it could be merged at any
> time. Yes, the remaining patches would break things if merged without
> the driver.

I've applied patch 5 then, could you send the rest of the DT patches
when 5.13-rc1 is out?

Thanks!
Maxime

--67rbkf5xfhl6dmyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCYA6j2QAKCRDj7w1vZxhR
xYcpAP91ABOYBXnLhbPFLoxRDI3hcFTpJzj4wbHeKnZQsH04KgD/UpIbE3RYPXqZ
nEg++6cCHvC0ym6NPIdLM/3ufqLqrAs=
=JBYr
-----END PGP SIGNATURE-----

--67rbkf5xfhl6dmyc--
