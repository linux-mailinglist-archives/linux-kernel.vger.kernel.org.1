Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 938F9304399
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 17:19:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391047AbhAZQSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 11:18:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391037AbhAZJ3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 04:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611653278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJqmWe0B1zwIrZ9/DXGf/qzkCZYW3LkB48QuI/Vyvzk=;
        b=HRRtZ4K4sE1bFnn7yM5x1XSy1waFyHjLyu2DHKGqTgzp2p0FV575LJav8fNNgPdf76IRze
        02UCwyURz650XGqdSAi+k21Khk3eMUj+cewCn9sLpK+6vDpt1Gx6GZHnV7o4mZMHyUx7fx
        3gPV2hr5MDpfVFiU1ZeNUv/oGzmDXNk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-YaTLfWUyMXeY-w1l3JX2ew-1; Tue, 26 Jan 2021 04:27:56 -0500
X-MC-Unique: YaTLfWUyMXeY-w1l3JX2ew-1
Received: by mail-wr1-f71.google.com with SMTP id q6so240644wro.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 01:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TJqmWe0B1zwIrZ9/DXGf/qzkCZYW3LkB48QuI/Vyvzk=;
        b=qJbCqYM0O1eH3VmyhPafVzcstW7RktyyFDP+1svwbwOQxu69JCu+P5NmvhTpTGNLv9
         9yeXLEl/m4iQPxx2jMbDxeQ4SY4EQxwrv19nrCPE5IsrKvaKU68FRvv33a0F7vGEQ1pZ
         dOW4ogrcQdYAaeVaHkqW6CiLGUrT3kmWOR/EBJOr/pf7l/RzzwGNU8qXYPfqPySwzFXI
         AwrQq1o5BUVbe0SGlHVAmdYsUh0NuoNU8ZR+PoMoGnXARUY2SVZu10CI5AkmX+my5fqJ
         PSRfPtgSrbJt3sH3+cmthK+69XoNJxBDl3nPnCEexFCr+R73SY380By5jHCwktFLLqae
         kG8w==
X-Gm-Message-State: AOAM532hTC8oip8Vl9CpGqVRx9Hcqgpcuh1Uj5URl9DjPsFOWAueeYPR
        35yX6GwqdAH7RlzwSX9crUkgW4tvZ8Xlm4uznC2ifKo5u1YKuNxfNeNrm8YUAQZDgQfjFWWV8qZ
        9tiVk/c34yLUJjzVPijUHkC6IZ9aOr2ArvHCgcYggnEKgD8lzHBmXDqU/QuwMcuuQUX4QFK8dyo
        YK
X-Received: by 2002:adf:d187:: with SMTP id v7mr5085186wrc.50.1611653275001;
        Tue, 26 Jan 2021 01:27:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxwJZvz1tWGNB31K2PdD/RQMxJIfSfaRIG9JEMFcujSvclTmPqLN1LlqyQzG38ZcxH8Ux9nVw==
X-Received: by 2002:adf:d187:: with SMTP id v7mr5085155wrc.50.1611653274835;
        Tue, 26 Jan 2021 01:27:54 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id j2sm24648989wrh.78.2021.01.26.01.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 01:27:54 -0800 (PST)
Subject: Re: [RESEND v13 07/10] KVM: vmx/pmu: Reduce the overhead of LBR
 pass-through or cancellation
To:     Like Xu <like.xu@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, ak@linux.intel.com,
        wei.w.wang@intel.com, kan.liang@intel.com, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210108013704.134985-1-like.xu@linux.intel.com>
 <20210108013704.134985-8-like.xu@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <59d947ae-3f6f-2efa-0d2d-3b130cb0bb5c@redhat.com>
Date:   Tue, 26 Jan 2021 10:27:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210108013704.134985-8-like.xu@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/21 02:37, Like Xu wrote:
> +
> +	/* A flag to reduce the overhead of LBR pass-through or cancellation. */
> +	bool already_passthrough;

	/* True if LBRs are marked as not intercepted in the MSR bitmap  */
	bool msr_passthrough;

>   };
>   
>   /*
> 

