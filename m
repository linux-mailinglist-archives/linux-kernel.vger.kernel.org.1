Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5152962D5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897503AbgJVQhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:37:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49096 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2897376AbgJVQhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603384672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QtYKlqqsfUh3onisRedfmUk1jbRBMiSeTyZIxTQjMc8=;
        b=BDZty5cD0GTG3/5hxsNVM1NYNYVqb2oWBgYqqKbwh/MdNxLsglXa9rmtvFchNUgM0F8aNx
        FChk0c95sZ5/bjBkVMhvuUaTSPkBOEXZK7C+zQeeg9CRaEG036GHyQxH16yC1CHtJew29m
        VbCpUQ7/2/iHPrqqb9W3Zb1Rsosid5E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-2un4l7GvOkyskbVOTh8Kew-1; Thu, 22 Oct 2020 12:37:48 -0400
X-MC-Unique: 2un4l7GvOkyskbVOTh8Kew-1
Received: by mail-wr1-f71.google.com with SMTP id 2so834513wrd.14
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 09:37:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QtYKlqqsfUh3onisRedfmUk1jbRBMiSeTyZIxTQjMc8=;
        b=Pk2vID7a5Yb9jFTdJUdsXi+A6Nrxxfc7csebexNKVjxqxl3JUcqLVMcPgeuTP2PEiV
         yWCwQsX8pjVZq67TUmONu1vfOOigUgiDfEq/QF27O42kd2qazx8/8XXr2Nm7UGnMvmiq
         1+nKs3DY9eOi1EyPQi3IH8WSakPWAhf5J0aQ+4/Nl8Wds6mEi2p/5ucPfqeaAN4nwk2N
         xOQaocPhj8HWvDx1Hd13Ad7YLvjWme5/iCTBIARXSz8hc6AGJj54uVjSfAvy0FzN25kY
         APRB5e2EplH5Ge/wT0sls4y6sOGrp80yLwKi0wqNFSXRLyBNS9Z0FqtEfFxmJ5pVH0RC
         X/jg==
X-Gm-Message-State: AOAM532PPMD0p8mt0PlbYTJB3jwWtJiyt9z03Ly6PQm963fB2fV6vhrk
        y+XmNckxVN8NGABs3GRvs/1n0oTcxTieJTympHVhShOq/AcgnXjaq5XE0I3Zj/L+f+5jMSrEQB9
        PeicEsNSfFPQx/0oCxiNpJnd3
X-Received: by 2002:a05:600c:d3:: with SMTP id u19mr3422671wmm.150.1603384667428;
        Thu, 22 Oct 2020 09:37:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz1dAAikdYTkIfDCyfgPB2/+jGjC1ziu0OYS9BzctMyy4WuCIHIg9aRgKHev2Ycgj9U+hDmog==
X-Received: by 2002:a05:600c:d3:: with SMTP id u19mr3422649wmm.150.1603384667195;
        Thu, 22 Oct 2020 09:37:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d129sm4073026wmf.19.2020.10.22.09.37.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2020 09:37:46 -0700 (PDT)
Subject: Re: [PATCH] KVM: X86: Expose KVM_HINTS_REALTIME in
 KVM_GET_SUPPORTED_CPUID
To:     Jim Mattson <jmattson@google.com>
Cc:     Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
References: <1603330475-7063-1-git-send-email-wanpengli@tencent.com>
 <cfd9d16f-6ddf-60d5-f73d-bb49ccd4055f@redhat.com>
 <CALMp9eR3Ng-WBrumXaJAecLWZECf-1NfzW+eTA0VxWuAcKAjAA@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <281bca2d-d534-1032-eed3-7ee7705cb12c@redhat.com>
Date:   Thu, 22 Oct 2020 18:37:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CALMp9eR3Ng-WBrumXaJAecLWZECf-1NfzW+eTA0VxWuAcKAjAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/10/20 18:35, Jim Mattson wrote:
> On Thu, Oct 22, 2020 at 6:02 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 22/10/20 03:34, Wanpeng Li wrote:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> Per KVM_GET_SUPPORTED_CPUID ioctl documentation:
>>>
>>> This ioctl returns x86 cpuid features which are supported by both the
>>> hardware and kvm in its default configuration.
>>>
>>> A well-behaved userspace should not set the bit if it is not supported.
>>>
>>> Suggested-by: Jim Mattson <jmattson@google.com>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>
>> It's common for userspace to copy all supported CPUID bits to
>> KVM_SET_CPUID2, I don't think this is the right behavior for
>> KVM_HINTS_REALTIME.
> 
> That is not how the API is defined, but I'm sure you know that. :-)

Yes, though in my defense :) KVM_HINTS_REALTIME is not a property of the
kernel, it's a property of the environment that the guest runs in.  This
was the original reason to separate it from other feature bits in the
same leaf.

Paolo

