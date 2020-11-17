Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62ED42B5A68
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 08:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgKQHkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 02:40:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57732 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726249AbgKQHkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 02:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605598811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4XVB2HLVPXWZSYAGy1w+L0QjlzQTnzB+6hDaTM7i40Y=;
        b=TUIzZOJiorOBEd+wWx/H7rtlF9MU+nRqlQp+58LKC4EVDNouCZ1JSxQnjd0fbFgEmtTGFu
        A/gKuC0KvbXvTlh3fajnAOWQ8IgLfsm5hESU9nA1zCwxTzXl0XEfg8vzAVAb84nOO+En/7
        DWcAQ3VoXuLMzGK2c0xrjbk7yZ3zUEg=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-YmaFQl74NWSykzQmrwJnhw-1; Tue, 17 Nov 2020 02:40:09 -0500
X-MC-Unique: YmaFQl74NWSykzQmrwJnhw-1
Received: by mail-ej1-f70.google.com with SMTP id e7so3479957eja.15
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 23:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4XVB2HLVPXWZSYAGy1w+L0QjlzQTnzB+6hDaTM7i40Y=;
        b=bcsJ/KAwiJab8x2m4+cjTOIqevFuwRppM94cE1uFotEFi8nl8WR2bgOwaiEh455j+U
         704BOBNNvBgERo09zdglyUd9UpcMgk4uuPtW//drDOcTF69ZHJN1zp3QZAVnb2woIS8r
         ZuvZoKczTlmAWtovYbZcn6JVTslYJC4VWynGSTlDZsRhjlTvhCla4ko9srWdngXt0Ief
         xSy13tVJxt7+/eCvgjOEARWmmqdGoK9HaA5AB3Min5Gd+DzQuUuaEVHy9n5UGo1m8RWn
         N4OQJ8xQb9pt1Sd3vkrca0YtiNjgGyXNBD4bGKz1qTZFfuCNVwdVkh9R6wjxZ9PJuk6h
         i06g==
X-Gm-Message-State: AOAM532DnEjgO5PTsoaDx5jRwhTg2MJlLWhWK0dri5qLimknujYRMQNI
        S+Q+1Q85jaIqBGhijKnENPNsRVTD21H/LgghhEABNcqDLQku3DfwbsA9dtK3WTz6rd21VRXPjnU
        JIIQn6U5J9qT1WL6v8jCK+56ebdKBFJ3ObitbNvthMM1fzim9JISjJiSySjdO6prKcAGcp45YCV
        XF
X-Received: by 2002:aa7:cc8f:: with SMTP id p15mr20781360edt.240.1605598808032;
        Mon, 16 Nov 2020 23:40:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyrEkHOlHKCbof8IeyU5M5pVclQNmoojK/SG37Qm5GctY0ngu506HbkBX3BPY9sTkZNAjQL1w==
X-Received: by 2002:aa7:cc8f:: with SMTP id p15mr20781340edt.240.1605598807737;
        Mon, 16 Nov 2020 23:40:07 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id w3sm11726222edt.84.2020.11.16.23.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2020 23:40:07 -0800 (PST)
Subject: Re: [PATCH] KVM: SVM: fix error return code in svm_create_vcpu()
To:     Chen Zhou <chenzhou10@huawei.com>, rkrcmar@redhat.com,
        tglx@linutronix.de, mingo@redhat.com
Cc:     hpa@zytor.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20201117025426.167824-1-chenzhou10@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3ffc3a59-fdc1-3cb4-46e8-0369084bcc06@redhat.com>
Date:   Tue, 17 Nov 2020 08:40:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201117025426.167824-1-chenzhou10@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/20 03:54, Chen Zhou wrote:
> Fix to return a negative error code from the error handling case
> instead of 0 in function svm_create_vcpu(), as done elsewhere in this
> function.
> 
> Fixes: f4c847a95654 ("KVM: SVM: refactor msr permission bitmap allocation")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
> ---
>   arch/x86/kvm/svm/svm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 1e81cfebd491..79b3a564f1c9 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1309,8 +1309,10 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>   		svm->avic_is_running = true;
>   
>   	svm->msrpm = svm_vcpu_alloc_msrpm();
> -	if (!svm->msrpm)
> +	if (!svm->msrpm) {
> +		err = -ENOMEM;
>   		goto error_free_vmcb_page;
> +	}
>   
>   	svm_vcpu_init_msrpm(vcpu, svm->msrpm);
>   
> 

Queued, thanks.

Paolo

