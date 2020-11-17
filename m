Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3612B5B41
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgKQItL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:49:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:55424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgKQItK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:49:10 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F842225E;
        Tue, 17 Nov 2020 08:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605602950;
        bh=htTADclsiKM9iBHnxQjBA65269s1iebyH+Dc/3nPf/c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bm6hrdaBW1+9GYWeb8yj32XrGY8JRUNXvZRnbRi02xVt+vea9fAYWvxRa4cSBzoFt
         stNdlBNaJij5KDipXG0YUqdLNxNs68rxAz/0KST/CXOYdD69UTXwbUKhTlvc48doyL
         ny0ZsGdJBhbrKtMtoqNVPXjpNIUihWlxXwjnnOi8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kewfj-00BH7x-Vo; Tue, 17 Nov 2020 08:49:08 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 17 Nov 2020 08:49:07 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, wanghaibin.wang@huawei.com,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH 1/2] KVM: arm64: vgic: Forbid invalid userspace
 Redistributor accesses
In-Reply-To: <7e58200c-814e-3598-155a-9a7e6cc24374@huawei.com>
References: <20201113142801.1659-1-yuzenghui@huawei.com>
 <20201113142801.1659-2-yuzenghui@huawei.com>
 <724c43702b52aac0d3c9beb9604d1bfb@kernel.org>
 <584b7ff1-ecf2-b0ec-cea3-ccc29902f43a@huawei.com>
 <cc45285fe491aff5c28a24f94c124508@kernel.org>
 <7e58200c-814e-3598-155a-9a7e6cc24374@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <c20865a267e44d1e2c0d52ce4e012263@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, wanghaibin.wang@huawei.com, zhukeqian1@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-11-16 14:57, Zenghui Yu wrote:
> Hi Marc,
> 
> On 2020/11/16 22:10, Marc Zyngier wrote:
>>> My take is that only if the "[Re]Distributor base address" is 
>>> specified
>>> in the system memory map, will the user-provided 
>>> kvm_device_attr.offset
>>> make sense. And we can then handle the access to the register which 
>>> is
>>> defined by "base address + offset".
>> 
>> I'd tend to agree, but it is just that this is a large change at -rc4.
>> I'd rather have a quick fix for 5.10, and a more invasive change for 
>> 5.11,
>> spanning all the possible vgic devices.
> 
> So you prefer fixing it by "return a value that doesn't have the Last
> bit set" for v5.10? I'm ok with it and can send v2 for it.

Cool. Thanks for that.

> Btw, looking again at the way we handle the user-reading of GICR_TYPER
> 
> 	vgic_mmio_read_v3r_typer(vcpu, addr, len)
> 
> it seems that @addr is actually the *offset* of GICR_TYPER (0x0008) and
> @addr is unlikely to be equal to last_rdist_typer, which is the *GPA* 
> of
> the last RD. Looks like the user-reading of GICR_TYPER.Last is always
> broken?

I think you are right. Somehow, we don't seem to track the index of
the RD in the region, so we can never compute the address of the RD
even if the base address is set.

Let's drop the reporting of Last for userspace for now, as it never
worked. If you post a patch addressing that quickly, I'll get it to
Paolo by the end of the week (there's another fix that needs merging).

Eric: do we have any test covering the userspace API?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
