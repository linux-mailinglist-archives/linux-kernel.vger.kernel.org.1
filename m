Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08D83270EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgISPJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 11:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39821 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726400AbgISPJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 11:09:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600528154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W1IebRkP5Qy8CK9eMesBAQ+yjVfyUddrM/ZK4BlJaXY=;
        b=Qr2V80wBUGO0mkOPywSlxa7ESEHQ/pBeood8ZSoFhArEiJ2zEWmg3Yim0JettfQQI3veyI
        OSB7GWm9Vl6lr0n4AI9es7PCpRnjumDAwLdgPUgV4dsiGSwy7+kVeIKVxMO/I58SDIDO8R
        CViVuLc9mhD+jKb1hbwxONaEO02tWxM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-126-Yciu-kQ-OqK08DrzUL75WQ-1; Sat, 19 Sep 2020 11:09:12 -0400
X-MC-Unique: Yciu-kQ-OqK08DrzUL75WQ-1
Received: by mail-wr1-f71.google.com with SMTP id j7so3548932wro.14
        for <linux-kernel@vger.kernel.org>; Sat, 19 Sep 2020 08:09:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W1IebRkP5Qy8CK9eMesBAQ+yjVfyUddrM/ZK4BlJaXY=;
        b=e3DGnXiOsHeYp/vuQOrT5jRjxB0tqpRA6PH7tcGBi5Frf+8eLMJhfZWemvgxvaFaW8
         CJi6HwZqIpA5Nq/TmYoDk0NbxiOMjhOTUXn+OsoNhHND9OCBS57vWQSc/j3iy+eJ58o3
         B61dD46ZZo4zCaLIrkJ0FcbdNbIgbnqgG3wyGFJPrF1qI+KLNYwfVtcwvyXov8hrAFhb
         JTUFjtqWsH50mh0REWw5tB8E6xszfTNN/X8oMPb0vC05BSPYEPpllWZCi6iLBjaSYJnc
         dTmFBn6LlDuEJCtIOOkv2ZQGncoBm7gwLGsYu88QObjv+W5cn9pEaE8SeLkqVaxtsvgr
         b9ig==
X-Gm-Message-State: AOAM532Ruhu/D004i06uQ1YhN3LO5HH1yFjrEuZBUbHulBriZi+yqziz
        stpH38Fp+87hvXs+Tegd0oaq0JVV0/Qt+SoFqOxtRylpdm+QYMDz3eDWFpRlZrjcsBzrHg8yXe9
        kGHENPTxRKRArb4WiHxTOVJXS
X-Received: by 2002:adf:f784:: with SMTP id q4mr37954880wrp.126.1600528151463;
        Sat, 19 Sep 2020 08:09:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKpPy0hJAxTQ09zpPWlpplAAHUVUoUjc4Gx4GB2KSdz9X07Qk+YMsfBpsl5LN7ahDONN6ajg==
X-Received: by 2002:adf:f784:: with SMTP id q4mr37954865wrp.126.1600528151264;
        Sat, 19 Sep 2020 08:09:11 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b20a:b600:521c:512d? ([2001:b07:6468:f312:b20a:b600:521c:512d])
        by smtp.gmail.com with ESMTPSA id f14sm11401536wme.22.2020.09.19.08.09.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 08:09:10 -0700 (PDT)
Subject: Re: [PATCH v4 2/2] KVM: nSVM: implement ondemand allocation of the
 nested state
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Vitaly Kuznetsov <vkuznets@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <20200917101048.739691-1-mlevitsk@redhat.com>
 <20200917101048.739691-3-mlevitsk@redhat.com>
 <20200917162942.GE13522@sjchrist-ice>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d9c0d190-c6ea-2e21-92ca-2a53efb86a1d@redhat.com>
Date:   Sat, 19 Sep 2020 17:09:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200917162942.GE13522@sjchrist-ice>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/09/20 18:29, Sean Christopherson wrote:
>> +				vcpu->arch.efer = old_efer;
>> +				kvm_make_request(KVM_REQ_OUT_OF_MEMORY, vcpu);
> I really dislike KVM_REQ_OUT_OF_MEMORY.  It's redundant with -ENOMEM and
> creates a huge discrepancy with respect to existing code, e.g. nVMX returns
> -ENOMEM in a similar situation.

Maxim, your previous version was adding some error handling to
kvm_x86_ops.set_efer.  I don't remember what was the issue; did you have
any problems propagating all the errors up to KVM_SET_SREGS (easy),
kvm_set_msr (harder) etc.?

Paolo

