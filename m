Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08824276974
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgIXGwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:52:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34839 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727232AbgIXGwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:52:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600930321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OnQ7RnpQyCWKyHzqHkBwFITRaelVc+b99566RYUlUuU=;
        b=Px5jN3yUPLFgaCEZFODUlf2YVFDFEdsApCj4qCQR2ghCNC69dBxb/yQxFs4REUtPlAWuX9
        79YXjGPXnNVXuIPk6q1poSEzV0500OkqpFqRi0HxepvMLBU/4uTcU7VXzJup9540pOA4Im
        EWZ+pktwDL3kpIhUT1AYM2u4uz2E8jU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-Om7ZnQ2wNm6yTWTU1ofa6g-1; Thu, 24 Sep 2020 02:51:59 -0400
X-MC-Unique: Om7ZnQ2wNm6yTWTU1ofa6g-1
Received: by mail-wr1-f72.google.com with SMTP id d13so823147wrr.23
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 23:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnQ7RnpQyCWKyHzqHkBwFITRaelVc+b99566RYUlUuU=;
        b=DZPJvASc6Kv8rR9/F4MqUNt2yTift4wG3Q8jdJTwwDAzt9lPDsTH7f2XkM73u1xOpi
         l4jcN8LzRKxIILi6IldzWUZzkH7HSF7zkkmIbXGEtz8kPXKPVhSwa3QPl2r50LGSj1xJ
         2hEbrks0l2A6pcuGb/Unka2/URyzSoaPwlovSbSdiA67ZnXJlAmC80KkGSGyj0g/PdoP
         KvJLnvy19+V1vwwtT7q4g0SaMEv3rW9eNpJmLEs1xCn+FJ70gdREcFObToIBcU2BYJEg
         zzqwvX73LbeIUsEjj4ghoRNvYTDWL0af+OuKuhl/LRQDO/DvmdpTKjmYgAy+PSRzTXWL
         SLjg==
X-Gm-Message-State: AOAM5314I6mAdwjF+87TOh6OeD4p8+L859Q1laq0UqyN8+wEv4Im3qnU
        M8gQOGSk9OpWX70jFzmBUux8kHhhIZBvsxzJZn403MtT68Gdh0cFyYa9SvMgRWFCLsVGrB0KzJz
        Tu7nHR5BdR9CKwWToyVKo669F
X-Received: by 2002:a7b:c095:: with SMTP id r21mr3254607wmh.133.1600930318652;
        Wed, 23 Sep 2020 23:51:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIeIX5AT7dBIOdJC7LRZQn1fAtdurXZZQW16RpkfOrEWOzAPYZlFOar52I36l0bKFZs60P9g==
X-Received: by 2002:a7b:c095:: with SMTP id r21mr3254593wmh.133.1600930318446;
        Wed, 23 Sep 2020 23:51:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:d80e:a78:c27b:93ed? ([2001:b07:6468:f312:d80e:a78:c27b:93ed])
        by smtp.gmail.com with ESMTPSA id n4sm2287101wrp.61.2020.09.23.23.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 23:51:57 -0700 (PDT)
Subject: Re: [PATCH] KVM: SVM: Add a dedicated INVD intercept routine
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <16f36f9a51608758211c54564cd17c8b909372f1.1600892859.git.thomas.lendacky@amd.com>
 <20200923203241.GB15101@linux.intel.com>
 <12be5ce2-2caf-ce8a-01f1-9254ca698849@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d260b1e1-1a53-a7ee-e613-a806395582f6@redhat.com>
Date:   Thu, 24 Sep 2020 08:51:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <12be5ce2-2caf-ce8a-01f1-9254ca698849@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/20 22:40, Tom Lendacky wrote:
>>> +static int invd_interception(struct vcpu_svm *svm)
>>> +{
>>> +	/*
>>> +	 * Can't do emulation on an SEV guest and INVD is emulated
>>> +	 * as a NOP, so just skip the instruction.
>>> +	 */
>>> +	return (sev_guest(svm->vcpu.kvm))
>>> +		? kvm_skip_emulated_instruction(&svm->vcpu)
>>> +		: kvm_emulate_instruction(&svm->vcpu, 0);
>>
>> Is there any reason not to do kvm_skip_emulated_instruction() for both SEV
>> and legacy?  VMX has the same odd kvm_emulate_instruction() call, but AFAICT
>> that's completely unecessary, i.e. VMX can also convert to a straight skip.
> 
> You could, I just figured I'd leave the legacy behavior just in case. Not
> that I can think of a reason that behavior would ever change.

Yeah, let's do skip for both SVM and VMX.

Paolo

