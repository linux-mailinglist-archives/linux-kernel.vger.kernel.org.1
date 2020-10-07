Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB11285A61
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgJGIXU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Oct 2020 04:23:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:45032 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725976AbgJGIXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:23:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-140-tCMlWTACM9qFAvnA6D6HLA-1; Wed, 07 Oct 2020 09:23:15 +0100
X-MC-Unique: tCMlWTACM9qFAvnA6D6HLA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 7 Oct 2020 09:23:14 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 7 Oct 2020 09:23:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tony Luck' <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
CC:     Youquan Song <youquan.song@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 4/6] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Thread-Topic: [PATCH v3 4/6] x86/mce: Avoid tail copy when machine check
 terminated a copy from user
Thread-Index: AQHWnCT7Akl0tQfunEO6b5w/PLxMVqmLzKMA
Date:   Wed, 7 Oct 2020 08:23:14 +0000
Message-ID: <c994091cdc9d42718769f584b7d4a134@AcuMS.aculab.com>
References: <20201005163130.GD21151@zn.tnic>
 <20201006210910.21062-1-tony.luck@intel.com>
 <20201006210910.21062-5-tony.luck@intel.com>
In-Reply-To: <20201006210910.21062-5-tony.luck@intel.com>
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

From: Tony Luck
> Sent: 06 October 2020 22:09
> 
> In the page fault case it is ok to see if a few more unaligned bytes
> can be copied from the source address. Worst case is that the page fault
> will be triggered again.
> 
> Machine checks are more serious. Just give up at the point where the
> main copy loop triggered the #MC and return from the copy code as if
> the copy succeeded. The machine check handler will use task_work_add() to
> make sure that the task is sent a SIGBUS.

Isn't that just plain wrong?
If copy is reported as succeeding the kernel code will use the 'old'
data that is in the buffer as if it had been read from userspace.
This could end up with kernel stack data being written to a file.

Even zeroing the rest of the kernel buffer is wrong.

IIRC the code to try to maximise the copy has been removed.
So the 'slow' retry wont happen any more.

	David

> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/lib/copy_user_64.S | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
> index 5b68e945bf65..77b9b2a3b5c8 100644
> --- a/arch/x86/lib/copy_user_64.S
> +++ b/arch/x86/lib/copy_user_64.S
> @@ -15,6 +15,7 @@
>  #include <asm/asm.h>
>  #include <asm/smap.h>
>  #include <asm/export.h>
> +#include <asm/trapnr.h>
> 
>  .macro ALIGN_DESTINATION
>  	/* check for bad alignment of destination */
> @@ -221,6 +222,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
>   * Try to copy last bytes and clear the rest if needed.
>   * Since protection fault in copy_from/to_user is not a normal situation,
>   * it is not necessary to optimize tail handling.
> + * Don't try to copy the tail if machine check happened
>   *
>   * Input:
>   * rdi destination
> @@ -232,11 +234,24 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
>   */
>  SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
>  	movl %edx,%ecx
> +	cmp $X86_TRAP_MC,%eax		/* check if X86_TRAP_MC */
> +	je 3f
>  1:	rep movsb
>  2:	mov %ecx,%eax
>  	ASM_CLAC
>  	ret
> 
> +	/*
> +	 * Return zero to pretend that this copy succeeded. This
> +	 * is counter-intuitive, but needed to prevent the code
> +	 * in lib/iov_iter.c from retrying and running back into
> +	 * the poison cache line again. The machine check handler
> +	 * will ensure that a SIGBUS is sent to the task.
> +	 */
> +3:	xorl %eax,%eax
> +	ASM_CLAC
> +	ret
> +
>  	_ASM_EXTABLE_CPY(1b, 2b)
>  SYM_CODE_END(.Lcopy_user_handle_tail)
> 
> --
> 2.21.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

