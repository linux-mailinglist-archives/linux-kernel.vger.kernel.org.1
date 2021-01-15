Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237322F7D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbhAONuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:50:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731796AbhAONuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:50:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610718524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UmdXZnJ0rCCxg9loWNAHyICDQUnDFC/MbRNMEAdOfbU=;
        b=A3MxPJBEhL1zGuhv61c07I+2YiFuFzocRDAE0mdPQyFzA1T7SWDUeM3gKJ9/kF4YU7Cy2x
        IGDCsLS1Xfa0yoOUnz5IjkicapAlQDqz/BMs9HEPAomv8jfJB5/XvN0f+S9PXD/Q3hrJ7M
        OThLsWnG8+XEUwr8GTx6qVtdQnNkZ2Y=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-Grvl3Dv1OtO2Oy3dRiemZQ-1; Fri, 15 Jan 2021 08:48:41 -0500
X-MC-Unique: Grvl3Dv1OtO2Oy3dRiemZQ-1
Received: by mail-ed1-f72.google.com with SMTP id 32so1711037edy.22
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:48:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UmdXZnJ0rCCxg9loWNAHyICDQUnDFC/MbRNMEAdOfbU=;
        b=s53Y0YkfBy5Dpmps0uv156V0hx0GtUhOVZlW9ngf0YMF4PlVBmkZiEp6yPdQoJVky8
         vhPj/EvzUt6E8kYP1uwBv+7h8RPez5/iYEgjIu1vbym/h6Hq7hqY7txzrMnAvOJWL2+l
         vLPFH5esGZqabNGUQqcCZUJ8X/SLtYTE2vHw9aw1OWuJynU8GB+i7u4ArfGfbOKXC4Be
         NxJqhKOdEF0aXHgbdIEz1gtZGmiwho2GNZfXY5RqpIeq7wFUQ1EvMvl2CTYP0TQGHh0t
         JhOtb6dLZScV4QXIQE3XSAtg82fUn/hWcWOQMCydrfUF/L3oEJRkemgChZYfCd0nsHi6
         V1cw==
X-Gm-Message-State: AOAM5327Y++YsdvcTI8Xyyzw9RLA+aqkFeUysHmA0+SIoxVKnJu6c0Ep
        xE1oiyNIfnauY0xGdt5VjxtYvw3H/vpUEzkCf+0ARq/zLhoWfqlKAzlgd1UGCB8gc1feZY1VPO+
        YlpPW/XhRUcmPpQc3cPlDeFnm
X-Received: by 2002:a17:906:1f8e:: with SMTP id t14mr8966249ejr.350.1610718520515;
        Fri, 15 Jan 2021 05:48:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy9EpSEC4BRPwW2BLpZzVG1AVTq23DwCnwPW8rSH7TxniRUbmiTF14i8qMsAaDUXEUKa1kQnA==
X-Received: by 2002:a17:906:1f8e:: with SMTP id t14mr8966234ejr.350.1610718520315;
        Fri, 15 Jan 2021 05:48:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l17sm3487008ejn.122.2021.01.15.05.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 05:48:39 -0800 (PST)
Subject: Re: [PATCH v2 2/3] KVM: nVMX: add kvm_nested_vmlaunch_resume
 tracepoint
To:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
References: <20210114205449.8715-1-mlevitsk@redhat.com>
 <20210114205449.8715-3-mlevitsk@redhat.com> <YADeT8+fssKw3SSi@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <18c386f2-a588-6324-fcde-d13b66f66d4f@redhat.com>
Date:   Fri, 15 Jan 2021 14:48:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YADeT8+fssKw3SSi@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/21 01:14, Sean Christopherson wrote:
>> +	trace_kvm_nested_vmlaunch_resume(kvm_rip_read(vcpu),
> Hmm, won't this RIP be wrong for the migration case?  I.e. it'll be L2, not L1
> as is the case for the "true" nested VM-Enter path.

It will be the previous RIP---might as well be 0xfffffff0 depending on 
what userspace does.  I don't think you can do much better than that, 
using vmcs12->host_rip would be confusing in the SMM case.

>> +					 vmx->nested.current_vmptr,
>> +					 vmcs12->guest_rip,
>> +					 vmcs12->vm_entry_intr_info_field);
> The placement is a bit funky.  I assume you put it here so that calls from
> vmx_set_nested_state() also get traced.  But, that also means
> vmx_pre_leave_smm() will get traced, and it also creates some weirdness where
> some nested VM-Enters that VM-Fail will get traced, but others will not.
> 
> Tracing vmx_pre_leave_smm() isn't necessarily bad, but it could be confusing,
> especially if the debugger looks up the RIP and sees RSM.  Ditto for the
> migration case.

Actually tracing vmx_pre_leave_smm() is good, and pointing to RSM makes 
sense so I'm not worried about that.

Paolo

