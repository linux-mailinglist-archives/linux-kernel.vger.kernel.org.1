Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3083F275182
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 08:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbgIWGbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 02:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgIWGbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:31:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600842706;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jC7xykCrdkUMT9gFZ3QyUZCRmwNkMDA3HcJpGrglkA8=;
        b=eP8iqQnjD3AtFbIUHSLJf2CXD4No+CBU4UUiNzk3ICw6hgtWcZSk4+HLDTmrueZYVE/OlM
        YcUmUaQVTwElImzMjnas46md71wqvI+ulS0gHgONyxciLWeD4xiyNeaCwkW18FU8OJNRc8
        wn+chOuqfGX83/ELj87B8foaIR98//M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-adDz4NVeMXC8L0K4fxJbxA-1; Wed, 23 Sep 2020 02:31:41 -0400
X-MC-Unique: adDz4NVeMXC8L0K4fxJbxA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEA4418C9F40;
        Wed, 23 Sep 2020 06:31:39 +0000 (UTC)
Received: from [10.64.54.30] (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 382767B7B3;
        Wed, 23 Sep 2020 06:31:37 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH V3 2/3] arm64/mm/hotplug: Enable MEM_OFFLINE event
 handling
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.com>,
        catalin.marinas@arm.com, Steve Capper <steve.capper@arm.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Marc Zyngier <maz@kernel.org>, will@kernel.org
References: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
 <1600689908-28213-3-git-send-email-anshuman.khandual@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <d4e90ed2-f348-0d80-b3d7-d156abe05a90@redhat.com>
Date:   Wed, 23 Sep 2020 16:31:34 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1600689908-28213-3-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 9/21/20 10:05 PM, Anshuman Khandual wrote:
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

I'm not sure if it makes sense since MEM_OFFLINE won't be triggered
after NOTIFY_BAD is returned from MEM_GOING_OFFLINE. NOTIFY_BAD means
the whole offline process is stopped. It would be guranteed by generic
framework from syntax standpoint.

However, this looks good if MEM_OFFLINE is triggered without calling
into MEM_GOING_OFFLINE previously, but it would be a bug from generic
framework.

>   arch/arm64/mm/mmu.c | 37 ++++++++++++++++++++++++++++++++-----
>   1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index df3b7415b128..6b171bd88bcf 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1482,13 +1482,40 @@ static int prevent_bootmem_remove_notifier(struct notifier_block *nb,
>   	unsigned long end_pfn = arg->start_pfn + arg->nr_pages;
>   	unsigned long pfn = arg->start_pfn;
>   
> -	if (action != MEM_GOING_OFFLINE)
> +	if ((action != MEM_GOING_OFFLINE) && (action != MEM_OFFLINE))
>   		return NOTIFY_OK;
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
> +
> +				/*
> +				 * Core memory hotplug does not process a return
> +				 * code from the notifier for MEM_OFFLINE event.
> +				 * Error condition has been reported. Report as
> +				 * ignored.
> +				 */
> +				return NOTIFY_DONE;
> +			}
> +		}
>   	}
>   	return NOTIFY_OK;
>   }
> 

It's pretty much irrelevant comment if the patch doesn't make sense:
the logical block for MEM_GOING_OFFLINE would be reused by MEM_OFFLINE
as they looks similar except the return value and error message :)

Cheers,
Gavin

