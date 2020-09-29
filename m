Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EDC27D4CE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730244AbgI2Rq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:46:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:44780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729113AbgI2Rq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:46:26 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1485207F7;
        Tue, 29 Sep 2020 17:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601401585;
        bh=Eygb0b3lGWlgqkHSLZz5ftXfR6UVNqbZY53CkkEuGME=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANSra6H4xGSHUFI7hYAnAt1P73+jiHWeE3tEvS93Fzj96VdhSDsD+vcopQcIBnEj2
         njZKuVe2AWaCC63qSJT/rItjjfCKlWU+gpuBoHKnJHy3xWJ5zmaY2qyjFrIBOS/M9L
         slpvSN2E7Mo9Vf01eUrE3jhf05OCf8mXPaUkBjBw=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kNJhn-00FxNf-Tk; Tue, 29 Sep 2020 18:46:24 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 29 Sep 2020 18:46:23 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     David Brazdil <dbrazdil@google.com>, kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v4 05/10] kvm: arm64: Remove hyp_adr/ldr_this_cpu
In-Reply-To: <20200929173407.GC14317@willie-the-truck>
References: <20200922204910.7265-1-dbrazdil@google.com>
 <20200922204910.7265-6-dbrazdil@google.com>
 <20200929173407.GC14317@willie-the-truck>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <2221d6a88c4077b7e0a4ce2ac5f50a45@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, catalin.marinas@arm.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, dennis@kernel.org, tj@kernel.org, cl@linux.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel-team@android.com, ascull@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-29 18:34, Will Deacon wrote:
> On Tue, Sep 22, 2020 at 09:49:05PM +0100, David Brazdil wrote:
>> The hyp_adr/ldr_this_cpu helpers were introduced for use in hyp code
>> because they always needed to use TPIDR_EL2 for base, while
>> adr/ldr_this_cpu from kernel proper would select between TPIDR_EL2 and
>> _EL1 based on VHE/nVHE.
>> 
>> Simplify this now that the hyp mode case can be handled using the
>> __KVM_VHE/NVHE_HYPERVISOR__ macros.
>> 
>> Acked-by: Andrew Scull <ascull@google.com>
>> Acked-by: Will Deacon <will@kernel.org>
>> Signed-off-by: David Brazdil <dbrazdil@google.com>
>> ---
>>  arch/arm64/include/asm/assembler.h | 29 +++++++++++++++++++----------
>>  arch/arm64/include/asm/kvm_asm.h   | 14 +-------------
>>  arch/arm64/kvm/hyp/hyp-entry.S     |  2 +-
>>  3 files changed, 21 insertions(+), 24 deletions(-)
>> 
>> diff --git a/arch/arm64/include/asm/assembler.h 
>> b/arch/arm64/include/asm/assembler.h
>> index 54d181177656..86e0ef79a799 100644
>> --- a/arch/arm64/include/asm/assembler.h
>> +++ b/arch/arm64/include/asm/assembler.h
>> @@ -218,6 +218,23 @@ lr	.req	x30		// link register
>>  	str	\src, [\tmp, :lo12:\sym]
>>  	.endm
>> 
>> +	/*
>> +	 * @dst: destination register (32 or 64 bit wide)
> 
> nit: this comment is wrong as I don't think mrs can take a W register
> as the destination argument. I'm assuming Marc can fix that up.

Indeed. I'll fix it locally.

Another thing is that this patch is going to clash with the Ghostbuster
branch (the hyp-entry.S hunk goes), but we can deal with that.

         M.
-- 
Jazz is not dead. It just smells funny...
