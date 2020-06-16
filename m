Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DE31FB8DA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 18:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732671AbgFPPxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 11:53:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:56500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732382AbgFPPx0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:53:26 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8FD82ADF7;
        Tue, 16 Jun 2020 15:53:29 +0000 (UTC)
Message-ID: <5551ac7d9c7ba7df2b44832af49b3744869b34ef.camel@suse.de>
Subject: Re: [PATCH v3 2/3] ARM: bcm2835: Switch to use %ptT
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Stefan Wahren <wahrenst@gmx.net>,
        nsaenzjulienne <nsaenzjulienne@suse.de>
Date:   Tue, 16 Jun 2020 17:53:23 +0200
In-Reply-To: <20200415170046.33374-3-andriy.shevchenko@linux.intel.com>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
         <20200415170046.33374-3-andriy.shevchenko@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-An1EPALnBiHPDcFUotsT"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-An1EPALnBiHPDcFUotsT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2020-04-15 at 20:00 +0300, Andy Shevchenko wrote:
> Use %ptT instead of open coded variant to print content of
> time64_t type in human readable format.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---

as originally reported by Stefan Wahren, this patch is likely to be the cau=
se
for a regression on RPi3b+ 32bit mode (multi_v7_defconfig,
5.8.0-rc1-00019-ga5dc8300df75):

[    3.759892] raspberrypi-firmware soc:firmware: Attached to firmware from=
 18446744073709048425-02-19T15:52:16

Whereas the same doesn't seem to happen in 64bit mode:

[    1.584126] raspberrypi-firmware soc:firmware: Attached to firmware from=
 2020-02-12T12:39:27

Regards,
Nicolas



--=-An1EPALnBiHPDcFUotsT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7o6vMACgkQlfZmHno8
x/4gmQgAqty+scESDIzhwEdcS/2N46EWITboHLSxUecGyRA/4GPjCDtpkFATSZKs
wyj6FGZDmiCPGRBRt3UPVHkE6VSkP/dLgSlkDv6PiyEJrQv/KJy0EPPPFfu0OQa8
rPo0hnDbr/ncdiGz4+HyPtHPTBJBTcKvlWfOmq5ajwGGIRcLDcDmuA5H89IgQyAD
GyS8ClEqSuJS1taVX84PKlC6a3MFsu6g4VXUyGeaw3TgSvmJZuO0OESd+alTUVba
caG5ESBjcwQwKyyGSidFu3wInTNO1MQvACoPhUBo6Qmi7wa8brCInaiFJFbFsCbo
pdGUsAFmj6dQQ6eXnp4qgyySR5xjXQ==
=mMRZ
-----END PGP SIGNATURE-----

--=-An1EPALnBiHPDcFUotsT--

