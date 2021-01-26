Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A03303BFB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392565AbhAZLqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:46:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32382 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392511AbhAZLf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 06:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611660872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L7832NLMKAy/RcXVz/j+3dnFc5pHVrcqYYEnyyLQrCk=;
        b=PGv7EMswpqfESR75wJf2psn08UHTW4MYh7wrqJqKBAQ3icx+TF5XDWIH9nJXpBqD7ZH8Tu
        SPQlsn2ukMbR+XFrVb8FkXlZ7NmFi5urpu4GogYTDc5YrTa/TAqZ+MPR+fQ9nr82qI752g
        BBFXN6PfcEoE1H0BhRZmL0TdVsNXCKQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-aprNMxCKMr2f7SR0Q_53YA-1; Tue, 26 Jan 2021 06:34:30 -0500
X-MC-Unique: aprNMxCKMr2f7SR0Q_53YA-1
Received: by mail-wr1-f69.google.com with SMTP id e12so10992957wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 03:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=L7832NLMKAy/RcXVz/j+3dnFc5pHVrcqYYEnyyLQrCk=;
        b=INLEtII4jjhuEAH/Z7HRN3e1VY1f5cr1Q9/x6EYz9zzl1LNG8fxNHATSf6Bt6t7cgJ
         CNPthgXeiZxCl4MuS9CLGrfy4AFe8FGpi8ILCm9KLIdUwiJygmO9VyoIGI5vbHBVHWBt
         EsS0ASaDeo8rDlHjArSP0IfkLYBjb399j6soOCy8fZvlSlSW/MaN4YDm3xO+o2xistVg
         dlfle3Fau/9bMRQ1xiiVMZIyBJ8K1VcDZkaFb0fXwDHxwCegEMtPtBifAB28Ez8Gdzj5
         dRveR3KJSRxJJCVgENa/P/gy3fgZMdRKX+4pGFpaZ7VTZVVhOSDZ52zgZiztvMovjEeM
         J9LQ==
X-Gm-Message-State: AOAM5321bpAKoweZ8HFaSawWbdLHaYUGQqzGYXuOZj1H+82wZVTAW0i6
        RpdrzD6MZVljkO3S2Zy1cY/WZSsI6481n/v3VRtnr7zgKmRqLUyZUZh9BPzYDyKIbOw4g1TRnmU
        uoFUDBce1EEr0mu+peZIa6nHq
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr4330099wma.6.1611660869224;
        Tue, 26 Jan 2021 03:34:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzI8Y1eI9CBUH+faCKXqBS3/o9NhYMNDfbacHl3bVp1lZ0gf5vw+ea3OLWjCpiHmfDTb0ooPg==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr4330085wma.6.1611660869070;
        Tue, 26 Jan 2021 03:34:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n4sm2474627wrt.47.2021.01.26.03.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 03:34:28 -0800 (PST)
Subject: Re: [PATCH v3 2/4] KVM: SVM: Add emulation support for #GP triggered
 by SVM instructions
To:     Wei Huang <wei.huang2@amd.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com,
        mlevitsk@redhat.com, seanjc@google.com, joro@8bytes.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        jmattson@google.com, wanpengli@tencent.com, bsd@redhat.com,
        dgilbert@redhat.com, luto@amacapital.net
References: <20210126081831.570253-1-wei.huang2@amd.com>
 <20210126081831.570253-3-wei.huang2@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <99e65d54-8d6b-b027-aa34-66e0e30b5e1f@redhat.com>
Date:   Tue, 26 Jan 2021 12:34:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210126081831.570253-3-wei.huang2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/21 09:18, Wei Huang wrote:
> 
> @@ -288,6 +290,9 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
>  		if (!(efer & EFER_SVME)) {
>  			svm_leave_nested(svm);
>  			svm_set_gif(svm, true);
> +			/* #GP intercept is still needed in vmware_backdoor */
> +			if (!enable_vmware_backdoor)
> +				clr_exception_intercept(svm, GP_VECTOR);
>  
>  			/*
>  			 * Free the nested guest state, unless we are in SMM.
> @@ -309,6 +314,10 @@ int svm_set_efer(struct kvm_vcpu *vcpu, u64 efer)
>  
>  	svm->vmcb->save.efer = efer | EFER_SVME;
>  	vmcb_mark_dirty(svm->vmcb, VMCB_CR);
> +	/* Enable #GP interception for SVM instructions */
> +	if (svm_gp_erratum_intercept)
> +		set_exception_intercept(svm, GP_VECTOR);
> +
>  	return 0;
>  }
>  

This should be in the "if (!(efer & EFER_SVME)) else" branch.  I'll fix 
it up myself.

Paolo

