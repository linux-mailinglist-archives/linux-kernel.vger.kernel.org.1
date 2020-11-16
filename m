Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C94752B52C4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 21:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733120AbgKPUjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 15:39:10 -0500
Received: from maynard.decadent.org.uk ([95.217.213.242]:52632 "EHLO
        maynard.decadent.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgKPUjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 15:39:10 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126] helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1kelHI-0003Bz-EW; Mon, 16 Nov 2020 21:39:08 +0100
Received: from ben by deadeye with local (Exim 4.94)
        (envelope-from <ben@decadent.org.uk>)
        id 1kelHH-00097f-Ag; Mon, 16 Nov 2020 20:39:07 +0000
Message-ID: <e18107c14e59672a179b4fe4d9918c311c0aa9e9.camel@decadent.org.uk>
Subject: Re: drivers/accessibility/speakup/serialio.c:48:19: warning:
 variable 'quot' set but not used
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Mon, 16 Nov 2020 20:39:02 +0000
In-Reply-To: <20201116203355.t7dboh6vlj57dsau@function>
References: <202011160942.AmYkxiJv-lkp@intel.com>
         <20201116190122.yslib3wicn45rbuo@function>
         <ef625c1e21c492be8c423730e45e90d92b1ae899.camel@decadent.org.uk>
         <20201116203355.t7dboh6vlj57dsau@function>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-zO1q+N+/584fGk3wK6e5"
User-Agent: Evolution 3.36.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 88.96.1.126
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zO1q+N+/584fGk3wK6e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-16 at 21:33 +0100, Samuel Thibault wrote:
> Ben Hutchings, le lun. 16 nov. 2020 19:51:23 +0000, a ecrit:
> > On Mon, 2020-11-16 at 20:01 +0100, Samuel Thibault wrote:
> > > Perhaps we should rather use
> > >=20
> > > depends on ISA || (X86 && COMPILE_TEST)
> > >=20
> > > ?
> > > so that we have compile testing on x86 only (where the inb/outb macro=
s
> > > always behave fine) to avoid such issues on other archs?
> >=20
> > That seems reasonable though unusual.
> >=20
> > > Or we tell the architecture maintainers to fix their out macros into
> > > consuming their parameters?
> > [...]
> >=20
> > It does seem odd for parisc to define the I/O functions this way.  I
> > don't know if it's really a bug.
>=20
> Sorry I wasn't clear: the problem here is when CONFIG_EISA is disabled,
> the eisa_in/out calls are replaced by BUG() stubs, and the stubs do not
> consume their input:

Yes, I did see that.

Ben.

> arch/parisc/include/asm/io.h
>=20
> #if defined(CONFIG_PCI)
> extern void outb(unsigned char b, int addr);
> #elif defined(CONFIG_EISA)
> #define outb eisa_out8
> #else
> #define outb(x, y)	BUG()
> #endif
>=20
> Samuel
--=20
Ben Hutchings
Everything should be made as simple as possible, but not simpler.
                                                      - Albert Einstein



--=-zO1q+N+/584fGk3wK6e5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAl+y42YACgkQ57/I7JWG
EQmeKQ/9HnaPJllzRlnZauq0VVAeVVEBvs6IHY4eVoOhRKITK2xyfu1bNLzTXXH+
gQv0rFWaGz6ebtfujeyqYE3irQohX4o1EUTxypQPUWhBCg4Isg19DpYohWguZabd
LURJWKjgiFCHC28+2qnW4uzoV7psQ6XmWOwcUlaEIEjJ+4AUBeM3mCA2hIfBDjty
J7EHM/x+oyMp/aWj2avUcLDP7sOANzkw6QJHUSvA1RHFS3gTlVAz6ubHkKUyXB8m
2BYd27AZpqq8DCCOf5KURRR1/TUEIwsYU8HyOsx8NL+jKQ3jA5m9qFpgAIOfMj8e
dc9kNSgLS6daIgyvhr6yO9lKO5V3VQpKbFEA+vhByko8w+2pAmI09e8+75PMlmDb
TnINz37PE0kD1DoRVw/ohKtQe8Dv8gJXxNR+SP7u/EbSOf34iH3GaaDmZ8ZFW8Zp
exsBnXrEt4KgbrXNxLP74nHMgeZtPb3g9LOMk2SDp09uj+GWLzLdk/Jk2tiIAQeF
gp+x+ViVaHXGjBkIqtZ8rG/wSKb/2/GuKlpjdr1PJRTtRz+jQRn+k7VbI5hG0EU/
IKwbCfKtewUvQeo37fkaNQi9PVke4EqksSaPEjutlh05lSrWeXRuSWBKZspCalNs
t43/PgxCQAXq58m3itcc5cPHu3GyQD8yLx/rxKRSX+m2/mHnuJs=
=Bw8u
-----END PGP SIGNATURE-----

--=-zO1q+N+/584fGk3wK6e5--
