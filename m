Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BF01A75E8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436673AbgDNIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:24:06 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60225 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436523AbgDNIVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:21:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586852461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TtBLM3c8JTLmBP2uDmSrWuT9/+Pwll6JJwpjBt6QX00=;
        b=Gp1QYLF1PrEgX3vAu+dXARdbbNzC1ycYKeG+e0+OpE4vNR7LX6VMIJvieYXs4I87X9JUX/
        gzuj5HEc/iaB6nLYR4Z289isVPNRjpA/FaBzKZI6u0tRNFN9Hc5SnZ4PMicCjfqTZnyeXs
        lgf+SPEheVAIOy5fbj3vM1Ma0KNTWZQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-495-J1iW7KjONDavI80bIPdQkA-1; Tue, 14 Apr 2020 04:19:02 -0400
X-MC-Unique: J1iW7KjONDavI80bIPdQkA-1
Received: by mail-wm1-f71.google.com with SMTP id h184so300020wmf.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 01:19:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TtBLM3c8JTLmBP2uDmSrWuT9/+Pwll6JJwpjBt6QX00=;
        b=Cgr8HCbif3MIqeAvrbaP65wJqr84FJUqsxgXLu8MBWiCQ2vuevr+gQV1oi5aks2jlU
         KqkAeDePvcGp0XO6mbrBrOMO4a7lal2QVJud/M+eSPonzeCBZKmGetB+s4BsT3FsHLQO
         /B496O27X7AtR6hHGrAQu7CmyswBlYsIgyn8DC10pfnL7mazCIO2cri35jsu16NmhIni
         /gubrk2xYnqPKTsR4jK1oEHWNQehJD3iQsr0Q8NTavcsl6MK0vC36iLDoPQFyDHGnrUs
         9vI+zhwH8XoQzuI5nDOqfM6Ttvu/E+mrr/F0TvRo/NtylIvwIc6/UuPNWMHmwXqiyIVk
         eQmw==
X-Gm-Message-State: AGi0Pua5o8/XF2SH8cxwjfgzerASJX726memW3T52H+E0FeFi4+P6enJ
        FwnMwJk+BnUGKhoWIj1vXPUqO7a2a0PuTqHKc079HiICaixpg+4f0ewBwHd5m7zWe9UvoqXPXcw
        8hR/l7gWYOnBdVWzowiM2Q/+9
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr8390693wrx.168.1586852341223;
        Tue, 14 Apr 2020 01:19:01 -0700 (PDT)
X-Google-Smtp-Source: APiQypKNVMzJLyv+Go05DzXWcde1VJnPobjfS5TpC3OSGCsAYJkHQBkL4kr8iyDzRWBXP64iQWFZGA==
X-Received: by 2002:a05:6000:8b:: with SMTP id m11mr8390681wrx.168.1586852340970;
        Tue, 14 Apr 2020 01:19:00 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:e159:eda1:c472:fcfa? ([2001:b07:6468:f312:e159:eda1:c472:fcfa])
        by smtp.gmail.com with ESMTPSA id o28sm3426907wra.84.2020.04.14.01.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 01:19:00 -0700 (PDT)
Subject: Re: [PATCH] kvm_host: unify VM_STAT and VCPU_STAT definitions in a
 single place
To:     =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        kvm@vger.kernel.org
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org
References: <20200413140332.22896-1-eesposit@redhat.com>
 <03a481a8-bcf2-8755-d113-71ef393508bf@amsat.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bf870876-9f9a-7ba8-d941-a3883e519eed@redhat.com>
Date:   Tue, 14 Apr 2020 10:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <03a481a8-bcf2-8755-d113-71ef393508bf@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/04/20 23:34, Philippe Mathieu-Daudé wrote:
>> +#define VM_STAT(x, ...) offsetof(struct kvm, stat.x), KVM_STAT_VM, ## __VA_ARGS__
>> +#define VCPU_STAT(x, ...) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU, ## __VA_ARGS__
> I find this macro expanding into multiple fields odd... Maybe a matter
> of taste. Sugggestion, have the macro define the full structure, as in
> the arm64 arch:
> 
> #define VM_STAT(n, x, ...) { n, offsetof(struct kvm, stat.x),
> KVM_STAT_VM, ## __VA_ARGS__ }
> 
> Ditto for VCPU_STAT().
> 

Yes, that's a good idea.  Emanuele, can you switch it to this format?

Thanks,

Paolo

