Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 607301AAA43
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 16:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370786AbgDOOjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 10:39:03 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:33429 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634316AbgDOOgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:36:09 -0400
Received: from methusalix.internal.home.lespocky.de ([92.117.44.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSKq0-1jrQ5p0Ebw-00ShhZ; Wed, 15 Apr 2020 16:35:29 +0200
Received: from falbala.internal.home.lespocky.de ([192.168.243.94])
        by methusalix.internal.home.lespocky.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92.3)
        (envelope-from <post@lespocky.de>)
        id 1jOj8M-0000YX-Nj; Wed, 15 Apr 2020 16:35:26 +0200
Date:   Wed, 15 Apr 2020 16:35:21 +0200
From:   Alexander Dahl <post@lespocky.de>
To:     x86@kernel.org
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Wolters <florian@florian-wolters.de>,
        Alexander Dahl <post@lespocky.de>
Subject: Re: [PATCH v2] dma: Fix max PFN arithmetic overflow on 32 bit systems
Message-ID: <20200415143519.iev6r4llqs3hwtgz@falbala.internal.home.lespocky.de>
Mail-Followup-To: x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org,
        Alan Jenkins <alan.christopher.jenkins@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Wolters <florian@florian-wolters.de>
References: <20200319153154.usbqsk6uspegw5pr@falbala.internal.home.lespocky.de>
 <20200321182823.1912-1-post@lespocky.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ahhticrbe2tikgv5"
Content-Disposition: inline
In-Reply-To: <20200321182823.1912-1-post@lespocky.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Scan-Signature: da85ea8975133f28083df41d042c8ce6
X-Spam-Score: -2.7 (--)
X-Provags-ID: V03:K1:IVw6I1Kpwa21fkaHCKwXojjV4/ttMR/aUvFUOzfL6qppUNnSm/b
 UOdZ95kulgEkWlmiCSwgMdour6+Xv+i2p8MV8SEK3zkp+1lqYiGp8hlNfWswyh69gW3vtVI
 mriMwnD7dgb+d9KcTN/AFzj+b1T7QGV88jn7/JZwq0CdnukucuS7MczDc7i5LE7J46w4bxK
 J31vvASfiEIOJjjq+PeJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:38CJH6+4tJU=:sbqlGgtb9QRA8SmwEjQnUt
 0/9BGzpd/YLLHpDLnuSR9wokBVkVI3gbEUeW1FumvI7RwHg3Mvkxu7fXAppyto5l4qQS7+IwX
 OoXfEX6sGSzVMPTTdnQllS3l6sVHTshwbUv+Z4fEmbV1JhPxe3JmnKx/3X+93KRA3oVh93ihY
 YhaL9yYWRcA+rddzxZMXr865rT2gCMrr515MOrseLaboI/0vesg8WFN5qcfwJwkQjRbImr0u3
 COJcYoV2Lg2s044wTg1wj3eQ0aOq1YqiyI9q/dg+ZChcip0D8N7IIbSHm00Uk0bHH1wpROrW3
 +/U4K64rvuQ4p/uYu5YBUHvfEHnjdIbaFZrph1l8Cb8V9wokdy81da0i0vXeXRDcy5nRgiyQ+
 9ZHTNmKXjiHELFKjRA0rpzrVdR4yLiJMXDnCr4PTKm4zWn+hkS/4XvGTuw6Buqrh939ZEbE6x
 S6TJr3Fgt80SmR87vHpkHqFkisty7jeKdm7T1U61VZXPscz7LRmterhRdNknMPRh5lgnIvOeW
 gse+ZgqgLSYc1kDTG6A/8964M6Il6BQFXHNWOc27ahFWMKy0/KEilmc0FghjLRA26wvAqUPcL
 GplUXb+Rh03iEEYr8/GAfve0PZfi2xzls5KwdyHnBTYbvBnVK1yfl7PswA5jpB9LtO1DJ2vQg
 XfWelXTM09gDIwC4sXMFTndqbQs0NrY5akjoTD8KesMAD9ohzxP+m8g4noU2QOzfeteBFisCx
 VOpi71/ridCEWDBz2hnN7eeP/pBCKwWhAtM5/YmqwXlU6IIrvlgJ9gCsFzyWuMQCs6c2NXDEw
 IrRmrpWt5jTVO6zV78m4waZQ3WKI7kAzJN+Ed1Us2Bl0ieWI6BoUH1jbnKBXFqaM+mANAJJ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ahhticrbe2tikgv5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

now after v5.7-rc1 is out, I would kindly ask, if anyone had time to
review this one line patch? Is anything wrong with that fix?

(I added the current fli4l kernel package maintainer Florian to Cc to
let him know I'm still having an eye on this.)

Greets
Alex

On Sat, Mar 21, 2020 at 07:28:23PM +0100, Alexander Dahl wrote:
> For ARCH=3Dx86 (32 bit) when you set CONFIG_IOMMU_INTEL since c5a5dc4cbbf4
> ("iommu/vt-d: Don't switch off swiotlb if bounce page is used") there's
> a dependency on CONFIG_SWIOTLB, which was not necessarily active before.
>=20
> The init code for swiotlb in 'pci_swiotlb_detect_4gb()' compares
> something against MAX_DMA32_PFN to decide if it should be active.
> However that define suffers from an arithmetic overflow since
> 1b7e03ef7570 ("x86, NUMA: Enable emulation on 32bit too") when it was
> first made visible to x86_32.
>=20
> The effect is at boot time 64 MiB (default size) were allocated for
> bounce buffers now, which is a noticeable amount of memory on small
> systems. We noticed this effect on the fli4l Linux distribution when
> migrating from kernel v4.19 (LTS) to v5.4 (LTS) on boards like pcengines
> ALIX 2D3 with 256 MiB memory for example:
>=20
>   Linux version 5.4.22 (buildroot@buildroot) (gcc version 7.3.0 (Buildroo=
t 2018.02.8)) #1 SMP Mon Nov 26 23:40:00 CET 2018
>   =E2=80=A6
>   Memory: 183484K/261756K available (4594K kernel code, 393K rwdata, 1660=
K rodata, 536K init, 456K bss , 78272K reserved, 0K cma-reserved, 0K highme=
m)
>   =E2=80=A6
>   PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
>   software IO TLB: mapped [mem 0x0bb78000-0x0fb78000] (64MB)
>=20
> The initial analysis and the suggested fix was done by user 'sourcejedi'
> at stackoverflow and explicitly marked as GPLv2 for inclusion in the
> Linux kernel:
>=20
>   https://unix.stackexchange.com/a/520525/50007
>=20
> The actual calculation however is the same as for arch/mips now as
> suggested by Robin Murphy.
>=20
> Fixes: https://web.nettworks.org/bugs/browse/FFL-2560
> Fixes: https://unix.stackexchange.com/q/520065/50007
> Reported-by: Alan Jenkins <alan.christopher.jenkins@gmail.com>
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Alexander Dahl <post@lespocky.de>
> ---
>=20
> Notes:
>     v1 -> v2:
>       - use the same calculation as with arch/mips (Robin Murphy)
>=20
>  arch/x86/include/asm/dma.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/include/asm/dma.h b/arch/x86/include/asm/dma.h
> index 00f7cf45e699..8e95aa4b0d17 100644
> --- a/arch/x86/include/asm/dma.h
> +++ b/arch/x86/include/asm/dma.h
> @@ -74,7 +74,7 @@
>  #define MAX_DMA_PFN   ((16UL * 1024 * 1024) >> PAGE_SHIFT)
> =20
>  /* 4GB broken PCI/AGP hardware bus master zone */
> -#define MAX_DMA32_PFN ((4UL * 1024 * 1024 * 1024) >> PAGE_SHIFT)
> +#define MAX_DMA32_PFN (1UL << (32 - PAGE_SHIFT))
> =20
>  #ifdef CONFIG_X86_32
>  /* The maximum address that we can perform a DMA transfer to on this pla=
tform */
> --=20
> 2.20.1
>=20
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

--=20
/"\ ASCII RIBBON | =C2=BBWith the first link, the chain is forged. The first
\ / CAMPAIGN     | speech censured, the first thought forbidden, the
 X  AGAINST      | first freedom denied, chains us all irrevocably.=C2=AB
/ \ HTML MAIL    | (Jean-Luc Picard, quoting Judge Aaron Satie)

--ahhticrbe2tikgv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEwo7muQJjlc+Prwj6NK3NAHIhXMYFAl6XG6IACgkQNK3NAHIh
XMbmog//e9M196yeEg88JKJH2mpdtfl60nTuzTfAj+jq/iuzzPTdrzfyBPqIhR97
DoG+nyi5M9OoBHtRNbruPAicBCjJGoiAvF7kI8fJkdbppDbxxIK4SwZfvB9SBTn9
YfW0l16y7OaAtTU8tGkiHpIl+D/uvEjlvoaxsYj12fZA5m/3V0FV5yCLPOAaUvMC
dJZ2Jhyyqk56M/6uCJsoYixeFnKZplOJE9RoNlSQVgFnjVPQVzJn+vgBpyBPpuLM
qNxxFFv8oA6tZD7coxL25Dkse9r/qTiT4aox+k9OtoHD0aLJBeBUBuQxXHCSuzOq
+ubisc0GxSIasuLlQzi2PshoxpUPgzTAAYSPmJs/fUFMCKz8YuMRRZiZdOWD9RRi
AZ5S5t7/A0AodDQEMDJ235xtAXIVQgF5yMdn7ihwhrtjeQkhFaCjFkMwkXs7ezwY
1fOmETmU8wJRsiKYgjsRpG47oX0wXquhJ6wCJNDvAE1V42ZfARGAtquG+i3D5XFU
Z3rav+9lc+ezeKX+Wb7e98GYL2v7FqT+G8U75A4otq+hZSUeD7gfhzNCKPqwzi5K
m2+9jchVeWaHyD+h0wYIiEUSS0snv//bw9I8iUhaNmtOC7obnGuRLaRC6r53TZeR
VhSG72hOG9MBVDfXp+abOL4PmBaziGcAN973BwGrtO3STpxKVbw=
=PSc6
-----END PGP SIGNATURE-----

--ahhticrbe2tikgv5--
