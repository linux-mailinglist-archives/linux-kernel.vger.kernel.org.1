Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780152D9FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 20:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441006AbgLNTCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 14:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440695AbgLNTCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:02:20 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4622AC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 11:01:40 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id hk16so7192296pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 11:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1kWGK0RczIOp+iVj83yQa4txxLqHCI2JyPCYLhw6aOc=;
        b=IW+b3fPAjrIiAyPxL8E1L3EkTc/tR/a3T8Sy0RT3363v51GzUV5oPr1UI8+DnrlBxq
         St9/drNjy7O9xsFp5+qK1zNcY7x8yjrhajfAVpVVgf6jW8Zlr5LVW4zTSNwnQBOk2IB0
         LF3pMIr5Iyt5KPecOQKlpx0tQF2nNA3e6Np16Pv91yeTs+BqPcvjW1p7QedlUe8s4+XK
         VtLxe+luT8Rls5RmhxvpteD0wFKihWdi4WTRsmVZvIlBiUjk72RQEbxU3hp9klM3TghG
         H6ZsA+oFqQnPb2oI2gRKpyC15lGjpR9+e3CBsQvlxDQD5imXYENxb3MBiynJOa+aVZpV
         Srfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1kWGK0RczIOp+iVj83yQa4txxLqHCI2JyPCYLhw6aOc=;
        b=i8u6rxysm/oG1aEXzaSPYAjLuDnhmUlA9+FGcf2GXKdOfWhp/0OJLFwhNoxo7dOpvP
         4PliGYCBUjSwpNot5Z8gNt7d+dm7g03Xyqbg7OM5EfEqU7l25aFnzI7fXPO0SoEZaar4
         4LEWeagWaqqdrDm7v/j+55BHF9f/5cGeINLJ/EQzvA/t5jaDTpkkw0gUyggtrCZOgxeY
         OQYBVYXeU/7vGKoia8UztSJmr6Myj7/KcrkdR+kkAEGoJ6pHsLV/AY7Ry9C4CtaTiVdd
         K4fSWFWlU+jcGrTUdkMJJtyfthh8P2YDgPXXLL29YOWe+pVbRuz/Gp9rgH/0VI9C1/87
         kmUQ==
X-Gm-Message-State: AOAM533h194tz7bPERqoaB1u2q4X5kz3KnnoEdxLOfXQ98DX+aTKZwDE
        p3BoZhLWkQU9O0iHvsFcd7A6zW+XYK9H2Q==
X-Google-Smtp-Source: ABdhPJzraNIBSIy+w0M5cqMA9btGHAYdNbSsyVAmIQl/cbkk91bRRZyEK/1b//gmtkxzZwpCP8NQFw==
X-Received: by 2002:a17:90a:d307:: with SMTP id p7mr26891434pju.214.1607972499565;
        Mon, 14 Dec 2020 11:01:39 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id b13sm4727079pfi.162.2020.12.14.11.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:01:38 -0800 (PST)
Date:   Mon, 14 Dec 2020 11:01:32 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-sgx@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] x86/sgx: Synchronize encl->srcu in sgx_encl_release().
Message-ID: <X9e2jOWz1hfXVpQ5@google.com>
References: <20201211113230.28909-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201211113230.28909-1-jarkko@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020, Jarkko Sakkinen wrote:
> Each sgx_mmun_notifier_release() starts a grace period, which means that

Should be sgx_mmu_notifier_release(), here and in the comment.

> one extra synchronize_rcu() in sgx_encl_release(). Add it there.
> 
> sgx_release() has the loop that drains the list but with bad luck the
> entry is already gone from the list before that loop processes it.

Why not include the actual analysis that "proves" the bug?  The splat that
Haitao reported would also be useful info.

> Fixes: 1728ab54b4be ("x86/sgx: Add a page reclaimer")
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Reported-by: Sean Christopherson <seanjc@google.com>

Haitao reported the bug, and for all intents and purposes provided the fix.  I
just did the analysis to verify that there was a legitimate bug and that the
synchronization in sgx_encl_release() was indeed necessary.

> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  arch/x86/kernel/cpu/sgx/encl.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
> index ee50a5010277..48539a6ee315 100644
> --- a/arch/x86/kernel/cpu/sgx/encl.c
> +++ b/arch/x86/kernel/cpu/sgx/encl.c
> @@ -438,6 +438,13 @@ void sgx_encl_release(struct kref *ref)
>  	if (encl->backing)
>  		fput(encl->backing);
>  
> +	/*
> +	 * Each sgx_mmun_notifier_release() starts a grace period. Thus one
> +	 * "extra" synchronize_rcu() is required here. This can go undetected by
> +	 * sgx_release() when it drains the mm list.
> +	 */
> +	synchronize_srcu(&encl->srcu);
> +
>  	cleanup_srcu_struct(&encl->srcu);
>  
>  	WARN_ON_ONCE(!list_empty(&encl->mm_list));
> -- 
> 2.27.0
> 
