Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C271B2A1E89
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 15:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgKAOdK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 1 Nov 2020 09:33:10 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:29753 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726370AbgKAOdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 09:33:09 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-19-MaBuzPe6NymqWwm9BDgSpA-1; Sun, 01 Nov 2020 14:33:06 +0000
X-MC-Unique: MaBuzPe6NymqWwm9BDgSpA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 1 Nov 2020 14:33:05 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 1 Nov 2020 14:33:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marc Zyngier' <maz@kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Android Kernel Team" <kernel-team@android.com>
Subject: RE: [PATCH 1/2] genirq: Allow an interrupt to be marked as 'naked'
Thread-Topic: [PATCH 1/2] genirq: Allow an interrupt to be marked as 'naked'
Thread-Index: AQHWsFD9Rnig6/7CxEqjPXAUWe/UuKmzVn2w
Date:   Sun, 1 Nov 2020 14:33:05 +0000
Message-ID: <83451f88a17e4a63ab5b523f8f817970@AcuMS.aculab.com>
References: <20201101131430.257038-1-maz@kernel.org>
 <20201101131430.257038-2-maz@kernel.org>
In-Reply-To: <20201101131430.257038-2-maz@kernel.org>
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

From: Marc Zyngier
> Sent: 01 November 2020 13:14
> 
> Some interrupts (such as the rescheduling IPI) rely on not going through
> the irq_enter()/irq_exit() calls. To distinguish such interrupts, add
> a new IRQ flag that allows the low-level handling code to sidestep the
> enter()/exit() calls.
> 
> Only the architecture code is expected to use this. It will do the wrong
> thing on normal interrupts.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> ---
>  include/linux/irq.h   |  4 +++-
>  kernel/irq/debugfs.c  |  1 +
>  kernel/irq/irqdesc.c  | 17 ++++++++++++-----
>  kernel/irq/settings.h |  7 +++++++
>  4 files changed, 23 insertions(+), 6 deletions(-)
> 
...
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 1a7723604399..c08a1c19d061 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -667,10 +667,9 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>  {
>  	struct pt_regs *old_regs = set_irq_regs(regs);
>  	unsigned int irq = hwirq;
> +	struct irq_desc *desc;
>  	int ret = 0;
> 
> -	irq_enter();
> -
>  #ifdef CONFIG_IRQ_DOMAIN
>  	if (lookup)
>  		irq = irq_find_mapping(domain, hwirq);
> @@ -680,14 +679,22 @@ int __handle_domain_irq(struct irq_domain *domain, unsigned int hwirq,
>  	 * Some hardware gives randomly wrong interrupts.  Rather
>  	 * than crashing, do something sensible.
>  	 */
> -	if (unlikely(!irq || irq >= nr_irqs)) {
> +	desc = irq_to_desc(irq);
> +	if (unlikely(!desc || irq >= nr_irqs)) {

Should those tests be in the other order?
Probably as:
	if (unlikely(irq >= nr_irqs || !(desc = irq_to_desc(irq))) {
		...

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

