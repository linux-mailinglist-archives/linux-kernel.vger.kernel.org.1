Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270EB2AD99D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbgKJPDV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Nov 2020 10:03:21 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:60728 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730853AbgKJPDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:03:20 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-264-Pa_8GOWQOlynPhI4iWLMJA-1; Tue, 10 Nov 2020 15:03:16 +0000
X-MC-Unique: Pa_8GOWQOlynPhI4iWLMJA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 10 Nov 2020 15:03:15 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 10 Nov 2020 15:03:15 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Yang Mingzhe' <cainiao666999@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "corbet@lwn.net" <corbet@lwn.net>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH] Documentation: x86: fix thread_info's position
Thread-Topic: [PATCH] Documentation: x86: fix thread_info's position
Thread-Index: AQHWt2zNmNlRN0bqL0my97PGUalbg6nBdF2A
Date:   Tue, 10 Nov 2020 15:03:15 +0000
Message-ID: <7766d351074242a8bc929b12857eed46@AcuMS.aculab.com>
References: <1605018060-11571-1-git-send-email-cainiao666999@gmail.com>
In-Reply-To: <1605018060-11571-1-git-send-email-cainiao666999@gmail.com>
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

From: Yang Mingzhe
> Sent: 10 November 2020 14:21
> 
> The bottom of the stack is where the first item was added to the stack,
> usually at the zero offset. Actually, the thread_info structure at the
> end of the stack.

Nope, most stacks 'grow down'.
So the first item pushed is at address 8k (for 8k stacks).

> Please see attached picture:
> https://github.com/Mutated1994/kernel-beginner/blob/master/kernel-stack.md
> 
> See commits c65eacb ("sched/core: Allow putting thread_info into
> task_struct"), 15f4eae ("x86: Move thread_info into task_struct")
> and 883d50f ("scripts/gdb: fix get_thread_info").
> 
> Signed-off-by: Yang Mingzhe <cainiao666999@gmail.com>
> ---
>  Documentation/x86/kernel-stacks.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/kernel-stacks.rst b/Documentation/x86/kernel-stacks.rst
> index 6b0bcf0..b88b9e12 100644
> --- a/Documentation/x86/kernel-stacks.rst
> +++ b/Documentation/x86/kernel-stacks.rst
> @@ -15,7 +15,9 @@ Like all other architectures, x86_64 has a kernel stack for every
>  active thread.  These thread stacks are THREAD_SIZE (2*PAGE_SIZE) big.
>  These stacks contain useful data as long as a thread is alive or a
>  zombie. While the thread is in user space the kernel stack is empty
> -except for the thread_info structure at the bottom.
> +except for the thread_info structure at the end (since kernel 4.9, the
> +thread_info has been moved into task_struct, no longer locates at the
> +end of kernel stack).

So 'bottom' - meaning address 0 is probably right.
Not sure what happens on the few architectures where pushing values
onto the stack does increase the stack pointer.

The bit about the kernel 4.9 changes doesn't read well at all.
I think the commas are just wrong.
You could say something like:

Prior to kernel 4.9 the thread_info structure was at the bottom
of the kernel stack. kernel 4.9 moved it into the task_struct.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

