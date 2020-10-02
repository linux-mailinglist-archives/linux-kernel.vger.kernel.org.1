Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 026D1280BDE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 03:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgJBBLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 21:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39046 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387430AbgJBBLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 21:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601601103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+fBTIK+DtEuLGceBYVu0Ja9YuYZ6ey8BaC6axIqLZaQ=;
        b=MyZP5512iG28+EdU3Lxbujo9u+37Gc/NhG2ghGaV0F77w6eaQGBKo66sF57bqNVuAu34LG
        EbA/sS6aBRCR1DXPcsJRvj7l2TlRTs8cjrvhqykxSvc4VZ4eUEn9mGlujqmAW0YstbHbP+
        jeGUFtZMPSM/yAgJlvOHRdfZiIfE7GA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-158-phDULCNTM_qwAJ7tGZyzCQ-1; Thu, 01 Oct 2020 21:11:41 -0400
X-MC-Unique: phDULCNTM_qwAJ7tGZyzCQ-1
Received: by mail-qv1-f71.google.com with SMTP id 99so417988qva.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 18:11:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+fBTIK+DtEuLGceBYVu0Ja9YuYZ6ey8BaC6axIqLZaQ=;
        b=p0zji+2VjvWCoDJkIFu7ZBcwDoQmkvCa5azF+7cqoXLF/NEnYOmcYMzm4sCwLIwMs4
         bXzDvYllfsLxsbWgbVtWTqSCvzfmmksjElxggkbF2ZgmuOxSSsNjCP2EK4l8l+YBHuGL
         zUi/gfKWqvp+fEN3k12W5ppKuDl2u1OA+PN00g8NyxLoQphqTYyRj6XpyeyLn5pEV2Cz
         ujMbyUlzF0hpPKaJyX0JuIBxjtBf2eUK3BINtORKisKl98ibfX8YgIwn11+Bu8Bnqz7E
         5riGrJNY9w7bMEUUxy7pdpr0wQA+yb4yDkJKwyC0aHie1TycKRoDU/yJdekPJangXAUY
         dXTA==
X-Gm-Message-State: AOAM532Py1aTDYAiE9amIqpYweQHHCjy8yFEXq5DfE8biS5OZZQKqFaj
        4174hcOYgLM7QVVDgcJ2tvQhqLaVvPQDteDyZ07qJVFg/XAi6xwclgZbKL0Htp4CEfb5OLTHBKg
        vlx/ICDuOzecW2i8f+poMjvMn
X-Received: by 2002:a0c:efd2:: with SMTP id a18mr10770490qvt.54.1601601101516;
        Thu, 01 Oct 2020 18:11:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyHEAxmtXCBaCsYbMz7AQ6TzrqnNZn2V2MZfMf+fvEL2o95uluK/32VhnLH6xFRTh25U45PHw==
X-Received: by 2002:a0c:efd2:: with SMTP id a18mr10770468qvt.54.1601601101244;
        Thu, 01 Oct 2020 18:11:41 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca. [184.147.14.204])
        by smtp.gmail.com with ESMTPSA id f24sm48984qka.5.2020.10.01.18.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 18:11:40 -0700 (PDT)
Date:   Thu, 1 Oct 2020 21:11:39 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alexander Graf <graf@amazon.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        KarimAllah Raslan <karahmed@amazon.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 6/8] KVM: x86: VMX: Prevent MSR passthrough when MSR
 access is denied
Message-ID: <20201002011139.GA5473@xz-x1>
References: <20200925143422.21718-1-graf@amazon.com>
 <20200925143422.21718-7-graf@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200925143422.21718-7-graf@amazon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I reported in the v13 cover letter of kvm dirty ring series that this patch
seems to have been broken.  Today I tried to reproduce with a simplest vm, and
after a closer look...

On Fri, Sep 25, 2020 at 04:34:20PM +0200, Alexander Graf wrote:
> @@ -3764,15 +3859,14 @@ static u8 vmx_msr_bitmap_mode(struct kvm_vcpu *vcpu)
>  	return mode;
>  }
>  
> -static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu,
> -					 unsigned long *msr_bitmap, u8 mode)
> +static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu, u8 mode)
>  {
>  	int msr;
>  
> -	for (msr = 0x800; msr <= 0x8ff; msr += BITS_PER_LONG) {
> -		unsigned word = msr / BITS_PER_LONG;
> -		msr_bitmap[word] = (mode & MSR_BITMAP_MODE_X2APIC_APICV) ? 0 : ~0;
> -		msr_bitmap[word + (0x800 / sizeof(long))] = ~0;
> +	for (msr = 0x800; msr <= 0x8ff; msr++) {
> +		bool intercepted = !!(mode & MSR_BITMAP_MODE_X2APIC_APICV);
> +
> +		vmx_set_intercept_for_msr(vcpu, msr, MSR_TYPE_RW, intercepted);
>  	}
>  
>  	if (mode & MSR_BITMAP_MODE_X2APIC) {

... I think we may want below change to be squashed:

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d160aad59697..7d3f2815b04d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3781,9 +3781,10 @@ static void vmx_update_msr_bitmap_x2apic(struct kvm_vcpu *vcpu, u8 mode)
        int msr;
 
        for (msr = 0x800; msr <= 0x8ff; msr++) {
-               bool intercepted = !!(mode & MSR_BITMAP_MODE_X2APIC_APICV);
+               bool apicv = mode & MSR_BITMAP_MODE_X2APIC_APICV;
 
-               vmx_set_intercept_for_msr(vcpu, msr, MSR_TYPE_RW, intercepted);
+               vmx_set_intercept_for_msr(vcpu, msr, MSR_TYPE_R, !apicv);
+               vmx_set_intercept_for_msr(vcpu, msr, MSR_TYPE_W, true);
        }
 
        if (mode & MSR_BITMAP_MODE_X2APIC) {

This fixes my problem the same as having this patch reverted.

-- 
Peter Xu

