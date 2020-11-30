Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3282D2C84EB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 14:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgK3NRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 08:17:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:54186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726289AbgK3NRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:17:32 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EE9F206F9;
        Mon, 30 Nov 2020 13:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606742211;
        bh=1zr1UMCcOfl2mGxHxT7EB+EAZA8oBQSjYHyotMbE2Rw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OX+Oqc/QaNqdyRhkmycg1jXs0/AB9qaBnvGnyYOBRvuSyg+YPI9em3wURWewdMImM
         q11Oi/wQSfCPJE8n4OwmfxHbwSg4a7s2LKXWGqf+HxbeOs5aK9wmOCGZbA496jUILq
         yl0R3TAM1lRLgWI296MmDo3RLhxNlvp7zGQ9hSWo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kjj2v-00EhLk-67; Mon, 30 Nov 2020 13:16:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 30 Nov 2020 13:16:49 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc:     yuzenghui <yuzenghui@huawei.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linuxarm <linuxarm@huawei.com>, eric.auger@redhat.com
Subject: Re: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy support
In-Reply-To: <ae78e69ded9a45bf82832241560bcee0@huawei.com>
References: <20201130102639.7504-1-shameerali.kolothum.thodi@huawei.com>
 <f6e8ee71-f76b-428c-cd56-5bc93b1afafe@huawei.com>
 <ae78e69ded9a45bf82832241560bcee0@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <7422841eba7a0243c8aaefb6c0f044bf@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: shameerali.kolothum.thodi@huawei.com, yuzenghui@huawei.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, eric.auger@redhat.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-30 12:06, Shameerali Kolothum Thodi wrote:
> Hi Zenghui,
> 
>> -----Original Message-----
>> From: yuzenghui
>> Sent: 30 November 2020 11:51
>> To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>;
>> linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Cc: maz@kernel.org; Linuxarm <linuxarm@huawei.com>;
>> eric.auger@redhat.com
>> Subject: Re: [PATCH] irqchip/gic-v3: Check SRE bit for GICv2 legacy 
>> support
>> 
>> Hi Shameer,
>> 
>> On 2020/11/30 18:26, Shameer Kolothum wrote:
>> > At present, the support for GICv2 backward compatibility on GICv3/v4
>> > hardware is determined based on whether DT/ACPI provides a memory
>> > mapped phys base address for GIC virtual CPU interface register(GICV).
>> > This creates a problem that a Qemu guest boot with default GIC(GICv2)
>> > hangs when firmware falsely reports this address on systems that don't
>> > have support for legacy mode.
>> 
>> So the problem is that BIOS has provided us a bogus GICC Structure.
> 
> Yes. And kernel uses this field to determine the legacy support.
> 
>> 
>> > As per GICv3/v4 spec, in an implementation that does not support legacy
>> > operation, affinity routing and system register access are permanently
>> > enabled. This means that the associated control bits are RAO/WI. Hence
>> > use the ICC_SRE_EL1.SRE bit to decide whether hardware supports GICv2
>> > mode in addition to the above firmware based check.
>> >
>> > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> > ---
>> > On Hisilicon D06, UEFI sets the GIC MADT GICC gicv_base_address but the
>> > GIC implementation on these boards doesn't have the GICv2 legacy support.
>> > This results in, Guest boot hang when Qemu uses the default GIC option.
>> >
>> > With this patch, the Qemu Guest with GICv2 now gracefully exits,
>> >   "qemu-system-aarch64: host does not support in-kernel GICv2 emulation"
>> >
>> > Not very sure there is a better way to detect this other than checking
>> > the SRE bit as done in this patch(Of course, we will be fixing the UEFI
>> > going forward).
>> 
>> Yes, I had seen the same problem on the D06. But I *do* think it's the
>> firmware that actually needs to be fixed.
> 
> Well, I am not sure I agree with that. The ACPI spec 6.3, section
> 5.2.12.14, says,
> "If the platform is not presenting a GICv2 with virtualization 
> extensions this
> field *can* be 0". So don’t think it mandates that.

Note: *GICv2*, not GICv3 with v2 compatibility. I still think the 
firmware
should be fixed. But that also relies on finding out whether the broken
FW is in the wild or not. If it is already, we need something in the 
kernel.

>> 
>> > Thanks,
>> > Shameer
>> >
>> > ---
>> >   drivers/irqchip/irq-gic-v3.c | 33 ++++++++++++++++++++++++++++-----
>> >   1 file changed, 28 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
>> > index 16fecc0febe8..15fa1eea45e4 100644
>> > --- a/drivers/irqchip/irq-gic-v3.c
>> > +++ b/drivers/irqchip/irq-gic-v3.c
>> > @@ -1835,6 +1835,27 @@ static void __init
>> gic_populate_ppi_partitions(struct device_node *gic_node)
>> >   	of_node_put(parts_node);
>> >   }
>> >
>> > +/* SRE bit being RAO/WI implies no GICv2 legacy mode support */
>> 
>> I'm wondering if this is a mandate of the architecture.
> 
> As I mentioned above, I am not sure this is the best way, though,
> section 1.3.5 of GICv3 spec, says(for no legacy support case "affinity
> routing and system register access are permanently enabled. This means
> that the associated control bits are RAO/WI"
> 
> But again later in the spec, it uses "might choose to
> make this bit RAO/WI". So it is arguable that it mandates it or not.
> 
> I leave that to Marc :)

- If we cannot clear SRE, then we cannot use v2 compat, and we're good.

- If we can clear SRE and that there is no GICV region, we're goo too.

- If we can clear SRE and that there is a *bogus* GICV region, there
   is nothing we can do and the machine will explode when the guest
   pokes at it.

Using ARE would be tempting, but AFAIKT it is only relevant to the
physical side of the GIC, and has no bearing on the virtual side
(since the distributor is itself virtual).

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
