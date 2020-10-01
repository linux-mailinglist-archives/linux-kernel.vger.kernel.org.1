Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3F927F6E0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 02:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbgJAAyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 20:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38411 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730155AbgJAAyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 20:54:02 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601513640;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFZ4y9PW18tIpaRq1GakM+ear76FmQioomwiibA1G8E=;
        b=OmgHNSnu6sF8YEdy33NVijBNV6/GZdTppJAdWWffECLjQWzENFibKtzpjvassRg9FjqtvG
        1ztomfpYy10tXDqM7/pt8sW34WpoFGwg+WaUDA5NEsQB8ID9IlY2xTKkZgtt+cSA+Xxio9
        CIUS3ibbx3Mwfth1wpUwqmqqKm7e4fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-nsUy6JLWNIqFVcYcAYcAtw-1; Wed, 30 Sep 2020 20:53:56 -0400
X-MC-Unique: nsUy6JLWNIqFVcYcAYcAtw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 06EAE1891E8A;
        Thu,  1 Oct 2020 00:53:55 +0000 (UTC)
Received: from [10.64.54.133] (vpn2-54-133.bne.redhat.com [10.64.54.133])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A0765578A;
        Thu,  1 Oct 2020 00:53:52 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH V4 3/3] arm64/mm/hotplug: Ensure early memory sections are
 all online
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
References: <1601387687-6077-1-git-send-email-anshuman.khandual@arm.com>
 <1601387687-6077-4-git-send-email-anshuman.khandual@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <471fed64-0f61-9c16-3943-2bb8f77ee810@redhat.com>
Date:   Thu, 1 Oct 2020 10:53:50 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1601387687-6077-4-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 9/29/20 11:54 PM, Anshuman Khandual wrote:
> This adds a validation function that scans the entire boot memory and makes
> sure that all early memory sections are online. This check is essential for
> the memory notifier to work properly, as it cannot prevent any boot memory
> from offlining, if all sections are not online to begin with. The notifier
> registration is skipped, if this validation does not go through. Although
> the boot section scanning is selectively enabled with DEBUG_VM.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Steve Capper <steve.capper@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/mm/mmu.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 59 insertions(+)

I don't understand why this is necessary. The core already ensure the
corresponding section is online when trying to offline it. It's guranteed
that section is online when the notifier is triggered. I'm not sure if
there is anything I missed?
  

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 90a30f5ebfc0..b67a657ea1ad 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1522,6 +1522,62 @@ static struct notifier_block prevent_bootmem_remove_nb = {
>   	.notifier_call = prevent_bootmem_remove_notifier,
>   };
>   
> +/*
> + * This ensures that boot memory sections on the plaltform are online
                                                     ^^^^^^^^^
> + * during early boot. They could not be prevented from being offlined
> + * if for some reason they are not brought online to begin with. This
> + * help validate the basic assumption on which the above memory event
> + * notifier works to prevent boot memory offlining and it's possible
> + * removal.
> + */
> +static bool validate_bootmem_online(void)
> +{
> +	struct memblock_region *mblk;
> +	struct mem_section *ms;
> +	unsigned long pfn, end_pfn, start, end;
> +	bool all_online = true;
> +
> +	/*
> +	 * Scanning across all memblock might be expensive
> +	 * on some big memory systems. Hence enable this
> +	 * validation only with DEBUG_VM.
> +	 */
> +	if (!IS_ENABLED(CONFIG_DEBUG_VM))
> +		return all_online;
> +
> +	for_each_memblock(memory, mblk) {
> +		pfn = PHYS_PFN(mblk->base);
> +		end_pfn = PHYS_PFN(mblk->base + mblk->size);
> +

It's not a good idea to access @mblk->{base, size}. There are two
accessors: memblock_region_memory_{base, end}_pfn().

> +		for (; pfn < end_pfn; pfn += PAGES_PER_SECTION) {
> +			ms = __pfn_to_section(pfn);
> +
> +			/*
> +			 * All memory ranges in the system at this point
> +			 * should have been marked early sections.
> +			 */
> +			WARN_ON(!early_section(ms));
> +
> +			/*
> +			 * Memory notifier mechanism here to prevent boot
> +			 * memory offlining depends on the fact that each
> +			 * early section memory on the system is intially
> +			 * online. Otherwise a given memory section which
> +			 * is already offline will be overlooked and can
> +			 * be removed completely. Call out such sections.
> +			 */

s/intially/initially

> +			if (!online_section(ms)) {
> +				start = PFN_PHYS(pfn);
> +				end = start + (1UL << PA_SECTION_SHIFT);
> +				pr_err("Memory range [%lx %lx] is offline\n", start, end);
> +				pr_err("Memory range [%lx %lx] can be removed\n", start, end);
> +				all_online = false;

These two error messages can be combined:

     pr_err("Memory range [%lx %lx] not online, can't be offlined\n",
            start, end);

I think you need to return @all_online immediately, without
checking if the subsequent sections are online or not? :)

> +			}
> +		}
> +	}
> +	return all_online;
> +}
> +
>   static int __init prevent_bootmem_remove_init(void)
>   {
>   	int ret = 0;
> @@ -1529,6 +1585,9 @@ static int __init prevent_bootmem_remove_init(void)
>   	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
>   		return ret;
>   
> +	if (!validate_bootmem_online())
> +		return -EINVAL;
> +
>   	ret = register_memory_notifier(&prevent_bootmem_remove_nb);
>   	if (ret)
>   		pr_err("%s: Notifier registration failed %d\n", __func__, ret);
> 

Cheers,
Gavin

