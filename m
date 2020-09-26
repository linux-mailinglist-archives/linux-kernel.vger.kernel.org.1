Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC612279598
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729743AbgIZAc2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28208 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726149AbgIZAc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:32:27 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601080345;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GGED/SP06qDpxxhBcwD9SA9XdIHBfiiFTtiKfufvWL0=;
        b=BXZ+34knyRjcZXAZngZO8TOGJtgxjgXRy2/LCLaXh/Wc4up9pX3kANhZrZQoMaZweAsokZ
        61/1BMD3z8sdYRsn9xpmbtQ94BkhZwI0uokEu2IMDAoOyvSwY9q3NgPApejI0V+Aj1Bv8H
        KKK4FFge/sifGe1ZzlulZ222Lm7Txec=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-MSJ_AflNMrqJi474CI16hQ-1; Fri, 25 Sep 2020 20:32:21 -0400
X-MC-Unique: MSJ_AflNMrqJi474CI16hQ-1
Received: by mail-wr1-f71.google.com with SMTP id v12so1737125wrm.9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:32:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GGED/SP06qDpxxhBcwD9SA9XdIHBfiiFTtiKfufvWL0=;
        b=jFccjVil/XF99kcX5BQ3sLZVJbX82EZfC5qlREsKAA2wVc5pBf0Zg2FwSoO+gZJJXf
         IPp56Cn684WRi98iPoeLgJCTlOfujpGTk1v5T4xgJ+Pz1luVp3dk7lYO0P2biLMSwtXa
         w13QN07Vxb1aOTjzYdNrypK+CwWtjxBGkDCHeaIFCRuZpOofCb3k4tHHbCh0Nk/BVUnH
         SkqdoN7oOPfXQdDcvlrs2tVuDS0saqQwwZVvtFgpKUnKXmPECBNpmAaR6r3n8xtgyWr0
         K5yKLSTj5pmGdsr2RRp8N7Ze890YEHDnQTFDRDyWbP20U2aEsH0WNBCTeaH/AhVJwbpl
         aUsQ==
X-Gm-Message-State: AOAM531XRNV1Uo9sJgHBppOHjgLqVcQdnYTX/VlqO8m1jw+knugK84Ij
        rx61RdZIbo/MQdSFhCBus+jHWPTgoABHr9pC0+fHKH2s2WJOGJpX+HGj8jQn0uihrtpKAkFKwCD
        lNcux7GrDFCK07Mn8Fu6nIZ/c
X-Received: by 2002:a1c:7714:: with SMTP id t20mr144585wmi.55.1601080340505;
        Fri, 25 Sep 2020 17:32:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEvSQR1X+gcWu2eaDsj1njEoatXZVeek8n0YilAr8OsyMpskkzs898k3FWW0lDKy0KoCJplw==
X-Received: by 2002:a1c:7714:: with SMTP id t20mr144565wmi.55.1601080340270;
        Fri, 25 Sep 2020 17:32:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ec9b:111a:97e3:4baf? ([2001:b07:6468:f312:ec9b:111a:97e3:4baf])
        by smtp.gmail.com with ESMTPSA id h2sm4678148wrp.69.2020.09.25.17.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Sep 2020 17:32:19 -0700 (PDT)
Subject: Re: [PATCH 14/22] kvm: mmu: Add access tracking for tdp_mmu
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
 <20200925212302.3979661-15-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d7964716-8949-a4ac-93ce-a71f3aebbd12@redhat.com>
Date:   Sat, 26 Sep 2020 02:32:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200925212302.3979661-15-bgardon@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/20 23:22, Ben Gardon wrote:
> @@ -332,7 +331,7 @@ static inline bool kvm_vcpu_ad_need_write_protect(struct kvm_vcpu *vcpu)
>  	return vcpu->arch.mmu == &vcpu->arch.guest_mmu;
>  }
>  
> -static inline bool spte_ad_enabled(u64 spte)
> +inline bool spte_ad_enabled(u64 spte)
>  {
>  	MMU_WARN_ON(is_mmio_spte(spte));
>  	return (spte & SPTE_SPECIAL_MASK) != SPTE_AD_DISABLED_MASK;
> @@ -607,7 +606,7 @@ int is_last_spte(u64 pte, int level)
>  	return 0;
>  }
>  
> -static bool is_executable_pte(u64 spte)
> +bool is_executable_pte(u64 spte)
>  {
>  	return (spte & (shadow_x_mask | shadow_nx_mask)) == shadow_x_mask;
>  }
> @@ -791,7 +790,7 @@ static bool spte_has_volatile_bits(u64 spte)
>  	return false;
>  }
>  
> -static bool is_accessed_spte(u64 spte)
> +bool is_accessed_spte(u64 spte)
>  {
>  	u64 accessed_mask = spte_shadow_accessed_mask(spte);
>  
> @@ -941,7 +940,7 @@ static u64 mmu_spte_get_lockless(u64 *sptep)
>  	return __get_spte_lockless(sptep);
>  }
>  
> -static u64 mark_spte_for_access_track(u64 spte)
> +u64 mark_spte_for_access_track(u64 spte)
>  {
>  	if (spte_ad_enabled(spte))
>  		return spte & ~shadow_accessed_mask;

More candidates for inlining, of course.

Paolo

