Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8503023D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 11:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbhAYKrR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Jan 2021 05:47:17 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:48998 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727561AbhAYKjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 05:39:35 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-268-EnfBxMR6OVGrbaoVYShqvw-1; Mon, 25 Jan 2021 10:37:39 +0000
X-MC-Unique: EnfBxMR6OVGrbaoVYShqvw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 25 Jan 2021 10:37:36 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 25 Jan 2021 10:37:36 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Candle Sun' <candlesea@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "natechancellor@gmail.com" <natechancellor@gmail.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "candle.sun@unisoc.com" <candle.sun@unisoc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>
Subject: RE: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
Thread-Topic: [PATCH] lkdtm: fix memory copy size for WRITE_KERN
Thread-Index: AQHW8v+fVpSBFdR3bUKo3QkF9iGP/qo4I1KA
Date:   Mon, 25 Jan 2021 10:37:36 +0000
Message-ID: <97d1f36a3b534b7fbd3790a0277ccaf5@AcuMS.aculab.com>
References: <20210125085622.2322-1-candlesea@gmail.com>
In-Reply-To: <20210125085622.2322-1-candlesea@gmail.com>
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

From: Candle Sun
> Sent: 25 January 2021 08:56
> 
> From: Candle Sun <candle.sun@unisoc.com>
> 
> Though do_overwritten() follows do_nothing() in source code, the final
> memory address order is determined by compiler. We can't always assume
> address of do_overwritten() is bigger than do_nothing(). At least the
> Clang we are using places do_overwritten() before do_nothing() in the
> object. This causes the copy size in lkdtm_WRITE_KERN() is *really*
> big and WRITE_KERN test on ARM32 arch will fail.
> 
> Compare the address order before doing the subtraction.

It isn't clear that helps.
Compile with -ffunction-sections and/or do LTO an there
is no reason at all why the functions should be together.

Even without that lkdtm_WRITE_KERN() could easily be between them.

You need to get the size of the 'empty function' from the
symbol table.

	David

> 
> Signed-off-by: Candle Sun <candle.sun@unisoc.com>
> ---
>  drivers/misc/lkdtm/perms.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 2dede2ef658f..fbfbdf89d668 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -31,13 +31,13 @@ static unsigned long ro_after_init __ro_after_init = 0x55AA5500;
>   * This just returns to the caller. It is designed to be copied into
>   * non-executable memory regions.
>   */
> -static void do_nothing(void)
> +static noinline void do_nothing(void)
>  {
>  	return;
>  }
> 
>  /* Must immediately follow do_nothing for size calculuations to work out. */
> -static void do_overwritten(void)
> +static noinline void do_overwritten(void)
>  {
>  	pr_info("do_overwritten wasn't overwritten!\n");
>  	return;
> @@ -110,15 +110,14 @@ void lkdtm_WRITE_RO_AFTER_INIT(void)
> 
>  void lkdtm_WRITE_KERN(void)
>  {
> -	size_t size;
> -	volatile unsigned char *ptr;
> +	unsigned long value_dow = (unsigned long)do_overwritten;
> +	unsigned long value_do =  (unsigned long)do_nothing;
> +	size_t size = (size_t)(value_dow > value_do ?
> +			value_dow - value_do : value_do - value_dow);
> 
> -	size = (unsigned long)do_overwritten - (unsigned long)do_nothing;
> -	ptr = (unsigned char *)do_overwritten;
> -
> -	pr_info("attempting bad %zu byte write at %px\n", size, ptr);
> -	memcpy((void *)ptr, (unsigned char *)do_nothing, size);
> -	flush_icache_range((unsigned long)ptr, (unsigned long)(ptr + size));
> +	pr_info("attempting bad %zu byte write at %px\n", size, do_overwritten);
> +	memcpy((void *)value_dow, (void *)value_do, size);
> +	flush_icache_range(value_dow, value_dow + (unsigned long)size);
>  	pr_err("FAIL: survived bad write\n");
> 
>  	do_overwritten();
> --
> 2.17.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

