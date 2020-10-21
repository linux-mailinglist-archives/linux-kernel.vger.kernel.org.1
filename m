Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 025DC294C40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440036AbgJUMIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59111 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406204AbgJUMIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603282115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JSRIhOa2ZboDQdRZ4wZoNo9M9MMQM9K6TVUIYNZpopo=;
        b=JzOMxz83TVkOpZCdEeCBdsE58BsR/EkqA4VFXAIGRTt4BEjl4fh4C7OQpM+z64OCCAh0KR
        IgyO4qxbt0By0cpXClZJVD/FvPHvpe1amZIJ38Pib7mOJIbFN9mF1wGAMKQMlPUWeo6tga
        hLxqjC7jc3nXFyxvcawIENnc1hqXU2Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-428-8F4iwGlQOAW5i3A3NhFYvQ-1; Wed, 21 Oct 2020 08:08:33 -0400
X-MC-Unique: 8F4iwGlQOAW5i3A3NhFYvQ-1
Received: by mail-wr1-f70.google.com with SMTP id 33so2355360wrf.22
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 05:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JSRIhOa2ZboDQdRZ4wZoNo9M9MMQM9K6TVUIYNZpopo=;
        b=rZwT9rEws7wZpsBDMiGfjJ/aFsdGqT3gKkf/zsnJj89NXabFi+U17UosSUM7QwXgtW
         F4/ip9HHm/Rt7lx/4/EPqWaPSIevCmuDZGcgQuswIahb0RHzbOWmmyxWQ2hngXpXWrLa
         bk5VFk9VlGO7WTCXHMGDnK0UXmimKYCmr9HrkYmXwYRFomU4ERj9EpionG1cJ58Bofsi
         rDH50P6PVi2+PERuZ+93pvGgI1BsK/dHGQGOZUMUv785BwkPP8zFsDBRxZ1X0wgXkZ6k
         nESRaDMZppOpeMDtkGWMjzclLHRFHIntnfY48p/muR+ZINw9l9XBVzM51FYZT+tNAEmp
         RKqg==
X-Gm-Message-State: AOAM533wTgUNjXTOzz/sUsGjbHTxaWJG6+IRUBnXlZXHU/icKv846Ipq
        tT9E4rIyxqR26PuHYcLIhVgmkwxLkozEUuODfYLWijdlfrqpBL4mgwe3sLXHqGX+4AB2NE49Ezb
        f+b8lLU56owgwixenXnFiSDmA
X-Received: by 2002:adf:bb07:: with SMTP id r7mr4655719wrg.150.1603282112106;
        Wed, 21 Oct 2020 05:08:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyIR6bSM2D0fd0B1XmtAvNAMAmeNT8HwaO9i0Blwri6gPmOW2YLQWRfTbK6wrZIdBprVA+r0w==
X-Received: by 2002:adf:bb07:: with SMTP id r7mr4655696wrg.150.1603282111899;
        Wed, 21 Oct 2020 05:08:31 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id s1sm3052094wmh.22.2020.10.21.05.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 05:08:30 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] KVM: VMX: Fold Hyper-V EPTP checking into it's only caller
In-Reply-To: <20201020215613.8972-4-sean.j.christopherson@intel.com>
References: <20201020215613.8972-1-sean.j.christopherson@intel.com> <20201020215613.8972-4-sean.j.christopherson@intel.com>
Date:   Wed, 21 Oct 2020 14:08:29 +0200
Message-ID: <8736276ate.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Fold check_ept_pointer_match() into hv_remote_flush_tlb_with_range() in
> preparation for combining the kvm_for_each_vcpu loops of the ==CHECK and
> !=MATCH statements.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 42 +++++++++++++++++++-----------------------
>  1 file changed, 19 insertions(+), 23 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 6d41c99c70c4..bba6d91f1fe1 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -469,27 +469,6 @@ static const u32 vmx_uret_msrs_list[] = {
>  static bool __read_mostly enlightened_vmcs = true;
>  module_param(enlightened_vmcs, bool, 0444);
>  
> -/* check_ept_pointer() should be under protection of ept_pointer_lock. */
> -static void check_ept_pointer_match(struct kvm *kvm)
> -{
> -	struct kvm_vcpu *vcpu;
> -	u64 tmp_eptp = INVALID_PAGE;
> -	int i;
> -
> -	kvm_for_each_vcpu(i, vcpu, kvm) {
> -		if (!VALID_PAGE(tmp_eptp)) {
> -			tmp_eptp = to_vmx(vcpu)->ept_pointer;
> -		} else if (tmp_eptp != to_vmx(vcpu)->ept_pointer) {
> -			to_kvm_vmx(kvm)->ept_pointers_match
> -				= EPT_POINTERS_MISMATCH;
> -			return;
> -		}
> -	}
> -
> -	to_kvm_vmx(kvm)->hv_tlb_eptp = tmp_eptp;
> -	to_kvm_vmx(kvm)->ept_pointers_match = EPT_POINTERS_MATCH;
> -}
> -
>  static int kvm_fill_hv_flush_list_func(struct hv_guest_mapping_flush_list *flush,
>  		void *data)
>  {
> @@ -519,11 +498,28 @@ static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
>  	struct kvm_vmx *kvm_vmx = to_kvm_vmx(kvm);
>  	struct kvm_vcpu *vcpu;
>  	int ret = 0, i;
> +	u64 tmp_eptp;
>  
>  	spin_lock(&kvm_vmx->ept_pointer_lock);
>  
> -	if (kvm_vmx->ept_pointers_match == EPT_POINTERS_CHECK)
> -		check_ept_pointer_match(kvm);
> +	if (kvm_vmx->ept_pointers_match == EPT_POINTERS_CHECK) {
> +		kvm_vmx->ept_pointers_match = EPT_POINTERS_MATCH;
> +		kvm_vmx->hv_tlb_eptp = INVALID_PAGE;
> +
> +		kvm_for_each_vcpu(i, vcpu, kvm) {
> +			tmp_eptp = to_vmx(vcpu)->ept_pointer;
> +			if (!VALID_PAGE(tmp_eptp))
> +				continue;
> +
> +			if (!VALID_PAGE(kvm_vmx->hv_tlb_eptp)) {
> +				kvm_vmx->hv_tlb_eptp = tmp_eptp;
> +			} else if (kvm_vmx->hv_tlb_eptp != tmp_eptp) {
> +				kvm_vmx->ept_pointers_match
> +					= EPT_POINTERS_MISMATCH;
> +				break;

Actually no (scratch my comment on PATCH1), in case pointers differ
kvm_vmx->hv_tlb_eptp remains set to the last matched EPTP. This likely
doesn't matter as we're not going to use it but maybe sacrificing couple
instructions and resetting it here to INVALID_PAGE (or actually setting
it only in case of EPT_POINTERS_MATCH after the loop)?

> +			}
> +		}
> +	}
>  
>  	if (kvm_vmx->ept_pointers_match != EPT_POINTERS_MATCH) {
>  		kvm_for_each_vcpu(i, vcpu, kvm) {

-- 
Vitaly

