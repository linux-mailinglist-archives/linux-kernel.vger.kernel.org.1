Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B498628FA6A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 23:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389908AbgJOVKV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 15 Oct 2020 17:10:21 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:58366 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389367AbgJOVKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 17:10:21 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-2-EK-J9T8gPN6LLxYYxqipNw-1;
 Thu, 15 Oct 2020 22:09:12 +0100
X-MC-Unique: EK-J9T8gPN6LLxYYxqipNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 15 Oct 2020 22:09:11 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 15 Oct 2020 22:09:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "clang-built-linux@googlegroups.com" 
        <clang-built-linux@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] compiler.h: Clarify comment about the need for
 barrier_data()
Thread-Topic: [PATCH] compiler.h: Clarify comment about the need for
 barrier_data()
Thread-Index: AQHWox7rJ5hC7vlNqk+GpAb0LFktmKmZJEvQ
Date:   Thu, 15 Oct 2020 21:09:11 +0000
Message-ID: <72958fd25e33490181b0df9413ec08b4@AcuMS.aculab.com>
References: <CAKwvOdkLvxeYeBh7Kx0gw7JPktPH8A4DomJTidUqA0jRQTR0FA@mail.gmail.com>
 <20201015181340.653004-1-nivedita@alum.mit.edu>
In-Reply-To: <20201015181340.653004-1-nivedita@alum.mit.edu>
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

From: Arvind Sankar
> Sent: 15 October 2020 19:14
> 
> Be clear about @ptr vs the variable that @ptr points to, and add some
> more details as to why the special barrier_data() macro is required.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  include/linux/compiler.h | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 93035d7fee0d..d8cee7c8968d 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -86,17 +86,28 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
> 
>  #ifndef barrier_data
>  /*
> - * This version is i.e. to prevent dead stores elimination on @ptr
> - * where gcc and llvm may behave differently when otherwise using
> - * normal barrier(): while gcc behavior gets along with a normal
> - * barrier(), llvm needs an explicit input variable to be assumed
> - * clobbered. The issue is as follows: while the inline asm might
> - * access any memory it wants, the compiler could have fit all of
> - * @ptr into memory registers instead, and since @ptr never escaped
> - * from that, it proved that the inline asm wasn't touching any of
> - * it. This version works well with both compilers, i.e. we're telling
> - * the compiler that the inline asm absolutely may see the contents
> - * of @ptr. See also: https://llvm.org/bugs/show_bug.cgi?id=15495
> + * This version is to prevent dead stores elimination on @ptr where gcc and
> + * llvm may behave differently when otherwise using normal barrier(): while gcc
> + * behavior gets along with a normal barrier(), llvm needs an explicit input
> + * variable to be assumed clobbered.
> + *
> + * Its primary use is in implementing memzero_explicit(), which is used for
> + * clearing temporary data that may contain secrets.
> + *
> + * The issue is as follows: while the inline asm might access any memory it
> + * wants, the compiler could have fit all of the variable that @ptr points to
> + * into registers instead, and if @ptr never escaped from the function, it
> + * proved that the inline asm wasn't touching any of it. gcc only eliminates
> + * dead stores if the variable was actually allocated in registers, but llvm
> + * reasons that the variable _could_ have been in registers, so the inline asm
> + * can't reliably access it anyway, and eliminates dead stores even if the
> + * variable is actually in memory.

I think I'd just say something like:

Although the compiler must assume a "memory" clobber may affect all
memory, local variables (on stack) cannot actually be visible to the
asm unless their address has been passed to an external function.
So the compiler may assume such variables cannot be affected by
a normal asm volatile(::"memory") barrier().
Passing the address of the local variables to the asm barrier
is enough to tell the compiler that the asm can 'see' the variables
(and spill anything held in registers to the stack) so that
the "memory" clobber has the expected effect.

This is necessary to get llvm to do a memset() of on-stack data
at the end of a function to clear memory that contains secrets.

	David

> + *
> + * This version works well with both compilers, i.e. we're telling the compiler
> + * that the inline asm absolutely may see the contents of the variable pointed
> + * to by @ptr.
> + *
> + * See also: https://llvm.org/bugs/show_bug.cgi?id=15495#c5
>   */
>  # define barrier_data(ptr) __asm__ __volatile__("": :"r"(ptr) :"memory")
>  #endif
> --
> 2.26.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

