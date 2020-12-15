Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 298FF2DB2EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 18:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgLORoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 12:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730742AbgLORnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 12:43:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608054134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6oD5/g/hpM8z9CKoFeIqYcXTfR0jHLooq+8MkZg5Z1w=;
        b=ReVcxgSV8mezBiJCtLv+cFbBXoOrLKVUldZxa7NAiEpDO6pEzyve9JSHoVSHxRsQQxl8y3
        /J3dd0ta2+ZzZpt2AxPAQszCHTZcGVQEsCEtr+Myhv38ZFOOAI0DCiJnOBwd8PuElxr+m6
        lCEJeLig5zh9G4VhuJQBA/P71ZJE/JU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-421-WFEN1ddVO4uUJ5pxouiv6w-1; Tue, 15 Dec 2020 12:42:13 -0500
X-MC-Unique: WFEN1ddVO4uUJ5pxouiv6w-1
Received: by mail-ed1-f69.google.com with SMTP id y19so8681454edw.16
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 09:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6oD5/g/hpM8z9CKoFeIqYcXTfR0jHLooq+8MkZg5Z1w=;
        b=hrQ50o6JqOGrAqlZqguHNRZzqdp9+Ut04r4GGjzQIj6P/1o6LcogfU48T9ACdf/EEJ
         jCfONkcXpRaChcvCZjXadthw99Zp6FBp9STIcaYsXlXDn6Edll3A8qp+gkQafuHU39/I
         q1XKIX1Xf0nPrnjhqJxLtwR37fyGtwvaYqinaLFyuSFuHoxU0/H7FRiTvsSs2oN/ttKB
         ftYS6SylYud6Q8CvQwrldsRmcKMxW+OkEhpnVapI/oGXShJuE6sWCVYkYDu0OfZUPl0V
         8L2vd8xbhwsud5G4zyFBZg4V2XJ5n9ge8iJN6pX7DfUgbUdxGquM5/2J3qnOSRJsbXas
         6BVg==
X-Gm-Message-State: AOAM5305UVu4xY9nCe3C+ecus4+GpbwrPewc21BABCbondfzbT0s3JRr
        PbCXnXszJ6iHo6j7DlCy7xukrguuWDBUWf1iSFJyptrbfedi78v7rtN+kuHEiFRzfhlMvk0Iuz4
        jd1mZYsXgI8JoalmItwxd3317
X-Received: by 2002:a05:6402:14c5:: with SMTP id f5mr29738440edx.232.1608054132092;
        Tue, 15 Dec 2020 09:42:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEQ2wWBHjF8PxLAO8CsvXfiziLjvASWmH9LrDkmTPJOKdvXJp5HF+P8uaJgCycV5SZ016suw==
X-Received: by 2002:a05:6402:14c5:: with SMTP id f5mr29738429edx.232.1608054131937;
        Tue, 15 Dec 2020 09:42:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f13sm1767590ejf.42.2020.12.15.09.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Dec 2020 09:42:11 -0800 (PST)
Subject: Re: [PATCH v5 00/34] SEV-ES hypervisor support
To:     Tom Lendacky <thomas.lendacky@amd.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Jim Mattson <jmattson@google.com>, Joerg Roedel <joro@8bytes.org>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
References: <cover.1607620209.git.thomas.lendacky@amd.com>
 <e348086e-1ca1-9020-7c0f-421768a96944@redhat.com>
 <2fac329e-8e4a-7966-c2c0-05ac0bce8e08@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ab6f85a2-f254-5479-bec0-fc111f65f469@redhat.com>
Date:   Tue, 15 Dec 2020 18:42:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <2fac329e-8e4a-7966-c2c0-05ac0bce8e08@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/12/20 17:46, Tom Lendacky wrote:
> KVM: SVM: Add AP_JUMP_TABLE support in prep for AP booting

Great, thanks!

Paolo

> From: Tom Lendacky<thomas.lendacky@amd.com>
> 
> The GHCB specification requires the hypervisor to save the address of an
> AP Jump Table so that, for example, vCPUs that have been parked by UEFI
> can be started by the OS. Provide support for the AP Jump Table set/get
> exit code.
> 
> Signed-off-by: Tom Lendacky<thomas.lendacky@amd.com>
> ---
>   arch/x86/kvm/svm/sev.c |   28 ++++++++++++++++++++++++++++
>   arch/x86/kvm/svm/svm.h |    1 +
>   2 files changed, 29 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6eb097714d43..8b5ef0fe4490 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -18,6 +18,8 @@
>   #include <linux/trace_events.h>
>   #include <asm/fpu/internal.h>
>   
> +#include <asm/trapnr.h>
> +
>   #include "x86.h"
>   #include "svm.h"
>   #include "cpuid.h"
> @@ -1559,6 +1561,7 @@ static int sev_es_validate_vmgexit(struct vcpu_svm *svm)
>   			goto vmgexit_err;
>   		break;
>   	case SVM_VMGEXIT_NMI_COMPLETE:
> +	case SVM_VMGEXIT_AP_JUMP_TABLE:
>   	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
>   		break;
>   	default:
> @@ -1883,6 +1886,31 @@ int sev_handle_vmgexit(struct vcpu_svm *svm)
>   	case SVM_VMGEXIT_NMI_COMPLETE:
>   		ret = svm_invoke_exit_handler(svm, SVM_EXIT_IRET);
>   		break;
> +	case SVM_VMGEXIT_AP_JUMP_TABLE: {
> +		struct kvm_sev_info *sev = &to_kvm_svm(svm->vcpu.kvm)->sev_info;
> +
> +		switch (control->exit_info_1) {
> +		case 0:
> +			/* Set AP jump table address */
> +			sev->ap_jump_table = control->exit_info_2;
> +			break;
> +		case 1:
> +			/* Get AP jump table address */
> +			ghcb_set_sw_exit_info_2(ghcb, sev->ap_jump_table);
> +			break;
> +		default:
> +			pr_err("svm: vmgexit: unsupported AP jump table request - exit_info_1=%#llx\n",
> +			       control->exit_info_1);
> +			ghcb_set_sw_exit_info_1(ghcb, 1);
> +			ghcb_set_sw_exit_info_2(ghcb,
> +						X86_TRAP_UD |
> +						SVM_EVTINJ_TYPE_EXEPT |
> +						SVM_EVTINJ_VALID);
> +		}
> +
> +		ret = 1;
> +		break;
> +	}
>   	case SVM_VMGEXIT_UNSUPPORTED_EVENT:
>   		vcpu_unimpl(&svm->vcpu,
>   			    "vmgexit: unsupported event - exit_info_1=%#llx, exit_info_2=%#llx\n",
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index a5067f776ce0..5431e6335e2e 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -78,6 +78,7 @@ struct kvm_sev_info {
>   	int fd;			/* SEV device fd */
>   	unsigned long pages_locked; /* Number of pages locked */
>   	struct list_head regions_list;  /* List of registered regions */
> +	u64 ap_jump_table;	/* SEV-ES AP Jump Table address */
>   };
>   
>   struct kvm_svm {
> 

