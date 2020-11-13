Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5682B215F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgKMRDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:03:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21959 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgKMRDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:03:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605287027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DKoRsVfplgtitPUGW0JkrU9zu2M6/XgQCkI3XS16McU=;
        b=LATTjiNveZvdh8J2amV6+5Yd3H/8eVvN7ANecFOegv6SG6nTvvDCPtE1TrZxTGxojH4W5B
        CGspfUNVvEMPExj1m2zSXFT97h7bdmytEOSZXRjhrZpV33L7Pc6ajUTQA13ycSr4yObiMu
        fwlgzy5XvezqdTeRZxsVfKDRzkr8+RE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-Zr9f2iK0OPew5SNfMp8yGQ-1; Fri, 13 Nov 2020 12:03:46 -0500
X-MC-Unique: Zr9f2iK0OPew5SNfMp8yGQ-1
Received: by mail-wm1-f72.google.com with SMTP id y1so4246476wma.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:03:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DKoRsVfplgtitPUGW0JkrU9zu2M6/XgQCkI3XS16McU=;
        b=uHJJstufhK5ifeNjOd3q969lBoFgwhcWSPSV5/uqUBwubhrxNTmQES9Gb7Y1rpZg9i
         nvZDxnrBJj0z2OfnENalpgzG/LNIVivdxh8/p+C4ZXGvxc0NE3BTUBku6SjGN2Tbm6lp
         TLLHHJQtro1oqu7Ic9OBl2qpyPvJ1+0uStVX7CC2vnr39Yst8L6tJJvZzJIo5H53EkOr
         ImMxUgz4S4VgRnKxmVHQGEuGAnSGLp3NP5ZIQG4iYg4BzWIDPUxqIRJrXuczxfS684z9
         fglmTg4+IgmxKMOF4JEfJMGzMY8qUlcxLs5yurFi8TZAQ+wmxiejO6ug68Psby/YEtM6
         2diA==
X-Gm-Message-State: AOAM5327od8VOSHn6l7PJcnkNGxbBOQcQBTqf+WoZl+YBe3bfzBm0eyA
        pKZJRGnULWqhz7lqvkcrceCGCBfaT8+2JmYs8FBrz2KSThLjs3MmB44wsCqlQ86QGvWA/F0O7ix
        0LyVXwOEYnruuOJ5NCykxj1sG
X-Received: by 2002:adf:fd03:: with SMTP id e3mr4512008wrr.303.1605287022154;
        Fri, 13 Nov 2020 09:03:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyefpts8kB3Et5LsbNipXTZ48c1P4Aia6XTASleZP9ph7mN9L2qKovlaJ4n0i7HOQU9u35eVA==
X-Received: by 2002:adf:fd03:: with SMTP id e3mr4511988wrr.303.1605287021961;
        Fri, 13 Nov 2020 09:03:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u16sm11595851wrn.55.2020.11.13.09.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 09:03:41 -0800 (PST)
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Cathy Avery <cavery@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, wei.huang2@amd.com, mlevitsk@redhat.com
References: <20201011184818.3609-1-cavery@redhat.com>
 <20201011184818.3609-2-cavery@redhat.com>
 <20201013012937.GA10366@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: SVM: Move asid to vcpu_svm
Message-ID: <6795358b-90a3-7c54-b889-7508356c5f46@redhat.com>
Date:   Fri, 13 Nov 2020 18:03:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201013012937.GA10366@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/20 03:29, Sean Christopherson wrote:
>> @@ -3446,6 +3447,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>>   
>>   	sync_lapic_to_cr8(vcpu);
>>   
>> +	svm->vmcb->control.asid = svm->asid;
> 
> Related to the above, handling this in vcpu_run() feels wrong.  There really
> shouldn't be a need to track the ASID.  vmcb01 will always exist if vmcb02
> exits, e.g. the ASID can be copied and marked dirty when loading vmcb02.
> For new_asid(), it can unconditionally update vmcb01 and conditionally update
> vmcb02.

Yeah, it is a bit ugly and it is only needed on processors without 
flush-by-ASID.  On those processors the ASID is used by KVM as a sort of 
TLB flush generation count.  A TLB flush should affect both VMCB01 and 
VMCB02, and that's the reason to have a global ASID in struct vcpu_svm.

On processors with flush-by-ASID, currently we bump the ASID on every 
physical CPU change.  However even that is not needed, in principle 
svm->asid should never change and we could also have different ASID01 
and ASID02, similar to VMX.  So: long term, svm->asid should only be 
used only on processors without flush-by-ASID.  kvm-amd however is not 
quite ready for that.

Paolo

