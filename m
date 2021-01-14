Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FA92F6F30
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 01:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbhANX70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 18:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731056AbhANX7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 18:59:25 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9128EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 15:58:45 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id be12so3760216plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 15:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Nvc3IiVsp1txtwU1w62SIZO9MP6aDBCxGAMOxwFlnfU=;
        b=H7nzFgoD0mmZjC3G98NJ258zxdOB4jQUx4WZeToA057UC7qaekindB4sM8jX+Y1oEl
         QGti5hPv1oA8iNHAOK2sp8TMWpMHyEjXvJjyNtfxBnWu0wIPGlctClYj9kgCW1yZlldb
         e+/Hs1Ji1KMtFSFo6t3FrGZVICol56ot6OE+zthMFkMElc13Ijd0dgMWhPDCSk2jCzVR
         5EsunfSh6ZH0Txhw2m4PvHQwA0xIj2Ivg3HU6wAzPqnKH2v4YxIQglIWxriNsEuhoRSu
         jTluatQOg7eYnkLfj3C2+wKHUqpTHKhRXCJ310FSG6QfH9FNr2Wbn+DzHDIgx/71ZYHl
         petw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Nvc3IiVsp1txtwU1w62SIZO9MP6aDBCxGAMOxwFlnfU=;
        b=uhlp2yhZsGYPRcjNbAus86R9R8z4brLYeYIntvslJMdND7P4srYMqE4QBPmvfVDZUX
         KnLWXrbsWvUiBsW5+gNYSY+gqY3R4y5SyIB/YHHWp5BjYVQm9Y/HVmzmsCx6bq7pSBc1
         h8EEUgOVfGR1ycyihEFMCCC8VXrEKvUl/5MRj93AVVYjXpm7D1xOeQOXeLcMkCai/BCZ
         GHRa6qL1Fw1dJEfP1NMuyZbo0xz903pGKgiC2K60PUR8JSVgbLCYGx5OL0bCumAVT+Pq
         owH2JNIl4zcisUkJB3Xs4Bnf+LbkfP/oS7+H7nDB7DZSmAQtW7m3JmMQxteIM8vAfi/g
         TbMw==
X-Gm-Message-State: AOAM5333Dw6SuPwRiHm1GwOQonRDV63X5Ve+PvraSCHd62/L8LEJTI3Q
        arzMh1JyAgIXfDAY2qzhUss0ww==
X-Google-Smtp-Source: ABdhPJzFHsi9Kv8DysKPjSpNxctiO1nz5yAe/V4FeI1lp/9eO+PQMeZV6DvVBkNf6U3Z5fBtrsJaMg==
X-Received: by 2002:a17:902:6b89:b029:da:fc41:baec with SMTP id p9-20020a1709026b89b02900dafc41baecmr10011317plk.39.1610668724942;
        Thu, 14 Jan 2021 15:58:44 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id z23sm5926576pfn.202.2021.01.14.15.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:58:44 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:58:37 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v2 1/3] KVM: nVMX: Always call sync_vmcs02_to_vmcs12_rare
 on migration
Message-ID: <YADarUMsE9uDKxOe@google.com>
References: <20210114205449.8715-1-mlevitsk@redhat.com>
 <20210114205449.8715-2-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210114205449.8715-2-mlevitsk@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject is confusing, and technically wrong.  Confusing because there is no call
to sync_vmcs02_to_vmcs12_rare().  Technically wrong because sync_...() won't be
called if need_sync_vmcs02_to_vmcs12_rare==false.

Maybe something like?

KVM: nVMX: Sync unsync'd vmcs02 state to vmcs12 on migration

On Thu, Jan 14, 2021, Maxim Levitsky wrote:
> Even when we are outside the nested guest, some vmcs02 fields
> are not in sync vs vmcs12.

s/are not/may not be

It'd be helpful to provide more details in the changelog, e.g. for those not in
the loop, it's not obvious that KVM intentionally keeps those fields unsync'd,
even across nested VM-Exit.

> However during the migration, the vmcs12 has to be up to date
> to be able to load it later after the migration.
> 
> To fix that, call that function.

s/that function/copy_vmcs02_to_vmcs12_rare().  Characters are cheap, and it's
jarring to have to jump back all the way back to the subject.  And, as mentioned
above, this doesn't actually call sync_ directly.

For the code,

Reviewed-by: Sean Christopherson <seanjc@google.com> 

> 
> Fixes: 7952d769c29ca ("KVM: nVMX: Sync rarely accessed guest fields only when needed")
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 0fbb46990dfce..776688f9d1017 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -6077,11 +6077,14 @@ static int vmx_get_nested_state(struct kvm_vcpu *vcpu,
>  	if (is_guest_mode(vcpu)) {
>  		sync_vmcs02_to_vmcs12(vcpu, vmcs12);
>  		sync_vmcs02_to_vmcs12_rare(vcpu, vmcs12);
> -	} else if (!vmx->nested.need_vmcs12_to_shadow_sync) {
> -		if (vmx->nested.hv_evmcs)
> -			copy_enlightened_to_vmcs12(vmx);
> -		else if (enable_shadow_vmcs)
> -			copy_shadow_to_vmcs12(vmx);
> +	} else  {
> +		copy_vmcs02_to_vmcs12_rare(vcpu, get_vmcs12(vcpu));
> +		if (!vmx->nested.need_vmcs12_to_shadow_sync) {
> +			if (vmx->nested.hv_evmcs)
> +				copy_enlightened_to_vmcs12(vmx);
> +			else if (enable_shadow_vmcs)
> +				copy_shadow_to_vmcs12(vmx);
> +		}
>  	}
>  
>  	BUILD_BUG_ON(sizeof(user_vmx_nested_state->vmcs12) < VMCS12_SIZE);
> -- 
> 2.26.2
> 
