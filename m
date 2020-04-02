Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7082C19C9CF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 21:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389442AbgDBTRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 15:17:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38889 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgDBTRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:17:43 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jK5LQ-0001k9-Kr; Thu, 02 Apr 2020 21:17:40 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 15EA1100D52; Thu,  2 Apr 2020 21:17:40 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     lars@metafoo.de
Subject: Re: [RFC] genirq: prevent allocated_irqs from being smaller than NR_IRQS
In-Reply-To: <20200402150820.GB5886@smtp.gmail.com>
References: <20200402150820.GB5886@smtp.gmail.com>
Date:   Thu, 02 Apr 2020 21:17:40 +0200
Message-ID: <87k12xn1d7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

Marcelo Schmitt <marcelo.schmitt1@gmail.com> writes:
> #ifdef CONFIG_SPARSE_IRQ
> # define IRQ_BITMAP_BITS (NR_IRQS + 8196)
> #else
> # define IRQ_BITMAP_BITS NR_IRQS
> #endif
>
> The thing I'm troubled about is that BITS_TO_LONGS divides
> IRQ_BITMAP_BITS by sizeof(long) * 8, which makes it possible for the
> size of allocated_irqs to be smaller than NR_IRQS.

No. It calculates the number of longs which are required to store
IRQ_BITMAP_BITS bits. And it does not only divide, it also takes the
reminder into account.

One byte fits 8 bits. Multiplied with sizeof(long) tells you how many
bits fit into a long: Unsurprisingly that 32 on 32bit and 64 on 64bit
systems.

> By the way, is there any mailing list for IRQ related discussions?
> I couldn't find one at vger.kernel.org.

The MAINTAINERS file tells you:

IRQ SUBSYSTEM
L:      linux-kernel@vger.kernel.org

So you picked the right one.

Thanks,

        tglx
