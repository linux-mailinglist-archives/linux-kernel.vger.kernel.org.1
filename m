Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8DCA2E082E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgLVJgQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Dec 2020 04:36:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26234 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726239AbgLVJgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:36:15 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-196-qd9Zl8UVMnGI_v8OB6DO1A-1; Tue, 22 Dec 2020 09:34:36 +0000
X-MC-Unique: qd9Zl8UVMnGI_v8OB6DO1A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 22 Dec 2020 09:34:35 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 22 Dec 2020 09:34:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Palmer Dabbelt' <palmer@dabbelt.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
CC:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@android.com" <kernel-team@android.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        "kernel test robot" <lkp@intel.com>
Subject: RE: [PATCH] clocksource: clint: Avoid remove __iomem in
 get_cycles_hi()
Thread-Topic: [PATCH] clocksource: clint: Avoid remove __iomem in
 get_cycles_hi()
Thread-Index: AQHW2CRMsP4vu/w5w0ydjz0Xpj6lf6oC2pkg
Date:   Tue, 22 Dec 2020 09:34:35 +0000
Message-ID: <ccc783075aac4ee2b0b43c4644cc992f@AcuMS.aculab.com>
References: <20201222053230.3229427-1-palmer@dabbelt.com>
In-Reply-To: <20201222053230.3229427-1-palmer@dabbelt.com>
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

From: Palmer Dabbelt
> Sent: 22 December 2020 05:33
> 
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> This cast loses the __iomem qualifier from clint_timer_val, which
> triggers an sparse warning.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  drivers/clocksource/timer-clint.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index 6cfe2ab73eb0..83a8b38d46f6 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -63,7 +63,7 @@ static struct riscv_ipi_ops clint_ipi_ops = {
>  #define clint_get_cycles()	readq_relaxed(clint_timer_val)
>  #else
>  #define clint_get_cycles()	readl_relaxed(clint_timer_val)
> -#define clint_get_cycles_hi()	readl_relaxed(((u32 *)clint_timer_val) + 1)
> +#define clint_get_cycles_hi()	readl_relaxed(((u32 __iomem *)clint_timer_val) + 1)
>  #endif

The correct fix is (probably) to define clint_timer_val as u32 on 32bit systems.

Oh - and get rid of those #defines, they are only used in the
functions just below them.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

