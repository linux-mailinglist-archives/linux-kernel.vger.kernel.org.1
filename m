Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BAD2C6A1C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 17:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgK0QtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 11:49:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60288 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731337AbgK0QtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 11:49:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606495739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nGp/DntBx65LrgMqUH3vUA33NqIvtHitHZjJU3bsRLY=;
        b=EHlQ79/zAKfF5TqUQrTOLHmoXfItZ7AS7CcFROXF2QZWOboIJ3JquLk0hzpGOrOERBbu1w
        pHkxywVtPcBcgM6vgswuvmH31lS9jnaLtMe/FpyeNkkllouyTf2Axb45j2ghswScAB7eFw
        3HeDi92Zlg7qx7hKJo8TZIRk/lzaug8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-n944F_NJN7a3oKlNbz6BEQ-1; Fri, 27 Nov 2020 11:48:56 -0500
X-MC-Unique: n944F_NJN7a3oKlNbz6BEQ-1
Received: by mail-ej1-f72.google.com with SMTP id k15so2168294ejg.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 08:48:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nGp/DntBx65LrgMqUH3vUA33NqIvtHitHZjJU3bsRLY=;
        b=j5u7cmZie0n2LI60qzbNKDNkgXJNRjblTQRbg4XM78nRNDB4yJuZ9XMX2UXU/Fx+wt
         4wE9WnwQOIxTGH5N2gM8s5/alsd2YzMkClvDmrZYicA1scMiSCGJnUNBF3RHdhT7K7nh
         dlineeXVCyVbjY5uNSiu2h0Bupc+K+Co2y9WYU1ksaQQRio5XWzzfDVnArb7fxi7frFX
         2Tz7nsYIxBm13yc/BVbwkJOGuVVra0HI7Pf35TB/YZcCUczFviNqyNoi1M1nc1/3rHTE
         sBe/cKk1hnYhGN5qLK2V2phG7fUMVGYZE8snfLR+f/TjY18nQg5um4f2ChVA4GNlohLI
         muxQ==
X-Gm-Message-State: AOAM5337sPaifyuWABl5EjGjxy1pfHANkK3SwzV12qCqTord02pcdnPD
        VVcyA94FN1a6Iow3LL12CPHpGmxtgeyKcKVH1jg494GKHyOGwQTHhKQ1hbWiu/81qkO0OWIyx+p
        yu8Jo7xPXMU/Ozxd9CJTjBJLo
X-Received: by 2002:a17:906:6b82:: with SMTP id l2mr8531570ejr.241.1606495734933;
        Fri, 27 Nov 2020 08:48:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzJUDCnzieJYN1ooH1FMZWePLUiObAU18Z7hCPD7yuVFtkt12b8hACer7ziwEvurg6/0HZMEQ==
X-Received: by 2002:a17:906:6b82:: with SMTP id l2mr8531363ejr.241.1606495732591;
        Fri, 27 Nov 2020 08:48:52 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b20sm557564eja.30.2020.11.27.08.48.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2020 08:48:51 -0800 (PST)
Subject: Re: [PATCH] kvm/x86/mmu: use the correct inherited permissions to get
 shadow page
To:     Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Avi Kivity <avi@qumranet.com>, linux-doc@vger.kernel.org
References: <20201120095517.19211-1-jiangshanlai@gmail.com>
 <20201126000549.GC450871@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0724aeb9-3466-5505-8f12-a5899144e68f@redhat.com>
Date:   Fri, 27 Nov 2020 17:48:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201126000549.GC450871@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/11/20 01:05, Sean Christopherson wrote:
> On Fri, Nov 20, 2020, Lai Jiangshan wrote:
>> From: Lai Jiangshan <laijs@linux.alibaba.com>
>>
>> Commit 41074d07c78b ("KVM: MMU: Fix inherited permissions for emulated
>> guest pte updates") said role.access is common access permissions for
>> all ptes in this shadow page, which is the inherited permissions from
>> the parent ptes.
>>
>> But the commit did not enforce this definition when kvm_mmu_get_page()
>> is called in FNAME(fetch). Rather, it uses a random (last level pte's
>> combined) access permissions.
> 
> I wouldn't say it's random, the issue is specifically that all shadow pages end
> up using the combined set of permissions of the entire walk, as opposed to the
> only combined permissions of its parents.
> 
>> And the permissions won't be checked again in next FNAME(fetch) since the
>> spte is present. It might fail to meet guest's expectation when guest sets up
>> spaghetti pagetables.
> 
> Can you provide details on the exact failure scenario?  It would be very helpful
> for documentation and understanding.  I can see how using the full combined
> permissions will cause weirdness for upper level SPs in kvm_mmu_get_page(), but
> I'm struggling to connect the dots to understand how that will cause incorrect
> behavior for the guest.  AFAICT, outside of the SP cache, KVM only consumes
> role.access for the final/last SP.
> 

Agreed, a unit test would be even better, but just a description in the 
commit message would be enough.

Paolo

