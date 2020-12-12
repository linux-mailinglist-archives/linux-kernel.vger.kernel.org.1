Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3366C2D837C
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 01:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437763AbgLLAgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 19:36:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437757AbgLLAgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 19:36:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607733295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6n7gVsD07Urzq1w4U97tF3A9zaEdePQkP4NQ7Yz5rzk=;
        b=Q/QaxsZoEnB6YbPN8qMrc277bXO+NOv4D3Tlyf9JjZAq5yyWd9YUUmcYeDuUVpx4Tw+Wbf
        Xg9voIS7BtSyWLKBPv7xeodMJ4qEb3TVKiMpEXZrtBGyUGYVkyXyakiLR9CzEoBULksUPf
        X7VMCFQjzjeNAY62ZGdLzsNav71ui9M=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-5bImK9OkMrePhFXL1w2JQA-1; Fri, 11 Dec 2020 19:34:51 -0500
X-MC-Unique: 5bImK9OkMrePhFXL1w2JQA-1
Received: by mail-ej1-f69.google.com with SMTP id m4so3332407ejc.14
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 16:34:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6n7gVsD07Urzq1w4U97tF3A9zaEdePQkP4NQ7Yz5rzk=;
        b=crTkGzYIkPeNPa3ye8tz0by74kvB/h6o19DatDAse7fdNgC5g/VFBw6mnSBJO+7ig7
         Il5mbY6NV7MakiDoU3xuMeg2kBWeTDXYPJFRAP3rHuFBwIpyP9anB8wapSxUFDp/uD3q
         cViGu/tosoYt7q0Jz+fmvoeyAiRUh+xmIVrRZqQwEpt8TxWqNE1q7DQg8wCfqqqJ5OmJ
         rztZsnRzJUW+wtfvMirOEf12hThovQXhYAIBih/X/CVrxpdPGNWN+67CJFlOt1QAytJZ
         rjeI6uFCXY5LfhMUporx6unn2f6knTxE8o7g/qGhxomkEvIbxAutw66vlsBliA+KVT0E
         d/Pw==
X-Gm-Message-State: AOAM530smbk9MHS+/b91m1ZiNZIxyWOX4N2l/Z0yEzWGABoPClOgo30J
        5OTHFqgomGG8hXP0a/lQ0A7PFpJ850wJfSsWXt5zggbudn7GhfglaB3pob2CyjMJ8nLyPiFG0x0
        Rx5CFVE7uvY2/emLZtIrLaKQMdBN+L1xgieD8qdqamLdT3FK2neii0a4s9j91I0RLewgI44qhLH
        ss
X-Received: by 2002:a05:6402:8cc:: with SMTP id d12mr14308698edz.0.1607733289744;
        Fri, 11 Dec 2020 16:34:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw/pWB+W4pnUDZs9aIAM+PZkpz95i0rsIxVZMYM2VpQI7std8xVl/ZrXqx/X6Jsjx+s1Cj+hA==
X-Received: by 2002:a05:6402:8cc:: with SMTP id d12mr14308676edz.0.1607733289522;
        Fri, 11 Dec 2020 16:34:49 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id ef11sm7991189ejb.15.2020.12.11.16.34.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 16:34:48 -0800 (PST)
Subject: Re: [PATCH] kvm:vmx:code changes in handle_io() to save some CPU
 cycles.
To:     Stephen Zhang <starzhangzsd@gmail.com>, seanjc@google.com,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1607588115-29971-1-git-send-email-starzhangzsd@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46f11275-c697-9c0b-a12b-152301acaa76@redhat.com>
Date:   Sat, 12 Dec 2020 01:34:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <1607588115-29971-1-git-send-email-starzhangzsd@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/20 09:15, Stephen Zhang wrote:
> code changes in handle_io() to save some CPU cycles.
> 
> Signed-off-by: Stephen Zhang <starzhangzsd@gmail.com>
> ---
>   arch/x86/kvm/vmx/vmx.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 47b8357..109bcf64 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -4899,15 +4899,14 @@ static int handle_triple_fault(struct kvm_vcpu *vcpu)
>   static int handle_io(struct kvm_vcpu *vcpu)
>   {
>   	unsigned long exit_qualification;
> -	int size, in, string;
> +	int size, in;
>   	unsigned port;
>   
>   	exit_qualification = vmx_get_exit_qual(vcpu);
> -	string = (exit_qualification & 16) != 0;
>   
>   	++vcpu->stat.io_exits;
>   
> -	if (string)
> +	if (exit_qualification & 16)
>   		return kvm_emulate_instruction(vcpu, 0);
>   
>   	port = exit_qualification >> 16;
> 

I would be very surprised if there's any change in the assembly code 
after this patch.

Paolo

