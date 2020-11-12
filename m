Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3E242B037F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgKLLHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:07:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23452 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727962AbgKLK7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605178755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PHjBjRZowY+IjVGBZ60XjvH5JSPQwQ4zt8y3iTk+Z+0=;
        b=E7RcpYs2Z8Vz5ZoQ6PDc7HBgWu/Zn0ESg7tyiaFgUL/14jygNPEUZv/dSRkvIDBf4Fab2T
        OCAbnwRfLrlKjnW6skZP/lBBgbcE7bhQSj7V4LWmo/tuEyGAfkeLR4UGJbdpAMkWKUC6s0
        MMEr9CgwgOSLElXGrcthlmKKQ++7NTU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-dbrB9FTIOsCrsXaMt0GhXA-1; Thu, 12 Nov 2020 05:59:14 -0500
X-MC-Unique: dbrB9FTIOsCrsXaMt0GhXA-1
Received: by mail-wm1-f70.google.com with SMTP id b206so1614281wmd.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PHjBjRZowY+IjVGBZ60XjvH5JSPQwQ4zt8y3iTk+Z+0=;
        b=OM0wxf3QeS4tFNW6JdI8kIYa+NJwMAYUDTrmpOGjv7Zm6JS++30iDMLuTlPFlzwZan
         NlZ81tXIdpmkoKEKauQedu7ZTaImKrVGC99CylFUi0qRtN7Rc16M7QAXphSKdLCbXhd0
         ddhEDUg7pHSy5MxGerHWm3dkeC1g3JgWiljYY9Ui4bujfT7PBRIGxJJAko8zmdLxUcgA
         5CoW3nNUqbhy1o1nTrD2EdB91YNQeraR0Z7pXVE1lhwtOkPJh1W0JhWDd5NNkebUUbox
         vrDsRLMLkVuCOcJQk64AJ+LTGYdr4GvZyjdLDR7qXKYKfruPLB2CYCfmT+XLDKgAqIhp
         ICQw==
X-Gm-Message-State: AOAM530GUckDiljFSzI0+mnShBk5P31B5pgsjhXXzrFKltYHzpPUoxbp
        yeIikI20yMxqo8oPibbm3rHuElT17X0+rA2ev5bRv0BRxhXtXkyP46TxGM/PBWBJ99EBdcIblcP
        Dgbo3rLJHieQ2yXDHpVXv/lV3LYRKY67HRx9U1+261JBsL3thniiLxFpwlgyNKN9e/qFy9fQbfX
        JR
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr15452572wrp.363.1605178752562;
        Thu, 12 Nov 2020 02:59:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8NqN7MYALoXUCZY6YKU0aWObW5mAt3CIykX41Fc8DE8b074d3YM8QF538aTonDg2bjBTJMQ==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr15452551wrp.363.1605178752379;
        Thu, 12 Nov 2020 02:59:12 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p12sm6204530wrw.28.2020.11.12.02.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 02:59:11 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/11] KVM: VMX: Skip additional Hyper-V TLB EPTP
 flushes if one fails
In-Reply-To: <20201027212346.23409-11-sean.j.christopherson@intel.com>
References: <20201027212346.23409-1-sean.j.christopherson@intel.com>
 <20201027212346.23409-11-sean.j.christopherson@intel.com>
Date:   Thu, 12 Nov 2020 11:59:10 +0100
Message-ID: <87zh3myh6p.fsf@vitty.brq.redhat.com>
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
>  arch/x86/kvm/vmx/vmx.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 5b7c5b2fd2c7..40a67dd45c8c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -528,7 +528,15 @@ static int hv_remote_flush_tlb_with_range(struct kvm *kvm,
>  			if (++nr_unique_valid_eptps == 1)
>  				kvm_vmx->hv_tlb_eptp = tmp_eptp;
>  
> -			ret |= hv_remote_flush_eptp(tmp_eptp, range);
> +			if (!ret)
> +				ret = hv_remote_flush_eptp(tmp_eptp, range);
> +
> +			/*
> +			 * Stop processing EPTPs if a failure occurred and
> +			 * there is already a detected EPTP mismatch.
> +			 */
> +			if (ret && nr_unique_valid_eptps > 1)
> +				break;
>  		}
>  
>  		/*

This should never happen (famous last words) but why not optimize the
impossibility :-)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

