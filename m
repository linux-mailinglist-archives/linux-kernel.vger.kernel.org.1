Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B942303C18
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405461AbhAZLvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:51:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391896AbhAZLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611661173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EpWnMnQAKA1lbkZEqiYIbptGSX1/j2tDMdqOAlnJ98E=;
        b=OMYhZaYOq6OWPTrcLSt4AeK2fIy9KRfL1xtxs1eobzlCdKqjHwbLBmSR93sROpT1UktdvI
        xzVaspQBQW5Ij7vt2c6YW58iA65yUW0evEa8hTuwnmpo3NkM3Sw70+OOYsNOSitRRSNyPD
        +ofWzGv/Kt1qViKzFJNTuFiwI9W6lvE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-XgIyhvjTPYyvMmGG8EqINA-1; Tue, 26 Jan 2021 06:39:31 -0500
X-MC-Unique: XgIyhvjTPYyvMmGG8EqINA-1
Received: by mail-ej1-f71.google.com with SMTP id md20so4846304ejb.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EpWnMnQAKA1lbkZEqiYIbptGSX1/j2tDMdqOAlnJ98E=;
        b=qmHajrba4T9SvnV3/IEs+hC6WOKQQhbPhLYHtVtMd48xmhnyxf+x+wI5TnJmx4yKHD
         6vlauqKO0m32gtrkstSYYUUin7Q+dApI9U+blCfGYqU/r17YWDBqCeGIFiA4R7Nt2TID
         +iPSiH12bwOHx4uj4lpQwPe4nUxeCtPAJigmAhabgzVEKjPPStQ6KAGoT9Wm3yjNDIzd
         58M0TGBLt/gaq/Ety4pBD3XjDpRDetBvfxh+RvpzR0GYapWJnp8kiwn0rwMb+smVDj9D
         nYwFU8OGVML8fvhbUYVgF6o1iI6sq0PXjzEJVRIQZGNr6IgGxWAJnpxHVfKnpBE9EmVf
         Imqw==
X-Gm-Message-State: AOAM533ZS6Y+KBxuDKiCn8zu1kmPYLD5i9bspjXiNiDKBineg4+Obdmy
        Jmswn6OEMUKu1x7HYzp6F07vz0PVXn8866uKRKEcL+f7WeQx4Ti8JXlemgdMOhjJmCEI0gQh9N6
        qsWq/DMw9iV+tB6bIkfwvu0Ks
X-Received: by 2002:a17:906:941a:: with SMTP id q26mr3296713ejx.266.1611661170112;
        Tue, 26 Jan 2021 03:39:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6YulkBBLOBEp+W7Z0U6Wh1eD5MMryQVC+TU6I84GU/K5McBKVF0I+NgjcE4xPAhkMay1Hew==
X-Received: by 2002:a17:906:941a:: with SMTP id q26mr3296705ejx.266.1611661169962;
        Tue, 26 Jan 2021 03:39:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id fi12sm9757502ejb.49.2021.01.26.03.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 03:39:29 -0800 (PST)
Subject: Re: [PATCH v3 0/4] Handle #GP for SVM execution instructions
To:     Wei Huang <wei.huang2@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        mlevitsk@redhat.com, seanjc@google.com, joro@8bytes.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        jmattson@google.com, wanpengli@tencent.com, bsd@redhat.com,
        dgilbert@redhat.com, luto@amacapital.net
References: <20210126081831.570253-1-wei.huang2@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3349e153-83ae-3c55-ee88-2036b2ce38d8@redhat.com>
Date:   Tue, 26 Jan 2021 12:39:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126081831.570253-1-wei.huang2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/21 09:18, Wei Huang wrote:
> While running SVM related instructions (VMRUN/VMSAVE/VMLOAD), some AMD
> CPUs check EAX against reserved memory regions (e.g. SMM memory on host)
> before checking VMCB's instruction intercept. If EAX falls into such
> memory areas, #GP is triggered before #VMEXIT. This causes unexpected #GP
> under nested virtualization. To solve this problem, this patchset makes
> KVM trap #GP and emulate these SVM instuctions accordingly.
> 
> Also newer AMD CPUs will change this behavior by triggering #VMEXIT
> before #GP. This change is indicated by CPUID_0x8000000A_EDX[28]. Under
> this circumstance, #GP interception is not required. This patchset supports
> the new feature.
> 
> This patchset has been verified with vmrun_errata_test and vmware_backdoor
> tests of kvm_unit_test on the following configs. Also it was verified that
> vmware_backdoor can be turned on under nested on nested.
>    * Current CPU: nested, nested on nested
>    * New CPU with X86_FEATURE_SVME_ADDR_CHK: nested, nested on nested
> 
> v2->v3:
>    * Change the decode function name to x86_decode_emulated_instruction()
>    * Add a new variable, svm_gp_erratum_intercept, to control interception
>    * Turn on VM's X86_FEATURE_SVME_ADDR_CHK feature in svm_set_cpu_caps()
>    * Fix instruction emulation for vmware_backdoor under nested-on-nested
>    * Minor comment fixes
> 
> v1->v2:
>    * Factor out instruction decode for sharing
>    * Re-org gp_interception() handling for both #GP and vmware_backdoor
>    * Use kvm_cpu_cap for X86_FEATURE_SVME_ADDR_CHK feature support
>    * Add nested on nested support
> 
> Thanks,
> -Wei
> 
> Wei Huang (4):
>    KVM: x86: Factor out x86 instruction emulation with decoding
>    KVM: SVM: Add emulation support for #GP triggered by SVM instructions
>    KVM: SVM: Add support for SVM instruction address check change
>    KVM: SVM: Support #GP handling for the case of nested on nested
> 
>   arch/x86/include/asm/cpufeatures.h |   1 +
>   arch/x86/kvm/svm/svm.c             | 128 +++++++++++++++++++++++++----
>   arch/x86/kvm/x86.c                 |  62 ++++++++------
>   arch/x86/kvm/x86.h                 |   2 +
>   4 files changed, 152 insertions(+), 41 deletions(-)
> 

Queued, thanks.

Paolo

