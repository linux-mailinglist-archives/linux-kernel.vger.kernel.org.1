Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7052579AD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Aug 2020 14:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgHaMs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 08:48:27 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:40917 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726384AbgHaMsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 08:48:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598878097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cnx3CjRYB9hGIWsNjQqszr2co7+0ihfxtc0QgvVHV+M=;
        b=YQYTF1bmcPeu7nl78MZ5j2qxOGfGN7YMOnni0dWZOG2ktsMpDV1X/RTaBrP+AfUNUeTq+n
        yl9Hm7KNQBTUEXCvryxNvQbQA6K44x6dt7A5fJaOqD+uOwVPQkkj0ojc+xkEJtNtoM+RhS
        MvfZJXvI+leo/PNxyILT8uRj5SKn7nE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-486-gQGkwcF2Nf20csw0cyct6g-1; Mon, 31 Aug 2020 08:48:15 -0400
X-MC-Unique: gQGkwcF2Nf20csw0cyct6g-1
Received: by mail-wm1-f72.google.com with SMTP id f189so951064wmf.8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 05:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=cnx3CjRYB9hGIWsNjQqszr2co7+0ihfxtc0QgvVHV+M=;
        b=VbPefayYa+Z62ZUvRJJGZxSU895N1EddWx4IIhCj4Bm/d8HSW6kVE2UUgj8LMsKY0k
         kQt1My6AUA3PQ56HPdXEQ46Hl3qEuvziRkZzzYBS1LQi/nRZfRBBuY1EJV9APZeU99f1
         zRNzRzy52DYT2Ad3a7Nz3O2ImyYlzoIVNDMUHCyt2FQxUWjZdehVoCN0gK3C3vFgcvUn
         cNmAjVURMwwqMr5TST1w8c7/Z34EhYilwUe55s4E1E3rBnCXeYGTnGq4Ds4ZOekMhNBz
         o3xJmumPo19JyO3EwQVRpCKeriFatcAZOIe30P+B5DZmZCwNTYYfHYK0YH3gPFcb1Ku0
         0L1A==
X-Gm-Message-State: AOAM531sa7wTwLlRuQrVVeejumN61apvLoIXh2W4It+1WFg8X0Rl/Nkq
        bx6YyoEKPZGBGhAPXQxh+U9X9fWg+lTB/0+UATVkgJP+C6IeGi8vECS1nPijY+DGTOhOqQRDY3N
        woHN2AvlTzOmgz3z+5ag5gYN3
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr1319222wmu.73.1598878094354;
        Mon, 31 Aug 2020 05:48:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwc3ks723eU0MJaIHVO/d8tt1FXCDACXwreTLs0dlEDnbVrsUC4Kux9ZLcT5gY6wvSD7o4bJg==
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr1319205wmu.73.1598878094196;
        Mon, 31 Aug 2020 05:48:14 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 62sm12384616wre.60.2020.08.31.05.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2020 05:48:13 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: LAPIC: Reset timer_advance_ns if timer mode switch
In-Reply-To: <1598578508-14134-1-git-send-email-wanpengli@tencent.com>
References: <1598578508-14134-1-git-send-email-wanpengli@tencent.com>
Date:   Mon, 31 Aug 2020 14:48:12 +0200
Message-ID: <87a6ybx9pv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> per-vCPU timer_advance_ns should be set to 0 if timer mode is not tscdeadline 
> otherwise we waste cpu cycles in the function lapic_timer_int_injected(), 

lapic_timer_int_injected is just a test, kvm_wait_lapic_expire()
(__kvm_wait_lapic_expire()) maybe?

> especially on AMD platform which doesn't support tscdeadline mode. We can 
> reset timer_advance_ns to the initial value if switch back to
> tscdealine

'tscdeadline'

> timer mode.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 654649b..abc296d 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1499,10 +1499,16 @@ static void apic_update_lvtt(struct kvm_lapic *apic)
>  			kvm_lapic_set_reg(apic, APIC_TMICT, 0);
>  			apic->lapic_timer.period = 0;
>  			apic->lapic_timer.tscdeadline = 0;
> +			if (timer_mode == APIC_LVT_TIMER_TSCDEADLINE &&
> +				lapic_timer_advance_dynamic)
> +				apic->lapic_timer.timer_advance_ns = LAPIC_TIMER_ADVANCE_NS_INIT;
>  		}
>  		apic->lapic_timer.timer_mode = timer_mode;
>  		limit_periodic_timer_frequency(apic);
>  	}
> +	if (timer_mode != APIC_LVT_TIMER_TSCDEADLINE &&
> +		lapic_timer_advance_dynamic)
> +		apic->lapic_timer.timer_advance_ns = 0;
>  }
>  
>  /*

-- 
Vitaly

