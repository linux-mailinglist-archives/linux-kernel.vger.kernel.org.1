Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81EF52B06F4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbgKLNte convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Nov 2020 08:49:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54452 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727264AbgKLNtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:49:32 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-160-14xZjbThOIiOpSvgo6sl3w-1; Thu, 12 Nov 2020 13:49:27 +0000
X-MC-Unique: 14xZjbThOIiOpSvgo6sl3w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 12 Nov 2020 13:49:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 12 Nov 2020 13:49:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Rob Landley' <rob@landley.net>,
        kernel test robot <oliver.sang@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        0day robot <lkp@intel.com>,
        "lkp@lists.01.org" <lkp@lists.01.org>
Subject: RE: ac0e958a00:
 Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:run_init_process
Thread-Topic: ac0e958a00:
 Kernel_panic-not_syncing:stack-protector:Kernel_stack_is_corrupted_in:run_init_process
Thread-Index: AQHWuPBHLSpk3pJOe0+t4d8Pl80aaanEgitA
Date:   Thu, 12 Nov 2020 13:49:27 +0000
Message-ID: <2bd72a2f0af948d29eb201e3072e514e@AcuMS.aculab.com>
References: <20201112071145.GC17067@xsang-OptiPlex-9020>
 <87765a0e-3a49-d437-4010-4848b8ece199@landley.net>
In-Reply-To: <87765a0e-3a49-d437-4010-4848b8ece199@landley.net>
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

From: Rob Landley
> Sent: 12 November 2020 12:46
> 
> On 11/12/20 1:11 AM, kernel test robot wrote:
> >
> > Greeting,
> >
> > FYI, we noticed the following commit (built with gcc-9):
> 
> Blah, switched from strlcpy to sprintf due to the lack of spaces and didn't
> adjust the size.
> 
> (And yes, the compiler's lifetime analysis should free the stack space before
> the tail call, and I'd assume exec restarts the stack anyway.)
> 
> Second-attempt-by: Rob Landley <rob@landley.net>
> ---
> 
>  init/main.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 130376ec10ba..e92320816ef8 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -1328,15 +1328,16 @@ static void __init do_pre_smp_initcalls(void)
>  static int run_init_process(const char *init_filename)
>  {
>  	const char *const *p;
> +	char buf[512], *s = buf;
> 
>  	argv_init[0] = init_filename;
> -	pr_info("Run %s as init process\n", init_filename);
> -	pr_debug("  with arguments:\n");
> -	for (p = argv_init; *p; p++)
> -		pr_debug("    %s\n", *p);
> -	pr_debug("  with environment:\n");
> -	for (p = envp_init; *p; p++)
> -		pr_debug("    %s\n", *p);
> +
> +	for (p = (void *)envp_init; *p; p++)
> +		s += sprintf(s, "%.*s ", (int)(sizeof(buf)-(s-buf)-2), *p);
> +	for (p = (void *)argv_init; *p; p++)
> +		s += sprintf(s, "%.*s ", (int)(sizeof(buf)-(s-buf)-2), *p);
> +	pr_info("Run init: %s\n", buf);
> +

Why not use scnprintf() as:
	len += scnprintf(buf + len, 256 - len, " %s", *p);

or even:
	s = buf + sizeof buf;
	len = sizeof buf;
	...
		len -= scnprintf(s - len, len, " %s", *p);

and remove the " " before the %s in the final pr_info().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

