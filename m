Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6FB2056D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 18:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732416AbgFWQMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 12:12:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728916AbgFWQMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:12:18 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EFD32081A;
        Tue, 23 Jun 2020 16:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592928737;
        bh=6nRc1jGM9JfCbm9AMXUpZEjUTEOQfLi5Qg96RQgjxSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=o8Oqg6WAtj5VPOvslTDqt6BUwgSHZhkB+0DXnYfwb0L7fa3cjFCiQh5Q+sskZ8pwE
         k0kfdvRZnaMLmdpKizu9J6N89rBIkUoFPPhz7IoF0M+AgnbBu8/K97R5W3kC1s7kvv
         kV36xNka75qLN9GjoaL6rjcFhg43GAlUT9HqwOVc=
Date:   Tue, 23 Jun 2020 17:12:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64/module: Optimize module load time by optimizing
 PLT counting
Message-ID: <20200623161212.GA4819@willie-the-truck>
References: <20200623011803.91232-1-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623011803.91232-1-saravanak@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 06:18:02PM -0700, Saravana Kannan wrote:
> When loading a module, module_frob_arch_sections() tries to figure out
> the number of PLTs that'll be needed to handle all the RELAs. While
> doing this, it tries to dedupe PLT allocations for multiple
> R_AARCH64_CALL26 relocations to the same symbol. It does the same for
> R_AARCH64_JUMP26 relocations.
> 
> To make checks for duplicates easier/faster, it sorts the relocation
> list by type, symbol and addend. That way, to check for a duplicate
> relocation, it just needs to compare with the previous entry.
> 
> However, sorting the entire relocation array is unnecessary and
> expensive (O(n log n)) because there are a lot of other relocation types
> that don't need deduping or can't be deduped.
> 
> So this commit partitions the array into entries that need deduping and
> those that don't. And then sorts just the part that needs deduping. And
> when CONFIG_RANDOMIZE_BASE is disabled, the sorting is skipped entirely
> because PLTs are not allocated for R_AARCH64_CALL26 and R_AARCH64_JUMP26
> if it's disabled.
> 
> This gives significant reduction in module load time for modules with
> large number of relocations with no measurable impact on modules with a
> small number of relocations. In my test setup with CONFIG_RANDOMIZE_BASE
> enabled, these were the results for a few downstream modules:
> 
> Module		Size (MB)
> wlan		14
> video codec	3.8
> drm		1.8
> IPA		2.5
> audio		1.2
> gpu		1.8
> 
> Without this patch:
> Module		Number of entries sorted	Module load time (ms)
> wlan		243739				283
> video codec	74029				138
> drm		53837				67
> IPA		42800				90
> audio		21326				27
> gpu		20967				32
> 
> Total time to load all these module: 637 ms
> 
> With this patch:
> Module		Number of entries sorted	Module load time (ms)
> wlan		22454				61
> video codec	10150				47
> drm		13014				40
> IPA		8097				63
> audio		4606				16
> gpu		6527				20
> 
> Total time to load all these modules: 247
> 
> Time saved during boot for just these 6 modules: 390 ms
> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> 
> v1 -> v2:
> - Provided more details in the commit text
> - Pulled in Will's comments on the coding style
> - Pulled in Ard's suggestion about skipping jumps with the same section
>   index (parts of Will's suggested code)
> 
>  arch/arm64/kernel/module-plts.c | 46 ++++++++++++++++++++++++++++++---
>  1 file changed, 43 insertions(+), 3 deletions(-)

Nice, it looks like you were more-or-less able to use my suggestion
directly! Commit message looks much better to, so:

Acked-by: Will Deacon <will@kernel.org>

Catalin can pick this up when he starts queuing patches for 5.9.

Cheers,

Will
