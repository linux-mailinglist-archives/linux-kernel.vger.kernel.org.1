Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 622712FA81E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407375AbhARR6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 12:58:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60191 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2407254AbhARR5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 12:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610992580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hWCFJ1Ui+QPJSU5mbyAyYwW1tEtCr30ZbCpgxh1LYJY=;
        b=M3W2Hajxip1CSnjK9e8rxGoUF/0uxR9FSDDQIn0Vcqv5bqL0GZvJYBzufuudMfmRz9jsBc
        EZbbxuaOA80NCiW4CzM8GT7OGybOkvhNgEBA9QlQtn591KMuT/x+0T3ajB6aCJTrA32r2C
        /Tje8FElHJoG1DXxarxJJs2Hoq4uA9Y=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-DkUwnKPNOqS9a5BBfg66mg-1; Mon, 18 Jan 2021 12:56:18 -0500
X-MC-Unique: DkUwnKPNOqS9a5BBfg66mg-1
Received: by mail-ed1-f71.google.com with SMTP id t9so2186830edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 09:56:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hWCFJ1Ui+QPJSU5mbyAyYwW1tEtCr30ZbCpgxh1LYJY=;
        b=qfhQCtW1hnG1CiSkOZzH0G0uf1EwLn16lI1p6kQPNoC96oiDaLJpfN5W+PMd06rqDn
         55XHvPcMR/rKJjgzufeIQ20Rm6TQ/0bruXmUX088jLOPNcdah/3xZtWglbEGYvczYrqr
         KBhg+9G5vQR6fZWZ0ubADAQGWIrm0c7aB3i7nKEK5MSyjK3QFGh4zA1j2NYSyKDy045m
         l6gpnUqKxNrTGK5sz0VHuUpZI6aMqewNrv7VfuA8HhV3LtikwGgSB1cPpRz0Mx6pKtrM
         IZf8vgxLM5Pg0NomNg7zzlu3WEEf36JnoF23112SJ+mthqCNi3QBCwPzjP0GUZ9gV39W
         /MpA==
X-Gm-Message-State: AOAM5309q306ZpSt8bd/aFzNO36qihJ+0eGMXAuICMy7rSTVHSjFXwDA
        11Pw89vHkTrceV0ue0al7wkIo2I50+DZtkqoZt3r33qxTf+JhQEAkKU/ubQuxkrZwB3VzQ3OCOi
        u7/OEeR+mp7vf4p2jpJRA2mFtnNenfVpVSkE54ANfjx5z3GTO+RVQUkkeRo9lh4WQ/h0T9w6aYl
        RG
X-Received: by 2002:a17:906:2743:: with SMTP id a3mr581496ejd.378.1610992577133;
        Mon, 18 Jan 2021 09:56:17 -0800 (PST)
X-Google-Smtp-Source: ABdhPJweIiZBMSxy+rAZQxNi6Ane9U5p3a9f6S5g64RN3dxS/Oxb1QDsjyZ1qz/3LCPKgLSAdM0WMA==
X-Received: by 2002:a17:906:2743:: with SMTP id a3mr581477ejd.378.1610992576903;
        Mon, 18 Jan 2021 09:56:16 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u24sm9809545eje.71.2021.01.18.09.56.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jan 2021 09:56:16 -0800 (PST)
Subject: Re: [PATCH v2] KVM: x86/pmu: Fix UBSAN shift-out-of-bounds warning in
 intel_pmu_refresh()
To:     Like Xu <like.xu@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210118025800.34620-1-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53930fc4-46d8-ce87-daa9-00460c6adb63@redhat.com>
Date:   Mon, 18 Jan 2021 18:56:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118025800.34620-1-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/21 03:58, Like Xu wrote:
> Since we know vPMU will not work properly when (1) the guest bit_width(s)
> of the [gp|fixed] counters are greater than the host ones, or (2) guest
> requested architectural events exceeds the range supported by the host, so
> we can setup a smaller left shift value and refresh the guest cpuid entry,
> thus fixing the following UBSAN shift-out-of-bounds warning:
> 
> shift exponent 197 is too large for 64-bit type 'long long unsigned int'
> 
> Call Trace:
>   __dump_stack lib/dump_stack.c:79 [inline]
>   dump_stack+0x107/0x163 lib/dump_stack.c:120
>   ubsan_epilogue+0xb/0x5a lib/ubsan.c:148
>   __ubsan_handle_shift_out_of_bounds.cold+0xb1/0x181 lib/ubsan.c:395
>   intel_pmu_refresh.cold+0x75/0x99 arch/x86/kvm/vmx/pmu_intel.c:348
>   kvm_vcpu_after_set_cpuid+0x65a/0xf80 arch/x86/kvm/cpuid.c:177
>   kvm_vcpu_ioctl_set_cpuid2+0x160/0x440 arch/x86/kvm/cpuid.c:308
>   kvm_arch_vcpu_ioctl+0x11b6/0x2d70 arch/x86/kvm/x86.c:4709
>   kvm_vcpu_ioctl+0x7b9/0xdb0 arch/x86/kvm/../../../virt/kvm/kvm_main.c:3386
>   vfs_ioctl fs/ioctl.c:48 [inline]
>   __do_sys_ioctl fs/ioctl.c:753 [inline]
>   __se_sys_ioctl fs/ioctl.c:739 [inline]
>   __x64_sys_ioctl+0x193/0x200 fs/ioctl.c:739
>   do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Reported-by: syzbot+ae488dc136a4cc6ba32b@syzkaller.appspotmail.com
> Signed-off-by: Like Xu <like.xu@linux.intel.com>
> ---
> v1->v2 Changelog:
> - Add similar treatment for eax.split.mask_length (Sean)
> 
>   arch/x86/kvm/vmx/pmu_intel.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index a886a47daebd..d1584ae6625a 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -345,7 +345,9 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>   
>   	pmu->nr_arch_gp_counters = min_t(int, eax.split.num_counters,
>   					 x86_pmu.num_counters_gp);
> +	eax.split.bit_width = min_t(int, eax.split.bit_width, x86_pmu.bit_width_gp);
>   	pmu->counter_bitmask[KVM_PMC_GP] = ((u64)1 << eax.split.bit_width) - 1;
> +	eax.split.mask_length = min_t(int, eax.split.mask_length, x86_pmu.events_mask_len);
>   	pmu->available_event_types = ~entry->ebx &
>   					((1ull << eax.split.mask_length) - 1);
>   
> @@ -355,6 +357,8 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>   		pmu->nr_arch_fixed_counters =
>   			min_t(int, edx.split.num_counters_fixed,
>   			      x86_pmu.num_counters_fixed);
> +		edx.split.bit_width_fixed = min_t(int,
> +			edx.split.bit_width_fixed, x86_pmu.bit_width_fixed);
>   		pmu->counter_bitmask[KVM_PMC_FIXED] =
>   			((u64)1 << edx.split.bit_width_fixed) - 1;
>   	}
> 

Queued, thanks.

Paolo

