Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2242777E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 19:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgIXRdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 13:33:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25351 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728563AbgIXRdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 13:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600968797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V7kSRS4B1/BYTAEIk47/08BOFWi35iNM3f4PHr30+k4=;
        b=W7gxml4T1ut5bId+BRHmpgXCbF6aa9N4mXKDKz8oJZoj6ZlBK/Fwb3G/upwpiEQ28dlZP9
        kVGS0+bzVyyDQvlbYWaPzULiC6X3Y/hnHnUQHn73Q471R7hndOWZkPYCuzlhjaXB/u5DtX
        WL3vav56eZ9d23ztLSVTlbwNQ2xFerM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-fNYZyArJNICXlw9--9NZTA-1; Thu, 24 Sep 2020 13:33:13 -0400
X-MC-Unique: fNYZyArJNICXlw9--9NZTA-1
Received: by mail-wm1-f71.google.com with SMTP id l15so27450wmh.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 10:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V7kSRS4B1/BYTAEIk47/08BOFWi35iNM3f4PHr30+k4=;
        b=HukoTC52IoUqbxr2cH/7LA/o0gB8nL28DMlIaOezSCXQ9yFdl4d7MP1Q4PB9j9KpVQ
         BIXoIkjaRzIlnq1X5XTJIvFGIero2jHTl8BaTyYUyUejzeqc8woL3qZiSnPhzPl+3Yze
         JQOtmzeu7n5AzSLEyydmgm5tY5JKl1Xttl8+KzOoAhugikZlBHv6zv+8MvIK1gj4/WQC
         gSFYwQVSy9pvgX23dYxeano/AQlcHp/jMldqiPlJhir+SCPvNxTEaYFq8K6NlQCOc34t
         BI9nMscqUFFDdDvqFCaszt4C9eB/17KLGS+xbFKxglnCh1T3L9kxUy6t0kYLjhQ3kKFz
         HLDw==
X-Gm-Message-State: AOAM532heZSVnlabftIpJnTMuh9bQGPYjdRrKDWHazQUxsBZuYs/Hmwz
        jrtrXouM2oY/E0dHyNJhLJa34pS3N5cPhpo7yWhjP0xPW3sj09eV99qozCk7lWFrO0Gjs4PGb12
        Ch42QFt/L2DRaJ3Mhf8U4bv3W
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr257956wmi.105.1600968791218;
        Thu, 24 Sep 2020 10:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxx1dgLJ+CZHwXSTB3l5SofvhGxO+ntlJ/RRYiBYml0sb2fmnsnyJcNcl0swptAiY2kX7OJ3w==
X-Received: by 2002:a7b:cbd4:: with SMTP id n20mr257934wmi.105.1600968790943;
        Thu, 24 Sep 2020 10:33:10 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d80e:a78:c27b:93ed? ([2001:b07:6468:f312:d80e:a78:c27b:93ed])
        by smtp.gmail.com with ESMTPSA id t10sm58354wmi.1.2020.09.24.10.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2020 10:33:10 -0700 (PDT)
Subject: Re: [PATCH v2 1/1] KVM: x86: fix MSR_IA32_TSC read for nested
 migration
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200921103805.9102-1-mlevitsk@redhat.com>
 <20200921103805.9102-2-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a35f7d67-d01b-0b2a-2993-7d6e0ba4add6@redhat.com>
Date:   Thu, 24 Sep 2020 19:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200921103805.9102-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/20 12:38, Maxim Levitsky wrote:
> MSR reads/writes should always access the L1 state, since the (nested)
> hypervisor should intercept all the msrs it wants to adjust, and these
> that it doesn't should be read by the guest as if the host had read it.
> 
> However IA32_TSC is an exception. Even when not intercepted, guest still
> reads the value + TSC offset.
> The write however does not take any TSC offset into account.
> 
> This is documented in Intel's SDM and seems also to happen on AMD as well.
> 
> This creates a problem when userspace wants to read the IA32_TSC value and then
> write it. (e.g for migration)
> 
> In this case it reads L2 value but write is interpreted as an L1 value.
> To fix this make the userspace initiated reads of IA32_TSC return L1 value
> as well.
> 
> Huge thanks to Dave Gilbert for helping me understand this very confusing
> semantic of MSR writes.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 17f4995e80a7e..ed4314641360e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -3219,9 +3219,21 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_IA32_POWER_CTL:
>  		msr_info->data = vcpu->arch.msr_ia32_power_ctl;
>  		break;
> -	case MSR_IA32_TSC:
> -		msr_info->data = kvm_scale_tsc(vcpu, rdtsc()) + vcpu->arch.tsc_offset;
> +	case MSR_IA32_TSC: {
> +		/*
> +		 * Intel SDM states that MSR_IA32_TSC read adds the TSC offset
> +		 * even when not intercepted. AMD manual doesn't explicitly
> +		 * state this but appears to behave the same.
> +		 *
> +		 * However when userspace wants to read this MSR, we should
> +		 * return it's real L1 value so that its restore will be correct.
> +		 */
> +		u64 tsc_offset = msr_info->host_initiated ? vcpu->arch.l1_tsc_offset :
> +							    vcpu->arch.tsc_offset;
> +
> +		msr_info->data = kvm_scale_tsc(vcpu, rdtsc()) + tsc_offset;
>  		break;
> +	}
>  	case MSR_MTRRcap:
>  	case 0x200 ... 0x2ff:
>  		return kvm_mtrr_get_msr(vcpu, msr_info->index, &msr_info->data);
> 

Applied the patch as it is doing the sanest possible thing for the
current semantics of host-initiated accesses.

Paolo

