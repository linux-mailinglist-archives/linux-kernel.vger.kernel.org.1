Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC4F92B212D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgKMQ5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:57:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39197 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725967AbgKMQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605286671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8ZQSCankw5B0QgNiJvLUAMhyn2rU6CiTpgEHp+KAF+c=;
        b=iGeUkU1LPanzsCpHcrG+QfGdmiGr0mHx1SnyrbUBRsRE/cug/ZcPSpaJFzODYUNHZDHbJd
        7O2O+ebF7ebsNjm1a1/IyV1qU1K+j+g+eT4W+sF+aTvu4Mw34TSsRdpGEg6ZhVEYfg53xJ
        9hGKHyaHFDxjes/+5RwWo75t0gICFEI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-Ap9MKAXlO5Om-ym2dbcnUA-1; Fri, 13 Nov 2020 11:57:50 -0500
X-MC-Unique: Ap9MKAXlO5Om-ym2dbcnUA-1
Received: by mail-wr1-f69.google.com with SMTP id k1so4140690wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:57:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8ZQSCankw5B0QgNiJvLUAMhyn2rU6CiTpgEHp+KAF+c=;
        b=olEHGzTRT+ZXEe/TxpjnB+uOYbbY8T9rvf4GPxYKRE+Hj9rGMJpK6xa0n8RZHiUOC6
         qYhC7NC0V5JK/st2zSb1JLeCtLuQBwrih+GeAgHbHn888IkAnpNvG6Y9MAWdOEvcwDrI
         FzLeJADjS9O9xPQZ9mpTu5ywU2M/t87V3RCW3oPMTRKtkCQ9PTju+DyjeXpmvFBf8SSl
         nsmqsCVDf9FxHSkwXooBmP6fSq0dNiPMgqtZ3jIc9xUMU7UWwxwvXBWQdm0sZmxB0rm5
         v33DtjEC6GQydspq4eW9fXt7tVnzJL/HTFdlpAE/pwPbtjIcp/v+DBV8uClUoQRknvTe
         F8HQ==
X-Gm-Message-State: AOAM531WdVgEoQOtg19HAxnYL7AUhP9WrKqVuJdWAecNbRYBgUuhTyPA
        OMxkt626g0Yl2/Ny4cDYbZuZEiyxNCVDZdcRcoHaA62KmwOMoqQ2R+OQL9PRiZ6iuqg30n3Szd5
        ELolY6htWSjjXb/kOGAhP7MBv
X-Received: by 2002:a05:6000:364:: with SMTP id f4mr4554172wrf.290.1605286663938;
        Fri, 13 Nov 2020 08:57:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwi/GV6bvhHaDYjQ+i+BKr+EldsibMpe6ecBnpRLJ7GXLQzaZLuUjw5ChknHnxVrvznO18MeQ==
X-Received: by 2002:a05:6000:364:: with SMTP id f4mr4553781wrf.290.1605286658811;
        Fri, 13 Nov 2020 08:57:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id a12sm11508076wrr.31.2020.11.13.08.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 08:57:37 -0800 (PST)
Subject: Re: [PATCH v2 1/2] KVM: SVM: Move asid to vcpu_svm
To:     Cathy Avery <cavery@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, wei.huang2@amd.com, mlevitsk@redhat.com
References: <20201011184818.3609-1-cavery@redhat.com>
 <20201011184818.3609-2-cavery@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aadb4690-9b2b-4801-f2fc-783cb4ae7f60@redhat.com>
Date:   Fri, 13 Nov 2020 17:57:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201011184818.3609-2-cavery@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 20:48, Cathy Avery wrote:
> Move asid to svm->asid to allow for vmcb assignment
> during svm_vcpu_run without regard to which level
> guest is running.

Slightly more verbose commit message:

KVM does not have separate ASIDs for L1 and L2; either the nested
hypervisor and nested guests share a single ASID, or on older processor
the ASID is used only to implement TLB flushing.

Either way, ASIDs are handled at the VM level.  In preparation
for having different VMCBs passed to VMLOAD/VMRUN/VMSAVE for L1 and
L2, store the current ASID to struct vcpu_svm and only move it to
the VMCB in svm_vcpu_run.  This way, TLB flushes can be applied
no matter which VMCB will be active during the next svm_vcpu_run.


> Signed-off-by: Cathy Avery <cavery@redhat.com>
> ---
>   arch/x86/kvm/svm/svm.c | 4 +++-
>   arch/x86/kvm/svm/svm.h | 1 +
>   2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index d4e18bda19c7..619980a5d540 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1101,6 +1101,7 @@ static void init_vmcb(struct vcpu_svm *svm)
>   		save->cr4 = 0;
>   	}
>   	svm->asid_generation = 0;
> +	svm->asid = 0;
>   
>   	svm->nested.vmcb = 0;
>   	svm->vcpu.arch.hflags = 0;
> @@ -1663,7 +1664,7 @@ static void new_asid(struct vcpu_svm *svm, struct svm_cpu_data *sd)
>   	}
>   
>   	svm->asid_generation = sd->asid_generation;
> -	svm->vmcb->control.asid = sd->next_asid++;
> +	svm->asid = sd->next_asid++;
>   
>   	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
>   }

This vmcb_mark_dirty must be delayed to svm_vcpu_run as well, because 
the active VMCB could change:

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 48965bfa3d1e..3b53a7ead04b 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1756,12 +1756,11 @@ static void new_asid(struct vcpu_svm *svm, 
struct svm_cpu_data *sd)
  		++sd->asid_generation;
  		sd->next_asid = sd->min_asid;
  		svm->vmcb->control.tlb_ctl = TLB_CONTROL_FLUSH_ALL_ASID;
+		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
  	}

  	svm->asid_generation = sd->asid_generation;
  	svm->asid = sd->next_asid++;
-
-	vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
  }

  static void svm_set_dr6(struct vcpu_svm *svm, unsigned long value)
@@ -3571,7 +3570,10 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct 
kvm_vcpu *vcpu)

  	sync_lapic_to_cr8(vcpu);

-	svm->vmcb->control.asid = svm->asid;
+	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
+		svm->vmcb->control.asid = svm->asid;
+		vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
+	}
  	svm->vmcb->save.cr2 = vcpu->arch.cr2;

  	/*

Queued with this change.

Paolo

