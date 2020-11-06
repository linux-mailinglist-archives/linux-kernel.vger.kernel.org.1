Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFA82A92D7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 10:35:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgKFJfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 04:35:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20717 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbgKFJfy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 04:35:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604655353;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=COh7322GhHnYTfoWCK648pPK1F4ogcTwn4taOORgpuE=;
        b=et0SjcajHDnLWQ5Ahrgq3OERkzsd39oadJrTn8X/+7OIXeEGLxJujWmhfT0L6jYX2g8fZi
        uWB3FolYu6lm61rOLjaEQnXiecov1nzoC1lLitUslhZy6TIpQVj/patGTIpkgcF10g1GU0
        Wsjp1QDxltA7hexvrqPIauO+HQTR8Qc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-TTqG_wLeNAmj9Yh1XgEnog-1; Fri, 06 Nov 2020 04:35:51 -0500
X-MC-Unique: TTqG_wLeNAmj9Yh1XgEnog-1
Received: by mail-ej1-f69.google.com with SMTP id p18so260620ejl.14
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 01:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=COh7322GhHnYTfoWCK648pPK1F4ogcTwn4taOORgpuE=;
        b=uUP5j81PofUl55u2D4aqXGfdcpJDNvkvJ0YpWjrYhJjCJNZ4g5q/a7KZ/C+m3KCMbe
         YlqxX7OMirCez1VCbPN63B9kA03CQZW9ZQWSnNQpsh/6NNoPvHNYJ8bukr1BhGl+OiFe
         PDlA7OVbxn9GfKPx5T1l0QYtFoUT6/MA3ntdkrS2bZwrSBSHz9C745L+4UZUrRZ8E34E
         23qO43sY6tQFFrLLBV3xssuUEoyOOlvKKj0mG9oUB9MoPyzopVYxHp2vbkD9MV0NJlHO
         SPI5SBxu6RyvFJD8KplddKe/YlbNNezqJieb0E6Bn4Nxcj5K86tfnh2oYK9qsJHtkEgU
         lM2w==
X-Gm-Message-State: AOAM531hu38YMDIP+c+5XFukvaZpY61o0rLNMLG8wsDC4yUtinyjN91x
        h+N5QYt/3DsYwYAjpUSPWwYRIDYNKonUDA6ckqS+Gv0fyE1v1bfoqZUs574ijhe66lzjD7eOfq3
        ceCZLOV4cYxCapLjjiyLdgXjd
X-Received: by 2002:aa7:c40b:: with SMTP id j11mr1052201edq.151.1604655350420;
        Fri, 06 Nov 2020 01:35:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxCyBjacm4/sWb+AyM7ztQpZR/p9PyzAKj5KqdlXmlv9S87IqV7wnB9RlzqOueD7Gf0frb6xQ==
X-Received: by 2002:aa7:c40b:: with SMTP id j11mr1052185edq.151.1604655350213;
        Fri, 06 Nov 2020 01:35:50 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i13sm485679ejv.84.2020.11.06.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 01:35:49 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hpa@zytor.com
Subject: Re: [PATCH] x86/kvm: remove unused macro HV_CLOCK_SIZE
In-Reply-To: <1604651963-10067-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1604651963-10067-1-git-send-email-alex.shi@linux.alibaba.com>
Date:   Fri, 06 Nov 2020 10:35:48 +0100
Message-ID: <87o8ka3k0b.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Shi <alex.shi@linux.alibaba.com> writes:

> This macro is useless, and could cause gcc warning:
> arch/x86/kernel/kvmclock.c:47:0: warning: macro "HV_CLOCK_SIZE" is not
> used [-Wunused-macros]
> Let's remove it.
>
> Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com> 
> Cc: Sean Christopherson <sean.j.christopherson@intel.com> 
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com> 
> Cc: Wanpeng Li <wanpengli@tencent.com> 
> Cc: Jim Mattson <jmattson@google.com> 
> Cc: Joerg Roedel <joro@8bytes.org> 
> Cc: Thomas Gleixner <tglx@linutronix.de> 
> Cc: Ingo Molnar <mingo@redhat.com> 
> Cc: Borislav Petkov <bp@alien8.de> 
> Cc: x86@kernel.org 
> Cc: "H. Peter Anvin" <hpa@zytor.com> 
> Cc: kvm@vger.kernel.org 
> Cc: linux-kernel@vger.kernel.org 
> ---
>  arch/x86/kernel/kvmclock.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
> index 34b18f6eeb2c..aa593743acf6 100644
> --- a/arch/x86/kernel/kvmclock.c
> +++ b/arch/x86/kernel/kvmclock.c
> @@ -44,7 +44,6 @@ static int __init parse_no_kvmclock_vsyscall(char *arg)
>  early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
>  
>  /* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
> -#define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
>  #define HVC_BOOT_ARRAY_SIZE \
>  	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))

Fixes: 95a3d4454bb1 ("x86/kvmclock: Switch kvmclock data to a PER_CPU variable")

where the last and the only user was removed.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

