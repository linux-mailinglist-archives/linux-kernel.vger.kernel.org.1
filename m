Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1B12D9B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 16:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438783AbgLNPq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 10:46:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:38017 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729628AbgLNPq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:46:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607960730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q/TCYNi4E3ahh+03JvG8chNRF5b2PxF2LEjxnN0TOPY=;
        b=CI0K71THknRY9HyOrCipdH2q78BM3/b3HW/ViYoYnOtRRmHW2ClKKiiZgIBqXvOO6GaZZ6
        5zJneYJ76PjzUWJnHbO2RIy4qWgIE4vMpSAGApQLI6u8tVx+OmpeE8shYjWfWja35RZNK1
        h/Wd1H0kTiA4116mYfaO34GCCR9Lj6o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-HDLaRYMKP_OSYL83QJhsrg-1; Mon, 14 Dec 2020 10:45:28 -0500
X-MC-Unique: HDLaRYMKP_OSYL83QJhsrg-1
Received: by mail-ej1-f69.google.com with SMTP id n17so4676484eja.23
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 07:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q/TCYNi4E3ahh+03JvG8chNRF5b2PxF2LEjxnN0TOPY=;
        b=M+fbFecW3nH3D6v7IXxnwha3PC2UOdnenHMARg+qypLLk58nCQmKlBZdQQGiJGCp2U
         eQ4R62OAVg0OYO/MzsA36Mkt5+1KUDUc0l6x3F/q7jrD//Bwx/5kyF4dnr4Fg3GkXVpo
         yxdAdkfQIwK3/f4RQUpvdREsYJDGw+o5EVJmHpIcP6nf5fcO0Yht+l6eMx8OmephAYOX
         R9nA1xPoMUNcPFPZEWxredi6W2rI2BpBI36XD9mK7+wsroawPxn/FWssaWG+dJpApzys
         PPycNk6Px0rkGb07adjUz9WqtqWWOQbTFfoQegbteCSE+6APD5+FRvhGs1Bzww7pnTEG
         WhkA==
X-Gm-Message-State: AOAM531Tnl3Kf6owYDTBuCvPPxYNuSp1KjCWFrfrZHbPTVukRzH4oRzz
        pV5ONWGlVvUYSNV+X6P+xfsxOFmuk1BaLTfOVCrsSdkkyVeQ6y/QuPqIcymvf0viK2n6bUn5byV
        jsS2Itl2IVZeUk+ouRQqqSEbO
X-Received: by 2002:a17:906:4058:: with SMTP id y24mr22357092ejj.245.1607960727147;
        Mon, 14 Dec 2020 07:45:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwaXA2Ba309W79JU5hMiEppsslQnq3vGs1JQLMrctl5UIKhhc3ULPX8PpkyVV4nCuzcB1RIaA==
X-Received: by 2002:a17:906:4058:: with SMTP id y24mr22357066ejj.245.1607960726917;
        Mon, 14 Dec 2020 07:45:26 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s6sm14003838ejb.122.2020.12.14.07.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 07:45:26 -0800 (PST)
Subject: Re: [PATCH v5 12/34] KVM: SVM: Add initial support for a VMGEXIT
 VMEXIT
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
 <c6a4ed4294a369bd75c44d03bd7ce0f0c3840e50.1607620209.git.thomas.lendacky@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7bac31c8-a008-8223-0ed5-9c25012e380a@redhat.com>
Date:   Mon, 14 Dec 2020 16:45:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <c6a4ed4294a369bd75c44d03bd7ce0f0c3840e50.1607620209.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 18:09, Tom Lendacky wrote:
> @@ -3184,6 +3186,8 @@ static int svm_invoke_exit_handler(struct vcpu_svm *svm, u64 exit_code)
>   		return halt_interception(svm);
>   	else if (exit_code == SVM_EXIT_NPF)
>   		return npf_interception(svm);
> +	else if (exit_code == SVM_EXIT_VMGEXIT)
> +		return sev_handle_vmgexit(svm);

Are these common enough to warrant putting them in this short list?

Paolo

>   #endif
>   	return svm_exit_handlers[exit_code](svm);
>   }

