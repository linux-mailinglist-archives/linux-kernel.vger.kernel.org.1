Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597912CECFF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 12:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbgLDLYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 06:24:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28698 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726031AbgLDLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 06:24:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607080973;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2xYmq1WDTNwe1WMK0sFOwKcOwQdm9xnUmb1ObuGviYU=;
        b=dLMhL3eaFcT5uTMDquQyfdPFjoGzlTFDN204ttVa9nShLlLyDMVoTDIeo+jGvoRZkWWre/
        lfck76MySkGHd+qAkXIin5oVlmzATy+z3UVMdLw/bB3tdV61X+QFSLX0bVxKcIGSGYyTL8
        eALZ8hCC2CsGOjhW3EMdHiSq0Hy07B8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-aNuxZLI4MJisVD0VR0s_1g-1; Fri, 04 Dec 2020 06:22:52 -0500
X-MC-Unique: aNuxZLI4MJisVD0VR0s_1g-1
Received: by mail-ed1-f69.google.com with SMTP id dh21so1385278edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 03:22:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2xYmq1WDTNwe1WMK0sFOwKcOwQdm9xnUmb1ObuGviYU=;
        b=uMBL/2nslv15i/7eY+WSSwueIu07AQ75VONa4xonkx6+owdCboUsyKmZfI+W6DtLrT
         nhZzDofEOgl6fJtOwNyAOc3gyN7GGnZb+4w5ZcFZGbZeCKjJ61GoUwhs09QFGrvj9D/4
         9u/LXCdAiC0KrMMqG4v/fAs9K7zD+pmgVTw/LWo9h1kJYNbFfjCS3H6ktmqu/mPQvmD3
         vMQDCZIQayhia/B1I/nVU3ugVGwxwLPtTlZrJxz4HQzOLQMWJ+JNhHxlvfJqYSIXBrc4
         32HkBUv3sG6i3SkcicsFJ6oFikCKt4pYvGFg8xa849l87KKuJuHYeUSDVDV4izT8tIBw
         ga1A==
X-Gm-Message-State: AOAM530BL3QNvJODg7GacmQpTBnrOgVRtMvEwFHI+kUmQHs6KvYw92XC
        kkk2JpHkT87WFXo5zlGqsmVS7xZ33YIGQbCuP0CMsI9VtQR85BonYKdmcVmRyVw6Er+47zGbWGf
        h7roIsudyWp/VKOgGLcEQmTOb
X-Received: by 2002:a17:906:6683:: with SMTP id z3mr6827626ejo.27.1607080970816;
        Fri, 04 Dec 2020 03:22:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw343SknxiSSuY0NNWzbJs4msxXhsprD6WBOFGcibn/gINRccGkPWRXPfY4u3yR4ha4Ysx8pw==
X-Received: by 2002:a17:906:6683:: with SMTP id z3mr6827610ejo.27.1607080970670;
        Fri, 04 Dec 2020 03:22:50 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u1sm3256230edf.65.2020.12.04.03.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Dec 2020 03:22:49 -0800 (PST)
Subject: Re: [PATCH v8 18/18] KVM: SVM: Enable SEV live migration feature
 implicitly on Incoming VM(s).
To:     Ashish Kalra <Ashish.Kalra@amd.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        joro@8bytes.org, bp@suse.de, Thomas.Lendacky@amd.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        srutherford@google.com, rientjes@google.com,
        venu.busireddy@oracle.com, brijesh.singh@amd.com
References: <cover.1588711355.git.ashish.kalra@amd.com>
 <a70e7ea40c47116339f968b7d2d2bf120f452c1e.1588711355.git.ashish.kalra@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7a3e57c5-8a8c-30dc-4414-cd46b201eed3@redhat.com>
Date:   Fri, 4 Dec 2020 12:22:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <a70e7ea40c47116339f968b7d2d2bf120f452c1e.1588711355.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 23:22, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> For source VM, live migration feature is enabled explicitly
> when the guest is booting, for the incoming VM(s) it is implied.
> This is required for handling A->B->C->... VM migrations case.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>   arch/x86/kvm/svm/sev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> index 6f69c3a47583..ba7c0ebfa1f3 100644
> --- a/arch/x86/kvm/svm/sev.c
> +++ b/arch/x86/kvm/svm/sev.c
> @@ -1592,6 +1592,13 @@ int svm_set_page_enc_bitmap(struct kvm *kvm,
>   	if (ret)
>   		goto unlock;
>   
> +	/*
> +	 * For source VM, live migration feature is enabled
> +	 * explicitly when the guest is booting, for the
> +	 * incoming VM(s) it is implied.
> +	 */
> +	sev_update_migration_flags(kvm, KVM_SEV_LIVE_MIGRATION_ENABLED);
> +
>   	bitmap_copy(sev->page_enc_bmap + BIT_WORD(gfn_start), bitmap,
>   		    (gfn_end - gfn_start));
>   
> 

I would prefer that userspace does this using KVM_SET_MSR instead.

Paolo

