Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE942C49F4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgKYVd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:33:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730364AbgKYVdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:33:25 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BE9C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 13:33:25 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id n137so3578987pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 13:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9wOr1Z3d7SWlchBOy6uxh4z9+jZco6+UMrcMQHjYMTg=;
        b=t2inMCCIEc63pZVJi8AhgGStflyTI1sfa5pD0zhJLM1aOfwmUOMZnaQIFAtyakXOfZ
         iBa1tcN0wI2SzCbV7DKXgXOKUVpWAqmUiT9f3fftNj4OkBXpu8YIvfaNnUw2BjejIOqO
         EXLnqOuu4vadYoFhS+1qppZw8iyWJPnZprYHDzWkB+PiFdBu6MKgdR+s8fb+3W0nLqqP
         RzaXUtOGqZXImR75rRlETuWLuQrCj/+mOdkQ8NMaUDGaIufxA0cJlzdXRiXWFbkm87da
         qP7W9GLxi3+ZjYxTpg2dq/7YrEIhnQcXe4s796soMoUUIT3s4F4+MQ0939Dm49r8I5oY
         hfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9wOr1Z3d7SWlchBOy6uxh4z9+jZco6+UMrcMQHjYMTg=;
        b=kHZHNgW8ivVPLrfQe0gs9nxd/8/a2pA17rvjwSllRmcQsfMGmMrMkEUeD3vkgyuN2x
         xlqk1q9K0ZtrgwsZZCytHi6F3AQCSBPwuECH4gFx0/Oudh1T0M77aVZxqO+hl2HQVDK/
         TId/MKFKtXp8NXq2UzS1ETvtvvr1/OLTp1Y1M1/UPp3bbmM6XIYqiVHhoZmHiFnIguMp
         M+pmy8/3Aw+YRv9+slBpUfAUalG4xpEm2KZiVcjJ7zm8IrkLK5YuZbmgRKughYXTSPTp
         HxX+bAkWZ+efl8xNR80z6CUFoM1Hu1uCtZDfAAerIdKOLVSKwDwbGgL4/gv+gdCK4kGl
         xZRQ==
X-Gm-Message-State: AOAM530nXqUyT7tj3b16OELn2pqwRBAA3AO8osunQmdCgOucdVeIkCbh
        FZbClingmwUTlxfYcRSJHtqjsg==
X-Google-Smtp-Source: ABdhPJwelwPJ2/9ktxZ/fmdE6ZLyVDWLIV9fPYCcaVDkn78bhaY41J5Ywd394iAHQq5OTnX9qKTzYg==
X-Received: by 2002:a17:90a:65c9:: with SMTP id i9mr6528623pjs.125.1606340005132;
        Wed, 25 Nov 2020 13:33:25 -0800 (PST)
Received: from google.com (242.67.247.35.bc.googleusercontent.com. [35.247.67.242])
        by smtp.gmail.com with ESMTPSA id s21sm2690987pgm.65.2020.11.25.13.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 13:33:24 -0800 (PST)
Date:   Wed, 25 Nov 2020 21:33:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     =?utf-8?B?5b2t5rWpKFJpY2hhcmQp?= <richard.peng@oppo.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "Suravee.Suthikulpanit@amd.com" <Suravee.Suthikulpanit@amd.com>,
        =?utf-8?B?a3ZtQHZnZXIua2VybmVsLm9yZ++8mw==?= <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kvm/svm: fixed a potential register value inconsistent
 with variable ldr_reg
Message-ID: <20201125213320.GB450871@google.com>
References: <HKAPR02MB429179237547D0B00A2F2C6FE0FA0@HKAPR02MB4291.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HKAPR02MB429179237547D0B00A2F2C6FE0FA0@HKAPR02MB4291.apcprd02.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020, 彭浩(Richard) wrote:
> If the ldr value is read out to zero, it does not call avic_ldr_write to update
> the virtual register, but the variable ldr_reg is updated.

Is there a failure associated with this?  And/or can you elaborate on why
skipping the svm->ldr_reg is correct?

I'm not familiar with the AVIC spec, and it's not at all clear to me what the
correct behavior should be for the LDR updates.  E.g. skipping the svm->ldr_reg
update appears to break avic_handle_apic_id_update(), which will see a stale
svm->ldr_reg and call avic_invalidate_logical_id_entry() when it presumably
should not.

> Fixes: 98d90582be2e ("SVM: Fix AVIC DFR and LDR handling")
> Signed-off-by: Peng Hao <richard.peng@oppo.com>
> ---
>  arch/x86/kvm/svm/avic.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 8c550999ace0..318735e0f2d0 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -417,7 +417,6 @@ static void avic_invalidate_logical_id_entry(struct kvm_vcpu *vcpu)
> 
>  static int avic_handle_ldr_update(struct kvm_vcpu *vcpu)
>  {
> -       int ret = 0;
>         struct vcpu_svm *svm = to_svm(vcpu);
>         u32 ldr = kvm_lapic_get_reg(vcpu->arch.apic, APIC_LDR);
>         u32 id = kvm_xapic_id(vcpu->arch.apic);
> @@ -427,13 +426,16 @@ static int avic_handle_ldr_update(struct kvm_vcpu *vcpu)
> 
>         avic_invalidate_logical_id_entry(vcpu);
> 
> -       if (ldr)
> +       if (ldr) {
> +               int ret;
>                 ret = avic_ldr_write(vcpu, id, ldr);
> 
> -       if (!ret)
> -               svm->ldr_reg = ldr;
> -
> -       return ret;
> +               if (!ret)
> +                       svm->ldr_reg = ldr;
> +               else
> +                       return ret;
> +       }
> +       return 0;
> }
> 
>  static int avic_handle_apic_id_update(struct kvm_vcpu *vcpu)
> --
> 2.18.4
