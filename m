Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572EC29FE54
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgJ3HRK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725832AbgJ3HRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604042227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fsLtbt0WVLl9lO+BzzDPUuT9NMeaDcoLcHYAkLj4g80=;
        b=QcNTPaIZquDBDWxTugzHp/bJn5Ms5tgkl5+9+fJWyIItrC7PFdrUW25/LkmPQfptwF7sb0
        cczWNOy4XSX1WNYUYwcZmkO3lXFOb31UqMgbvSBMEXZZJ3VlTGIQxhfPCXX6xpmG/MEbq/
        oDnEA3XTsiqNpYJqLn/g1/GbenVh70Q=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-bAUFWd_WNheSZJ60cY55Ig-1; Fri, 30 Oct 2020 03:17:05 -0400
X-MC-Unique: bAUFWd_WNheSZJ60cY55Ig-1
Received: by mail-ed1-f70.google.com with SMTP id a73so2251581edf.16
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 00:17:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fsLtbt0WVLl9lO+BzzDPUuT9NMeaDcoLcHYAkLj4g80=;
        b=q2vJt/uI4MjqvEBy4G0j8EP2pTH/0a2VbMrvM9dOIdPHgNDF0F6JXsfz9WihjvvQut
         QgzDDdI5gzojhdPlmfGRW4PjNhU1A5OB3nPYOXfMuOzwi9sWJdBEM/dbbCBZVuYcKRft
         geKfCRKMO+NfxyzJBOMKrLMjTomNsZMrQzdO/peaHS3hreM3U9wc7jxORobu2c7torVW
         IQGpA62IAlpVCw8oPEokpnRw0ZCjed7SjcbKBpJTpeJmq2UrXrmx3LxkXWfebSrTf2Ei
         esGkoz3E7kKBqHH1CCJ8G2cceEN/hEq8wezYRopZoIDSsbtoUs1nHUWXJfka41Y7p6vR
         Sh4Q==
X-Gm-Message-State: AOAM531SUqhY+FOsPNxOM4cwDw2GE3le8B7utmhZBchEJV6uAT1iHm5A
        wCAwMB6VA5hRxrsMF+XYFHprKCdUtrP6e2SJvZb52uLE+KnP4p46iIFCeaiy7CkVeEiwX/vbUSU
        9eSMbfEqvEx58bygBz41hVxfx
X-Received: by 2002:a05:6402:384:: with SMTP id o4mr827444edv.387.1604042223805;
        Fri, 30 Oct 2020 00:17:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOz7Odf3r2gUKdJWqZdZ6A8NU3zOEGqtk5Ocv0U7Qp7D2Tczotk3LS3Ma3XCaKKXToXCfJQg==
X-Received: by 2002:a05:6402:384:: with SMTP id o4mr827426edv.387.1604042223641;
        Fri, 30 Oct 2020 00:17:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q2sm2564222ejd.20.2020.10.30.00.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 00:17:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Filter out more Intel-specific PMU MSRs in kvm_init_msr_list()
In-Reply-To: <20201014125020.2406434-1-vkuznets@redhat.com>
References: <20201014125020.2406434-1-vkuznets@redhat.com>
Date:   Fri, 30 Oct 2020 08:17:01 +0100
Message-ID: <87o8kkyyhe.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> When running KVM selftest in a Hyper-V VM they stumble upon
>
>   Unexpected result from KVM_GET_MSRS, r: 14 (failed MSR was 0x309)
>
> MSR_ARCH_PERFMON_FIXED_CTR[0..3] along with MSR_CORE_PERF_FIXED_CTR_CTRL,
> MSR_CORE_PERF_GLOBAL_STATUS, MSR_CORE_PERF_GLOBAL_CTRL,
> MSR_CORE_PERF_GLOBAL_OVF_CTRL are only valid for Intel PMU ver > 1 but
> Hyper-V instances have CPUID.0AH.EAX == 0 (so perf code falls back to
> p6_pmu instead of intel_pmu). Surprisingly, unlike on AMD hardware for
> example, our rdmsr_safe() check passes and MSRs are not filtered out.
>
> MSR_ARCH_PERFMON_FIXED_CTR[0..3] can probably be checked against
> x86_pmu.num_counters_fixed and the rest is only present with
> x86_pmu.version > 1.
>
> Unfortunately, full elimination of the disconnection between system-wide
> KVM_GET_MSR_INDEX_LIST/KVM_GET_MSR_FEATURE_INDEX_LIST and per-VCPU
> KVM_GET_MSRS/KVM_SET_MSRS seem to be impossible as per-vCPU PMU setup
> depends on guest CPUIDs which can always be altered.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ce856e0ece84..85d72b125fba 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5436,6 +5436,15 @@ static void kvm_init_msr_list(void)
>  			    min(INTEL_PMC_MAX_GENERIC, x86_pmu.num_counters_gp))
>  				continue;
>  			break;
> +		case MSR_ARCH_PERFMON_FIXED_CTR0 ... MSR_ARCH_PERFMON_FIXED_CTR0 + 3:
> +			if (msrs_to_save_all[i] - MSR_ARCH_PERFMON_FIXED_CTR0 >=
> +			    min(INTEL_PMC_MAX_FIXED, x86_pmu.num_counters_fixed))
> +				continue;
> +			break;
> +		case MSR_CORE_PERF_FIXED_CTR_CTRL ... MSR_CORE_PERF_GLOBAL_OVF_CTRL:
> +			if (x86_pmu.version <= 1)
> +				continue;
> +			break;
>  		default:
>  			break;
>  		}

Ping?

-- 
Vitaly

