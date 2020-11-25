Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17A8C2C3E6A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 11:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKYKtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 05:49:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727724AbgKYKtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 05:49:22 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6802C2075A;
        Wed, 25 Nov 2020 10:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606301361;
        bh=k8JMumggIN1LUGGzTQSyZv3AZbIMuj0rpxQJfz5sL8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=v6vPS9fDI5hnTJ8ThHNAiwCD6PcSrZAAmxL3Jclalq593Krfgz9aISvSIn+UJKxU2
         KR5yjs019NW8WgI8ke2w2sp2+dJ8fu/SOTyL9K036/PMaH2UdpztAgikPjvoWYDsd+
         uLV7LUNmH768ZbUFhs3uTuiw0YGcY2BgUgIWEQtY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1khsMR-00DVTd-18; Wed, 25 Nov 2020 10:49:19 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 25 Nov 2020 10:49:18 +0000
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
Subject: Re: [PATCH v2 06/24] kvm: arm64: Move hyp-init params to a per-CPU
 struct
In-Reply-To: <20201125103946.2unmclsdfqpr3eyk@google.com>
References: <20201116204318.63987-1-dbrazdil@google.com>
 <20201116204318.63987-7-dbrazdil@google.com> <87lfes5f54.wl-maz@kernel.org>
 <20201125103946.2unmclsdfqpr3eyk@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <643459b9146c5cdf91c3316bb1cb096e@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-25 10:39, David Brazdil wrote:
> On Mon, Nov 23, 2020 at 02:20:07PM +0000, Marc Zyngier wrote:

[...]

>> > +
>> > +	/*
>> > +	 * Flush the init params from the data cache because the struct will
>> > +	 * be read while the MMU is off.
>> > +	 */
>> > +	__flush_dcache_area(params, sizeof(*params));
>> 
>> nit: please use kvm_flush_dcache_to_poc(), as it clearly indicates to
>> which point we are flushing.
> 
> Will change, but out of curiosity - how is it different? AFAICT, it is 
> just
> an alias with a single use in __clean_dcache_guest_page:
> 
>   #define kvm_flush_dcache_to_poc(a,l)	__flush_dcache_area((a), (l))

It is indeed the exact same thing, but it says clearly in the name that 
we
are cleaning to the "Point Of Coherency", as opposed to any other 
architectural level (Unification or Persistence).

It makes it clear that we are cleaning all the way to the point where it 
can
be accessed reliably with an uncacheable mapping, and not leaving the 
data
dangling at a shallower cache level.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
