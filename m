Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE829272360
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgIUMK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:10:57 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:51365 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgIUMK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:10:56 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E585AC27;
        Mon, 21 Sep 2020 08:10:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 21 Sep 2020 08:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm3; bh=1
        puBf763Hn5njAG9buN3U2bh3/4MgrqGWDDXZwURC2c=; b=X3+eGxjAUm2tAXMxp
        pgx598OGmcI9d+BvgQSBK3zvhws4T6eCsGDPiwmatVF+iChPPElivZBi5r1270CK
        O6QvkrJ8VgF6TLvJ1PIqRvwrGjixYh0ypjt3drL+tKzOxnm8BL2f0z0ASHT1UVTK
        2JeilFPU2HCm6CGZduOUY+b1mLDkq0peVh1gv4PUxsy0T+OfkOabL2xXmhtk4TZE
        xpSQeYSqGvqG5VlzlmbiEN8Nl8PMtWh75kSbxsry5Jm+HRkVUT3E2OWW6H+EGfDH
        anitEGM/5PDYEyxSgPRyX5+CUDYY067QMRFPSwfTxjE/cE4/ar+kzwzJqZieyTuE
        ZzxZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=1puBf763Hn5njAG9buN3U2bh3/4MgrqGWDDXZwURC
        2c=; b=Ur1f3ox4pTBXQghy7D33WjhG2RgFozlPk3lg4dxV7o7+TV0X4A7x4ry+k
        uUR0D14PfK86gEUCoypB2gDeZ6mawOPZNHmkKfRfYrl0K9yQGdZ3rkxjIKPJHwTA
        qIrYFvVTj+O76iAimZfmodlCiXJmv06z1P1GEhn8CdSRV+QvtpYxgOwxZ1tp8///
        WEbaF+tfnXxMkx+CbvrVp3DOWiXI1CPRARUAtUEQuBY8im8XGm9ytTeSppACmE57
        Z/ljN+Qp04ZuXqYzKVsrajA39xeDQnkRIlKFx5LWitMrGjLHQhmY8qB5OHmDjQem
        Bsc2epe3S0eZ87ZNC1+4B+SgiqsIA==
X-ME-Sender: <xms:TZhoX9gqsGCDIm8RLFNUmTuOkGCPiZk21jQsWekIOuAfWGt29i9uOA>
    <xme:TZhoXyBqloiR_aFCa7wO5NCsoZwX5XQ5FUzDFFJEk1n6frLS2u8o_YjAuwdcAKAzM
    yv2WnIpyGvE_Oy5YI0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggugfgjsehtqhertddttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepkeeludfhledtieegfeelveetveegueeghfeitedttddvjefhgfevgfdtleeg
    heehnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkphepledtrdekledrieekrd
    ejieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehm
    rgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:TZhoX9FHRNgXeCh-EFNILlokaVJ6ndUZmTsPIPeZJFG5mYB43NmN3A>
    <xmx:TZhoXyTGJyWIN1OESjyzR74oOp1ksXuZP5J2AF59eCawEtKJd2g30A>
    <xmx:TZhoX6x5Z6tEQlQdEOcbaB1AS_HtfXNN5x6FzyfoqFvmdTfLzzb6ww>
    <xmx:TphoX_rxu5jlUg5Z2CLugSgprHArQIJyhNKku8W41Yqa7GzXv1YHxA>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 993663280065;
        Mon, 21 Sep 2020 08:10:53 -0400 (EDT)
Date:   Mon, 21 Sep 2020 14:10:51 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Wilken Gottwalt <wilken.gottwalt@mailbox.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] dt-bindings: arm: sunxi: update H2+/H3 cpu clocks
Message-ID: <20200921121051.jt64fo6xc6c3zrlq@gilmour.lan>
References: <20200903100708.GA466735@monster.powergraphx.local>
 <20200909120859.yosl2vgs3rj34stu@gilmour.lan>
 <20200909155446.382cf06d@monster.powergraphx.local>
 <20200909155307.pjlebalzo3jqqhfj@gilmour.lan>
 <20200914060056.7c2edc1f@monster.powergraphx.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200914060056.7c2edc1f@monster.powergraphx.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Sep 14, 2020 at 06:00:56AM +0200, Wilken Gottwalt wrote:
> > > > cpufreq OPP misconfiguration on Allwinner SoCs has been known to cr=
eate
> > > > some errors that are fairly hard to spot and be quite easy to go
> > > > unnoticed (like caches corruptions).
> > >=20
> > > Yeah, I noticed that in the beginning where I prepared the first kern=
els
> > > for these devices. But after switching to multiples of 48MHz and bigg=
er
> > > steps these issues disappeared. I'm aware that this does not proof th=
at
> > > these issues do not appear, but thougth I share the values which I
> > > consider stable.
> >=20
> > The only really reliable test we've had so far is the one I pointed out,
> > so please run it on one board at least
> >=20
> > > > The only reliable test we have is:
> > > > https://github.com/ssvb/cpuburn-arm/blob/master/cpufreq-ljt-stress-=
test
> > > >=20
> > > > > Signed-off-by: Wilken Gottwalt <wilken.gottwalt@mailbox.org>
> > > > > ---
> > > > >  arch/arm/boot/dts/sun8i-h3.dtsi | 34 +++++++++++++++++++++++++++=
++++--
> > > > >  1 file changed, 32 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/=
sun8i-h3.dtsi
> > > > > index 4e89701df91f..5517fcc02b7d 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> > > > > @@ -48,23 +48,53 @@ cpu0_opp_table: opp_table0 {
> > > > >  		compatible =3D "operating-points-v2";
> > > > >  		opp-shared;
> > > > > =20
> > > > > -		opp-648000000 {
> > > > > -			opp-hz =3D /bits/ 64 <648000000>;
> > > > > +		opp-528000000 {
> > > > > +			opp-hz =3D /bits/ 64 <528000000>;
> > > > > +			opp-microvolt =3D <1020000 1020000 1300000>;
> > > > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > > > +		};
> > > > > +
> > > > > +		opp-624000000 {
> > > > > +			opp-hz =3D /bits/ 64 <624000000>;
> > > > >  			opp-microvolt =3D <1040000 1040000 1300000>;
> > > > >  			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > > >  		};
> > > > > =20
> > > > > +		opp-720000000 {
> > > > > +			opp-hz =3D /bits/ 64 <720000000>;
> > > > > +			opp-microvolt =3D <1060000 1060000 1300000>;
> > > > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > > > +		};
> > > > > +
> > > > >  		opp-816000000 {
> > > > >  			opp-hz =3D /bits/ 64 <816000000>;
> > > > >  			opp-microvolt =3D <1100000 1100000 1300000>;
> > > > >  			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > > >  		};
> > > > > =20
> > > > > +		opp-912000000 {
> > > > > +			opp-hz =3D /bits/ 64 <912000000>;
> > > > > +			opp-microvolt =3D <1140000 1140000 1300000>;
> > > > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > > > +		};
> > > > > +
> > > > >  		opp-1008000000 {
> > > > >  			opp-hz =3D /bits/ 64 <1008000000>;
> > > > >  			opp-microvolt =3D <1200000 1200000 1300000>;
> > > > >  			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > > >  		};
> > > > > +
> > > > > +		opp-1104000000 {
> > > > > +			opp-hz =3D /bits/ 64 <1104000000>;
> > > > > +			opp-microvolt =3D <1240000 1240000 1300000>;
> > > > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > > > +		};
> > > > > +
> > > > > +		opp-1200000000 {
> > > > > +			opp-hz =3D /bits/ 64 <1200000000>;
> > > > > +			opp-microvolt =3D <1300000 1300000 1300000>;
> > > > > +			clock-latency-ns =3D <244144>; /* 8 32k periods */
> > > > > +		};
> > > > >  	};
> > > >=20
> > > > IIRC U-Boot will start the CPU at 1008 MHz on the H3, so in the
> > > > situation where a board doesn't list the regulators attached to the=
 CPU,
> > > > the kernel will happily use the 1104 and 1200 MHz frequencies, even
> > > > though it won't adjust the voltage accordingly, causing errors.
> > >=20
> > > Yeah, I know that. The u-boot running on the mentioned devices also h=
ave
> > > these modifications, including a higher clocked DRAM (actually runnin=
g at
> > > 624 MHz).
> > >=20
> > > > The way we worked around that is to provide the extra OOPs in a sep=
arate
> > > > DTSI so that the boards with regulator support can opt-in.
> > >=20
> > > Oh, did I overlooked something? I was working on 4.14 up to 4.19 kern=
els
> > > and may be a bit to eager to post the modifications.
> >=20
> > It's not really my point :)
> >=20
> > My point is that since it's in the DTSI, every board using an H2/H3 will
> > now get to use those OPPs, even if they don't have the regulator support
> > and the voltage set for the highest frequency, so you can end up on
> > those boards with the CPU running at 1.2GHz and the voltage associated
> > to 1GHz
>=20
> Yeah, I understand. So the solution would be to drop the two highest OPPs
> or make these changes only for the tested devices. What would you prefer?

Like I said earlier, the easiest would be to have another DTSI with the
OPPs that would be included by the boards with regulator support

Maxime
