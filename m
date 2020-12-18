Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCF702DE1C7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 12:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389106AbgLRLJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 06:09:22 -0500
Received: from bin-mail-out-05.binero.net ([195.74.38.228]:42525 "EHLO
        bin-mail-out-05.binero.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732577AbgLRLJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 06:09:21 -0500
X-Halon-ID: 581e0ce0-4121-11eb-a542-005056917a89
Authorized-sender: andreas@gaisler.com
Received: from andreas.got.gaisler.com (h-98-128-223-123.na.cust.bahnhof.se [98.128.223.123])
        by bin-vsp-out-01.atm.binero.net (Halon) with ESMTPA
        id 581e0ce0-4121-11eb-a542-005056917a89;
        Fri, 18 Dec 2020 12:08:32 +0100 (CET)
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>, Guo Ren <guoren@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marco Elver <elver@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, software@gaisler.com
References: <20190307091514.2489338-1-arnd@arndb.de>
 <X9S28TcEXd2zghzp@elver.google.com> <87czzeg5ep.fsf@nanos.tec.linutronix.de>
 <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
 <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
 <20201215193800.GA1098247@ravnborg.org>
 <CAK8P3a24eAYjPTw_GvEC5H9nGODjeKCVLSmfpoNSvrzew5BX4Q@mail.gmail.com>
 <6a2c250a-2c7e-81c5-705a-5904c0fc91b8@gaisler.com>
 <CAK8P3a31LRref0UfsQ3AbyohZcTN6F=6qYA-dspMaadSkP8Vrw@mail.gmail.com>
From:   Andreas Larsson <andreas@gaisler.com>
Message-ID: <e9be6bfd-38da-cbfa-9b54-fc4d3dd94d14@gaisler.com>
Date:   Fri, 18 Dec 2020 12:08:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a31LRref0UfsQ3AbyohZcTN6F=6qYA-dspMaadSkP8Vrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-17 17:43, Arnd Bergmann wrote:
> It does make sense to require that a single kernel can work on all
> possible hardware. So if we remove sun4m/sun4d support, all that
> is left is LEON, and you likely wouldn't need to worry about other
> CPUs any more.
> 
> However, there is still the question whether a single kernel needs
> to work on LEON both with and without CASA. Do you still care
> about Linux users on LEON cores that do not support CASA, or is
> widespread enough that you just make it unconditional for both
> SMP and non-SMP?

We are fine with unconditional CASA for both SMP and non-SMP for LEON.


> I hope that you can make it to 5.10 then, as this contains the work
> I did for 64-bit time_t, which is required if you have users that want to
> run systems after 2038.

That is a good point! Thank you!


> FWIW, glibc-2.31 does not have support for 64-bit time_t yet, but I
> know there was interest in adding sparc support to the musl libc, which
> does support 64-bit time_t.

Yes, we will have to follow the developments regarding 64-bit time_t
in GLIBC as well.

-- 
Andreas
