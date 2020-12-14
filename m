Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E92D9BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 17:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439511AbgLNQHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 11:07:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727956AbgLNQHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 11:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607961947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CKOysfJXgz9SEv/3tw1NKD9IbJ/IVoxDoBxG2bfHpqM=;
        b=DFrWK/MES9f4GsQnCObCXE+XExwLNzJoFbdT4Qoduafp3CU8DIjirdwp+M/f72E5vrWYME
        E52rdjeqsHjo/ttLBc0fMSE2cAGGQTr+qIopwd05LoJxGn8LmiuR2zx6hrNhjqrOsYW2xd
        DGKnbknRjIC4bIA0rwzRbNqoOmJRKAI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-RmQWWhm1NFuuBm_UaxXhIw-1; Mon, 14 Dec 2020 11:05:44 -0500
X-MC-Unique: RmQWWhm1NFuuBm_UaxXhIw-1
Received: by mail-ej1-f71.google.com with SMTP id gu19so1009357ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 08:05:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CKOysfJXgz9SEv/3tw1NKD9IbJ/IVoxDoBxG2bfHpqM=;
        b=NPDxCl/yl3KhL9mwHHZL23b/32ux5SFeDFDZPE4UIJcr8NhxzKGX0GAFZVKUFQGAeH
         xFi9uNwstIvimGhokfvj6acDW5lVV6OHRqasU+SAQ/MhJ+5UoPffQpyNQ685B/skDrMk
         PZIVxzbpsLBpvu0NESieguLHSZcrptuRJYNQGjcgYVdWd8hyng2Wvje4f9nA1gg38BDQ
         7VD3DcqMYHq75ubHjfZCZ8luk5C1gNNd63Ke0gDYdj4KZ+LTPJ3dlvEDuqz5+N4xqY+Q
         V25XnscbFns/9BImxirIOI6H5WXr8DSpCC/zi516vuRFzou/JwTx6z7pw+a+yv+V/9VL
         cTfA==
X-Gm-Message-State: AOAM5334teHukEYceGgJvvqihDhbW1dFCfbUsVRVfjnI8gZLxbFJW/Bc
        UThQq/U5ojcnpPrt4gWarw9WN0R0/f0hYtwRv9vZM7FsMByKin+8lJCVE/+pxgzggHR3b82F+ua
        lOKBUkYGg9syzrFgr8vFshlbF
X-Received: by 2002:a17:906:604e:: with SMTP id p14mr23016279ejj.543.1607961942599;
        Mon, 14 Dec 2020 08:05:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrcdNJs/vG856VzAHg8Cu6Ust63aIqYsGR68byTwFU2nmYO6bZ3YYIJPcGhTvlayxbn9s0Xg==
X-Received: by 2002:a17:906:604e:: with SMTP id p14mr23016266ejj.543.1607961942435;
        Mon, 14 Dec 2020 08:05:42 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i13sm6625914edu.22.2020.12.14.08.05.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Dec 2020 08:05:41 -0800 (PST)
Subject: Re: [PATCH v5 27/34] KVM: SVM: Add support for booting APs for an
 SEV-ES guest
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
 <47d11ed1c1a48ab71858fc3cde766bf67a4612d1.1607620209.git.thomas.lendacky@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <caede9f7-03cc-340c-de13-90202a844f6c@redhat.com>
Date:   Mon, 14 Dec 2020 17:05:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <47d11ed1c1a48ab71858fc3cde766bf67a4612d1.1607620209.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 18:10, Tom Lendacky wrote:
> @@ -10144,6 +10144,15 @@ void kvm_vcpu_deliver_sipi_vector(struct kvm_vcpu *vcpu, u8 vector)
>   {
>   	struct kvm_segment cs;
>   
> +	/*
> +	 * Guests with protected state can't have their state altered by KVM,
> +	 * call the vcpu_deliver_sipi_vector() x86 op for processing.
> +	 */
> +	if (vcpu->arch.guest_state_protected) {
> +		kvm_x86_ops.vcpu_deliver_sipi_vector(vcpu, vector);
> +		return;
> +	}
> +

Also, I don't mind that you just call 
kvm_x86_ops.vcpu_deliver_sipi_vector from lapic.c, and make VMX just do

	.vcpu_deliver_sipi_vector = kvm_vcpu_deliver_sipi_vector,

(SVM would do it if !guest_state_protected).  This matches more or less 
how I redid the MSR part.

Paolo

