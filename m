Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C26E27500D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 06:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgIWEpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 00:45:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33008 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726198AbgIWEpR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 00:45:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9F8B6D6E;
        Tue, 22 Sep 2020 21:45:16 -0700 (PDT)
Received: from [10.163.72.76] (unknown [10.163.72.76])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2DB3F718;
        Tue, 22 Sep 2020 21:45:13 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V3 2/3] arm64/mm/hotplug: Enable MEM_OFFLINE event
 handling
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Will Deacon <will@kernel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
 <1600689908-28213-3-git-send-email-anshuman.khandual@arm.com>
Message-ID: <9b00cfc3-ef97-f476-28d4-93c2d5842e37@arm.com>
Date:   Wed, 23 Sep 2020 10:14:38 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1600689908-28213-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/21/2020 05:35 PM, Anshuman Khandual wrote:
> This enables MEM_OFFLINE memory event handling. It will help intercept any
> possible error condition such as if boot memory some how still got offlined
> even after an explicit notifier failure, potentially by a future change in
> generic hot plug framework. This would help detect such scenarios and help
> debug further.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/mmu.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index df3b7415b128..6b171bd88bcf 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1482,13 +1482,40 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
>  	unsigned long end_pfn = arg->start_pfn + arg->nr_pages;
>  	unsigned long pfn = arg->start_pfn;
>  
> -	if (action != MEM_GOING_OFFLINE)
> +	if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
>  		return NOTIFY_OK;
>  
> -	for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> -		ms = __pfn_to_section(pfn);
> -		if (early_section(ms))
> -			return NOTIFY_BAD;
> +	if (action == MEM_GOING_OFFLINE) {
> +		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> +			ms = __pfn_to_section(pfn);
> +			if (early_section(ms)) {
> +				pr_warn("Boot memory offlining attempted\n");
> +				return NOTIFY_BAD;
> +			}
> +		}
> +	} else if (action == MEM_OFFLINE) {
> +		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> +			ms = __pfn_to_section(pfn);
> +			if (early_section(ms)) {
> +
> +				/*
> +				 * This should have never happened. Boot memory
> +				 * offlining should have been prevented by this
> +				 * very notifier. Probably some memory removal
> +				 * procedure might have changed which would then
> +				 * require further debug.
> +				 */
> +				pr_err("Boot memory offlined\n");

It is returning in the first instance, when a section inside the
offline range happen to be part of the boot memory. So wondering
if it would be better to call out here, entire attempted offline
range or just the first section inside that which overlaps with
boot memory ? But some range information here will be helpful.
