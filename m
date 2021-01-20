Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC62FCE1E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jan 2021 11:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732225AbhATKRv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 20 Jan 2021 05:17:51 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:24105 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731478AbhATJet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 04:34:49 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-136-FlUOqhZwNni2kAj9MZ8Nhg-1; Wed, 20 Jan 2021 09:33:01 +0000
X-MC-Unique: FlUOqhZwNni2kAj9MZ8Nhg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 20 Jan 2021 09:33:00 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 Jan 2021 09:33:00 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        "Michael Ellerman" <mpe@ellerman.id.au>
CC:     "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] powerpc/44x: Remove STDBINUTILS kconfig option
Thread-Topic: [PATCH 2/2] powerpc/44x: Remove STDBINUTILS kconfig option
Thread-Index: AQHW7wFdZXRNi2FVUEGR2+8ye/HSkqowP30w
Date:   Wed, 20 Jan 2021 09:33:00 +0000
Message-ID: <e19c6d6bf92d4f7399a939c7c3c7ad0d@AcuMS.aculab.com>
References: <2fed79b1154c872194f98bac4422c23918325e61.1611128938.git.christophe.leroy@csgroup.eu>
 <f9981e819009aa121a998dc483052ec76f78f991.1611128938.git.christophe.leroy@csgroup.eu>
In-Reply-To: <f9981e819009aa121a998dc483052ec76f78f991.1611128938.git.christophe.leroy@csgroup.eu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Leroy
> Sent: 20 January 2021 07:49
> 
> STDBINUTILS is just a toggle to allow 256k page size
> to appear in the possible page sizes list for the 44x.
> 
> Make 256k page size appear all the time with an
> explicit warning on binutils, and remove this unneccessary
> STDBINUTILS config option.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/Kconfig | 27 +++++++--------------------
>  1 file changed, 7 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index a685e42d3993..3e29995540a7 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -720,18 +720,6 @@ config ARCH_MEMORY_PROBE
>  	def_bool y
>  	depends on MEMORY_HOTPLUG
> 
> -config STDBINUTILS
> -	bool "Using standard binutils settings"
> -	depends on 44x
> -	default y
> -	help
> -	  Turning this option off allows you to select 256KB PAGE_SIZE on 44x.
> -	  Note, that kernel will be able to run only those applications,
> -	  which had been compiled using binutils later than 2.17.50.0.3 with
> -	  '-zmax-page-size' set to 256K (the default is 64K). Or, if using
> -	  the older binutils, you can patch them with a trivial patch, which
> -	  changes the ELF_MAXPAGESIZE definition from 0x10000 to 0x40000.
> -
>  choice
>  	prompt "Page size"
>  	default PPC_4K_PAGES
> @@ -771,17 +759,16 @@ config PPC_64K_PAGES
>  	select HAVE_ARCH_SOFT_DIRTY if PPC_BOOK3S_64
> 
>  config PPC_256K_PAGES
> -	bool "256k page size"
> -	depends on 44x && !STDBINUTILS && !PPC_47x
> +	bool "256k page size (Requires non-standard binutils settings)"
> +	depends on 44x && !PPC_47x
>  	help
>  	  Make the page size 256k.
> 
> -	  As the ELF standard only requires alignment to support page
> -	  sizes up to 64k, you will need to compile all of your user
> -	  space applications with a non-standard binutils settings
> -	  (see the STDBINUTILS description for details).
> -
> -	  Say N unless you know what you are doing.
> +	  That kernel will be able to run only those applications,
> +	  which had been compiled using binutils later than 2.17.50.0.3 with
> +	  '-zmax-page-size' set to 256K (the default is 64K). Or, if using
> +	  the older binutils, you can patch them with a trivial patch, which
> +	  changes the ELF_MAXPAGESIZE definition from 0x10000 to 0x40000.


The kernel will only be able to run applications that have been
compiled with '-zmax-page-size' set to 256K (the default is 64K)
using binutils later than 2.17.50.0.3, or by patching the
ELF_MAXPAGESIZE definition from 0x10000 to 0x40000 in older versions.

> 
>  endchoice
> 
> --
> 2.25.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

