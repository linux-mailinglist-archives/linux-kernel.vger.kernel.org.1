Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A25072DB611
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 22:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgLOVXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 16:23:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:57114 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727896AbgLOVWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 16:22:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 695CEAC93;
        Tue, 15 Dec 2020 21:22:00 +0000 (UTC)
Message-ID: <0c29dbdb8c6b042dd1c2dd6f4ed3b113aba19d97.camel@suse.de>
Subject: Re: [PATCH 0/6] Expose RPi4'd bootloader configuration
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        devicetree@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>
Date:   Tue, 15 Dec 2020 22:21:59 +0100
In-Reply-To: <CAL_JsqJwUzBL+9E0jsTzAr4hTnGbGFUkD=xdTMJiFgYfpo4aFA@mail.gmail.com>
References: <20201215155627.2513-1-nsaenzjulienne@suse.de>
         <20201215184407.GA44849@C02TF0J2HF1T.local>
         <1e0ad098ca7b1c13dbc6602285b77790b9cd54a1.camel@suse.de>
         <CAL_JsqJwUzBL+9E0jsTzAr4hTnGbGFUkD=xdTMJiFgYfpo4aFA@mail.gmail.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-p4v4j9FxejBEde40K8yJ"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-p4v4j9FxejBEde40K8yJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob, thanks for having a look at this.

On Tue, 2020-12-15 at 13:54 -0600, Rob Herring wrote:
> On Tue, Dec 15, 2020 at 1:01 PM Nicolas Saenz Julienne
> <nsaenzjulienne@suse.de> wrote:
> >=20
> > Hi Catalin,
> >=20
> > On Tue, 2020-12-15 at 18:44 +0000, Catalin Marinas wrote:
> > > On Tue, Dec 15, 2020 at 04:56:20PM +0100, Nicolas Saenz Julienne wrot=
e:
> > > > Soon to be released versions of RPi4's firmware will take of care
> > > > passing their bootloader's configuration to the OS by copying it in=
to
> > > > memory and creating a reserved memory node in the board's DT. In or=
der
> > > > to make use of this information, this series introduces a new gener=
ic
> > > > nvmem driver that maps reserved-memory nodes into nvmem devices.
> > > >=20
> > > > An alternative approach, less nice IMO, would be to create a
> > > > platform-specific 'soc' driver.
> > >=20
> > > What kind of information is this and how would the kernel use it?
> >=20
> > Sorry, I wasn't clear enough, the ultimate goal is to use this informat=
ion from
> > user-space, through nvmem's sysfs interface. The kernel itself has no u=
se for
> > it.
>=20
> That still leaves the first question.

It's the bootloader configuration, stuff like boot order, TFTP IP, etc... S=
ee
more here:
https://www.raspberrypi.org/documentation/hardware/raspberrypi/bcm2711_boot=
loader_config.md

I'll add a new paragraph explaining all this on next version's cover letter=
.

Regards,
Nicolas


--=-p4v4j9FxejBEde40K8yJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl/ZKPcACgkQlfZmHno8
x/6MKgf7BO8gBlEQPizFY2pVw0UcI+ewT5fdSAO2v/tenS5h7UoAVU+hB/BzsI6E
0W0X9jBkKxTmL7ZYH6qE2A6E/7JJQ4VaGwxAjq8mmmqYuWq0qjZ/VeDiCOVz3pP/
ukelSJJWGKTex3/ylirX8QoKS31kgZkLstMjSZnDk8fG4y35QhpBgnlqACcPNGim
D91ybwJkGN75bVKRxysWsMMwkclek4ey6ILvrpVshpRyT3LJJKKoQGIeN1rHtbyi
7bncoTJB/eRIVelZZru5CSyZnWX905nils6TS6pb1RUGzp52x0R2V/eEFd5CaoZj
0liDYByLl+H8g9XHmhkttDu7A/zz+g==
=S4P/
-----END PGP SIGNATURE-----

--=-p4v4j9FxejBEde40K8yJ--

