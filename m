Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BADE2AF124
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgKKMqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:46:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:48938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725908AbgKKMqe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:46:34 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2AA520709;
        Wed, 11 Nov 2020 12:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605098793;
        bh=fgvFar5VH6U4VmS5tTBAQ11UfAbcAq37UA/xmP7e4uI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=r9nWEq3/jfTwQEjDuIXAGQ3H5G3m3fz1i1Uank6++ovoprns/8F8c+AJfmJKnfkV7
         U9NlWyNw0S5q4V2xcpf3b2+tlqT2T4LDiaqsi1VnqngsXR8NZmG4TrZwTzJ7CAHd82
         DHwKVfdZtvolrjK4/t4Wre1aIEKeFreUOxIC7ckM=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcpWA-009lDZ-KI; Wed, 11 Nov 2020 12:46:30 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Nov 2020 12:46:30 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 06/24] kvm: arm64: Support per_cpu_ptr in nVHE hyp code
In-Reply-To: <20201111123222.ooevu6nryu3ncphv@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-7-dbrazdil@google.com>
 <f28c9a67759cb04157e888b3a71b2ce2@kernel.org>
 <20201111123222.ooevu6nryu3ncphv@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <52b47a4284aaff2e198385ef9acbe01f@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-11 12:32, David Brazdil wrote:
>> > +
>> > +	cpu_base_array = kern_hyp_va(&kvm_arm_hyp_percpu_base[0]);
>> 
>> There is no guarantee that this will not generate a PC relative
>> addressing, resulting in kern_hyp_va() being applied twice.
>> 
>> Consider using hyp_symbol_addr() instead, which always does the right
>> by forcing a PC relative addressing and not subsequently mangling
>> the address.
>> 
>> > +	this_cpu_base = kern_hyp_va(cpu_base_array[cpu]);
>> > +	return this_cpu_base - (unsigned long)&__per_cpu_start;
>> 
>> And this is the opposite case: if the compiler generates an absolute
>> address, you're toast. Yes, this is just as unlikely, but hey...
>> Same remedy should apply.
> 
> Good point, and I'll probably keep forgetting about this in the future. 
> Now
> that all .hyp.text is only executed under hyp page tables, should we 
> start
> thinking about fixing up the relocations?

Why not, if you can deal with the hypervisor text being mapped at a 
random
location, and make sure that the kernel doesn't process the relocations
for you. This would certainly save us a lot of runtime offsetting (which
I'm adding to in a separate series).

         M.
-- 
Jazz is not dead. It just smells funny...
