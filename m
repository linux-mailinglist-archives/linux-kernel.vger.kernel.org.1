Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4A2B36ED
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 18:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbgKOREE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 12:04:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:57224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726998AbgKORED (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 12:04:03 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A7F2223FB;
        Sun, 15 Nov 2020 17:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605459843;
        bh=47Yg3gRFv07hkRm946gKdQt9gA1sJtG0nNWa6xf0C/4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tWwIjkCozPQsYmXmcuNE1AUahp+dOfl95+iNZIM/P4bLp6VYNMnrBqlIjVkkNBWwo
         9rH+4FQExc4s+GkE5zlJMIUKciQYYg3xxPlWXX34AKG9HdThv7oI6qL6LAFza+Uy85
         k//45RpJvVLbH9IPaJYsbqpAEUXv+o0cLsa68o4M=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1keLRZ-00AoQd-Ho; Sun, 15 Nov 2020 17:04:01 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sun, 15 Nov 2020 17:04:01 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, eric.auger@redhat.com,
        james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, wanghaibin.wang@huawei.com,
        Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH 1/2] KVM: arm64: vgic: Forbid invalid userspace
 Redistributor accesses
In-Reply-To: <20201113142801.1659-2-yuzenghui@huawei.com>
References: <20201113142801.1659-1-yuzenghui@huawei.com>
 <20201113142801.1659-2-yuzenghui@huawei.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <724c43702b52aac0d3c9beb9604d1bfb@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, wanghaibin.wang@huawei.com, zhukeqian1@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zenghui,

On 2020-11-13 14:28, Zenghui Yu wrote:
> It's expected that users will access registers in the redistributor 
> *if*
> the RD has been initialized properly. Unfortunately userspace can be 
> bogus
> enough to access registers before setting the RD base address, and KVM
> implicitly allows it (we handle the access anyway, regardless of 
> whether
> the base address is set).
> 
> Bad thing happens when we're handling the user read of GICR_TYPER. We 
> end
> up with an oops when deferencing the unset rdreg...
> 
> 	gpa_t last_rdist_typer = rdreg->base + GICR_TYPER +
> 			(rdreg->free_index - 1) * KVM_VGIC_V3_REDIST_SIZE;
> 
> Fix this issue by informing userspace what had gone wrong (-ENXIO).

I'm worried about the "implicit" aspect of the access that this patch
now forbids.

The problem is that the existing documentation doesn't cover this case,
and -ENXIO's "Getting or setting this register is not yet supported"
is way too vague. There is a precedent with the ITS, but that's 
undocumented
as well. Also, how about v2? If that's the wasy we are going to fix 
this,
we also nned to beef up the documentation.

Of course, the other horrible way to address the issue is to return a 
value
that doesn't have the Last bit set, since we can't synthetise it. It 
doesn't
change the userspace API, and I can even find some (admittedly  twisted)
logic to it (since there is no base address, there is no last RD...).

Thoughts?

         M.
-- 
Jazz is not dead. It just smells funny...
