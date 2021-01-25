Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3E4302BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 20:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732211AbhAYTvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 14:51:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26572 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731944AbhAYTgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611603313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dTm8KkWeoMqY1NMXfpUUnmE85GAUqbldlznQCf84YPQ=;
        b=DETj7xDHXKx+uCn+Pc7FgzYOnCgMI6I6woPKAovVWJfAFsI74da0rGCIp/1ppkaQfzg76O
        s0xY53DgkxLHkZfqfSjvnsmarMJ8o5ikWAfW907tIa9SSS6Hte8TibhD0ZJqsPXgoi8wat
        cruyzcwxqTCXQrExZokaVA+b4mdVaHo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-NV_cRyrgNa2F0t9TVTvlDw-1; Mon, 25 Jan 2021 14:35:11 -0500
X-MC-Unique: NV_cRyrgNa2F0t9TVTvlDw-1
Received: by mail-ed1-f69.google.com with SMTP id a26so8139619edx.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:35:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dTm8KkWeoMqY1NMXfpUUnmE85GAUqbldlznQCf84YPQ=;
        b=HCq5loY/LWFBJW0Mj6Skh6O0A63GzjR2k+yTh7QsQf9qwrslHP/Pi8QH+wpHY3MBFX
         Mv3CnNpxiCyCNKLr2Sj2jkzPDkytJD07UeKFMmDuoBGuEyTmjz439NmQqoLbjcg25wSP
         4UjJuZTd1eE/RAIev7bIsnD/pexk2w8DEDR+p+c7Im3M8b6NdDFXgHHr3IW9mtS7QA0Q
         eQJHM/r7oa3v6gcSee12qVigS81iE1AqoaDoSiiOU6ovCKRTxoNfWl9xGPkFUA3RBn5j
         uSoDFexl0qdwc12UUrQqalgE/L8DgnFnrg4g/wS5/7iiIiPC7gWnH1IbNSz3MTmhrlW1
         +SBw==
X-Gm-Message-State: AOAM5339Er4d9XWix9FAHw+mmKqqDnsZYiwazbhls5Z7jW4Ov4/q8p0F
        yI7y1xbp45zjTezoV5GPuWiM2l6oT7+kTJl1JB3rIqKJ4piEvzPniG8u43kLw7qGBxZSXRjPejV
        LytrkaiTqfdSdjd6+ivgdXUmv
X-Received: by 2002:a50:d552:: with SMTP id f18mr1800607edj.168.1611603310261;
        Mon, 25 Jan 2021 11:35:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx7yvA/3vdrnGvBeOjexbw/4ggd4FoC4n3YqRVtQrKPUDJ+85s+hGxVzZmzSbJD4J9B2D/1Nw==
X-Received: by 2002:a50:d552:: with SMTP id f18mr1800600edj.168.1611603310149;
        Mon, 25 Jan 2021 11:35:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id cx6sm11511897edb.53.2021.01.25.11.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:35:09 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: allow KVM_REQ_GET_NESTED_STATE_PAGES outside
 guest mode for VMX
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        stable@vger.kernel.org
References: <20210125172044.1360661-1-pbonzini@redhat.com>
 <YA8ZHrh9ca0lPJgk@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0b90c11b-0dce-60f3-c98d-3441b418e771@redhat.com>
Date:   Mon, 25 Jan 2021 20:35:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YA8ZHrh9ca0lPJgk@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/21 20:16, Sean Christopherson wrote:
>>   }
>>   
>> +static bool vmx_get_nested_state_pages(struct kvm_vcpu *vcpu)
>> +{
>> +	if (!nested_get_evmcs_page(vcpu))
>> +		return false;
>> +
>> +	if (is_guest_mode(vcpu) && !nested_get_vmcs12_pages(vcpu))
>> +		return false;
> nested_get_evmcs_page() will get called twice in the common case of
> is_guest_mode() == true.  I can't tell if that will ever be fatal, but it's
> definitely weird.  Maybe this?
> 
> 	if (!is_guest_mode(vcpu))
> 		return nested_get_evmcs_page(vcpu);
> 
> 	return nested_get_vmcs12_pages(vcpu);
> 

I wouldn't say there is a common case; however the idea was to remove 
the call to nested_get_evmcs_page from nested_get_vmcs12_pages, since 
that one is only needed after KVM_GET_NESTED_STATE and not during 
VMLAUNCH/VMRESUME.

Paolo

