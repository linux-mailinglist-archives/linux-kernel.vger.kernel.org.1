Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD3C27FC90
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 11:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731661AbgJAJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 05:40:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40663 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731131AbgJAJkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 05:40:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601545209;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=W+qdRS5/a8zCmqSGYmyxBFmoynTXfJcL0xwHcD/CgTk=;
        b=aAqP/sg27WrnbZBpWoe4pRrfKozdNUj9xZQw4NGBj6SMAVnH0lfDq/bCiNoUT/2Pw42of1
        QUz7b0PL3IPHxMqPX5turCz4jBTsqAjIW6PoSdXWFWSu4vio+NVy+OlLw5KYiOeOpxa2GY
        e5KoB235EXkbBYHkB6CELy+3NvuoNPc=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-473-u9fxKvzANWCIaTGmKhc6lQ-1; Thu, 01 Oct 2020 05:40:08 -0400
X-MC-Unique: u9fxKvzANWCIaTGmKhc6lQ-1
Received: by mail-ej1-f72.google.com with SMTP id w17so2005724eja.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 02:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=W+qdRS5/a8zCmqSGYmyxBFmoynTXfJcL0xwHcD/CgTk=;
        b=T3fhlcdSPAwYTwFJ+BJaWUU09k2vSomVYtEH8BLZQsKLJXGlv3FHWCWEBUEU6BWSK4
         S/4JEyfheSCrm94tE/un42h7XyjkxZCaEz7I4vCP4gBiiJcuYYx6baqdx2VMflYVuu4L
         2uhBKPJsOEJZ42f36KHkO8AG17KNcgAj6dhfZesAwuNTv+oBvXI+l4xiN3E5FinkL2bg
         Pla/KQXr8ZatjVTPThRnjanNxZAfTiadPJDIpfI31RV7f1ePPx8b9VpEB32TjODZRIlQ
         dKPDmDQk2ybcE4i3zcWmKmeVvd+XOJV6KMY/ed52YlJaoavBjrnc8gX9OvzkXfcIuKdG
         l2/Q==
X-Gm-Message-State: AOAM5318sauVGM4SnqXcvLOpBzQElJVmYujCPZ4QLVy6MEIVuB2//imb
        kE+rB05NUM4wmn3yQUvY1Rb+WTYzyUbYlW9dvPEySTqXHAcIlcw0afnMl4uj4QOTZM8qxM/1dsN
        PgOVzBuaWioUNkyvXvvG+9DNS
X-Received: by 2002:a17:906:914b:: with SMTP id y11mr7339396ejw.145.1601545206698;
        Thu, 01 Oct 2020 02:40:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy9IIKy2hrN4BNbHRx60c8rkP5XpM/JhtjGU0CUYR/6c8NZB5v943ip0V4tzFA3kjX3lN0Pmw==
X-Received: by 2002:a17:906:914b:: with SMTP id y11mr7339372ejw.145.1601545206504;
        Thu, 01 Oct 2020 02:40:06 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n14sm3662483edy.55.2020.10.01.02.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 02:40:05 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, mikelley@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>, stable@kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in hyperv_flush_tlb_others()
In-Reply-To: <20201001013814.2435935-1-sashal@kernel.org>
References: <20201001013814.2435935-1-sashal@kernel.org>
Date:   Thu, 01 Oct 2020 11:40:04 +0200
Message-ID: <87o8lm9te3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:

> cpumask can change underneath us, which is generally safe except when we
> call into hv_cpu_number_to_vp_number(): if cpumask ends up empty we pass
> num_cpu_possible() into hv_cpu_number_to_vp_number(), causing it to read
> garbage. As reported by KASAN:
>
> [   83.504763] BUG: KASAN: slab-out-of-bounds in hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> [   83.908636] Read of size 4 at addr ffff888267c01370 by task kworker/u8:2/106
> [   84.196669] CPU: 0 PID: 106 Comm: kworker/u8:2 Tainted: G        W         5.4.60 #1
> [   84.196669] Hardware name: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> [   84.196669] Workqueue: writeback wb_workfn (flush-8:0)
> [   84.196669] Call Trace:
> [   84.196669] dump_stack (lib/dump_stack.c:120)
> [   84.196669] print_address_description.constprop.0 (mm/kasan/report.c:375)
> [   84.196669] __kasan_report.cold (mm/kasan/report.c:507)
> [   84.196669] kasan_report (arch/x86/include/asm/smap.h:71 mm/kasan/common.c:635)
> [   84.196669] hyperv_flush_tlb_others (include/asm-generic/mshyperv.h:128 arch/x86/hyperv/mmu.c:112)
> [   84.196669] flush_tlb_mm_range (arch/x86/include/asm/paravirt.h:68 arch/x86/mm/tlb.c:798)
> [   84.196669] ptep_clear_flush (arch/x86/include/asm/tlbflush.h:586 mm/pgtable-generic.c:88)
>
> Fixes: 0e4c88f37693 ("x86/hyper-v: Use cheaper HVCALL_FLUSH_VIRTUAL_ADDRESS_{LIST,SPACE} hypercalls when possible")
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: stable@kernel.org
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/hyperv/mmu.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index 5208ba49c89a9..b1d6afc5fc4a3 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -109,7 +109,9 @@ static void hyperv_flush_tlb_others(const struct cpumask *cpus,
>  		 * must. We will also check all VP numbers when walking the
>  		 * supplied CPU set to remain correct in all cases.
>  		 */
> -		if (hv_cpu_number_to_vp_number(cpumask_last(cpus)) >= 64)
> +		int last = cpumask_last(cpus);
> +
> +		if (last < num_possible_cpus() && hv_cpu_number_to_vp_number(last) >= 64)
>  			goto do_ex_hypercall;

In case 'cpus' can end up being empty (I'm genuinely suprised it can)
the check is mandatory indeed. I would, however, just return directly in
this case:

if (last < num_possible_cpus())
	return;

if (hv_cpu_number_to_vp_number(last) >= 64)
	goto do_ex_hypercall;

as there's nothing to flush, no need to call into
hyperv_flush_tlb_others_ex().

Anyway, the fix seems to be correct, so

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>  
>  		for_each_cpu(cpu, cpus) {

-- 
Vitaly

