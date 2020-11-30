Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEF42C8A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgK3RAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:00:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48683 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729004AbgK3RAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:00:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606755553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I4LH1qAWvewXopVUKwwVaGkrglwVm5xN/89Xs5ZOgWY=;
        b=crZNzZUjTxAfnJGrZzK+CftL/sFGd5Fd3RIJjx9Zs6tEfvNezsQ346gIA+W0JhSj6iPfDQ
        /etVGsv5UfC+UtZd1Sj4nMshqrDhJ2ts1TlTgFzawCGwR+JPb6ZMratLRe/evSg8EE31iq
        DVWrpNgvI8NR0aFFqoeRxyVrt9B8/tA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-S5QwfVs_O3aFJhtKOn6haw-1; Mon, 30 Nov 2020 11:59:12 -0500
X-MC-Unique: S5QwfVs_O3aFJhtKOn6haw-1
Received: by mail-ed1-f72.google.com with SMTP id m8so6543539edq.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 08:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I4LH1qAWvewXopVUKwwVaGkrglwVm5xN/89Xs5ZOgWY=;
        b=kY9BXOmoEK7v/yjuuHbuBMCsTbEISxBI50GBqD4481+r7Mx2DYBKWhrYVcozMywGkx
         /AOIfm1vu4VkVuB+Anf2bP9+FM24rJlACosEED8nciJ9+LrbQIdgs73fwaGSzrWQlx2a
         t3pRlu8GTwLYptKk2bw2XBKQnscz6oIljxmL517LuyTVcUpTbjSwlmTA2a5XTh+zdixi
         /oZlSOonNDswetzovsmPJmhFw+5B6kdXwg85EqBC7PzaJqmVQCuIx7PZvVVy24k4ba8b
         TYs1IMmTvJMzwvpDmPjo7k/GsHxrF61rAIJ3i5glHoCY9FPDvGC5de20Jpu33xOV44eb
         088Q==
X-Gm-Message-State: AOAM530qbkQem1BgJfzhbO1kzEcAR6mlMktCRf6SXX1v+CVyrGQ/rv+7
        oDKIf86er4yioemJ2QJokRgJLsz4plHXiZNh04vOUUqRtSPDJICpKjxTeNwZZMgfNP3Ee9Tc7KJ
        I3cR3ynrQmgoke7BEPIwwcxJ/
X-Received: by 2002:a05:6402:3089:: with SMTP id de9mr22702674edb.100.1606755550677;
        Mon, 30 Nov 2020 08:59:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJymalDiKWug9j4JZvUBqiNMbGKSfPpmio8hUaihWWE//+uuNfXrRRf4dxPmhiVrO8rpujqrlA==
X-Received: by 2002:a05:6402:3089:: with SMTP id de9mr22702648edb.100.1606755550512;
        Mon, 30 Nov 2020 08:59:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k17sm8658535ejj.1.2020.11.30.08.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Nov 2020 08:59:09 -0800 (PST)
Subject: Re: [PATCH 0/2] RFC: Precise TSC migration
To:     Andy Lutomirski <luto@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>, Oliver Upton <oupton@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        open list <linux-kernel@vger.kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Jim Mattson <jmattson@google.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20201130133559.233242-1-mlevitsk@redhat.com>
 <CALCETrVr2bM4yJTVpQULN+EYVQJuWGCvjX0SMFsCRy6BwqZc0w@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <26444d65-083b-5df4-52c9-c1cfad556b10@redhat.com>
Date:   Mon, 30 Nov 2020 17:59:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVr2bM4yJTVpQULN+EYVQJuWGCvjX0SMFsCRy6BwqZc0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/20 17:54, Andy Lutomirski wrote:
>> I*do think*  however that we should redefine KVM_CLOCK_TSC_STABLE
>> in the documentation to state that it only guarantees invariance if the guest
>> doesn't mess with its own TSC.
>>
>> Also I think we should consider enabling the X86_FEATURE_TSC_RELIABLE
>> in the guest kernel, when kvm is detected to avoid the guest even from trying
>> to sync TSC on newly hotplugged vCPUs.
>>
>> (The guest doesn't end up touching TSC_ADJUST usually, but it still might
>> in some cases due to scheduling of guest vCPUs)
>>
>> (X86_FEATURE_TSC_RELIABLE short circuits tsc synchronization on CPU hotplug,
>> and TSC clocksource watchdog, and the later we might want to keep).
> If you're going to change the guest behavior to be more trusting of
> the host, I think
> the host should probably signal this to the guest using a new bit.
> 

Yes, a new CPUID bit takes longer to propagate to existing setups, but 
it is more future proof.

Paolo

