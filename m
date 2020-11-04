Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D68352A6A03
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:40:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731090AbgKDQkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:40:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728999AbgKDQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604508041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Mp9QCJhjo+sJEBC1NS3OQRyapsDLjbHLcu9H4V0AhRU=;
        b=Of1a6tXjiwxAQIaJh0JBqIwCCNJbKtZfvyb2iwLqU9rhYhphNarYZRUQ9wnSbxJGZJQUfc
        QyE9WdMlQScx2FtdKiSofpS0UsCffnSIqkF+YPqtsmDc1jCdyJMaDhu4rYzpkfrMePEOHk
        uw8SNpVddZLPt+F6JJJt6YNXRhwPAic=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-nxAWLHxwMWqI_fW0kmxCdA-1; Wed, 04 Nov 2020 11:40:39 -0500
X-MC-Unique: nxAWLHxwMWqI_fW0kmxCdA-1
Received: by mail-wm1-f69.google.com with SMTP id o19so1439293wme.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:40:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Mp9QCJhjo+sJEBC1NS3OQRyapsDLjbHLcu9H4V0AhRU=;
        b=bl092HUnNgv3FjGijQt0BqcC7WHitCWppIMX29QpxOkJUk4/RRc4fOatQM1xvHzi0R
         o15UZ/E3kOAq6LUiCX7i4LYIyHSLCD2Z9hqyxVehgBdDU8Gmoz2Pe1ed18rpzAvO8d/R
         v092CAEGrICeY2IJ133+wBlDMBBQBj6tRtBwULdIbtx1WH9VA266iXh/fAyMQ3B3EUMD
         YcTY68cR4CUgSXLd060Md7U3JV660j5Kcc0ftxMoDtI63nas2JxTbyt44QGcVy51R8FO
         6SK+ATTiWVwfqGcuWdCioSea4fSdKBvoWbtxuVXsNT1RE2hKBexYL+bfXfHtZDLIzY0k
         DSKw==
X-Gm-Message-State: AOAM530S4ua1UZyRNgpFhqsPWcaYaIaG/mdqbcA4kYjhObtbsSN+0Kul
        sdC1lAyzxI+pv2qU2B4BJqviyQV0hwpNwyunsZAzvCm/fR4JgxX3V8iX0MmY5uMwGWMs8BUBBxg
        4FjsWzPH6ynZ3Ajfn7Ajcf5FO
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr5391024wmh.94.1604508038680;
        Wed, 04 Nov 2020 08:40:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7zIlg5Rjpu8xt5Hb182GPOmPT4u+LCPNEr0alVGGIsXNBCMBunmYCr29Os8CtFQIGob8ORQ==
X-Received: by 2002:a1c:4d05:: with SMTP id o5mr5391013wmh.94.1604508038513;
        Wed, 04 Nov 2020 08:40:38 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e7sm3722593wrm.6.2020.11.04.08.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 08:40:37 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: use positive error values for msr emulation
 that causes #GP
To:     Qian Cai <cai@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
        kvm@vger.kernel.org
Cc:     Borislav Petkov <bp@alien8.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>
References: <20201101115523.115780-1-mlevitsk@redhat.com>
 <247d36e9a0f2b06c8a4008c634d008ef4403c579.camel@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b24378fd-98d4-0231-3de4-3cc4f7d0e61c@redhat.com>
Date:   Wed, 4 Nov 2020 17:40:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <247d36e9a0f2b06c8a4008c634d008ef4403c579.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11/20 17:31, Qian Cai wrote:
> On Sun, 2020-11-01 at 13:55 +0200, Maxim Levitsky wrote:
>> Recent introduction of the userspace msr filtering added code that uses
>> negative error codes for cases that result in either #GP delivery to
>> the guest, or handled by the userspace msr filtering.
>>
>> This breaks an assumption that a negative error code returned from the
>> msr emulation code is a semi-fatal error which should be returned
>> to userspace via KVM_RUN ioctl and usually kill the guest.
>>
>> Fix this by reusing the already existing KVM_MSR_RET_INVALID error code,
>> and by adding a new KVM_MSR_RET_FILTERED error code for the
>> userspace filtered msrs.
>>
>> Fixes: 291f35fb2c1d1 ("KVM: x86: report negative values from wrmsr emulation
>> to userspace")
>> Reported-by: Qian Cai <cai@redhat.com>
>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Apparently, it does not apply cleanly on today's linux-next. Paolo, is it
> possible to toss this into -next soon, so our CI won't be blocked because of
> this bug?
> 

Yep, I plan to send it to Linus later this week.

Paolo

