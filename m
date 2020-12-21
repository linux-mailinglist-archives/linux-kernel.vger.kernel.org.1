Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B642DFFBD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgLUS22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbgLUS22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:28:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608575221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rS/dYtI//F4K7bV0mJuUUzS3DlkOae1kX99K/3SIHlU=;
        b=Nbugh5KYuKONRMMEdLZCAE/4b6c3m+7yRiycFPmmQ9zpnCnyFDlq5slF6T2EhPND2cOxet
        O+p+GHTNRRWvuUyrUYu17UjB7bUpSxrgys2/dVSfrZkh+LKV6+kfcAOimHV3HDVpkoQNAo
        C5cfgfvAIkQe0zrDRDtODE16j0JY+WQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-W_a99pzTPYOkMfezbxxXqg-1; Mon, 21 Dec 2020 13:26:58 -0500
X-MC-Unique: W_a99pzTPYOkMfezbxxXqg-1
Received: by mail-wm1-f69.google.com with SMTP id s130so7926205wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:26:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rS/dYtI//F4K7bV0mJuUUzS3DlkOae1kX99K/3SIHlU=;
        b=qwrYaIKeOhfVUG84kCtJIGZX61/WjnYESYICRqjLPSIIGiH/gwdUTvPGNvNGdP3lF5
         DtlzlwA6uJ59tSc+MIK/CCm84XzxF+gZ6oFRq5oSEwysaBjP2pXyUobgNSwZ+EEyZ4JN
         uRel4PKD7IllkpiyCTcpLwkeV522OG0Nh2k8QyiIRL6MUsBJWz3ymDqY6pidabp1cMoh
         ADn39sbBybzNlu43tDqEEjFrgAIfgTib6jwv4xz0Pqr+0musEbzqVmIELLuCCfhXK8qQ
         jAopmgXTFLD9GOk/wsCIbJ0jB1X6VOUc07LTlKHmQzSdwz4emKIj985YFCPeddm1Gzaw
         VLVQ==
X-Gm-Message-State: AOAM530jRV8vHctYa6bYYVf0te9s9d5E+qaaRUVQ2I1cY06h+dwudmlJ
        /X6TqGTLvppeVtOXy3qaiHcb1eQLpJChhsjwisaQqevg0iBaMLWMVdQyaCPyf9Idv40uyZZkImY
        nJQVGHXIbTkCuwK12hrbpuj0r
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr18090018wme.182.1608575217040;
        Mon, 21 Dec 2020 10:26:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyMZhfQHOfHnX7nor0CK0K7VmN4wDmsJ9iebYUBKXuakLExeUShKYQ6snFKiTzD8em8boHFLw==
X-Received: by 2002:a05:600c:2188:: with SMTP id e8mr18090012wme.182.1608575216887;
        Mon, 21 Dec 2020 10:26:56 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id y7sm24487637wmb.37.2020.12.21.10.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Dec 2020 10:26:56 -0800 (PST)
Subject: Re: [PATCH 0/4] KVM: x86/mmu: Bug fixes and cleanups in
 get_mmio_spte()
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Richard Herbert <rherbert@sympatico.ca>
References: <20201218003139.2167891-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c706666a-3ef1-d4dc-bb3b-054867a80490@redhat.com>
Date:   Mon, 21 Dec 2020 19:26:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201218003139.2167891-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/20 01:31, Sean Christopherson wrote:
> Two fixes for bugs that were introduced along with the TDP MMU (though I
> strongly suspect only the one reported by Richard, fixed in patch 2/4, is
> hittable in practice).  Two additional cleanup on top to try and make the
> code a bit more readable and shave a few cycles.
> 
> Sean Christopherson (4):
>    KVM: x86/mmu: Use -1 to flag an undefined spte in get_mmio_spte()
>    KVM: x86/mmu: Get root level from walkers when retrieving MMIO SPTE
>    KVM: x86/mmu: Use raw level to index into MMIO walks' sptes array
>    KVM: x86/mmu: Optimize not-present/MMIO SPTE check in get_mmio_spte()
> 
>   arch/x86/kvm/mmu/mmu.c     | 53 +++++++++++++++++++++-----------------
>   arch/x86/kvm/mmu/tdp_mmu.c |  9 ++++---
>   arch/x86/kvm/mmu/tdp_mmu.h |  4 ++-
>   3 files changed, 39 insertions(+), 27 deletions(-)
> 

Queued, thanks (and thanks for Ccing stable on the first two already :)).

Paolo

