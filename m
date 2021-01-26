Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68FC304632
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404178AbhAZSUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:20:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394536AbhAZSRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611684979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cmZOZYz/idYpsUVMR+3OZjZX/ko4arY+uQksfsUX+40=;
        b=IIRo7wjw9A0Kdd1uT+H9q5cTZGlw5/qkNhw8Xcve+jgG6X6vLJ+c7lGa9yVJrwqlepPAVJ
        DG2zinv5dgBb/IZZTvN0UEpUE9Z+Z1oUVpQEpCf4nzbhB18X4mBMyH9ZFYKD22j4/823GY
        sS2Cq3+zJrDXzDCgwY+34aSHBRVRVj0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-fZ4mfv63OVmFHb8xe1j0Pw-1; Tue, 26 Jan 2021 13:16:17 -0500
X-MC-Unique: fZ4mfv63OVmFHb8xe1j0Pw-1
Received: by mail-ed1-f69.google.com with SMTP id t9so9796348edd.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 10:16:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cmZOZYz/idYpsUVMR+3OZjZX/ko4arY+uQksfsUX+40=;
        b=cFG0mSABGL2YQ5c8S8pZEYKJxswhO771KNhVIhXSXa3niE8u8cJAEhZqgkOqx5YV2F
         gJ7y1Q62tTFGVlNgBHuGpibU63kIMJFk2xwUt+QKjKbR7ymEd7PmJl9yMERFElYjBr1h
         wrInYFyv9SzMHpDLf+4LOhJiklj1Qiw4qvjWLd5VD2nOX552B6oxaaZ9vtPMPSfarvI6
         rFsh72N2eITlwzZ7Jwp4GYOriVKbSlmuzctFLtHuQMpAwIeYpUW0U2ktRdOGh+z9ubLb
         4gvjQCxYkgnGmmzN1Kl4LKHCj3qKC1UY7ah7k9Bb5aVu33pa7TdarXIy5w3SuKcJa+Ii
         s8fA==
X-Gm-Message-State: AOAM5307x0oLqDG6EcxHF7tSI1ZJ8UGOWdghJBuW6ZHrqTgR68+OD1+z
        Ua91ZBjY9QlRBbY7cRo7f2FH45uDnNwuD9AEmSuIvg/8NLyQdcmqEIa4VCDkri7qNs/SbMlzAdS
        mHkK0adQ8mkU7AS8HTSYp6/zmGDIzEU89FZ1ufraRkzqXSalfwMJwYorVdtAe/PTXs7V4YNmhjS
        iP
X-Received: by 2002:a17:906:b756:: with SMTP id fx22mr4048982ejb.406.1611684975594;
        Tue, 26 Jan 2021 10:16:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJypKXVL9QA3KjINlSp9zzxrFNyf6nh1t/Um3t99rhx/I4h0iJs9AqWjmXyOZtrMW1FsPrA9Mw==
X-Received: by 2002:a17:906:b756:: with SMTP id fx22mr4048959ejb.406.1611684975305;
        Tue, 26 Jan 2021 10:16:15 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id r11sm12850914edt.58.2021.01.26.10.16.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 10:16:14 -0800 (PST)
Subject: Re: [RFC 4/7] KVM: MMU: Refactor pkr_mask to cache condition
To:     Chenyi Qiang <chenyi.qiang@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200807084841.7112-1-chenyi.qiang@intel.com>
 <20200807084841.7112-5-chenyi.qiang@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f4e5dd40-f721-049f-de0f-3af59d48a003@redhat.com>
Date:   Tue, 26 Jan 2021 19:16:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20200807084841.7112-5-chenyi.qiang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/20 10:48, Chenyi Qiang wrote:
> 
>  		* index of the protection domain, so pte_pkey * 2 is
>  		* is the index of the first bit for the domain.
>  		*/
> -		pkr_bits = (vcpu->arch.pkru >> (pte_pkey * 2)) & 3;
> +		if (pte_access & PT_USER_MASK)
> +			pkr_bits = (vcpu->arch.pkru >> (pte_pkey * 2)) & 3;
> +		else
> +			pkr_bits = 0;
>  
> -		/* clear present bit, replace PFEC.RSVD with ACC_USER_MASK. */
> -		offset = (pfec & ~1) +
> -			((pte_access & PT_USER_MASK) << (PFERR_RSVD_BIT - PT_USER_SHIFT));
> +		/* clear present bit */
> +		offset = (pfec & ~1);
>  
>  		pkr_bits &= mmu->pkr_mask >> offset;
>  		errcode |= -pkr_bits & PFERR_PK_MASK;

I think this is incorrect.  mmu->pkr_mask must cover both clear and set 
ACC_USER_MASK, in to cover all combinations of CR4.PKE and CR4.PKS. 
Right now, check_pkey is !ff && pte_user, but you need to make it 
something like

	check_pkey = !ff && (pte_user ? cr4_pke : cr4_pks);

Paolo

