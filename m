Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855972EAB87
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729838AbhAENHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729176AbhAENHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:07:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609851973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=85pKVnvSeYA5QLQD5EhADjq2rId3Mid5CE6/9bUvHYM=;
        b=fjUIk+tGp/ui2/U5U3g4JLTnl7eRfFj1KpkrOBITODmwDs/gGcocJvJfNu6PdSYsOpq4vD
        57JzmG8m8h53DcjqzhqfNif9TWmoa1ypn8hZTTQ/hRKPxEKfn6Kr9XdEnyCEwEvK5APcVi
        033oW51nW0ES2lqE+bdyuKbxupgM0BE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-Q8pAyullO5mQCud3qURWpw-1; Tue, 05 Jan 2021 08:06:11 -0500
X-MC-Unique: Q8pAyullO5mQCud3qURWpw-1
Received: by mail-ej1-f72.google.com with SMTP id pv24so7921042ejb.19
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=85pKVnvSeYA5QLQD5EhADjq2rId3Mid5CE6/9bUvHYM=;
        b=Q9mFhWtAlxPbC3M26fg4dQW4NICm6Vd1a14zu6k0ykdgpgRypA5m3AevlK2y27niJL
         s8RlUXRqwqdArRaR4PorN6yk3U9Tenu8MZ2JuNf+43YTWTg5mID+Javtc9YDI2fJF5my
         1bjiVWSlxmh9HXD5bvJ6cv5gmfBX+/JaWkj2UTMuwgs9kpZz86GkMfjflRmOBoVONupO
         1Bn5atNcpXNTqgUEYHRgrd0mKX+N8wVlkPGOOQboFUB9E6n1CRQBV1aPXI+aYOFR+J5b
         PNV2ZZHWn+Tcp4oZ6QAgS9TEcnF6ThieMAznQ4sBFVed8UjpcwtaIq7yuPCiEv0EuGUv
         so3A==
X-Gm-Message-State: AOAM533ezkmDwSD+9PYyW8iaxaY7ALb0dOPc1QxqY+7n2tXto5s4gQ1s
        xzOzUGi6UHoWWAbuDZyzL4H+14AJCyI51faKAlqx6ZpASfjGw6QbdM3HEpmBEFdKzGHslba/Y/9
        Y1KLb4dj24LIziYy/U5EXWC0u
X-Received: by 2002:a05:6402:3192:: with SMTP id di18mr74257299edb.332.1609851970497;
        Tue, 05 Jan 2021 05:06:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIXZH+i4vTIqBL+qL/InbxzIhFkuFWwsUFjB/084QZuJD1bxGWu2omuhWudF/kow2Btliw+A==
X-Received: by 2002:a05:6402:3192:: with SMTP id di18mr74257264edb.332.1609851970322;
        Tue, 05 Jan 2021 05:06:10 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p12sm22637661eds.39.2021.01.05.05.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:06:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Alexey Makhalov <amakhalov@vmware.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, hpa@zytor.com,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        pv-drivers@vmware.com, sdeep@vmware.com
Subject: Re: [PATCH] x86/vmware: avoid TSC recalibration
In-Reply-To: <20210105004752.131069-1-amakhalov@vmware.com>
References: <20210105004752.131069-1-amakhalov@vmware.com>
Date:   Tue, 05 Jan 2021 14:06:08 +0100
Message-ID: <87im8bildr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Makhalov <amakhalov@vmware.com> writes:

> When TSC frequency is known (retrieved from hypervisor), we should skip
> TSC refined calibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
>
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c6ede3b3d302..83164110ccc5 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -378,6 +378,8 @@ static void __init vmware_set_capabilities(void)
>  {
>  	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
>  	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> +	if (vmware_tsc_khz)
> +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
>  		setup_force_cpu_cap(X86_FEATURE_VMCALL);
>  	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)

The same trick is being used in Xen/Jailhouse/KVM code already and
Hyper-V overwrites x86_platform.calibrate_tsc/x86_platform.calibrate_cpu
hooks to basically achive the same goal. Should we maybe introduce a
flag in 'struct hypervisor_x86' or something like that to unify all
this?

Just a suggestion.

-- 
Vitaly

