Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014F1294E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437414AbgJUOWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:22:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49708 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2437241AbgJUOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:22:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603290173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yp3OQZh03TZtBBh//ZUnTZtHQGcv7MxFTpyYeikglDA=;
        b=HDtSe+1KEyXRuiGcMGdpjv3vsU8ye4vjXoRPENJUbY94D8CR7iZnGwu/rKQV6T2AjKe1oj
        QLY/1k6y6sCxt2pbG/m+VpM2+ywV8ST5hd1v3NrbRIE8fyj89Lm3nPg80SuMmZgrUsmMMm
        FSeGQyMp938vw9iwrK2D/8Vu8oKGjzw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-383-LW4_haPVNnuizcEb93YPEg-1; Wed, 21 Oct 2020 10:22:52 -0400
X-MC-Unique: LW4_haPVNnuizcEb93YPEg-1
Received: by mail-wr1-f71.google.com with SMTP id t11so2777926wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 07:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Yp3OQZh03TZtBBh//ZUnTZtHQGcv7MxFTpyYeikglDA=;
        b=LJW+g+T5xZEJSWDmcbJ3XRZlqUWkyXvtt6YKdNv4ix7/VrUQElCQu61QDkQMDdm+LU
         OEm1cWivpEnJlCbYajXsPlbxvEfXt2hRvaI60g9/vSgOVSI7VlmfVOCkkjl37yf93sm1
         5z/gFY+DoNQ0UZ2OiGtVSMcVxuwxbEUwzAj64C949wsa3PDFiyUNbJPjOKZbaJyOV5eo
         PMlziBciy0dw15BkXUT+HieF//De+kpCkHUNhYETfJAcmWXjb2AwsqLcCmxVM3H975gQ
         PoBIJDi1XSy9F3YX/ta/nR+lpWd6YLpVaKy/lugEpDxuQecZTDvvatxh8Chcblqie232
         I6Mw==
X-Gm-Message-State: AOAM531QfF+vPRIhoPVCxt/zcKFv9YycYRZUQQJ2vxzA75zIhh82dtPY
        0/TidTNjk48BDzvBgVvBXecwk+VrEuuU65tFuYHHhXM3Pnej0o5QmTpmTZ1xF/3iQBJwhNARNZx
        OwYDy5hiLNqfEX8Btbrd0d5xv
X-Received: by 2002:a7b:c762:: with SMTP id x2mr3947349wmk.102.1603290170046;
        Wed, 21 Oct 2020 07:22:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwzI0babsXTfkHvpBywnFhVI0rRhxJ+HbO+aHyxoWr0eH5bbHIxBdCFCtR3bE85jVIbhRKW+w==
X-Received: by 2002:a7b:c762:: with SMTP id x2mr3947334wmk.102.1603290169859;
        Wed, 21 Oct 2020 07:22:49 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q8sm4168755wro.32.2020.10.21.07.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 07:22:48 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 09/10] KVM: VMX: Skip additional Hyper-V TLB EPTP flushes if one fails
In-Reply-To: <20201020215613.8972-10-sean.j.christopherson@intel.com>
References: <20201020215613.8972-1-sean.j.christopherson@intel.com> <20201020215613.8972-10-sean.j.christopherson@intel.com>
Date:   Wed, 21 Oct 2020 16:22:47 +0200
Message-ID: <87lffz4q14.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Skip additional EPTP flushes if one fails when processing EPTPs for
> Hyper-V's paravirt TLB flushing.  If _any_ flush fails, KVM falls back
> to a full global flush, i.e. additional flushes are unnecessary (and
> will likely fail anyways).
>
> Continue processing the loop unless a mismatch was already detected,
> e.g. to handle the case where the first flush fails and there is a
> yet-to-be-detected mismatch.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index a45a90d44d24..e0fea09a6e42 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -517,7 +517,11 @@ static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
>  			else
>  				mismatch = true;
>  
> -			ret |= hv_remote_flush_eptp(tmp_eptp, range);
> +			if (!ret)
> +				ret = hv_remote_flush_eptp(tmp_eptp, range);
> +
> +			if (ret && mismatch)
> +				break;
>  		}
>  		if (mismatch)
>  			kvm_vmx->hv_tlb_eptp = INVALID_PAGE;

In case my suggestion on PATCH5 gets dismissed,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

