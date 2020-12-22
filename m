Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2F1C2E0E22
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 19:15:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgLVSOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 13:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbgLVSOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 13:14:16 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8DEC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:13:36 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id 4so7834697plk.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 10:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fWVOXJGn61Cgm3ve2YR3d0fo4X0XPEIOJb4DIoZEUgg=;
        b=J2UhttQNdgWZ12raeERXe21eLZaWcoEvkXaFv89OF6A1MPZkc+0hL98KSRa77jNIvC
         AlPj6BKKLs+w5v77V+8o7Ec/2GzL9XqZgX1dWZD8abmSLBzHY3+hgxYcJ0QezftdGc+I
         RygVs6f3QcIUs9mFfvAddTua7NCZLW/10dPJZeGKIcuqIBjWjfHTtzUZM12VR+ypRdA9
         vvHPwCxo0mveR6PpPuzMvyrkMkgUucTeXofRbUjscFO8+hU086MuTang2zLIptxH0CQg
         pakU4v8E7XOqc+JbNRDv3uGnWqgtGSeCxfRHg3NVU2deoAIUYy0mPmRGX27rs45oZb2W
         /FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fWVOXJGn61Cgm3ve2YR3d0fo4X0XPEIOJb4DIoZEUgg=;
        b=Gkk+OSC381HlIwGOYao2TJUx1GZHUYTaWBxLgyiblGCJg6yIqdJ1HnyXrqNMRVx9UD
         uYiiEW3kjDDWLrVdJNxp9sf+I2DW0PGiqWWJhr1E3YsHJW0ptOH5z/HYQmKidWWpL7ee
         KoXCDQuX28VaZmnLFU96KcoYaaCOC+EDD9Ocs1tdYnO5CWg0Gkt0wdOyT3fHTx4uQhup
         yTI/1C5b1LdoUbcTtTHYBaJHiWqgQ8ZNtJDdcDgHO22oybOcIKZhH/ilenqb1Qntj3ZZ
         3Mxs3WppRhn92fCz2tUMoREzZrlSKSUhzGYxTf1pR6tn8LxRwPyhjvt6pMcaVHgH87yj
         OgBw==
X-Gm-Message-State: AOAM533q2qQXYssypLGg1XfzsEKqXR/cn+86WrZtJLq+9Pg0lDR3x1pL
        JUq4pHyD0uuEODf9GQdg+yTDkQ==
X-Google-Smtp-Source: ABdhPJyTohKUfbED/apZlaT2hLLZ2upfLYaOQBi14hobUSjdQp8Ow6TEoLaDW+c2v5kLsu4mYJ/qMQ==
X-Received: by 2002:a17:90a:450c:: with SMTP id u12mr23081264pjg.93.1608660816229;
        Tue, 22 Dec 2020 10:13:36 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id w6sm5168744pfq.208.2020.12.22.10.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 10:13:35 -0800 (PST)
Date:   Tue, 22 Dec 2020 10:13:28 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        syzbot+e87846c48bf72bc85311@syzkaller.appspotmail.com
Subject: Re: [PATCH] KVM: x86: fix shift out of bounds reported by UBSAN
Message-ID: <X+I3SFzLGhEZIzEa@google.com>
References: <20201222102132.1920018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222102132.1920018-1-pbonzini@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020, Paolo Bonzini wrote:
> Since we know that e >= s, we can reassociate the left shift,
> changing the shifted number from 1 to 2 in exchange for
> decreasing the right hand side by 1.

I assume the edge case is that this ends up as `(1ULL << 64) - 1` and overflows
SHL's max shift count of 63 when s=0 and e=63?  If so, that should be called
out.  If it's something else entirely, then an explanation is definitely in
order.

> Reported-by: syzbot+e87846c48bf72bc85311@syzkaller.appspotmail.com
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 9c4a9c8e43d9..581925e476d6 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -49,7 +49,7 @@ static inline u64 rsvd_bits(int s, int e)
>  	if (e < s)
>  		return 0;

Maybe add a commment?  Again assuming my guess about the edge case is on point.

	/*
	 * Use 2ULL to incorporate the necessary +1 in the shift; adding +1 in
	 * the shift count will overflow SHL's max shift of 63 if s=0 and e=63.
	 */

> -	return ((1ULL << (e - s + 1)) - 1) << s;
> +	return ((2ULL << (e - s)) - 1) << s;
>  }
>  
>  void kvm_mmu_set_mmio_spte_mask(u64 mmio_value, u64 access_mask);
> -- 
> 2.26.2
> 
