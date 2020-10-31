Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3182A17FE
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 14:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgJaNyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 09:54:46 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43639 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbgJaNyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 09:54:46 -0400
Received: from methusalix.internal.home.lespocky.de ([109.250.100.133]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MTiHb-1kvZI83UCb-00U2mO; Sat, 31 Oct 2020 14:54:13 +0100
Received: from falbala.internal.home.lespocky.de ([192.168.243.94])
        by methusalix.internal.home.lespocky.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <post@lespocky.de>)
        id 1kYrKc-0007w5-MQ; Sat, 31 Oct 2020 14:54:11 +0100
Date:   Sat, 31 Oct 2020 14:54:09 +0100
From:   Alexander Dahl <post@lespocky.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexander Dahl <ada@thorsis.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [Linux-stm32] [PATCH v7 10/12] ARM: dts: stm32: Fix schema
 warnings for pwm-leds
Message-ID: <20201031135408.lgpiy5goa7l4cg2k@falbala.internal.home.lespocky.de>
Mail-Followup-To: Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Alexander Dahl <ada@thorsis.com>, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20201005203451.9985-1-post@lespocky.de>
 <20201005203451.9985-11-post@lespocky.de>
 <b387bda8-3643-1d27-4996-2aa4dc94d69f@pengutronix.de>
 <20201027100536.cpfizc67gwrolp2z@falbala.internal.home.lespocky.de>
 <f6ed201d-51b6-f278-7a95-3e3e49dc19ee@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ddtzb2gxy77t23sv"
Content-Disposition: inline
In-Reply-To: <f6ed201d-51b6-f278-7a95-3e3e49dc19ee@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Scan-Signature: 398b5fa1ed41958f905023f519330efd
X-Spam-Score: -2.9 (--)
X-Provags-ID: V03:K1:kOJxMHpGJCYtvBKRj3a5Ly8/ilfwpNNXI1ocWX5i5fr374VhsBt
 XY+3dWYOOSBqHrm0QBckVTKaVnpenhn7Uh2IlaJx6UC+1How4h/6RmzbZPI7EeF6UhXe6pK
 eKCecDo6OoX2+9Qb9Mt3PSNf8AhYm2ZcDajM/8GaKnr1hXnqw+FHr6wP9hYLA9ldvbjZuhV
 pi62QF0PirWPfLHq9QFxw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:tdONFEfhZCc=:cGmwJuBlzO3ekW8iSHTpqb
 jxAFgeN1rSd12PhXPzUSdS13qXWBFtnPArrSzrLH64aJ23ezNNhaW0E21f6bMf9KnEiveMYPJ
 kntm5B0u/IuV3f62ZgRn46eIGV76LjlbkXxG2KaJFEe8SEVcqgYJhvgHNufIMjLp02tpANaLg
 LEbI2AnxancoF0iKlLsxixftKZU8RcY7muxGTqvbiUZ6Mp0tm8MzymZZb0LiFi033FBhzpX6N
 M62vEo4VM8B0OE7IoOhpROVbfYWmQF7SnsQEOr0U83lAFDkggYBGSb0Irwhr/82NMHUM5sp/k
 t1C9n77YO/n7eqtoIKG3RXnryfv5LwmEjqVEYv8X2SXm4rL3ODpJJb3xpGCMp6NZCmp16F9Ho
 lOSAgG7pxo03Et3nlZ51Q0lxk32BoSQZVXQBJ0hjP/9fmpO9GaSoC26P7eaFP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ddtzb2gxy77t23sv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hei hei,

On Tue, Oct 27, 2020 at 11:58:10AM +0100, Ahmad Fatoum wrote:
> Hello,
>=20
> On 10/27/20 11:05 AM, Alexander Dahl wrote:
> > Hello Ahmad,
> >=20
> > thanks for your feedback, comments below.
> >=20
>=20
> >>> -	led-rgb {
> >>> +	led-controller-2 {
> >>
> >> Is a single RGB LED really a controller?
> >=20
> > I just followed the recommendations by Rob here.
>=20
> Do you happen to know if the new multicolor LED support could be used her=
e?
>=20
> I find it unfortunate that the device tree loses information relevant to =
humans
> to adhere to a fixed nomenclature. Apparently led-controller isn't even c=
odified
> in the YAML binding (It's just in the examples). If you respin, please ad=
d a
> comment that this is a single RGB led. I'd prefer to keep the information
> in the DTB as well though.

Slightly off-topic, but while I was working on the patch based on your
feedback I tried to find some information on that Linux Automation
MC-1 board.  However I could not find any? Is there some website, some
datasheet or maybe a schematic online?  The vendor prefix says "Linux
Automation GmbH", but I find only that USB-SD-Mux on their page?

Greets
Alex

>=20
>=20
>=20
> >=20
> >>>  		compatible =3D "pwm-leds";
> >>> =20
> >>> -		led-red {
> >>> +		led-2 {
> >>
> >> Shouldn't this have been led-1 as well or is the numbering "global" ?
> >=20
> > Also good question. This numbering is for dts only, it usually does
> > not correspond with LEDs on the board, so it could be numbered per
> > led-controller as well?
>=20
> I'd prefer that it starts by 1. That way it's aligned with PWM channel
> ID.
>=20
> Thanks for fixing the dtschema warnings by the way!
>=20
> Cheers,
> Ahmad
>=20
> >=20
> > Greets
> > Alex
> >=20
> >>
> >>>  			label =3D "mc1:red:rgb";
> >>>  			pwms =3D <&leds_pwm 1 1000000 0>;
> >>>  			max-brightness =3D <255>;
> >>>  			active-low;
> >>>  		};
> >>> =20
> >>> -		led-green {
> >>> +		led-3 {
> >>>  			label =3D "mc1:green:rgb";
> >>>  			pwms =3D <&leds_pwm 2 1000000 0>;
> >>>  			max-brightness =3D <255>;
> >>>  			active-low;
> >>>  		};
> >>> =20
> >>> -		led-blue {
> >>> +		led-4 {
> >>>  			label =3D "mc1:blue:rgb";
> >>>  			pwms =3D <&leds_pwm 3 1000000 0>;
> >>>  			max-brightness =3D <255>;
> >>>
> >>
> >> --=20
> >> Pengutronix e.K.                           |                          =
   |
> >> Steuerwalder Str. 21                       | http://www.pengutronix.de=
/  |
> >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0 =
   |
> >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-55=
55 |
> >=20
>=20
> --=20
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--=20
/"\ ASCII RIBBON | =BBWith the first link, the chain is forged. The first
\ / CAMPAIGN     | speech censured, the first thought forbidden, the
 X  AGAINST      | first freedom denied, chains us all irrevocably.=AB
/ \ HTML MAIL    | (Jean-Luc Picard, quoting Judge Aaron Satie)

--ddtzb2gxy77t23sv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAl+dbHwACgkQNK3NAHIh
XMbKlRAAvIubmqiN++XwaqH5hXCbf7EM1ob2W5t69Hrh3pjVgu/gK0SGLqeHHyNP
7FRMW6hMn3VFCFBaLrQL9ElCJ5gx9h9ZCRIJKR+EUsj8gWFOhs5/zqUnk2dkN8HD
845u1H7h+xQXCPI8CUVmBLGzQXlh/7vunQABDYFR5FJKAXRpZBmvHcwt6wDcmVng
jM93vIM2ixPIvjS2qEXYOCa7fh85GooXH4MSJ9oabFUM/uTfhRDogpq6q3uk5qz4
6STtbz6guRHBvIV4VMJeJucA4tfLJSV63GVtI3xbpUlNoiVGGQRq8MtJWQCvU1bi
pcHHw8Ydyzzf7QWk0H5fteboW/rYngD6J7Wxk2zcJNOBU7sgMiEgTIe25nuoub+E
X4LsGx3XBmhQGNSP7dCaeyZm2qhNASdGA3AdnSDPm4AmeXa6jJ1aH6jIl362KLS5
qhRNxo9j0CQu8QgqSTLBpG+A3ZdaLli7ErXdVgfgSj6Z+ku03iPkkJy1+uSyv9CW
YWQ4J2BwAmbUitBavgrYw74ES3WtssHTTicJ33zIARZ3vQT0HPR9bzjfKQ4BXwgd
r89naMgGERE2ifQ0maRQ02aenvX0V7JACCO4UbC7Zpv0jkkFYBbn5naGxTlokwPm
W1yNqL6VZv25zhzFFd7k7N9g3MbmNhaC8Gnj7BJBEMQ8o37HZJY=
=Iu4R
-----END PGP SIGNATURE-----

--ddtzb2gxy77t23sv--
