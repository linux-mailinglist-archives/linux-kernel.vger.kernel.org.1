Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C2C527509D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 08:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726629AbgIWGFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 02:05:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726179AbgIWGFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 02:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600841109;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rYJ+scwxgIVdLM3G4UWy3vWMdK97SIs3I3Rw635Z5+0=;
        b=YibiQrDcADD57j5CTAz1OT+fdaJDQ7yfmbPyXoviQfhYgWFkTBh2EFbtXUl9HLfQbiELzd
        qCxOEvxnjY0ASKlmLb/P+CPknhcHSTQQpO7u3jTPxxfWri3Ch8B89U7lJNjJzkguy8mbVN
        4o/sE5KSUmuVAMx3CYKLhcFiQ8mh3DQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-26iReUI8O-uYBr6EjlCYLQ-1; Wed, 23 Sep 2020 02:05:03 -0400
X-MC-Unique: 26iReUI8O-uYBr6EjlCYLQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0F81188C132;
        Wed, 23 Sep 2020 06:05:01 +0000 (UTC)
Received: from [10.64.54.30] (vpn2-54-30.bne.redhat.com [10.64.54.30])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EA40219C4F;
        Wed, 23 Sep 2020 06:04:58 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH V3 1/3] arm64/mm/hotplug: Register boot memory hot remove
 notifier earlier
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.com>,
        catalin.marinas@arm.com, Steve Capper <steve.capper@arm.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Marc Zyngier <maz@kernel.org>, will@kernel.org
References: <1600689908-28213-1-git-send-email-anshuman.khandual@arm.com>
 <1600689908-28213-2-git-send-email-anshuman.khandual@arm.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <bde102b0-7054-ae1d-d5d2-6348f4049d13@redhat.com>
Date:   Wed, 23 Sep 2020 16:04:56 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1600689908-28213-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 9/21/20 10:05 PM, Anshuman Khandual wrote:
> This moves memory notifier registration earlier in the boot process from
> device_initcall() to early_initcall() which will help in guarding against
> potential early boot memory offline requests. Even though there should not
> be any actual offlinig requests till memory block devices are initialized
> with memory_dev_init() but then generic init sequence might just change in
> future. Hence an early registration for the memory event notifier would be
> helpful. While here, just skip the registration if CONFIG_MEMORY_HOTREMOVE
> is not enabled and also call out when memory notifier registration fails.
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
>   arch/arm64/mm/mmu.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 

With the following nit-picky comments resolved:

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 75df62fea1b6..df3b7415b128 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1499,7 +1499,17 @@ static struct notifier_block prevent_bootmem_remove_nb = {
>   
>   static int __init prevent_bootmem_remove_init(void)
>   {
> -	return register_memory_notifier(&prevent_bootmem_remove_nb);
> +	int ret = 0;
> +
> +	if (!IS_ENABLED(CONFIG_MEMORY_HOTREMOVE))
> +		return ret;
> +
> +	ret = register_memory_notifier(&prevent_bootmem_remove_nb);
> +	if (!ret)
> +		return ret;
> +
> +	pr_err("Notifier registration failed - boot memory can be removed\n");
> +	return ret;
>   }

It might be cleaner if the duplicated return statements can be
avoided. Besides, it's always nice to print the errno even though
zero is always returned from register_memory_notifier(). So I guess
you probably need something like below:

         ret = register_memory_notifier(&prevent_bootmem_remove_nb);
         if (ret)
             pr_err("%s: Error %d registering notifier\n", __func__, ret)

         return ret;


register_memory_notifier                   # 0 is returned on !CONFIG_MEMORY_HOTPLUG_SPARSE
    blocking_notifier_chain_register
       notifier_chain_register              # 0 is always returned
       
> -device_initcall(prevent_bootmem_remove_init);
> +early_initcall(prevent_bootmem_remove_init);
>   #endif
> 

Cheers,
Gavin

