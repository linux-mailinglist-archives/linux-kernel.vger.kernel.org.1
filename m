Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA7B2B229E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 18:36:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKMRgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 12:36:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23247 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726771AbgKMRgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 12:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605288971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NAWOiKNPr7NdH0SfoGuNiXpNKXaZRwcJVJ3a0/q6UEM=;
        b=YiO0JKczEiBNtIFWPn9YAqI/+lVq8hzwXVZNPNO8oeZj+ri+MMokLbfYphrHDzfvlq1WY1
        PxiYSz1jiegg42jiOUhEVO1auDYAdMQ9lOeHr/4XgH9vUnMZ/l9H+dF3aZUWrxsuSrq68K
        flren0lAkpkL8MnQXOOE/jJ5StLf/ug=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-heobo9GqOPy8jsTTUG5krQ-1; Fri, 13 Nov 2020 12:36:09 -0500
X-MC-Unique: heobo9GqOPy8jsTTUG5krQ-1
Received: by mail-wr1-f69.google.com with SMTP id w5so1946947wrm.22
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 09:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NAWOiKNPr7NdH0SfoGuNiXpNKXaZRwcJVJ3a0/q6UEM=;
        b=cnCE2XoGFuKMII//f+ry35V7gwZXD5aXe515qC4nS3i+x6MSxUoJcwRDGaJfK/Q58J
         hcQ/k3fOsMwTiqwI3PqN7ld0CmDe21AUZjav3RShD+H08pwwbSrhh1oGsxTqU5EBEHt2
         KqhtAkAsAVGvdweGQ/nBqV9Fk5oFbSHfJURfbbkBANRi8rNCUwdk5lfiHzOGEPUiz9HX
         yWyqtpagFx5MI4KepH5v1QFEe6xbH/84yMWrTpcQSGtOwCT1Ry4ULBJsQ3kjDOw3bdw3
         BMptutxEhYngAkfZiNyVh1EGp5Z9RPn1aBndzXyn4ndSa/mh6oiNwXhIhfh+6jdpHlTc
         RgBQ==
X-Gm-Message-State: AOAM531mj0fY9q/d9Db9DWKJqSMdPt9HeChr9HC0M7W0xN/RnyVopAkE
        0LjBwlMNEMthu4Q3aCuTehQyVIdwqn4kf7wiPhNmAHGeEpxMX/Fc3+ELcFCkqYaWVor7C5B7HBa
        B8ICLb2OJRfIbUvMO+qt4/tvf
X-Received: by 2002:adf:fc01:: with SMTP id i1mr4829496wrr.250.1605288964942;
        Fri, 13 Nov 2020 09:36:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0vudkfKU4Xydr2EdpA/kzp9pTcHNEHyW7SYCAkCMGeUkCOR26XxFLcWnUl7631MBD2ZKN5A==
X-Received: by 2002:adf:fc01:: with SMTP id i1mr4829446wrr.250.1605288964464;
        Fri, 13 Nov 2020 09:36:04 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id d63sm10940123wmd.12.2020.11.13.09.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 09:36:03 -0800 (PST)
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Cathy Avery <cavery@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, wei.huang2@amd.com, mlevitsk@redhat.com
References: <20201011184818.3609-1-cavery@redhat.com>
 <20201011184818.3609-3-cavery@redhat.com>
 <20201013013349.GB10366@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/2] KVM: SVM: Use a separate vmcb for the nested L2
 guest
Message-ID: <f3268301-6cbd-904e-949c-7ccc4a2e5d36@redhat.com>
Date:   Fri, 13 Nov 2020 18:36:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201013013349.GB10366@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/20 03:33, Sean Christopherson wrote:
>> +	svm->vmcb = svm->vmcb01;
>> +	svm->vmcb_pa = svm->vmcb01_pa;
> I very highly recommend adding a helper to switch VMCB.  Odds are very good
> there will be more than just these two lines of boilerplate code for changing
> the active VMCB.

Yes, probably we can make svm->vmcb01 and svm->vmcb02 something like 
VMX's struct loaded_vmcs:

struct kvm_vmcb {
	void *vmcb;
	unsigned long pa;
}

I don't expect a lot more to happen due to SVM having no need for 
caching, so for now I think it's okay.

I have other comments for which I'll reply to the patch itself.

Paolo

