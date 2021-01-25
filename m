Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF55C3028C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbhAYRZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:25:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24084 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731014AbhAYRZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611595412;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BwQcCHg2Ol8PYg3iWhYhyw6ZkX3/4q3t8h9u7eKel9Y=;
        b=JtqhuaLnkgFnYa95tnMsLqp/dSWeiXGw7bAI9TK1VoqnwkPGatzIj36Sku4EkEMeOZ3MKH
        UxsQKR705j57sG2D76RpHCSxZLtP3TAF/K5NUBGHedA93wZAyBOOlVv3hIFAP2i6E+Pr6X
        75k4rNAzVVWom3TQVUAXeLIDQsELrw8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-SNSLLGNcO327cDgbYPDduA-1; Mon, 25 Jan 2021 12:23:31 -0500
X-MC-Unique: SNSLLGNcO327cDgbYPDduA-1
Received: by mail-ej1-f71.google.com with SMTP id f1so4073302ejq.20
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 09:23:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BwQcCHg2Ol8PYg3iWhYhyw6ZkX3/4q3t8h9u7eKel9Y=;
        b=dcgQHSQH4JSlkX3fMgKIFzJRIrrEDH1P9hC8OTB7C/J6MWQpq3Q3VGzuwNcXg93AG5
         u2SssWaI76VP9qc6P9q7SFGOY5Vr7EskUEmMq7jioecbUZulW4q5yCjLD9rj+9XdF4nN
         aSd6AZmjthIRJUaYieCQsRu2WwRnGuKN+NvM0iRnD/VoWSQxrDDLhtLXe5W3tAzRL0yK
         kO2egjLWJPQ0Rh4HrBHsxHY/sf9bPxuw1yO608ZA5TZnNh75RJfNbzjunS0t79QqD+3v
         tKv+uyZq9m1uONcP1tN7cO8RsWjOXkpb0rJ+OFhDwjc59VYdyApPIhlt/Ww5IK/9pFT8
         xuEQ==
X-Gm-Message-State: AOAM530xWeyv8cSrdog77FYwTbUxoWKCdAHpvFNvYXqfnwOrYaY8WagM
        NluLMSNMdiYj3qaNZYhjd4Ahoqi5rjnrBBUNysyJGNTgdhVlvKw9o0PgfbIW8gwU7vZzNTEz0dn
        sP1vudSi4oIaO0vEFNdynSqaZreD91uyxUN35u3spL2bwv5fOe8ir4fPfwjteeqk9Rs4V4E6n2N
        Kj
X-Received: by 2002:a17:906:338b:: with SMTP id v11mr1096999eja.74.1611595409505;
        Mon, 25 Jan 2021 09:23:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwBvA/3+BRG5ShSjQfjG1DrHKuVqIXrFquO1tdYvWlxQ5IONMOmT/H0MA5fjh51RCxYQ2DQ6g==
X-Received: by 2002:a17:906:338b:: with SMTP id v11mr1096984eja.74.1611595409333;
        Mon, 25 Jan 2021 09:23:29 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id s18sm11161636edw.66.2021.01.25.09.23.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jan 2021 09:23:28 -0800 (PST)
Subject: Re: [PATCH 0/2] KVM: x86: Minor steal time cleanups
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210123000334.3123628-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5dfde03f-5a3f-193b-5dec-3d35a35af9c9@redhat.com>
Date:   Mon, 25 Jan 2021 18:23:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210123000334.3123628-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/21 01:03, Sean Christopherson wrote:
> Cleanups and a minor optimization to kvm_steal_time_set_preempted() that
> were made possible by the switch to using a cache gfn->pfn translation.
> 
> Sean Christopherson (2):
>    KVM: x86: Remove obsolete disabling of page faults in
>      kvm_arch_vcpu_put()
>    KVM: x86: Take KVM's SRCU lock only if steal time update is needed
> 
>   arch/x86/kvm/x86.c | 30 +++++++++++-------------------
>   1 file changed, 11 insertions(+), 19 deletions(-)
> 

Queued, thanks.

Paolo

