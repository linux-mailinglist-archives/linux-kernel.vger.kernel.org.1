Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1126CC2A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 22:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728508AbgIPUjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 16:39:39 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33013 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726736AbgIPRGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 13:06:18 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 28A7D58011F;
        Wed, 16 Sep 2020 12:57:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 16 Sep 2020 12:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=u8jbHISbSUUNQj4aheiIBcbQzWT
        dwA6DbD/UfopS5AA=; b=EyG/8c0/G9xXeiBHnZNVdtJY6d8BC2rME/t6/EmIQFV
        47BAhwZnUMP/57J73C7Iyn9wyo+lbqv+5FBwjwE8AUg+U+PDqkt2R5DOunVh6Zk8
        F4rtXpTUCOP5f/2bzEzPbKZjaZSR448COTL0a+H6eve3TzS/Y67ZwZoCmsciVgmQ
        1rNtEy3kz44B4cNmbogojSsgi4qtGeQaN4ikvROrFDAuCOSgtCIW6VWXOJBby9qe
        eJgW/Ri0E1hAo+b7DWfu555RGsrNoW5daaKJ1sxqqgoubECBq2GCTb/wqUVOwXFZ
        SEdBDYItV/nZ7ldBsl8Th6zxWoyTRUVO+OyOTRR0nqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=u8jbHI
        SbSUUNQj4aheiIBcbQzWTdwA6DbD/UfopS5AA=; b=uJDj+5FtdycqWiX+jymszg
        EiwsCklp8q3zAgck221U68jcnEEbhAeOD+kWt9idE/lYtvpqUyYTkgemngX3GAhZ
        yTdM2INsE6lvgwggnqv8/iWKmBhJgfL4A6oDbYpxbzNLIOvwmMwt6uGiAQ+zCOZ2
        nodz4iceUK8FjwA7F7Ex5O8QvwZdT6zwPeq/hGrG2RR5fmQ/nc21oP5+Z095Vd0J
        HVynvFBwQBffR5Bbphmt6Qd956KywUykDT4MCe9AGOFgUI5Kefq9iAnYlBSO6EAE
        4jaVVVPvndPJmecnlQurDaFh0jKLOWEG/VdrGY37DJC9ldMsrvPFJp/16HBOmQjA
        ==
X-ME-Sender: <xms:40NiX3FHSwns3-axUffiqCEEWFqGOzn8S_ksziv9ujsChYZryjvRaw>
    <xme:40NiX0UNX7k-QKF5ppRL_KIpMv8le1QLFCBgqgAGnH7jv2cAg6e8QObmTkBZ3Fdpl
    vsfjlsDGJKaFlbDjE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrtddvgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepuddvudfhkeekhefgffetffelgffftdehffduffegveetffehueeivddvjedv
    gfevnecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:40NiX5L8YFxWD87DxqL82ByOECI-Uhnz3y4uIeJ4LDXoJadxV602Pw>
    <xmx:40NiX1Eisi8ZQUrdtBAuCoH6rujI8a4e9zuHLEM8OzhIsuaz0bX8LA>
    <xmx:40NiX9UmnXZK-WgPiCWYtkw5AmMRKq3ZbnTLwMcx8Nz37fX575kmNw>
    <xmx:5ENiXyXwG9nD99Dbg66Jo-yaLSiGwo9usCJELBPOl13zI49bmVWEPQ>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id 017CD328005A;
        Wed, 16 Sep 2020 12:57:06 -0400 (EDT)
Date:   Wed, 16 Sep 2020 18:57:05 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Hoegeun Kwon <hoegeun.kwon@samsung.com>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        =?utf-8?B?64KY7ISx6rWt?= <sungguk.na@samsung.com>
Subject: Re: [PATCH v5 00/80] drm/vc4: Support BCM2711 Display Pipeline
Message-ID: <20200916165705.7pfgesma47vgkfxt@gilmour.lan>
References: <CGME20200904071259epcas1p3de4209531c0bc5ed6ea9ef19827b6ed5@epcas1p3.samsung.com>
 <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
 <cca5234f-e1e8-b642-048b-b710f402409d@samsung.com>
 <20200908120019.3rmhzoijoijrbb7d@gilmour.lan>
 <3e113525-aa89-b1e2-56b7-ca55bd41d057@samsung.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zlz5rlu4elwsvrxu"
Content-Disposition: inline
In-Reply-To: <3e113525-aa89-b1e2-56b7-ca55bd41d057@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zlz5rlu4elwsvrxu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2020 at 07:14:11PM +0900, Hoegeun Kwon wrote:
> Hi Maxime,
>=20
> On 9/8/20 9:00 PM, Maxime Ripard wrote:
> > Hi Hoegeun,
> >
> > On Mon, Sep 07, 2020 at 08:49:12PM +0900, Hoegeun Kwon wrote:
> >> On 9/3/20 5:00 PM, Maxime Ripard wrote:
> >>> Hi everyone,
> >>>
> >>> Here's a (pretty long) series to introduce support in the VC4 DRM dri=
ver
> >>> for the display pipeline found in the BCM2711 (and thus the Raspberry=
Pi 4).
> >>>
> >>> The main differences are that there's two HDMI controllers and that t=
here's
> >>> more pixelvalve now. Those pixelvalve come with a mux in the HVS that=
 still
> >>> have only 3 FIFOs. Both of those differences are breaking a bunch of
> >>> expectations in the driver, so we first need a good bunch of cleanup =
and
> >>> reworks to introduce support for the new controllers.
> >>>
> >>> Similarly, the HDMI controller has all its registers shuffled and spl=
it in
> >>> multiple controllers now, so we need a bunch of changes to support th=
is as
> >>> well.
> >>>
> >>> Only the HDMI support is enabled for now (even though the DPI and DSI
> >>> outputs have been tested too).
> >>>
> >>> Let me know if you have any comments
> >>> Maxime
> >>>
> >>> Cc: bcm-kernel-feedback-list@broadcom.com
> >>> Cc: devicetree@vger.kernel.org
> >>> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
> >>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> >>> Cc: Rob Herring <robh+dt@kernel.org>
> >>> Cc: Stephen Boyd <sboyd@kernel.org>
> >>>
> >>> Changes from v4:
> >>>     - Rebased on top of next-20200828
> >>>     - Collected the various tags
> >>>     - Fixed some issues with 4k support and dual output (thanks Hoege=
un!)
> >> Thanks for your v5 patchset.
> >>
> >> I tested all patches based on the next-20200812.
> > Thanks again for testing all the patches
> >
> >> Everything else is fine, but the dual hdmi modetest doesn't work well =
in my
> >> environment...
> >>
> >> In my environment, dsi is not connected, I have seen your answer[1].
> > Can you share a bit more your setup? What monitors are being connected
> > to each HDMI port? Do you hotplug any?
> Yes, Monitors are being connected to each HDMI ports. (did not use hotplu=
g)
>=20
> When booting, both HDMI-0 and 1 are recognized and the kernel log is outp=
ut.
> But after run modetest on HDMI-0(works) and modetest on HDMI-1(works),
> crtc timed out occurs on HDMI-0 and does not work.
>=20
> When HDMI-0 is not working we do a modetest on HDMI-0, it will work agin
> after about 40 sec.
>=20
> Below is the log for modetest.
>=20
>=20
> root:~> modetest -Mvc4 -s 32:1280x720 =A0=A0=A0 =A0=A0=A0 - HDMI-0 works
> setting mode 1280x720-60Hz@XR24 on connectors 32, crtc 64
> failed to set gamma: Invalid argument
>=20
> root:~> modetest -Mvc4 -s 32:1280x720 =A0=A0=A0 =A0=A0=A0 - HDMI-0 works
> setting mode 1280x720-60Hz@XR24 on connectors 32, crtc 64
> failed to set gamma: Invalid argument
>=20
> root:~> modetest -Mvc4 -s 38:1280x720 =A0=A0=A0 =A0=A0=A0 - HDMI-1 works
> setting mode 1280x720-60Hz@XR24 on connectors 38, crtc 69
> failed to set gamma: Invalid argument
>=20
>  =A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 - Crtc timed out occurs on HDMI-0 and=20
> does not work.
>=20
> [=A0=A0 71.134283] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR*=20
> [CRTC:64:crtc-3] flip_done timed out
> [=A0=A0 81.374296] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=
=20
> [CRTC:64:crtc-3] flip_done timed out
> [=A0=A0 91.618380] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=
=20
> [CONNECTOR:32:HDMI-A-1] flip_done timed out
> [=A0 101.854274] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=20
> [PLANE:60:plane-3] flip_done timed out
>=20
> [=A0 112.094271] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR*=20
> [CRTC:64:crtc-3] flip_done timed out
> [=A0 122.590311] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=20
> [CRTC:64:crtc-3] flip_done timed out
>=20
> root:~> modetest -Mvc4 -s 32:1280x720
> [=A0 132.830309] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=20
> [CONNECTOR:32:HDMI-A-1] flip_done timed out
> [=A0 143.070307] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=20
> [PLANE:60:plane-3] flip_done timed out
> [=A0 153.310303] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR*=20
> [CRTC:64:crtc-3] flip_done timed out
> setting mode 1280x720-60Hz@XR24 on connectors 32, crtc 64
> [=A0 163.550340] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=20
> [CRTC:64:crtc-3] flip_done timed out
> [=A0 173.790277] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=20
> [CONNECTOR:32:HDMI-A-1] flip_done timed out
> [=A0 184.030286] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR*=20
> [PLANE:60:plane-3] flip_done timed out
> failed to set gamma: Invalid argument =A0=A0=A0 =A0=A0=A0 - HDMI-0 works

Thanks :)

I was able to reproduce it just by also letting X boot. I'm on a good
path to fix it and found a workaround. I'll send you the patch in the
upcoming days :)

Thanks again,
Maxime

--zlz5rlu4elwsvrxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCX2JD4QAKCRDj7w1vZxhR
xRSMAQDJUj9nSuN6IyZmgUE3IaFEuev8g+P2MdyQzGg10MpHBQEA00Yn3whT31br
uSzvMFoupb5cWMsYQo6Zh1bdS0ejIAg=
=BQPM
-----END PGP SIGNATURE-----

--zlz5rlu4elwsvrxu--
