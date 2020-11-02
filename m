Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE502A2800
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 11:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgKBKPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 05:15:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:48746 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728362AbgKBKPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 05:15:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A08C3AF2C;
        Mon,  2 Nov 2020 10:15:43 +0000 (UTC)
Message-ID: <de6362933a104fa81e38b1e7f8a8b540f37f069e.camel@suse.de>
Subject: Re: Hard lockup on Raspberry Pi 4 after v5.10-rc1
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-rpi-kernel@lists.infradead.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Mon, 02 Nov 2020 11:15:41 +0100
In-Reply-To: <20201102072900.GA2124436@ubuntu-m3-large-x86>
References: <20201102072900.GA2124436@ubuntu-m3-large-x86>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-r7OltOwC1wkoa8ne25RE"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-r7OltOwC1wkoa8ne25RE
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2020-11-02 at 00:29 -0700, Nathan Chancellor wrote:
> Hi everyone,
>=20
> Starting with v5.10-rc1, I appear to be experiencing hard lockups on my
> Raspberry Pi 4 when compiling LLVM. My standard workflow for testing the
> Raspberry Pi 4 has been compiling tip of tree LLVM (to catch host
> AArch64 issues), compiling linux-next ARCH=3Darm64 defconfig, then bootin=
g
> it with QEMU + KVM, which has caught a few issues so far. Starting with
> v5.10-rc1, compiling LLVM causes the serial console to print junk like
>=20
>  |=E2=96=92pp=E2=96=92p=E2=96=92p=E2=96=92p
>  p|=E2=96=92|=E2=96=92|p=E2=96=92p=E2=96=92p|=E2=96=92=E2=96=92|=E2=96=92=
|=E2=96=92|p|=E2=96=92=E2=96=92|=E2=96=92|=E2=96=92|
>  p=E2=96=92pp=E2=96=92=E2=96=92=E2=96=92|=E2=96=92=E2=96=92
>  =E2=96=92
>  =E2=96=92|=E2=96=92|=E2=96=92=E2=96=92=E2=96=92=E2=96=92
>  p=E2=96=92
>  =E2=96=92
>  =E2=96=92=E2=96=92
>  =E2=96=92
>  =E2=96=92p|p
>=20
> then I lose my mosh connection and I see the lights on the front of the
> Pi stop blinking.
>=20
> I have managed to narrow it down to a commit somewhere in the armsoc DT
> merge.
>=20
> Good: 2e368dd2bbea ("Merge tag 'armsoc-drivers' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc")
> Bad: e533cda12d8f ("Merge tag 'armsoc-dt' of
> git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc")
>=20
> I have not been able to complete a full bisect due to a lack of time
> unfortunately, I am sending this email to hopefully get some more eyes
> on the issue.
>=20
> $ head -n6 /boot/config.txt
> # My settings
> enable_uart=3D1
> core_freq_min=3D500
> kernel=3DImage
> os_prefix=3Dcustom-mainline-gcc-arm64/
> upstream_kernel=3D1
>=20
> $ cat /boot/.firmware_revision
> e8ddac7cd34b179efd702d4dc1efd0ccf44559b9
>=20
> I can reproduce the issue with:
>=20
> $ git clone --depth=3D1 https://github.com/llvm/llvm-project
>=20
> $ mkdir -p llvm-project/build && cd llvm-project/build
>=20
> $ cmake \
> -G Ninja \
> -DCMAKE_BUILD_TYPE=3DRelease \
> -DLLVM_ENABLE_PROJECTS=3D"clang;lld" \
> ../llvm &&
> ninja
>=20
> If you need any more information or testing, please let me know!

Thanks for the report! I'll have a look at it tomorrow.

Regards,
Nicolas


--=-r7OltOwC1wkoa8ne25RE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+f3E0ACgkQlfZmHno8
x/5pBAf8Cq/zso/3zLGGWh5+YRbtGn/c63hYTim11PFcAT3aj+XhawnAg/F8j9ll
v22w1HQqHEWGnkC3bbYD6BXUH0DzwOppb9CWIEVmwP4c2tJSXy18oetzj8UPQ2YO
v6NUlcOn3FIxyORSw0EYstiIFgZkbIOyJGoDCIOePuqA5RWGb1tp5/kujW10MkCw
zT6gU007d3agGml4utmyw4gE3vwljUwKOQv8ismuKfsB43WfRwefMhyIcsVoQzzc
bKv9xCWpqyVOwna+UhpakQ8uzoVyJF2BtKxTgX5qZgPOOl8qI1EpjaLLcPuPrt2l
JR+0GMjjT+1oQzbqRBcMpNTIqD+b2g==
=LEK+
-----END PGP SIGNATURE-----

--=-r7OltOwC1wkoa8ne25RE--

