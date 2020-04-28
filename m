Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0B701BC0E9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 16:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgD1OOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 10:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727104AbgD1OOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:14:34 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A323AC03C1AB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:14:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id t3so21926405qkg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YmG6e8PfiNmVhhdbXMVIOaZWVWR6olJeBRQ69y4M/14=;
        b=nh6Qpqd9QRGYZOrXjf/W936AyFxS8AyRj0FgCELzs85TWec2cVRazwamkciK/XdRYE
         Hu6lvZ+FwDwd9ZT4wmZy2rsp/XGbAhuFID9OqLfRBTBkd9pNNbCTx9osw9r9w4sD6S4h
         GpmVmsALHtzvIfsoXvX3cEn5PwWwFvJl1QEVQudPV3wDETh6ruXFPQzbO3uIKdVAq26j
         xpiDaafvdhD8n8ZuR4KlhW0kdGfUTpx6PTd/5tSwwicoEdwDd0j/qKRH0rOLrXOxeS9U
         efQu9EYCozGtTZCEAeOie7UAqO23Qryyz43rAAQXq38x+Wn3PgDE/wYQSDBD5N1C8WjK
         6pQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YmG6e8PfiNmVhhdbXMVIOaZWVWR6olJeBRQ69y4M/14=;
        b=TqNpXMJqoVUOJOeKr4Fg+zV3mZsQK5VcSyf3xfgpGTNAvpHoyFs2I7w33Nudppns6I
         cuimvtcQBOz44CSTKr7QpZfjVn5fYTxdNMRm756yJr5iqUTi5JdUqeALJQBThILgwtyx
         AVGi5cQLzxJw/Z6n0eEtRIiPg/IENIFHfSQNAfKL7C4jJvKiU5DilwtPvNrKjfMsd/FS
         YopIqD6Kk1FpdKWNrExhcS1a06kNBXM9ROJPRTSC1MRCw4nceAPZuU4INbMWpfVV45sD
         4fxr27xq+UwVEcFJ76kke2MBEb+2Mfcxw/LR2JolMXC9BUbxdSjPjoFO+6+P6WTNbCWK
         FvSw==
X-Gm-Message-State: AGi0PuYFNF6loDQ64SQpiOOTEdioQwmqDdinXiCqcydKO7+gAa353tzo
        KSzlzoapaUyZzcO90KG00FTBcPffHro=
X-Google-Smtp-Source: APiQypIOpiFNANzTvPctzvvDY2gG6uXAjSuNrdv5GAYwajOlR96Gh1jix1heX9RukZ5ogaHaqmOC7Q==
X-Received: by 2002:a37:6cc7:: with SMTP id h190mr27716937qkc.115.1588083271951;
        Tue, 28 Apr 2020 07:14:31 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id p4sm13509507qkg.48.2020.04.28.07.14.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 07:14:31 -0700 (PDT)
Subject: Re: [PATCH 0/3] KVM: x86/mmu: Use kernel's PG_LEVEL_* enums
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200428005422.4235-1-sean.j.christopherson@intel.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <a8dbc4c2-2594-2cff-8dfb-aabe6812b0f5@google.com>
Date:   Tue, 28 Apr 2020 10:14:30 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428005422.4235-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 8:54 PM, Sean Christopherson wrote:
> Drop KVM's PT_{PAGE_TABLE,DIRECTORY,PDPE}_LEVEL KVM enums in favor of the
> kernel's PG_LEVEL_{4K,2M,1G} enums, which have far more user friendly
> names.

thanks for doing this - it fell off my radar.

all 3:

Reviewed-by: Barret Rhoden <brho@google.com>

> 
> The KVM names were presumably intended to abstract away the page size.  In
> practice, the abstraction is only useful for a single line of code, a PSE
> paging related large page check.  For everything else, the abstract names
> do nothing but obfuscate the code.
> 
> Boot tested a PSE kernel under 32-bit KVM and 64-bit KVM, with and without
> EPT enabled.  Patches 2 and 3 generate no binary difference relative to
> patch 1 when compared via "objdump -d".
> 
> Sean Christopherson (3):
>    KVM: x86/mmu: Tweak PSE hugepage handling to avoid 2M vs 4M conundrum
>    KVM: x86/mmu: Move max hugepage level to a separate #define
>    KVM: x86/mmu: Drop KVM's hugepage enums in favor of the kernel's enums
> 
>   arch/x86/include/asm/kvm_host.h |  13 +---
>   arch/x86/kvm/mmu/mmu.c          | 118 +++++++++++++++-----------------
>   arch/x86/kvm/mmu/page_track.c   |   4 +-
>   arch/x86/kvm/mmu/paging_tmpl.h  |  18 ++---
>   arch/x86/kvm/mmu_audit.c        |   6 +-
>   arch/x86/kvm/svm/svm.c          |   2 +-
>   arch/x86/kvm/vmx/vmx.c          |   6 +-
>   arch/x86/kvm/x86.c              |   4 +-
>   8 files changed, 79 insertions(+), 92 deletions(-)
> 

