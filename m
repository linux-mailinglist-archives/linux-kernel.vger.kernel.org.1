Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6DC52B4CC8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 18:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732843AbgKPR2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 12:28:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42536 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731210AbgKPR2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 12:28:39 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605547717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7t6pO0vuHx8JNVg8Mkr7fdnSU9HbcIAMULe0RJhYplw=;
        b=xHECSjhGakm4OggbxTnbYTgX/z5fzwfMak05l8LCNh4hf1Eo8wuwmHQdVsFp1I93vsJdyL
        8s0OQgU8fCijsl2/7y1qP7FttszqWKzoUgceWGT0U8PNFPsaBT1M6IXoLbCEBE56jyrGID
        3gvQL0zpOV5k9bB/sepkDAyaOtYOr/1DvYEgbyMC5KqGcqah+7Rx7eEVri3gipCrqg6bKf
        EdrXdgWWdIhJdkORAuhmythtZq5DZggFeD/fD1Xth7jBlmqt4VAAxh8eNzNuLNixZob1rB
        eJ/Q5MLkX4b6Sy7r/qQFCOau6fkK6uvwWMZEuKCVEj3IT7D0sIo+jneD13x7bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605547717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7t6pO0vuHx8JNVg8Mkr7fdnSU9HbcIAMULe0RJhYplw=;
        b=FvK8npyOmc8lgRvEEGU144ZBCojNrtGMo+kC5Vl11C50dECqJ770+DP/vcFwvI3Yb6sQwx
        scxLnJI7P/3A9iAA==
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] irqdomain: fix -Wshadow warning
In-Reply-To: <CAK8P3a2fprKoq3D-u4vV7RvqdpCL06ET2QWS9HJkLuOnNU5Ntg@mail.gmail.com>
References: <20201026162022.3710091-1-arnd@kernel.org> <87h7ppz9ew.fsf@nanos.tec.linutronix.de> <CAK8P3a2fprKoq3D-u4vV7RvqdpCL06ET2QWS9HJkLuOnNU5Ntg@mail.gmail.com>
Date:   Mon, 16 Nov 2020 18:28:36 +0100
Message-ID: <877dqlyzwb.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16 2020 at 16:26, Arnd Bergmann wrote:
> On Mon, Nov 16, 2020 at 3:03 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> So instead of trying to chase all these places we really want to rename
>> the global 'nr_irqs' variable.
>
> Fair enough, yes.
>
>> Something like the uncompiled below which is purely mechanical and does
>> not even try to look at some of the places which use it for the very
>> wrong reasons and purpose * Shudder *.
>
> Looks good to me.
>
> If we rename it, we might want to pick an even longer name to make
> it stand out in code review when it does get used, and easier to
> grep for.

Sure, I just picked it lazily without much thought.

>> +               if (msi < max_nr_irqs && irq_get_chip_data(msi) == msic) {
>>                         generic_handle_irq(msi);
>>                         msic->fifo_virt[idx] = cpu_to_le32(0xffffffff);
>>                 } else {
>
> Most of the ones like this seem to have been simply converted from
> old sanity checks using NR_IRQS and would work just as well without
> the checks.

Yeah. As I said I did not look closely, but the peek already told me
that there is cruft.

> Actually removing the checks would have a small regression
> potential.

Right, it shouldn't cause problems.

>> --- a/drivers/pcmcia/at91_cf.c
>> +++ b/drivers/pcmcia/at91_cf.c
>
> potential.
>
>> @@ -312,7 +312,7 @@ static int at91_cf_probe(struct platform
>>                         goto fail0a;
>>                 cf->socket.pci_irq = gpio_to_irq(board->irq_pin);
>>         } else
>> -               cf->socket.pci_irq = nr_irqs + 1;
>> +               cf->socket.pci_irq = max_nr_irqs + 1;
>>
>>         /*
>>          * pcmcia layer only remaps "real" memory not iospace
>
> This one would seem to actually warrant a bugfix, setting
> the field to zero.

Indeed.

Thanks,

        tglx
