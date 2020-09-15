Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7B826B917
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbgIPA4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30586 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726222AbgIOLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 07:17:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600168621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yepvtMKn+6+XBcz8DK1yijuVwPuVaYyQMfi00UvSTyw=;
        b=KklnTGg8Jm03sZWkQpyjgFl93MBkFT7vTOmgIoPzhp+Ov2m6uOO/bDRngBBE9qaBhgB6h1
        KMoS6M6HIEvv5IuzKbjHuB6IQFow7hg+UhCp48sgIrJoNZQIcd5snevhshF3PJwdZnqTxb
        OJNXWCob/4wYxEwTbOeN0JtOepBey1Q=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-yCfcQps3PZCwZ5lCkuvGyA-1; Tue, 15 Sep 2020 07:14:20 -0400
X-MC-Unique: yCfcQps3PZCwZ5lCkuvGyA-1
Received: by mail-wr1-f70.google.com with SMTP id j7so1094372wro.14
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 04:14:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yepvtMKn+6+XBcz8DK1yijuVwPuVaYyQMfi00UvSTyw=;
        b=rLpo/8AGQAgBtxIplDDuN0K1U5ul6NQgxVuk9+9yX4BCNol+CBuOpAVXbHqN2Jhc2V
         rzklp7y6MrrN+gEUfdJUnbdKxARkhvcThSaTUV5xwO45ytsND2aW0GMppl3cIJaZxgAv
         WDi16ybSS41rhmlDqIDdcKD4PkSbPiLYV3xxsWxQufLkyn2vUdlNglfCI3nq5vo5PIUn
         vQGq9AjhaWHDFlpP3go1wtYHBDEwrVZt6pH4OESjQLKqQu07Z/qA4eqmPpImBIWGsd9Y
         LhK48e7is5fYu/yaL5BpX79HK4xYuoE8G4l3uoUNlTbXf4qtqAms4dO9nWQLa5rcfOLf
         ogDQ==
X-Gm-Message-State: AOAM533QzQL4oeAdId99zeep9F6JSA0BV0taS0ibz1MuviTf5Z2LgGr9
        3hDgNR+8G2qj1TdoQlbpZrWp/pGjcFsC+oaXgOE6hoEcLkZzDkYQj39vgnjbxSZdUwWbSrfLu0V
        y7HjAt4sl72xiVMqFbtlWGNvm
X-Received: by 2002:a1c:2403:: with SMTP id k3mr4031972wmk.153.1600168458809;
        Tue, 15 Sep 2020 04:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOzi3Ja62k21YvM26bciVJnHAtZqdXuOel1sIRIJNA9BcjPXAZhIRYZguDOvo2rTnyovo1Uw==
X-Received: by 2002:a1c:2403:: with SMTP id k3mr4031937wmk.153.1600168458576;
        Tue, 15 Sep 2020 04:14:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o6sm27250404wrm.76.2020.09.15.04.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:14:18 -0700 (PDT)
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
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC v1 10/18] x86/hyperv: implement and use hv_smp_prepare_cpus
In-Reply-To: <20200914115928.83184-2-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914115928.83184-2-wei.liu@kernel.org>
Date:   Tue, 15 Sep 2020 13:14:16 +0200
Message-ID: <87mu1rjnqv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> Microsoft Hypervisor requires the root partition to make a few
> hypercalls to setup application processors before they can be used.
>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> CPU hotplug and unplug is not yet supported in this setup, so those
> paths remain untouched.
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index 1bf57d310f78..7522cae02759 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -203,6 +203,31 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  	hv_init_spinlocks();
>  #endif
>  }
> +
> +static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +#if defined(CONFIG_X86_64)

I think it makes little sense to try to make Linux work as Hyper-V root
partition when !CONFIG_X86_64. If we still care about Hyper-V enablement
for !CONFIG_X86_64 we can probably introduce something like
CONFIG_HYPERV_ROOT and enable it automatically, e.g.

config HYPERV_ROOT
        def_bool HYPERV && X86_64

and use it instead.

> +	int i;
> +	int vp_index = 1;
> +	int ret;
> +
> +	native_smp_prepare_cpus(max_cpus);
> +
> +	for_each_present_cpu(i) {
> +		if (i == 0)
> +			continue;
> +		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
> +		BUG_ON(ret);
> +	}
> +
> +	for_each_present_cpu(i) {
> +		if (i == 0)
> +			continue;
> +		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, vp_index++, i);

So vp_index variable is needed here to make sure there are no gaps? (or
we could've just used 'i')?

> +		BUG_ON(ret);
> +	}
> +#endif
> +}
>  #endif
>  
>  static void __init ms_hyperv_init_platform(void)
> @@ -359,6 +384,8 @@ static void __init ms_hyperv_init_platform(void)
>  
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> +	if (hv_root_partition)
> +		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
>  # endif
>  
>  	/*

-- 
Vitaly

