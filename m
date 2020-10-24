Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E0D297B0E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 08:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759766AbgJXG3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 02:29:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1759757AbgJXG3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 02:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603520952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zNm+Nqq4sdY9gKwTOr5dT8TgTjmTU4f3Y+OcGbCbZdk=;
        b=RnxRY8V1P4GAz1AXfO1NtIcByKz3sJhkUBydK890UZbUuCzTyufcYy+Iv2cz9LV4NmEk67
        CIGFYyTz0PCA2gmdUG8TE/9ZykBspB8aXY1HDlogAR7PKS//g4EAdUU1fKMVWZ28zRMwYQ
        WNW9pjPzBCX77hgJ1SFMNiSEp58HUKc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-lF009kUBNliIB786g1Yx7Q-1; Sat, 24 Oct 2020 02:29:09 -0400
X-MC-Unique: lF009kUBNliIB786g1Yx7Q-1
Received: by mail-ed1-f71.google.com with SMTP id u12so1430744edi.17
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 23:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zNm+Nqq4sdY9gKwTOr5dT8TgTjmTU4f3Y+OcGbCbZdk=;
        b=nJz16w1FEqPjgghs/4igWcEVEAmxkobV3UVLJIR25VrqQ3uznedhkVndmBCsg3S2Qv
         NfKxX0pcb43y851JkCAe1crXAFJkUAv2bESUbJeJ3UDbP+5cYjvWSmTDIBmYjUO6GLSn
         9Q6gqbYMneBfAvWIIb9UVprL4OLcnySB6b1Bx/kqae5nvl4Eeh3qaZmHMJQUuuRf9HQV
         NydjpS2TfVdJfH8JjDq4xg3KwYG/lpVqxQkkSESrQJXchI3WNFHVYx79s37QdUOTb8E8
         +yEJy5uXH9yq04e0k3O0HdvWXWnGhTe0Lhr8KbrVgpBvfraIouU6MwqkKxi4i2Oe6dYu
         jPkw==
X-Gm-Message-State: AOAM532cMBvyMh7xL86FArcR9VG7AITqvr7WL5wDLpdTzjVlVPgontxM
        PaZVU7LWbJ44XB7hBw/Xs+Vu6mPUN+shDE8cITPhv6FqOh3X3UZnCJio+G0YKKlru9haVyLq/6c
        pryBp216stIVyn2OBaykUWkuy
X-Received: by 2002:aa7:cacb:: with SMTP id l11mr5720779edt.332.1603520948271;
        Fri, 23 Oct 2020 23:29:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxmuFu2/00OKrqJC7TpA1YpX8QYyZQZ1yN6UWIlIYuqj9OHVCBu8bLxjDr12UlhMYizflbQdg==
X-Received: by 2002:aa7:cacb:: with SMTP id l11mr5720763edt.332.1603520948007;
        Fri, 23 Oct 2020 23:29:08 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id i22sm1810746ejv.8.2020.10.23.23.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 23:29:07 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Avoid modulo operator on 64-bit value to
 fix i386 build
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
References: <20201024031150.9318-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <94427d37-03af-6d78-2039-cd326710904b@redhat.com>
Date:   Sat, 24 Oct 2020 08:29:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201024031150.9318-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/20 05:11, Sean Christopherson wrote:
> Replace a modulo operator with the more common pattern for computing the
> gfn "offset" of a huge page to fix an i386 build error.
> 
>   arch/x86/kvm/mmu/tdp_mmu.c:212: undefined reference to `__umoddi3'
> 
> Fixes: 2f2fad0897cb ("kvm: x86/mmu: Add functions to handle changed TDP SPTEs")
> Reported-by: Daniel Díaz <daniel.diaz@linaro.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> Linus, do you want to take this directly so that it's in rc1?  I don't
> know whether Paolo will be checking mail before then

Yes, I am.  I also have another bugfix, I was going to wait a couple
days for any -rc1 issues to pop up but they came up faster than that.

Paolo

