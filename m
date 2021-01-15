Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C64E2F7D2C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 14:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbhAONvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 08:51:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727719AbhAONvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 08:51:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610718623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GClJQCWfDVIp8Abu+51pXYFvR3+SULW6nqe1Zw2Nhco=;
        b=F+C/Hx6rDj6qxuWxoXF4UDZORvoqvomimmfQoOsHcoZKMBYGVHBSLExAifxSGlvAaOJJBl
        9+lkUfyfYCNzsEn9TAbCqWGD+UhdB/3cSdgIoQMafk/NPnL9D8VPYFjPIgzaRRq34Bhjnb
        4p+LlPZHWepEE14XN/D+inHv6mlglS0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-Sw3FYx9nOvSkuVUxAwYhvw-1; Fri, 15 Jan 2021 08:50:21 -0500
X-MC-Unique: Sw3FYx9nOvSkuVUxAwYhvw-1
Received: by mail-ej1-f72.google.com with SMTP id b18so1612652ejz.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 05:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GClJQCWfDVIp8Abu+51pXYFvR3+SULW6nqe1Zw2Nhco=;
        b=lhy1FvY2IYT2oSCNBUpE+QCNMin9xorhrNbNCRSEyRN/RFYGTMWoKDaU9Wfs/8GNP5
         AA6WFl+F5Mr8YATnzSFBZAuaCh0/axjzhJhJTUKZX4DkgSlDqok0lThQ4M95r6djV4jy
         VrYuozyPfr5QgKBqp9hPn9T1njiec8/NPJ2NcbT/nUWeN7MehImwCXgkZSsxBL/8w5fo
         w1fs8kIS42iPWW4NiA6BDDZeYxH2CFV3n0pInL6Jf9PlkjjDgpP3kM5hXxW7Mmx/UzLR
         rNeZUqmsXnO5VoG93N7FNHMboQ3fiBHUkjzNF6nII3oIpOTUkoMj90rHWi1T1Lb7haaw
         payw==
X-Gm-Message-State: AOAM533KkXp2stILNZj2h/JxAAvux5+LO4gCcrs7FJL3HQ/CBQnMgxGd
        Fn7PaE3V1KlQSZBzeltlpgNNdrsUfqLZWifZ/847MojgJO5rhpHlcOuottb+PlM5LYB7iEA9Dd8
        QQFllf6Gh0J8pjyl1s9CUK17B
X-Received: by 2002:a17:907:3f13:: with SMTP id hq19mr9060270ejc.142.1610718620211;
        Fri, 15 Jan 2021 05:50:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKpmIkaYyI1N+J5ZOU1XodqPeFuoNmwqs4aW3Sw/NgHl/VK+y6PQ/FPUfmzNJDpLKJ7aNWYg==
X-Received: by 2002:a17:907:3f13:: with SMTP id hq19mr9060257ejc.142.1610718620074;
        Fri, 15 Jan 2021 05:50:20 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id u2sm3461214ejb.65.2021.01.15.05.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jan 2021 05:50:19 -0800 (PST)
Subject: Re: [PATCH v2 2/3] KVM: x86: introduce definitions to support static
 calls for kvm_x86_ops
To:     Peter Zijlstra <peterz@infradead.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     seanjc@google.com, kvm@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andrea Arcangeli <aarcange@redhat.com>
References: <cover.1610680941.git.jbaron@akamai.com>
 <e5cc82ead7ab37b2dceb0837a514f3f8bea4f8d1.1610680941.git.jbaron@akamai.com>
 <YAFf2+nvhvWjGImy@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <84b2f5ba-1a16-cb01-646c-37e25d659650@redhat.com>
Date:   Fri, 15 Jan 2021 14:50:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <YAFf2+nvhvWjGImy@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/21 10:26, Peter Zijlstra wrote:
>> +#define KVM_X86_OP(func)					     \
>> +	DEFINE_STATIC_CALL_NULL(kvm_x86_##func,			     \
>> +				*(((struct kvm_x86_ops *)0)->func));
>> +#define KVM_X86_OP_NULL KVM_X86_OP
>> +#include <asm/kvm-x86-ops.h>
>> +EXPORT_STATIC_CALL_GPL(kvm_x86_get_cs_db_l_bits);
>> +EXPORT_STATIC_CALL_GPL(kvm_x86_cache_reg);
>> +EXPORT_STATIC_CALL_GPL(kvm_x86_tlb_flush_current);
> Would something like:
> 
>    https://lkml.kernel.org/r/20201110103909.GD2594@hirez.programming.kicks-ass.net
> 
> Be useful? That way modules can call the static_call() but not change
> it.
> 

Maybe not in these cases, but in general there may be cases where we 
later want to change the static_call (for example replacing jump labels 
with static_calls).

Paolo

