Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E762EF606
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 17:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbhAHQvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 11:51:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbhAHQvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 11:51:54 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084A9239FD;
        Fri,  8 Jan 2021 16:51:14 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kxuyl-0067gk-RL; Fri, 08 Jan 2021 16:51:11 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 08 Jan 2021 16:51:11 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [PATCH] KVM: arm64: Compute TPIDR_EL2 ignoring MTE tag
In-Reply-To: <20210108161254.53674-1-steven.price@arm.com>
References: <20210108161254.53674-1-steven.price@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <e49459f08d0afb30a120dfb3d6b80741@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, glider@google.com, akpm@linux-foundation.org, andreyknvl@google.com, vincenzo.frascino@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2021-01-08 16:12, Steven Price wrote:
> KASAN in HW_TAGS mode will store MTE tags in the top byte of the
> pointer. When computing the offset for TPIDR_EL2 we don't want anything
> in the top byte, so remove the tag to ensure the computation is correct
> no matter what the tag.
> 
> Fixes: 94ab5b61ee16 ("kasan, arm64: enable CONFIG_KASAN_HW_TAGS")
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Without this fix I can't boot a config with KASAN_HW_TAGS and KVM on an
> MTE enabled host. I'm unsure if this should really be in
> this_cpu_ptr_nvhe_sym().

this_cpu_ptr_nvhe_sym() should return something that is valid for
the EL1 kernel, so I guess untagging in the helper may not be
that useful.

However, I'm more concerned by anything at requires us to follow
pointers set up by EL1 at EL2. It looks to me that the only reason
the whole thing works is because kern_hyp_va() *accidentally* drops
tags before applying the EL1/EL2 offset...

Or am I getting it wrong?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
