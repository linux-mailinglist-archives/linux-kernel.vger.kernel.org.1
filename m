Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53E3027958D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgIZAYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:24:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48192 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726316AbgIZAYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:24:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601079859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HTbkQv9ToVq5Nb6qFL5vX3aJCuo5OQrcsX4p0Kd2ypk=;
        b=cl5spbH2TY+igwtvhj1hzAqGXSwezIklOFUA1rwAywXaDK6a2MeSOz5na4h3LiObnt0/Fs
        04tGMSbWKi8mm3MWaAFdjt2F2ulo5iI5y9V94pWbboJVWKKoyfDAYfweD9C8uE+ZKY7uZh
        B+cVGRFCRnw/1Uz0p/6x7YsbGxGqli8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-drhDz9LPPZmF2FdyCRQpYw-1; Fri, 25 Sep 2020 20:24:18 -0400
X-MC-Unique: drhDz9LPPZmF2FdyCRQpYw-1
Received: by mail-wr1-f70.google.com with SMTP id w7so1740790wrp.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HTbkQv9ToVq5Nb6qFL5vX3aJCuo5OQrcsX4p0Kd2ypk=;
        b=SWDOZvZf/54og55idWu9FBHC9VypEgSaJXYUJ3IgqPzj3oTCxMKLUIcweuz0YuRsoY
         PPpp87Hp37uYBhI7ZJq4n7cxTbFWzzvN55zSyVcTbrZBNZ9kACAjJhGpoZ+qY4++RzSM
         lxOR5/6T0CyTMk34bWt/dO3ytDOv0/jG+7Nga2Z8CdXZfkvKhT8yPSOquk404Y2UfBgY
         bV90tCx+QQqud2R7Fw1lDpcJBe2HWpgSgsL9Eo/Q0YqoQGM7cfGtknaTeH8w0YrOrxaa
         tI10kmQlK/niLdrLnMgkC/pNK7i2pkCbLlgT+rMYwZ8HkJretohXxcdjUQGb4RK6VHw5
         aKgQ==
X-Gm-Message-State: AOAM530xUB4IJ1B8GR5fs0Yy9i0O81wJS4f7t/bkaZoBk3CPRFjF+jOm
        a7HlpVwbtFqzP+RD1EVAhb8vS4AHnyD0ubenwWOVUHxdqtSSd6XfN7gIvjPiJAGZciyzGvCf8S9
        tz0hzKfMVtm7j+yPKtCEZ1d+K
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr6906346wrs.405.1601079856917;
        Fri, 25 Sep 2020 17:24:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwXnUXGGJV/FfFaMovV4aazM0LgdoYGaagCmq82JGdB2BpZ0AjjUYLskKwTQb+5bScCk/oUSA==
X-Received: by 2002:adf:ffc7:: with SMTP id x7mr6906333wrs.405.1601079856737;
        Fri, 25 Sep 2020 17:24:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id n21sm660473wmi.21.2020.09.25.17.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 17:24:16 -0700 (PDT)
Subject: Re: [PATCH 10/22] kvm: mmu: Add TDP MMU PF handler
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Peter Feiner <pfeiner@google.com>,
        Junaid Shahid <junaids@google.com>,
        Jim Mattson <jmattson@google.com>,
        Yulei Zhang <yulei.kernel@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20200925212302.3979661-1-bgardon@google.com>
 <20200925212302.3979661-11-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <91269bc5-ddef-9ede-774a-9a07d4ceb675@redhat.com>
Date:   Sat, 26 Sep 2020 02:24:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-11-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:22, Ben Gardon wrote:
>  
> -static bool is_nx_huge_page_enabled(void)
> +bool is_nx_huge_page_enabled(void)
>  {
>  	return READ_ONCE(nx_huge_pages);
>  }
> @@ -381,7 +361,7 @@ static inline u64 spte_shadow_dirty_mask(u64 spte)
>  	return spte_ad_enabled(spte) ? shadow_dirty_mask : 0;
>  }
>  
> -static inline bool is_access_track_spte(u64 spte)
> +inline bool is_access_track_spte(u64 spte)
>  {
>  	return !spte_ad_enabled(spte) && (spte & shadow_acc_track_mask) == 0;
>  }
> @@ -433,7 +413,7 @@ static u64 get_mmio_spte_generation(u64 spte)
>  	return gen;
>  }
>  
> -static u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
> +u64 make_mmio_spte(struct kvm_vcpu *vcpu, u64 gfn, unsigned int access)
>  {
>  
>  	u64 gen = kvm_vcpu_memslots(vcpu)->generation & MMIO_SPTE_GEN_MASK;
> @@ -613,7 +593,7 @@ int is_shadow_present_pte(u64 pte)
>  	return (pte != 0) && !is_mmio_spte(pte);
>  }
>  
> -static int is_large_pte(u64 pte)
> +int is_large_pte(u64 pte)
>  {
>  	return pte & PT_PAGE_SIZE_MASK;
>  }

All candidates for inlining too

(Also probably we'll create a common.c file for stuff that is common to
the shadow and TDP MMU, but that can come later).

Paolo

