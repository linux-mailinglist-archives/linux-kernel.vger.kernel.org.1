Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 119D42730BB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 19:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728296AbgIURPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 13:15:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:54776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbgIURPL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 13:15:11 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63B7A20758;
        Mon, 21 Sep 2020 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600708510;
        bh=oNl21GKbETxspIUiGd6NDudHCGJOD0WlSYjrtXePsT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZryhrD874sShofTk0rTnQKhsxe5vhXg2Uc0l76zhVlL43CNGinRt1Tmca5p4p5c88
         k+nRlUPhwlqlluWbpD3RsHOc4PubKpcwCDazHBD6eda+rgc8HupCJTCIharrUtuNGS
         pRqj+BOsrJtKboJxXSxVPfvrZfqAaXVX6vqw1/rs=
Date:   Mon, 21 Sep 2020 18:15:05 +0100
From:   Will Deacon <will@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Andrew Scull <ascull@google.com>
Subject: Re: [PATCH v3 05/11] kvm: arm64: Remove hyp_adr/ldr_this_cpu
Message-ID: <20200921171503.GB2822@willie-the-truck>
References: <20200916173439.32265-1-dbrazdil@google.com>
 <20200916173439.32265-6-dbrazdil@google.com>
 <20200918090533.GE30834@willie-the-truck>
 <20200921145320.2b2ipdj6w4morjc3@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921145320.2b2ipdj6w4morjc3@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 03:53:20PM +0100, David Brazdil wrote:
> > Cosmetic, but I think it would be cleaner just to define two variants of the
> > macro here:
> > 
> > #if defined(__KVM_NVHE_HYPERVISOR__) || defined(__KVM_VHE_HYPERVISOR__)
> > 	.macro  this_cpu_offset, dst
> > 	mrs     \dst, tpidr_el2
> > 	.endm
> > #else
> > 	.macro  this_cpu_offset, dst
> > alternative_if_not ARM64_HAS_VIRT_HOST_EXTN
> > 	mrs     \dst, tpidr_el1
> > alternative_else
> > 	mrs     \dst, tpidr_el2
> > alternative_endif
> > 	.endm
> > #endif
> 
> Sure.

Ta.

> > (and should we have a shorthand __HYPERVISOR define to avoid the NVHE || VHE
> > logic?)
> 
> Happy to add this but let's agree on the details.
>  * name: just __HYPERVISOR or __KVM_HYPERVISOR__?

Hey, I leave the hard decisions to others!

>  * defined where? I'm wary of defining it in a header file because then sombody
>    will forget to add it and 'ifdef HYP' will be skipped. So I'd put this as
>    another '-D__HYPERVISOR' in the build rules. Do you agree?

Hmm, that's a good point. Leave that part as-is for now then and we can
tackle it separately if it comes up again.

Will
