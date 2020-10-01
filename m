Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1125D2800B2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 16:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732595AbgJAOBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 10:01:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55600 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732581AbgJAOA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 10:00:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601560857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6S44Cl1SWHyUe4fYYQfKjzqsq0aN4+O/1HZKr3HYiiY=;
        b=VJfDgA+UJtMGfaZJxNU0C84WHXfoWbnzx5EUdkFB3Xt5EskMjSd8juvpB2ekdF0j8Xm2mJ
        1bL9cI4ZV/Ts0dvOZ5OiggV//oi5UOuSDy7Jgb8dFVks7cju56hO2G2TeDHcSn0BoziVkl
        MXENW51oenXb5GlR+Nw5IilYSSUo6w4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-nwcjV7cOPuuMOoQ9FzDQgw-1; Thu, 01 Oct 2020 10:00:55 -0400
X-MC-Unique: nwcjV7cOPuuMOoQ9FzDQgw-1
Received: by mail-wr1-f70.google.com with SMTP id a10so2057611wrw.22
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 07:00:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6S44Cl1SWHyUe4fYYQfKjzqsq0aN4+O/1HZKr3HYiiY=;
        b=ZIwrcwKGRVDQudSipGGqxP3cKjKguQTs3c46CwkjJTMMGt1zvvD97dPiYXgzb7Zl+T
         1PZjdoNK7zkhOGrhWdsfp/sLCfe+w4rI8SHwt8GsXWr5dYNXJYSXqDOHh9gimLKHnCEs
         OJFFdN363XIQyTxSw7ogihZgEoraBAanRx9b30xhArPgowhSdW4d+rj1SqvHJb8nPm+E
         W9hQCVpYCPuOA8IpvC2ncEwwW3OoF9HsvFhypFSrD/60qPGu9JR+QAMhBWsQ8DFgKqsR
         sr4LYhYUDKM88Xuu3q/lwTAL34bGgcH9fdLwqs5N2gYK/cVuBiXb42W2MllEUPSNbdCX
         vZTQ==
X-Gm-Message-State: AOAM532/zlflW9cozp5613p5uOOJKeUgP5/yIf4fMYq9XaJgq1NgsR3h
        OgGEEITJiZ0bqMGaFBVDxzAfwWceHFLNhbXEsynOKkken09MZfd6JChpHMl1wFeLNSzZStJT2Tu
        abJ+uqkVOBinR5SrPRa2OuoQu
X-Received: by 2002:adf:dd44:: with SMTP id u4mr8819554wrm.22.1601560854079;
        Thu, 01 Oct 2020 07:00:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYj/8ORDVYdNbRPeku5Fpyq8wvSyE05tvQI2eThYq+MXR17DDK2stsqrdhIqYW+td6JTxv3A==
X-Received: by 2002:adf:dd44:: with SMTP id u4mr8819515wrm.22.1601560853797;
        Thu, 01 Oct 2020 07:00:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u2sm10439301wre.7.2020.10.01.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 07:00:53 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>, kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH] x86/kvm: hide KVM options from menuconfig when KVM is not compiled
In-Reply-To: <20201001112014.9561-1-mcroce@linux.microsoft.com>
References: <20201001112014.9561-1-mcroce@linux.microsoft.com>
Date:   Thu, 01 Oct 2020 16:00:52 +0200
Message-ID: <87a6x69hbf.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Matteo Croce <mcroce@linux.microsoft.com> writes:

> From: Matteo Croce <mcroce@microsoft.com>
>
> Let KVM_WERROR depend on KVM, so it doesn't show in menuconfig alone.
>
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>

I'd even say

Fixes: 4f337faf1c55e ("KVM: allow disabling -Werror")

> ---
>  arch/x86/kvm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
> index fbd5bd7a945a..f92dfd8ef10d 100644
> --- a/arch/x86/kvm/Kconfig
> +++ b/arch/x86/kvm/Kconfig
> @@ -66,6 +66,7 @@ config KVM_WERROR
>  	default y if X86_64 && !KASAN
>  	# We use the dependency on !COMPILE_TEST to not be enabled
>  	# blindly in allmodconfig or allyesconfig configurations
> +	depends on KVM
>  	depends on (X86_64 && !KASAN) || !COMPILE_TEST
>  	depends on EXPERT
>  	help

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

