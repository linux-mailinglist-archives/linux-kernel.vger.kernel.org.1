Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3127D495
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgI2Rhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:37:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:58148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgI2Rhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:37:34 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F104B2076A;
        Tue, 29 Sep 2020 17:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601401054;
        bh=UvE53L1sg8GJvFFhgRjsqC9XadWv4tH7FwQa5T0OhUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vZKRt8BvGxP8BhKW+TX+EPD0sF8tIwU68IIJ5O0yeTLJykidd8yXBaRh2X9NlG4be
         cdqMJ7rEFbnk2lZDKK73WldEsTLqguaSKm0zeRVkLaJP33bwr9N/9y8IAu+/9D7vKi
         IGHQdUni92YI8Z3vgo2aB+88b/opTUQ4bfRvaYIQ=
Date:   Tue, 29 Sep 2020 18:37:28 +0100
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
        kernel-team@android.com
Subject: Re: [PATCH v4 07/10] kvm: arm64: Duplicate
 arm64_ssbd_callback_required for nVHE hyp
Message-ID: <20200929173728.GD14317@willie-the-truck>
References: <20200922204910.7265-1-dbrazdil@google.com>
 <20200922204910.7265-8-dbrazdil@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922204910.7265-8-dbrazdil@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:49:07PM +0100, David Brazdil wrote:
> Hyp keeps track of which cores require SSBD callback by accessing a
> kernel-proper global variable. Create an nVHE symbol of the same name
> and copy the value from kernel proper to nVHE as KVM is being enabled
> on a core.
> 
> Done in preparation for separating percpu memory owned by kernel
> proper and nVHE.
> 
> Signed-off-by: David Brazdil <dbrazdil@google.com>
> ---
>  arch/arm64/include/asm/kvm_mmu.h | 14 +++++++++++++-
>  arch/arm64/kernel/image-vars.h   |  1 -
>  arch/arm64/kvm/arm.c             |  3 +++
>  arch/arm64/kvm/hyp/nvhe/switch.c |  3 +++
>  4 files changed, 19 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Marc: please take a look at for-next/ghostbusters on the arm64 tree, as
that has the patches which remove this stuff entirely. I had to rebase
the branch today because I screwed up some of the SoBs but the HEAD is
now stable at 780c083a8f84.

Will
