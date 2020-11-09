Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9045F2AC835
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 23:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgKIWWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 17:22:10 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:53483 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIWWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 17:22:09 -0500
Received: from methusalix.internal.home.lespocky.de ([109.250.109.120]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MDgxt-1kUrhM3mpb-00Ar1g; Mon, 09 Nov 2020 23:21:56 +0100
Received: from falbala.internal.home.lespocky.de ([192.168.243.94])
        by methusalix.internal.home.lespocky.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <post@lespocky.de>)
        id 1kcFXq-0000UB-S0; Mon, 09 Nov 2020 23:21:52 +0100
Date:   Mon, 9 Nov 2020 23:21:49 +0100
From:   Alexander Dahl <post@lespocky.de>
To:     Alexandre Torgue <alexandre.torgue@st.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexander Dahl <ada@thorsis.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [Linux-stm32] [PATCH v7 10/12] ARM: dts: stm32: Fix schema
 warnings for pwm-leds
Message-ID: <20201109222149.bnhjpytdvo4en2mf@falbala.internal.home.lespocky.de>
Mail-Followup-To: Alexandre Torgue <alexandre.torgue@st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexander Dahl <ada@thorsis.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20201005203451.9985-1-post@lespocky.de>
 <20201005203451.9985-11-post@lespocky.de>
 <b387bda8-3643-1d27-4996-2aa4dc94d69f@pengutronix.de>
 <20201027100536.cpfizc67gwrolp2z@falbala.internal.home.lespocky.de>
 <f6ed201d-51b6-f278-7a95-3e3e49dc19ee@pengutronix.de>
 <20201031135408.lgpiy5goa7l4cg2k@falbala.internal.home.lespocky.de>
 <eef76d72-7467-eed7-ac65-93237bd2b3bb@st.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tg3xdjfnxy6oryuh"
Content-Disposition: inline
In-Reply-To: <eef76d72-7467-eed7-ac65-93237bd2b3bb@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Scan-Signature: 32d533e4f5a363e773e61cc60979e854
X-Spam-Score: -2.9 (--)
X-Provags-ID: V03:K1:uRzyeS+D8J1L5TCU3F2VQPGtUcxz3rOAIlM/FoPvLCXkoNvXqFr
 SM9zBYHs66uMcyQI7Xgp8xNiyk8sUySv95F3G+N14mzztP0hMuD3892UZo8db9empKYOikF
 MXiOKhI969Vmmo5k/dwFZI21VvdXUV4uFR/JwEohUVy9qHhpKVNQHCYd03/rItgSaOGedNV
 lEZsMLJ4LVq60B84tkBHw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3zqv1keYpnc=:iLWUv2jtr23YVepedP7+/1
 JjcHPG9VYsdH27Wd16J4IRcgDWIPnMdDK8zs+rk8TO25gnczbYQk6mCUweTWpp1f7xbAs2V0X
 48uzN+8iG/T4CMxU/enrJ0Z+lnmlC7XIVhsaKwljahppGIpu42iqgloFd9ySsvZW8zCenS6xS
 DSI4sEuxqVE4K2KR+FwEU6mjsuzJEBjGga4BzA/qluN23yel4DHUqGww3MWpIsUHJx2zBSNqO
 8cEJJqztAKLaOLymi8RbgnqKLA5R1d9r6Hm1ic31p29vHjJ2XX+e2V2dI7j9kwpzvUCYxu2at
 55u6Wa2fP8C0kCE/6TQa15pg+YEb6KULU8SD63wjKqpbZmvKAnhXFMCs7kL2YyM6RqgbA194p
 VHVSueJ7zyEZo5a9vCiliX6WSYrxdIJUzFALKxjrFiqSPJ0OPW3wBogaXY6rV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tg3xdjfnxy6oryuh
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alex,

On Mon, Nov 09, 2020 at 12:02:18PM +0100, Alexandre Torgue wrote:
> Hi Alex
>=20
> On 10/31/20 2:54 PM, Alexander Dahl wrote:
> > Hei hei,
> >=20
> > On Tue, Oct 27, 2020 at 11:58:10AM +0100, Ahmad Fatoum wrote:
> > > Hello,
> > >=20
> > > On 10/27/20 11:05 AM, Alexander Dahl wrote:
> > > > Hello Ahmad,
> > > >=20
> > > > thanks for your feedback, comments below.
> > > >=20
> > >=20
> > > > > > -	led-rgb {
> > > > > > +	led-controller-2 {
> > > > >=20
> > > > > Is a single RGB LED really a controller?
> > > >=20
> > > > I just followed the recommendations by Rob here.
> > >=20
> > > Do you happen to know if the new multicolor LED support could be used=
 here?
> > >=20
> > > I find it unfortunate that the device tree loses information relevant=
 to humans
> > > to adhere to a fixed nomenclature. Apparently led-controller isn't ev=
en codified
> > > in the YAML binding (It's just in the examples). If you respin, pleas=
e add a
> > > comment that this is a single RGB led. I'd prefer to keep the informa=
tion
> > > in the DTB as well though.
> >=20
> > Slightly off-topic, but while I was working on the patch based on your
> > feedback I tried to find some information on that Linux Automation
> > MC-1 board.  However I could not find any? Is there some website, some
> > datasheet or maybe a schematic online?  The vendor prefix says "Linux
> > Automation GmbH", but I find only that USB-SD-Mux on their page?
> >=20
> > Greets
> > Alex
>=20
> I saw that Ahmad Acked this patch but regarding your discussion it seems
> there are opening questions. Are you going to send an update of it or can=
 I
> take it ?

I'll send an update, I already reworked this patch. I'm still waiting
for an Ack for the first patch of the series before sending the next
iteration, though. :-/

Greets
Alex

>=20
> regards
> alex
>=20
>=20
>=20
> >=20
> > >=20
> > >=20
> > >=20
> > > >=20
> > > > > >   		compatible =3D "pwm-leds";
> > > > > > -		led-red {
> > > > > > +		led-2 {
> > > > >=20
> > > > > Shouldn't this have been led-1 as well or is the numbering "globa=
l" ?
> > > >=20
> > > > Also good question. This numbering is for dts only, it usually does
> > > > not correspond with LEDs on the board, so it could be numbered per
> > > > led-controller as well?
> > >=20
> > > I'd prefer that it starts by 1. That way it's aligned with PWM channel
> > > ID.
> > >=20
> > > Thanks for fixing the dtschema warnings by the way!
> > >=20
> > > Cheers,
> > > Ahmad
> > >=20
> > > >=20
> > > > Greets
> > > > Alex
> > > >=20
> > > > >=20
> > > > > >   			label =3D "mc1:red:rgb";
> > > > > >   			pwms =3D <&leds_pwm 1 1000000 0>;
> > > > > >   			max-brightness =3D <255>;
> > > > > >   			active-low;
> > > > > >   		};
> > > > > > -		led-green {
> > > > > > +		led-3 {
> > > > > >   			label =3D "mc1:green:rgb";
> > > > > >   			pwms =3D <&leds_pwm 2 1000000 0>;
> > > > > >   			max-brightness =3D <255>;
> > > > > >   			active-low;
> > > > > >   		};
> > > > > > -		led-blue {
> > > > > > +		led-4 {
> > > > > >   			label =3D "mc1:blue:rgb";
> > > > > >   			pwms =3D <&leds_pwm 3 1000000 0>;
> > > > > >   			max-brightness =3D <255>;
> > > > > >=20
> > > > >=20
> > > > > --=20
> > > > > Pengutronix e.K.                           |                     =
        |
> > > > > Steuerwalder Str. 21                       | http://www.pengutron=
ix.de/  |
> > > > > 31137 Hildesheim, Germany                  | Phone: +49-5121-2069=
17-0    |
> > > > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-2069=
17-5555 |
> > > >=20
> > >=20
> > > --=20
> > > Pengutronix e.K.                           |                         =
    |
> > > Steuerwalder Str. 21                       | http://www.pengutronix.d=
e/  |
> > > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0=
    |
> > > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5=
555 |
> >=20
> >=20
> > _______________________________________________
> > Linux-stm32 mailing list
> > Linux-stm32@st-md-mailman.stormreply.com
> > https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
> >=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--=20
/"\ ASCII RIBBON | =BBWith the first link, the chain is forged. The first
\ / CAMPAIGN     | speech censured, the first thought forbidden, the
 X  AGAINST      | first freedom denied, chains us all irrevocably.=AB
/ \ HTML MAIL    | (Jean-Luc Picard, quoting Judge Aaron Satie)

--tg3xdjfnxy6oryuh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAl+pwPkACgkQNK3NAHIh
XMZDZBAAjQ9AjH65EFBg5Jlgg8u/x5tHb7W+lCSF046ptY9v/PF176asnwcl6QO6
WW9d//at/gyhxuWEvDQikYLOYG1sV8/0zg20av+Dmk+iKKOxVUdwvOpx3allksI2
v/B2GhzSWT8UT/npB5qNjRu8hQFAUwa0cO1SVNkCgffxiwcuBp6mXjvFRP6e10kx
VY7rxWTwDeys/DqrsNh1nPLdRUdxzTk7rsSuWU2j/0CUIgi68xLvYAkXKs5uU3Ld
oAzQCrrvUkqN3Boo3vYq6VAFfbhkv/6zoNLpbbVq72CXF2e80KTmdPIs4UdKFQ4B
dlyJgn40hqKGG8E+LExeGnFuD4Mh/ekdRHHY0ONYD2nB/g4VDR5WymE1k4GEW7Jz
IpNwiZ6WGDXY1Txib6TWdvNgaWZtut8jmk7oBTV9crQy0czRW7A3HouzRG19O23H
7Bine7fTrCGej+2AdBQEoErwuu/bYBrWc2iI6PTpU5VKKM1hLY/lhEnoKtNTTEgw
7qJhLID8bItqsVI4MRx/roGdbeAmlkPawAVkO53TS1kX9D+WcUKGi8J3w8MJ1WBC
w7MJd6WZ0ZMKGhPPr0hMKgphI1epebwS1aK1YWfsp2edPhEug0q0biJl3r/CIktz
Kr7tOZxeCgxWjg1jBl6C1AZ0zLKZCSYoWpeca6LaPfEsUwh1t98=
=Kw9j
-----END PGP SIGNATURE-----

--tg3xdjfnxy6oryuh--
