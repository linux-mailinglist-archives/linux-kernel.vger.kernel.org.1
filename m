Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4CE2DD99C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 21:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgLQUD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 15:03:58 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:60498 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLQUD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 15:03:58 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 986F620026;
        Thu, 17 Dec 2020 21:03:03 +0100 (CET)
Date:   Thu, 17 Dec 2020 21:03:02 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Guo Ren <guoren@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
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
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/2] futex: mark futex_detect_cmpxchg() as 'noinline'
Message-ID: <20201217200302.GB1523049@ravnborg.org>
References: <20190307091514.2489338-1-arnd@arndb.de>
 <X9S28TcEXd2zghzp@elver.google.com>
 <87czzeg5ep.fsf@nanos.tec.linutronix.de>
 <CAK8P3a0LWjNgwm605TM4dKCsn078X7NC3sEfdBSgcMNEocQ5iA@mail.gmail.com>
 <CAJF2gTRLEbBfZJ7Y6UNOMq-cwG5OYRW=+8Pfauz6v6R8ntBjYA@mail.gmail.com>
 <CAK8P3a3+WaQNyJ6Za2qfu6=0mBgU1hApnRXrdp1b1=P7wwyRUg@mail.gmail.com>
 <20201215193800.GA1098247@ravnborg.org>
 <CAK8P3a24eAYjPTw_GvEC5H9nGODjeKCVLSmfpoNSvrzew5BX4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a24eAYjPTw_GvEC5H9nGODjeKCVLSmfpoNSvrzew5BX4Q@mail.gmail.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=sAUyEq6cmD5XSRaL4sYA:9 a=CjuIK1q_8ugA:10
        a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> > I think we would be better served dropping support for sun4m and sun4d
> > from the kernel.
> 
> This seems appropriate as well to me.

I did a quick hack:
20 files changed, 40 insertions(+), 3051 deletions(-)

All the leon stuff is kept and there is room for more cleaning up.
The kernel can build a sparc32_defconfig with the Gaisler toochain.
This was a one hour quick hack that I cannot commit - it needs to be
split up to allow some resemble of review.

And it touched only arch/sparc/ - no sparc32 specific drivers were
dropped.

If we decide to chase this and we can drop sun4m/sun4d then maintaining
leon will be simpler as a nice side effect.

	Sam
