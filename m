Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D81B1BF996
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 15:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgD3NdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 09:33:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:40832 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbgD3NdR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:33:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 736E4AC69;
        Thu, 30 Apr 2020 13:33:14 +0000 (UTC)
Message-ID: <73e70f88919c253192f4d2e9bacd7fe27093ba57.camel@suse.de>
Subject: Re: [PATCH v2 1/2] arm: rpi: Add function to trigger VL805's
 firmware load
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     mbrugger@suse.com, u-boot@lists.denx.de, bmeng.cn@gmail.com,
        marex@denx.de, linux-kernel@vger.kernel.org, sjg@chromium.org,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com
Date:   Thu, 30 Apr 2020 15:33:13 +0200
In-Reply-To: <0161a6a5254871ce@bloch.sibelius.xs4all.nl>
References: <20200430130433.11248-1-nsaenzjulienne@suse.de>
         <20200430130433.11248-2-nsaenzjulienne@suse.de>
         <0161a6a5254871ce@bloch.sibelius.xs4all.nl>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-MNSqPPSvmFT1N7XYtoNT"
User-Agent: Evolution 3.36.2 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MNSqPPSvmFT1N7XYtoNT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-04-30 at 15:31 +0200, Mark Kettenis wrote:
> > From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> > Date: Thu, 30 Apr 2020 15:04:32 +0200
> >=20
> > On the Raspberry Pi 4, after a PCI reset, VL805's (a xHCI chip) firmwar=
e
> > may either be loaded directly from an EEPROM or, if not present, by the
> > SoC's VideoCore (the SoC's co-processor). Introduce the function that
> > informs VideoCore that VL805 may need its firmware loaded.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> >=20
> > ---
> > Changes since v1:
> >  - Rename function so it's not mistaken with regular firmware loading
> >=20
> >  arch/arm/mach-bcm283x/include/mach/mbox.h | 13 +++++++
> >  arch/arm/mach-bcm283x/include/mach/msg.h  |  7 ++++
> >  arch/arm/mach-bcm283x/msg.c               | 43 +++++++++++++++++++++++
> >  3 files changed, 63 insertions(+)
> >=20
> > diff --git a/arch/arm/mach-bcm283x/include/mach/mbox.h b/arch/arm/mach-
> > bcm283x/include/mach/mbox.h
> > index 60e226ce1d..2ae2d3d97c 100644
> > --- a/arch/arm/mach-bcm283x/include/mach/mbox.h
> > +++ b/arch/arm/mach-bcm283x/include/mach/mbox.h
> > @@ -491,6 +491,19 @@ struct bcm2835_mbox_tag_set_palette {
> >  	} body;
> >  };
> > =20
> > +#define BCM2835_MBOX_TAG_NOTIFY_XHCI_RESET          0x00030058
> > +
> > +struct bcm2835_mbox_tag_pci_dev_addr {
> > +	struct bcm2835_mbox_tag_hdr tag_hdr;
> > +	union {
> > +		struct {
> > +			u32 dev_addr;
> > +		} req;
> > +		struct {
> > +		} resp;
> > +	} body;
> > +};
> > +
> >  /*
> >   * Pass a raw u32 message to the VC, and receive a raw u32 back.
> >   *
> > diff --git a/arch/arm/mach-bcm283x/include/mach/msg.h b/arch/arm/mach-
> > bcm283x/include/mach/msg.h
> > index 4afb08631b..e45c1bf010 100644
> > --- a/arch/arm/mach-bcm283x/include/mach/msg.h
> > +++ b/arch/arm/mach-bcm283x/include/mach/msg.h
> > @@ -48,4 +48,11 @@ int bcm2835_set_video_params(int *widthp, int *heigh=
tp,
> > int depth_bpp,
> >  			     int pixel_order, int alpha_mode, ulong *fb_basep,
> >  			     ulong *fb_sizep, int *pitchp);
> > =20
> > +/**
> > + * bcm2711_load_vl805_firmware() - get vl805's firmware loaded
> > + *
> > + * @return 0 if OK, -EIO on error
> > + */
> > +int bcm2711_notify_vl805_reset(void);
>=20
> Now the comment and function prototype don't agree :(.

Aargh, went too fast... I'll fix it on the next revision.

Regards,
Nicolas


--=-MNSqPPSvmFT1N7XYtoNT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl6q05kACgkQlfZmHno8
x/6Nwwf+NZLKPXbv+Z6Cl2ePeiRzwi5VX30yi5+F/sMJK6nTt68rz6wVXzCg9SwO
gBr6Zjw7vRpyHIVW9KEher0oqvOvZPQdbFkmLFFLZtMXryNBT7dj/LUcw2ePP8Gb
mwItiBu3ABoql3XHBdfX9FNIrjibip2MKZuqtQN2g7d0Ch25liOnUP70aaJPy7kx
keTJWR1IdRzOofWJgBsKNXFM8sSXCXOJAbOXT/3YH+9oQbJKtH9CauJzIovj9Og9
4btjr36HxEghgi3VWfSoBCCZcuJ8VWV7ENKlziyrrA3H3j2TcJ2b2XKqjrPymeH+
V4+ZlNvsDwz/4i6uvYKvr7/Am06F6Q==
=JzSI
-----END PGP SIGNATURE-----

--=-MNSqPPSvmFT1N7XYtoNT--

