Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C5329891B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 10:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1772594AbgJZJHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 05:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391099AbgJZJHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 05:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603703252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SEprIZYzYLqEdMCsaNu8aMt1VGMkVphvSgSzQPUy25I=;
        b=AJcSzrBoLRDFHHQ79euDn1qHoCNJflaakiXDoYtMj7mYj/GSxovEWyI7MuuPk9DkjtQVnD
        u9LdEfa61ib0YiFLvsVNNspEnE3mtdMQPIDw6ybIpiIQ10O7XW7LupQjJUR4Cp/KRRpriq
        HbeakCIX/x32HbCdqnz+nFBICA7AnfE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-qYnK4ttqOO-Ue5HQVeEnXg-1; Mon, 26 Oct 2020 05:07:30 -0400
X-MC-Unique: qYnK4ttqOO-Ue5HQVeEnXg-1
Received: by mail-ed1-f69.google.com with SMTP id ay19so3850721edb.23
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 02:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SEprIZYzYLqEdMCsaNu8aMt1VGMkVphvSgSzQPUy25I=;
        b=FzALiUxAC1mF/7A5WQEo+ZMxXHGHYLvN+U47oq37qzBev9esYD0mSnvOg6KAGzvw10
         H3cN8zjIxcXsp2ytzsXQtuLmWGahLgasApN/q7EE6cOxM4SDMa7dDxqjokQ7M//lVWhY
         aC3lrl6ZG5yDTxFp66542x3gpzQddRC3IXYIXV/33nUOMo+fp3TBIYhY9jnFejjh5/mj
         RfRfvb6HlhuW3JiW8514trxt8Z77R1SAsoBgTVgZWAec22JEAEoFVR9h7IG2vkWnmSTZ
         7JJmRAmjFHPxr6DLlJXfuBwq3rp7Wt8h7O1fOi+pqL3Jg8W25bXN9QLyFBIdh/PDUokh
         bqRA==
X-Gm-Message-State: AOAM531uAb84BPjjBc5UmZBp7GFqcuvHyzImgd2N4HeFsSTN5uYO5L4+
        3jThyUHEoZYeg3QmzESSXcMBd6UBKz88HJJQWqrUPaLZ0/nrReDXehwnnvn6hz+q6pVVQRL6qLq
        TZ4vQhJ4JZlUbgizN5tArCmxt
X-Received: by 2002:a05:6402:17e4:: with SMTP id t4mr14983335edy.118.1603703248806;
        Mon, 26 Oct 2020 02:07:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX4twJBC9HPBWYucM43/xc3UpxKMK4mGRFRdSjt4DfA7Dv5k0xH1dFdpFyxML5HhEiX+nyfQ==
X-Received: by 2002:a05:6402:17e4:: with SMTP id t4mr14983326edy.118.1603703248577;
        Mon, 26 Oct 2020 02:07:28 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id mw1sm5438635ejb.1.2020.10.26.02.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 02:07:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Steffen Dirkwinkel <kernel-bugs@steffen.cc>
Subject: Re: [PATCH 2/2] KVM: X86: Fix null pointer reference for KVM_GET_MSRS
In-Reply-To: <20201025185334.389061-3-peterx@redhat.com>
References: <20201025185334.389061-1-peterx@redhat.com> <20201025185334.389061-3-peterx@redhat.com>
Date:   Mon, 26 Oct 2020 10:07:27 +0100
Message-ID: <871rhl2w4w.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:

> kvm_msr_ignored_check() could trigger a null pointer reference

'dereference' but I'd also clarify that 'vcpu' is NULL.

>  if ignore_msrs=Y
> and report_ignore_msrs=Y when try to fetch an invalid feature msr using the
> global KVM_GET_MSRS.  Degrade the error report to not rely on vcpu since that
> information (index, rip) is not as important as msr index/data after all.
>
> Fixes: 12bc2132b15e0a96

Fixes: 12bc2132b15e ("KVM: X86: Do the same ignore_msrs check for feature msrs")

please (checkpatch.pl should've complained I guess)

> Reported-by: Steffen Dirkwinkel <kernel-bugs@steffen.cc>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index ce856e0ece84..5993fbd6d2c5 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -259,8 +259,8 @@ static int kvm_msr_ignored_check(struct kvm_vcpu *vcpu, u32 msr,
>  
>  	if (ignore_msrs) {
>  		if (report_ignored_msrs)
> -			vcpu_unimpl(vcpu, "ignored %s: 0x%x data 0x%llx\n",
> -				    op, msr, data);
> +			kvm_pr_unimpl("ignored %s: 0x%x data 0x%llx\n",
> +				      op, msr, data);

I would've preserved vcpu version for non-gloal cases, e.g.

if (report_ignored_msrs) {
	if (vcpu)
        	vcpu_unimpl(vcpu, "ignored %s: 0x%x data 0x%llx\n",
	                op, msr, data);
        else
	        kvm_pr_unimpl("ignored %s: 0x%x data 0x%llx\n",
                               op, msr, data);
}

>  		/* Mask the error */
>  		return 0;
>  	} else {

-- 
Vitaly

