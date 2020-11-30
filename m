Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8893F2C873C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 15:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgK3O51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 09:57:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbgK3O50 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 09:57:26 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 81489206D8;
        Mon, 30 Nov 2020 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606748205;
        bh=H9HW6M0N7P3/ljXHXDTtoOCZtSNFV7sHkFwrFta8g8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=e6g4ZLS8pGm/ueEw04sTAufe9NAGM4bJ4U4pSgVeJtaPOzRx00XYwAn35Mj2pM2xH
         UaoaOV0YGkUykA2cI0T3BxLC6I5oVG14Hv7M02VshPMAuedJhrQ/flPaiKcmQjophg
         3THh9W77jduh6FqqR5HC6XKOW+G3BXbZKKe1cZU0=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjkbb-00Eizp-9b; Mon, 30 Nov 2020 14:56:43 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Nov 2020 14:56:43 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eric.auger@redhat.com, Linuxarm <linuxarm@huawei.com>
Subject: Re: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
In-Reply-To: <85bb389a75f347d29ab3f75e4cfae060@huawei.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
 <f8a97f360073fa495cae75acc11ecf4f@kernel.org>
 <85bb389a75f347d29ab3f75e4cfae060@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <846387e4168f1a22638ad07ae670c531@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: shameerali.kolothum.thodi@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, eric.auger@redhat.com, linuxarm@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shameer,

On 2020-11-30 13:55, Shameerali Kolothum Thodi wrote:
> Hi Marc,
> 
>> -----Original Message-----
>> From: Marc Zyngier [mailto:maz@kernel.org]
>> Sent: 30 November 2020 12:28
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>> Cc: linux-kernel@vger.kernel.org; 
>> linux-arm-kernel@lists.infradead.org;
>> eric.auger@redhat.com; Linuxarm <linuxarm@huawei.com>
>> Subject: Re: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy 
>> support
>> 
>> Hi Shameer,
>> 
>> On 2020-11-30 10:26, Shameer Kolothum wrote:
>> > At present, the support for GICv2 backward compatibility on GICv3/v4
>> > hardware is determined based on whether DT/ACPI provides a memory
>> > mapped phys base address for GIC virtual CPU interface register(GICV).
>> > This creates a problem that a Qemu guest boot with default GIC(GICv2)
>> 
>> That'd be true of *any* guest using GICv2, not just when using QEMU as
>> the VMM, right?
> 
> Yes, I would think so.
> 
>> > hangs when firmware falsely reports this address on systems that don't
>> > have support for legacy mode.
>> 
>> And I guess it isn't just the guest that hangs, but the whole system 
>> can
>> go south (it would be totally legitimate for the HW to deliver a
>> SError).
> 
> So far I haven’t seen that happening. I was able to kill the Guest and 
> recover.
> But the annoying thing is Guest boot hangs at random places without any
> error reported and people end up spending lot of time only to be told 
> later
> that gic-version=3 is missing from their scripts.

That's pretty lucky. The guest has been reading/writing to random 
places,
and depending on where this maps in the physical space, anything can
happen. Out  of (morbid) curiosity, what is at the address pointed to by
GICC in MADT?

> 
>> > As per GICv3/v4 spec, in an implementation that does not support legacy
>> > operation, affinity routing and system register access are permanently
>> > enabled. This means that the associated control bits are RAO/WI. Hence
>> > use the ICC_SRE_EL1.SRE bit to decide whether hardware supports GICv2
>> > mode in addition to the above firmware based check.
>> >
>> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> > ---
>> > On Hisilicon D06, UEFI sets the GIC MADT GICC gicv_base_address but the
>> > GIC implementation on these boards doesn't have the GICv2 legacy
>> > support.
>> > This results in, Guest boot hang when Qemu uses the default GIC option.
>> 
>> What a bore. Is this glorious firmware really out in the wild?
> 
> :(. I am afraid it is.

Meh. We'll have to paper over it then. How urgent is that?

[...]

>> How about this instead? Completely untested, of course.
> 
> Thanks for that. I just tested and it works.

OK. I'll rework it a bit and post it as a complete patch. Is there an
erratum number on your side?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
