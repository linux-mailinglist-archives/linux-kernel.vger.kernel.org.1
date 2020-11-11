Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067152AF28C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 14:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKKNwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 08:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:42122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbgKKNwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 08:52:09 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6D702072C;
        Wed, 11 Nov 2020 13:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605102728;
        bh=vpzQhD31kZiz0Ds3ndWnHcNtFHrzT9rX+xjSS3L2qxs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WvD1Kt0rYFg9LPKQES5pJcwfYvw83ZpPUhh0NWExD5onFN9DyY3DuF/q61lUKfdpD
         CIoap2gAK2Q2fSkijiMy5U01a8voRmPb8f4kaqvbDtPWP8k/1FphdUqx4VNzfHAkiK
         WxDnceLo/UM3VrVCveroTBou4ju2eMynmawPEs5E=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kcqXe-009mGl-JM; Wed, 11 Nov 2020 13:52:06 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Nov 2020 13:52:06 +0000
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
Subject: Re: [PATCH v1 07/24] kvm: arm64: Create nVHE copy of cpu_logical_map
In-Reply-To: <20201111134527.ygzf5cm6qpdpcroo@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-8-dbrazdil@google.com>
 <d473fd26e5314f2407b70242488f33de@kernel.org>
 <20201111130321.qalrzfabdonrwvsz@google.com>
 <15a580e6ac06294ead8859fba8f51deb@kernel.org>
 <20201111134527.ygzf5cm6qpdpcroo@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <3ed604d7837fa64ec7c4fe5920c57382@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-11 13:45, David Brazdil wrote:
> On Wed, Nov 11, 2020 at 01:29:29PM +0000, Marc Zyngier wrote:
>> On 2020-11-11 13:03, David Brazdil wrote:
>> > > > +/*
>> > > > + * nVHE copy of data structures tracking available CPU cores.
>> > > > + * Only entries for CPUs that were online at KVM init are populated.
>> > > > + * Other CPUs should not be allowed to boot because their features were
>> > > > + * not checked against the finalized system capabilities.
>> > > > + */
>> > > > +u64 __ro_after_init __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1]
>> > > > = INVALID_HWID };
>> > >
>> > > I'm not sure what __ro_after_init means once we get S2 isolation.
>> >
>> > It is stretching the definition of 'init' a bit, I know, but I don't see
>> > what
>> > your worry is about S2? The intention is to mark this read-only for
>> > .hyp.text
>> > at runtime. With S2, the host won't be able to write to it after KVM
>> > init.
>> > Obviously that's currently not the case.
>> 
>> More importantly, EL2 can write to it at any time, which is the bit 
>> I'm
>> worried
>> about, as it makes the annotation misleading.
> 
> EL2 can't, at least not accidentally. The hyp memory mapping is 
> PAGE_HYP_RO
> (see patch 05).

Ah, I obviously overlooked that. Thanks for setting me straight.

> Shouldn't clash with include files. Where fixing the kernel might clash 
> is
> all the users of for_each_*_cpu that use an int for the iterator var.

I don't think that's a problem (nobody expects that many CPUs). But if 
you
are confident that we don't have a problem, no need to change the kernel
itself.

         M.
-- 
Jazz is not dead. It just smells funny...
