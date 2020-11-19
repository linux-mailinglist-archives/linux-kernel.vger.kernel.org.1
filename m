Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0E12B9942
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 18:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729270AbgKSRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 12:25:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:45266 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728945AbgKSRZd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 12:25:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94A7DAC22;
        Thu, 19 Nov 2020 17:25:31 +0000 (UTC)
Message-ID: <d232c68aa73e5c71524e3c9ef52386047af84386.camel@suse.de>
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     James Morse <james.morse@arm.com>, robh+dt@kernel.org, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        will@kernel.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org,
        Chen Zhou <chenzhou10@huawei.com>
Date:   Thu, 19 Nov 2020 18:25:29 +0100
In-Reply-To: <20201119171048.GD4376@gaia>
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
         <20201103173159.27570-2-nsaenzjulienne@suse.de>
         <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
         <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
         <X6rZRvWyigCJxAVW@trantor>
         <b5336064145a30aadcfdb8920226a8c63f692695.camel@suse.de>
         <20201113112901.GA3212@gaia>
         <ba343af12fc60bce36837cc090a39c9e42457788.camel@suse.de>
         <20201119171048.GD4376@gaia>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-9cQ0v5X6IA/r29m3PJ3m"
User-Agent: Evolution 3.36.5 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-9cQ0v5X6IA/r29m3PJ3m
Content-Type: multipart/mixed; boundary="=-HnSPaIR12nsnh7HdxWY+"


--=-HnSPaIR12nsnh7HdxWY+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2020-11-19 at 17:10 +0000, Catalin Marinas wrote:
> On Thu, Nov 19, 2020 at 03:09:58PM +0100, Nicolas Saenz Julienne wrote:
> > On Fri, 2020-11-13 at 11:29 +0000, Catalin Marinas wrote:
> > [...]
> > > > > > Let me stress that knowing the DMA constraints in the system be=
fore reserving
> > > > > > crashkernel's regions is necessary if we ever want it to work s=
eamlessly on all
> > > > > > platforms. Be it small stuff like the Raspberry Pi or huge serv=
ers with TB of
> > > > > > memory.
> > > > >=20
> > > > > Indeed. So we have 3 options (so far):
> > > > >=20
> > > > > 1. Allow the crashkernel reservation to go into the linear map bu=
t set
> > > > >    it to invalid once allocated.
> > > > >=20
> > > > > 2. Parse the flattened DT (not sure what we do with ACPI) before
> > > > >    creating the linear map. We may have to rely on some SoC ID he=
re
> > > > >    instead of actual DMA ranges.
> > > > >=20
> > > > > 3. Assume the smallest ZONE_DMA possible on arm64 (1GB) for crash=
kernel
> > > > >    reservations and not rely on arm64_dma_phys_limit in
> > > > >    reserve_crashkernel().
> > > > >=20
> > > > > I think (2) we tried hard to avoid. Option (3) brings us back to =
the
> > > > > issues we had on large crashkernel reservations regressing on som=
e
> > > > > platforms (though it's been a while since, they mostly went quiet=
 ;)).
> > > > > However, with Chen's crashkernel patches we end up with two
> > > > > reservations, one in the low DMA zone and one higher, potentially=
 above
> > > > > 4GB. Having a fixed 1GB limit wouldn't be any worse for crashkern=
el
> > > > > reservations than what we have now.
> > > > >=20
> > > > > If (1) works, I'd go for it (James knows this part better than me=
),
> > > > > otherwise we can go for (3).
> > > >=20
> > > > Overall, I'd prefer (1) as well, and I'd be happy to have a got at =
it. If not
> > > > I'll append (3) in this series.
> > >=20
> > > I think for 1 we could also remove the additional KEXEC_CORE checks,
> > > something like below, untested:
> > >=20
> > > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > > index 3e5a6913acc8..27ab609c1c0c 100644
> > > --- a/arch/arm64/mm/mmu.c
> > > +++ b/arch/arm64/mm/mmu.c
> > > @@ -477,7 +477,8 @@ static void __init map_mem(pgd_t *pgdp)
> > >  	int flags =3D 0;
> > >  	u64 i;
> > > =20
> > > -	if (rodata_full || debug_pagealloc_enabled())
> > > +	if (rodata_full || debug_pagealloc_enabled() ||
> > > +	    IS_ENABLED(CONFIG_KEXEC_CORE))
> > >  		flags =3D NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> > > =20
> > >  	/*
> > > @@ -487,11 +488,6 @@ static void __init map_mem(pgd_t *pgdp)
> > >  	 * the following for-loop
> > >  	 */
> > >  	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
> > > -#ifdef CONFIG_KEXEC_CORE
> > > -	if (crashk_res.end)
> > > -		memblock_mark_nomap(crashk_res.start,
> > > -				    resource_size(&crashk_res));
> > > -#endif
> > > =20
> > >  	/* map all the memory banks */
> > >  	for_each_mem_range(i, &start, &end) {
> > > @@ -518,21 +514,6 @@ static void __init map_mem(pgd_t *pgdp)
> > >  	__map_memblock(pgdp, kernel_start, kernel_end,
> > >  		       PAGE_KERNEL, NO_CONT_MAPPINGS);
> > >  	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
> > > -
> > > -#ifdef CONFIG_KEXEC_CORE
> > > -	/*
> > > -	 * Use page-level mappings here so that we can shrink the region
> > > -	 * in page granularity and put back unused memory to buddy system
> > > -	 * through /sys/kernel/kexec_crash_size interface.
> > > -	 */
> > > -	if (crashk_res.end) {
> > > -		__map_memblock(pgdp, crashk_res.start, crashk_res.end + 1,
> > > -			       PAGE_KERNEL,
> > > -			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
> > > -		memblock_clear_nomap(crashk_res.start,
> > > -				     resource_size(&crashk_res));
> > > -	}
> > > -#endif
> > >  }
> > > =20
> > >  void mark_rodata_ro(void)
> >=20
> > So as far as I'm concerned this is good enough for me. I took the time =
to
> > properly test crashkernel on RPi4 using the series, this patch, and ano=
ther
> > small fix to properly update /proc/iomem.
> >=20
> > I'll send v7 soon, but before, James (or anyone for that matter) any ob=
vious
> > push-back to Catalin's solution?
>=20
> I talked to James earlier and he was suggesting that we check the
> command line for any crashkernel reservations and only disable block
> mappings in that case, see the diff below on top of the one I already
> sent (still testing it).

That's even better :)

> If you don't have any other changes for v7, I'm happy to pick v6 up on
> top of the no-block-mapping fix.

Yes I've got a small change in patch #1, the crashkernel reservation has to=
 be
performed before request_standart_resouces() is called, which is OK, since
we're all setup by then, I moved the crashkernel reservation at the end of
bootmem_init(). I attached the patch. If it's easier for you I'll send v7.

Regards,
Nicolas


--=-HnSPaIR12nsnh7HdxWY+
Content-Disposition: attachment;
	filename="0001-arm64-mm-Move-reserve_crashkernel-into-mem_init.patch"
Content-Type: text/x-patch;
	name="0001-arm64-mm-Move-reserve_crashkernel-into-mem_init.patch";
	charset="UTF-8"
Content-Transfer-Encoding: base64

RnJvbSAwMGRkMmMzMWEwMjdjNDJmODBiNzY5OTBhNjg2MDAwYTM2Y2MzYmNmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOaWNvbGFzIFNhZW56IEp1bGllbm5lIDxuc2FlbnpqdWxpZW5u
ZUBzdXNlLmRlPgpEYXRlOiBXZWQsIDE0IE9jdCAyMDIwIDE0OjAyOjQ0ICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gYXJtNjQ6IG1tOiBNb3ZlIHJlc2VydmVfY3Jhc2hrZXJuZWwoKSBpbnRvIG1lbV9p
bml0KCkKCmNyYXNoa2VybmVsIG1pZ2h0IHJlc2VydmUgbWVtb3J5IGxvY2F0ZWQgaW4gWk9ORV9E
TUEuIFdlIHBsYW4gdG8gZGVsYXkKWk9ORV9ETUEncyBpbml0aWFsaXphdGlvbiBhZnRlciB1bmZs
YXR0ZW5pbmcgdGhlIGRldmljZXRyZWUgYW5kIEFDUEkncwpib290IHRhYmxlIGluaXRpYWxpemF0
aW9uLCBzbyBtb3ZlIGl0IGxhdGVyIGluIHRoZSBib290IHByb2Nlc3MuClNwZWNpZmljYWxseSBp
bnRvIGJvb3RtZW1faW5pdCgpIHNpbmNlIHJlcXVlc3Rfc3RhbmRhcmRfcmVzb3VyY2VzKCkKZGVw
ZW5kcyBvbiBpdC4KClNpZ25lZC1vZmYtYnk6IE5pY29sYXMgU2FlbnogSnVsaWVubmUgPG5zYWVu
emp1bGllbm5lQHN1c2UuZGU+ClRlc3RlZC1ieTogSmVyZW15IExpbnRvbiA8amVyZW15LmxpbnRv
bkBhcm0uY29tPgoKLS0tCgpDaGFuZ2VzIHNpbmNlIHY2OgogLSBNb3JlIHJlc2VydmUgcGxhY2Vt
ZW50IGVhcmxpZXIuCi0tLQogYXJjaC9hcm02NC9tbS9pbml0LmMgfCA4ICsrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvbW0vaW5pdC5jIGIvYXJjaC9hcm02NC9tbS9pbml0LmMKaW5kZXggNzFkNDYz
NTQ0NDAwLi5mYWZkZjk5MmZkMzIgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtNjQvbW0vaW5pdC5jCisr
KyBiL2FyY2gvYXJtNjQvbW0vaW5pdC5jCkBAIC0zODksOCArMzg5LDYgQEAgdm9pZCBfX2luaXQg
YXJtNjRfbWVtYmxvY2tfaW5pdCh2b2lkKQogCWVsc2UKIAkJYXJtNjRfZG1hMzJfcGh5c19saW1p
dCA9IFBIWVNfTUFTSyArIDE7CiAKLQlyZXNlcnZlX2NyYXNoa2VybmVsKCk7Ci0KIAlyZXNlcnZl
X2VsZmNvcmVoZHIoKTsKIAogCWhpZ2hfbWVtb3J5ID0gX192YShtZW1ibG9ja19lbmRfb2ZfRFJB
TSgpIC0gMSkgKyAxOwpAQCAtNDMwLDYgKzQyOCwxMiBAQCB2b2lkIF9faW5pdCBib290bWVtX2lu
aXQodm9pZCkKIAlzcGFyc2VfaW5pdCgpOwogCXpvbmVfc2l6ZXNfaW5pdChtaW4sIG1heCk7CiAK
KwkvKgorCSAqIHJlcXVlc3Rfc3RhbmRhcmRfcmVzb3VyY2VzKCkgZGVwZW5kcyBvbiBjcmFzaGtl
cm5lbCdzIG1lbW9yeSBiZWluZworCSAqIHJlc2VydmVkLCBzbyBkbyBpdCBoZXJlLgorCSAqLwor
CXJlc2VydmVfY3Jhc2hrZXJuZWwoKTsKKwogCW1lbWJsb2NrX2R1bXBfYWxsKCk7CiB9CiAKLS0g
CjIuMjkuMgoK


--=-HnSPaIR12nsnh7HdxWY+--

--=-9cQ0v5X6IA/r29m3PJ3m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl+2qokACgkQlfZmHno8
x/7inAf8C64zjRlGkNi91iy/N/4C4L0YH7dfUqSq4u0zc+pOXMa2BmWS8dpsFZwL
lYvuQgPxpXcCMQ4KG0jzKUMMEunEj/bNszPTPGHH7g5Nasl5w59hUe/J3sqPyWst
+T42/1Z0PPmK7wYftnd/yLFXpe9ROhbi59t1BiOuh3LaQVqgJv/OzuNPGZt60Lpo
j4uA9uo4+VKZv7s9LuiGpkw05r/B2PsjXGMCw53byVUFtgpVVfhenvpLF4QyMrBO
rtKfNA/W5IgXUH7Ip63HOpLbacOOcUgrItw6inKWOfJFj+OglgMJ5Z79S4n9pdzF
AAe1Ses1dBw18fzSiliXpRym9MIbDg==
=Whpb
-----END PGP SIGNATURE-----

--=-9cQ0v5X6IA/r29m3PJ3m--

