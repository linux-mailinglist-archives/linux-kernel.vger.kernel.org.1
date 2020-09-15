Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E00EC26A31B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIOK1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:27:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49511 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726201AbgIOK10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600165644;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fkoLRj4CpMUCFaAU/c0cpXEpa6XQZl3hQi3pkjeuyww=;
        b=Q/OuQeQHlw+zgxQethY2Tz6hS7jZZaAAFMdIAK6rGxV2hxk1BD0Qqqv87mPSARJOLbztaA
        UUZircXcWWFU8tE2frFBcbhUFeeuzYTbH6VJtxZCPAMkrbEDLnbUz+FlZKcBDf1rpc2b62
        E9LoTwUpHbpvFZRrQrIhMkUsAjWJUo8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-FEVhin7mPWyNUOswJedzXw-1; Tue, 15 Sep 2020 06:27:22 -0400
X-MC-Unique: FEVhin7mPWyNUOswJedzXw-1
Received: by mail-wm1-f70.google.com with SMTP id s19so1008086wme.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 03:27:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fkoLRj4CpMUCFaAU/c0cpXEpa6XQZl3hQi3pkjeuyww=;
        b=R1CJorspXQE5Id1SahcHZKrhMmYrPO+lihSdAYOSND5AsrGRrWrInlcRBmsTIPD243
         BXAiHUBFxhqOmUIil67bgiO9nsJRLRRzu/BeJkWV67Nolzrv+ljaGKSPpHlBkP4Vbumb
         e/qw9sArBVC1u3GRnLHrbJK2tmB4GodTwrRJ0f81HzVgXT0IyMz90rSEdMFeWSH7bNKg
         jlHp3/wzKbVaphUNycT8xY+L2UXgIl0Nz2h/ffkKX8NO8CpyP+s9fjDihAVRA5IKg7BF
         Wg5dm3f7o+3FqTmTIOmseqqshmTw/hifjVWfaMBMIFknz2cK2zeSa69C1+u8n9vGRVpj
         8Gmg==
X-Gm-Message-State: AOAM532d5Yi3LuU0iblCnz1cHkY09TOtdMXRFQ/aMz4GGPPwAQma5ghn
        DxFtRPMK//B4/NxhV8x91scNnmHYV2BQ6h9YIOmp+UotXJfRt5OJKmweuuX9A3TSofbz/ddb0qZ
        +2vYgNb7gIlVuMCQIJaE3KlTf
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr4181807wmc.112.1600165638453;
        Tue, 15 Sep 2020 03:27:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwV7+MNnmdJ7LoABeyhT5kZ24BSMQZtr2CvPEQVPzv2SqkmoR19M8GCrVTONoAPOxgeK7xVNw==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr4181777wmc.112.1600165638158;
        Tue, 15 Sep 2020 03:27:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z15sm25217526wrv.94.2020.09.15.03.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 03:27:17 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        "open list\:GENERIC INCLUDE\/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>
Subject: Re: [PATCH RFC v1 07/18] x86/hyperv: extract partition ID from Microsoft Hypervisor if necessary
In-Reply-To: <20200914112802.80611-8-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-8-wei.liu@kernel.org>
Date:   Tue, 15 Sep 2020 12:27:16 +0200
Message-ID: <87y2lbjpx7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> We will need the partition ID for executing some hypercalls later.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c         | 26 ++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h   |  2 ++
>  include/asm-generic/hyperv-tlfs.h |  6 ++++++
>  3 files changed, 34 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index ebba4be4185d..0eec1ed32023 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -30,6 +30,9 @@
>  bool hv_root_partition;
>  EXPORT_SYMBOL_GPL(hv_root_partition);
>  
> +u64 hv_current_partition_id;
> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> +
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>  
> @@ -345,6 +348,26 @@ static struct syscore_ops hv_syscore_ops = {
>  	.resume		= hv_resume,
>  };
>  
> +void __init hv_get_partition_id(void)
> +{
> +	struct hv_get_partition_id *output_page;
> +	int status;
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
> +		HV_HYPERCALL_RESULT_MASK;

Nit: in this case status is 'u16', we can define it as such (instead of
signed int).

> +	if (status != HV_STATUS_SUCCESS)
> +		pr_err("Failed to get partition ID: %d\n", status);
> +	else
> +		hv_current_partition_id = output_page->partition_id;
> +	local_irq_restore(flags);
> +
> +	/* No point in proceeding if this failed */
> +	BUG_ON(status != HV_STATUS_SUCCESS);
> +}
> +
>  /*
>   * This function is to be invoked early in the boot sequence after the
>   * hypervisor has been detected.
> @@ -440,6 +463,9 @@ void __init hyperv_init(void)
>  
>  	register_syscore_ops(&hv_syscore_ops);
>  
> +	if (hv_root_partition)
> +		hv_get_partition_id();

According to TLFS, partition ID is available when AccessPartitionId
privilege is granted. I'd suggest we check that instead of
hv_root_partition (and we can set hv_current_partition_id to something
like U64_MAX so we know it wasn't acuired). So the BUG_ON condition will
move here:

        hv_get_partition_id();
        BUG_ON(hv_root_partition && hv_current_partition_id == U64_MAX);

> +
>  	return;
>  
>  remove_cpuhp_state:
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index f5c62140f28d..4039302e0ae9 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -65,6 +65,8 @@ extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
>  extern void  __percpu  **hyperv_pcpu_output_arg;
>  
> +extern u64 hv_current_partition_id;
> +
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
>  	u64 input_address = input ? virt_to_phys(input) : 0;
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index e6903589a82a..87b1a79b19eb 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -141,6 +141,7 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
>  #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
>  #define HVCALL_SEND_IPI_EX			0x0015
> +#define HVCALL_GET_PARTITION_ID			0x0046
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_POST_MESSAGE			0x005c
> @@ -407,6 +408,11 @@ struct hv_tlb_flush_ex {
>  	u64 gva_list[];
>  } __packed;
>  
> +/* HvGetPartitionId hypercall (output only) */
> +struct hv_get_partition_id {
> +	u64 partition_id;
> +} __packed;
> +
>  /* HvRetargetDeviceInterrupt hypercall */
>  union hv_msi_entry {
>  	u64 as_uint64;

-- 
Vitaly

