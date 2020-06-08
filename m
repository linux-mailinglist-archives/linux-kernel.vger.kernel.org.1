Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0D61F264B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 01:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgFHXgj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 19:36:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728175AbgFHXge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:36:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1CBC08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 16:36:34 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jiRJY-0002nN-Ul; Tue, 09 Jun 2020 01:36:25 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 65786101181; Tue,  9 Jun 2020 01:36:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "maz\@kernel.org" <maz@kernel.org>,
        "Saidi\, Ali" <alisaidi@amazon.com>
Cc:     "jason\@lakedaemon.net" <jason@lakedaemon.net>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel\@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "Woodhouse\, David" <dwmw@amazon.co.uk>,
        "Zilberman\, Zeev" <zeev@amazon.com>,
        "Machulsky\, Zorik" <zorik@amazon.com>
Subject: Re: [PATCH] irqchip/gic-v3-its: Don't try to move a disabled irq
In-Reply-To: <0940571f9daa9829f70616b3036a2b3b3f25953c.camel@kernel.crashing.org>
References: <AE04B507-C5E2-44D2-9190-41E9BE720F9D@amazon.com> <622fb6be108e894ee365d6b213535c8b@kernel.org> <f9e9d8c37eb92e4b9576bfcb4386ff6ef00eddce.camel@amazon.com> <87mu5dacs7.fsf@nanos.tec.linutronix.de> <0940571f9daa9829f70616b3036a2b3b3f25953c.camel@kernel.crashing.org>
Date:   Tue, 09 Jun 2020 01:36:24 +0200
Message-ID: <873675870n.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben,

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Mon, 2020-06-08 at 15:48 +0200, Thomas Gleixner wrote:
>> > 	if (cpu != its_dev->event_map.col_map[id]) {
>> > 		target_col = &its_dev->its->collections[cpu];
>> > -		its_send_movi(its_dev, target_col, id);
>> > +
>> > +		/* If the IRQ is disabled a discard was sent so don't move */
>> > +		if (!irqd_irq_disabled(d))
>> 
>> That check needs to be !irqd_is_activated() because enable_irq() does
>> not touch anything affinity related.
>
> Right. Note: other  drivers  (like arch/powerpc/sysdev/xive/common.c
> use irqd_is_started() ... this gets confusing :)

Blast from the past ...

arch/powerpc does not use hierarchical irq domains, so the activated
state does not matter there.


>> > +			its_send_movi(its_dev, target_col, id);
>> > +
>> > 		its_dev->event_map.col_map[id] = cpu;
>> > 		irq_data_update_effective_affinity(d, cpumask_of(cpu));
>> 
>> And then these associtations are disconnected from reality in any case.
>
> Not sure what you mean here, that said...

You skip the setup and then you set that state to look like it really
happened. How is that NOT disconnected from reality and a proper source
for undecodable failure later on beause something else subtly depends on
that state?

>> Something like the completely untested patch below should work.
>
> Ok. One possible issue though is before, the driver always had the
> opportunity to "vet" the affinity mask for whatever platform
> constraints may be there and change it before applying it. This is no
> longer the case on a deactivated interrupt with your patch as far as I
> can tell. I don't know if that is a problem and if drivers that do that
> have what it takes to "fixup" the affinity at startup time, the ones I
> wrote don't need that feature, but...

The driver still has the opportunity to do so when the interrupt is
acticated. And if you look at the conditions of that patch it carefully
applies this only to architectures which actually use hiearachical irq
domains. Everything else including good old PPC won't notice at all.

>> Thanks,
>> 
>>         tglx

<SNIP 60+ lines of useless information ....>

Can you please trim your replies?

Thanks,

        tglx
