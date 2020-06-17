Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77F981FCC01
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 13:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgFQLOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 07:14:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:40350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725967AbgFQLOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 07:14:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0EAFFAD2A;
        Wed, 17 Jun 2020 11:14:57 +0000 (UTC)
Message-ID: <40aadcbe828c71a2e148890b437330465c756f15.camel@suse.de>
Subject: Re: [PATCH v1] ARM: bcm2835: Fix integer overflow in
 rpi_firmware_print_firmware_revision()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Cc:     Stefan Wahren <wahrenst@gmx.net>, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Date:   Wed, 17 Jun 2020 13:14:50 +0200
In-Reply-To: <20200616163139.4229-1-andriy.shevchenko@linux.intel.com>
References: <20200616163139.4229-1-andriy.shevchenko@linux.intel.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ynQa6guyQFZObAY5epcQ"
User-Agent: Evolution 3.36.3 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ynQa6guyQFZObAY5epcQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-06-16 at 19:31 +0300, Andy Shevchenko wrote:
> time64_t is 64-bit width type, we are not supposed to supply lesser ones
> as in the case of rpi_firmware_print_firmware_revision() after the commit
> 4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT"). Use temporary variable
> of time64_t type to correctly handle lesser types.
>=20
> Fixes: 4a60f58ee002 ("ARM: bcm2835: Switch to use %ptT")
> Reported-by: Stefan Wahren <wahrenst@gmx.net>
> Reported-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---

Applied to fixes branch,

Thanks,
Nicolas


--=-ynQa6guyQFZObAY5epcQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl7p+yoACgkQlfZmHno8
x/5Riwf/fwhHo4BKrFvZ2tryVk+NyLoa1ypLPLc3+UOCOUgvltq62KtKZwEEMV1o
HtCNCp8PEEhkQmecy4pmf8ZJWwxGX+1Zxs5wkF0uCXeElx/nL4jV5rkjQXlYaUO5
io65R/SYGias/WQ654TzZ2OokH1MiT0ztVn2VwX0kArRrjlrKiW7NBSUhPIBcdRD
1Zz9X+RHnMb1JG9h96a1xdq52Rkbws3a1aIvYfBpiNfOLDNb7VPbg1Ey+LhF5egY
8xS4dFpNeBp4eIMBKHu/kgxMny3g2a6pjCQ0KufX6DSwRfzloqNDVtAO/G2bviBL
6PvLre+RG575hjoXfe3H6ufM1RVtsA==
=Gjqy
-----END PGP SIGNATURE-----

--=-ynQa6guyQFZObAY5epcQ--

