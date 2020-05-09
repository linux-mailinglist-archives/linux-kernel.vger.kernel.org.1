Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 742E01CC16E
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 14:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgEIMve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 08:51:34 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35862 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726017AbgEIMvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589028691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZsSizwN3KlfPsuv6zYOV+aQzzPjSLBPKuOPVAQfWcDY=;
        b=W7c957zDPzuy3yS4stxxsLtFayjaCKEBZeV3uI3kaDVJxuc4jykBsdhHNLTlXqQ4ka0R15
        54Z91cOZUxiGOnXk+2gNr2dmGWcDXJ0jZCftWyQDvCcfUJ49r6DswopOZZXL/99lYW0enq
        zleJ6251eZozJYAP9gUl6rONgGx4mW0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-9rFQDP0TM-OE7a6NWamaPw-1; Sat, 09 May 2020 08:51:30 -0400
X-MC-Unique: 9rFQDP0TM-OE7a6NWamaPw-1
Received: by mail-wr1-f70.google.com with SMTP id g30so393042wrb.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 05:51:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZsSizwN3KlfPsuv6zYOV+aQzzPjSLBPKuOPVAQfWcDY=;
        b=EURpkKyKFo5rkhbyaZcgI/Gz1gDxBRHnPsArwtwo1G3t07PvWWWZXig0LaJsj++57U
         MYnrvxrQ2stE5Jaro8TOcMHZrm7cM/gJaRjy1R7PRmCF+GONu8l/+2T8ZiPC2S3QcQy6
         zCeoaxJhq6BymLibsvysddUT0fVnoP3yDGkb+meMxVN4y/Av3kzfuTiRIZInoezZlUaK
         9iTaG0o4nj5WW5/oq3+P3ktBGog32gD5/MiLZLKZX7/Dc8IJqWulri9muVwe3kxvuuDd
         iQjHrDNmqYOGo0Pi1j73GvpIZ+r7nKtbPVcJFM7NByQMswnZeTM+nBXIdWMge3gV5Oos
         mG/g==
X-Gm-Message-State: AGi0PuZmQOdQAtDyk7XZkJVoytzK7AtSFxoNiL/moD/EdEdm4QpNcBjb
        vRk9pX4FWLcv8CVfqUeWoxegQHZRBZwMHkPV+8E+A7QxkxOw7OAoKEPSDeMTIxQz4Vfxk6ZpU7d
        UpremhfnIGRr2ibNhON5xtXjW
X-Received: by 2002:a1c:44d4:: with SMTP id r203mr16403614wma.35.1589028689107;
        Sat, 09 May 2020 05:51:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypJTN47vffkcAKbNDjHwMXuOJf5f4riYk34PnCsy1WC2C9b/CkIxCWcUJ/yHM4NLtu8EsZCBWw==
X-Received: by 2002:a1c:44d4:: with SMTP id r203mr16403592wma.35.1589028688841;
        Sat, 09 May 2020 05:51:28 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1cb4:2b36:6750:73ce? ([2001:b07:6468:f312:1cb4:2b36:6750:73ce])
        by smtp.gmail.com with ESMTPSA id i6sm7922763wrw.97.2020.05.09.05.51.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2020 05:51:28 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Restore update of required xstate size in
 guest's CPUID
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200508233749.3417-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bec6f18e-510e-c5bd-b5b4-d9e188153bc7@redhat.com>
Date:   Sat, 9 May 2020 14:51:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200508233749.3417-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/20 01:37, Sean Christopherson wrote:
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 35845704cf57a..cd708b0b460a0 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -84,11 +84,13 @@ int kvm_update_cpuid(struct kvm_vcpu *vcpu)
>  				   kvm_read_cr4_bits(vcpu, X86_CR4_PKE));
>  
>  	best = kvm_find_cpuid_entry(vcpu, 0xD, 0);
> -	if (!best)
> +	if (!best) {
>  		vcpu->arch.guest_supported_xcr0 = 0;
> -	else
> +	} else {
>  		vcpu->arch.guest_supported_xcr0 =
>  			(best->eax | ((u64)best->edx << 32)) & supported_xcr0;
> +		best->ebx = xstate_required_size(vcpu->arch.xcr0, false);
> +	}
>  
>  	best = kvm_find_cpuid_entry(vcpu, 0xD, 1);
>  	if (best && (cpuid_entry_has(best, X86_FEATURE_XSAVES) ||
> -- 2.26.0

Ugh, I'll write a testcase as penance.  Squashed, thanks.

Paolo

