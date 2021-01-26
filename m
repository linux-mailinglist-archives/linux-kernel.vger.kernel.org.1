Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31314304F93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 04:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235146AbhA0DPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 22:15:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36433 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405277AbhAZUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 15:07:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611691562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fm6++ANnZe9IDQ9KscAGZIuA0pCFUfZXiHtKeS4n2T4=;
        b=ParpJVrMDmHZNoiikMyaPO59XnatkBlYzCxVlLiaIZTeZ8ay0rLqJ5b6acwg9q1ucw6rHw
        d4imeNXtnsWAwRRGdO+2JlqnoxqClk+kjast/E4xoYF2UIs6EqRkab9jCyt/JjOPylMSzE
        Vyu4uCICJiq0T7LyebfhZ9cBB/UIKq0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227--DcsH3luPoGIOGkqxRUBrw-1; Tue, 26 Jan 2021 15:06:00 -0500
X-MC-Unique: -DcsH3luPoGIOGkqxRUBrw-1
Received: by mail-ej1-f69.google.com with SMTP id n25so5127008ejd.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 12:05:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fm6++ANnZe9IDQ9KscAGZIuA0pCFUfZXiHtKeS4n2T4=;
        b=QHO9r8ZKfCkJBFVfPLACkSVIhuBE2V1MEbbm+xf6NL81bgnI4QR/TWYSrpX/4wqBjp
         IyfO3JUr2vDxjGrZa8x33RM0sizn4NxJ1jSe7DcVZALb93gSE2TrhWFQmfUnD3NYijrX
         B/O3UoSEVaeqtO4wtx0MwMIHVuwVJy2C57cj40SapcZQfMDQJdNK48Jp5f//UWUuZoKv
         a0dqYsffKh9+9I5f6IPIGJj1fT52uIT3UjH4/B/VBha9BKuj2MGjFS65t7n19iraGJn3
         8qEpidFgK/oNqRvQhHYKwi5eUJ7FswMRSmquKU+fZWVbK4UQVU68+W4f/Xtzz8aIg+5t
         VxFg==
X-Gm-Message-State: AOAM530ujfKHGDkoMHnYmK7GQDiZQn2iutSOpZpJKW6yFaxMqUqsQ7gH
        zS1gUfBV68MjcslgIrpuilPjXPkTX0qCo7T6l3qAc+x3FAjWl0ICUdNWU4bxFCujALvkZwkAVyy
        XNd12fhXUVYNoWOxOdlSIZXh4qwF7wEH1OcNqfWL0lR3YzdlgkT6FIW2uoaIyMfwr+qNqWnB+Mt
        px
X-Received: by 2002:aa7:d0d4:: with SMTP id u20mr5619190edo.203.1611691558410;
        Tue, 26 Jan 2021 12:05:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyBEhTyu8DhAS9s2x0+O49a/nKL+15oROg7kqWOc36XP1JWY1jrOPOKIWUaxI0eA6I6ObZsZw==
X-Received: by 2002:aa7:d0d4:: with SMTP id u20mr5619170edo.203.1611691558136;
        Tue, 26 Jan 2021 12:05:58 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id gb13sm7076891ejc.81.2021.01.26.12.05.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jan 2021 12:05:56 -0800 (PST)
Subject: Re: [RFC 6/7] KVM: X86: Expose PKS to guest and userspace
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200807084841.7112-1-chenyi.qiang@intel.com>
 <20200807084841.7112-7-chenyi.qiang@intel.com>
 <CALMp9eQ=QUZ04_26eXBGHqvQYnsN6JEgiV=ZSSrE395KLX-atA@mail.gmail.com>
 <20200930043634.GA29319@linux.intel.com>
 <c8f39e4e-75e1-8089-f8ef-9931ce14339f@redhat.com>
 <YBB0AT6xfObR7A5l@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c87cd73-82c4-f849-5223-6b6e3a4e5adc@redhat.com>
Date:   Tue, 26 Jan 2021 21:05:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YBB0AT6xfObR7A5l@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/21 20:56, Sean Christopherson wrote:
>>> It does belong in the mmu_role_bits though;-)
>>
>> Does it?  We don't support PKU/PKS for shadow paging, and it's always zero
>> for EPT.  We only support enough PKU/PKS for emulation.
>
> As proposed, yes. The PKU/PKS mask is tracked on a per-mmu basis, e.g. 
> computed in update_pkr_bitmask() and consumed in permission_fault() 
> during emulation. Omitting CR4.PKS from the extended role could let KVM 
> reuse an MMU with the wrong pkr_mask.

Right, not for the hash table key but for reuse.

> IIUC, the logic is PKU|PKS, with pkr_mask generation being PKU vs. PKS agnostic.

Not in the patches as submitted, but it's what I suggested indeed (using 
one bit of the PFEC to pick one of CR4.PKE and CR4.PKS).

> Another option would be to move the tracking out of the MMU, e.g. make pkr_mask
> per-vCPU and recalculate when CR4 changes.  I think that would "just work", even
> when nested VMs are in play?

Yeah, pkr_mask is basically one of four constants (depending on CR4.PKE 
and CR4.PKS) so recalculating when CR4 changes would work too.  But I'm 
okay with doing that later, too.

Paolo

