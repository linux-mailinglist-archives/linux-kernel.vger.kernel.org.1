Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85E4328E354
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 17:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729947AbgJNPbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgJNPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 11:31:31 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159ECC061755
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:31:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id i5so3588978edr.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Oct 2020 08:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lLaoTqSkVwqSk2kesrGYJgFsDCH26vFshkH1oOI8pwo=;
        b=g/hy24jvrFDBm71npM+gxMiD3HSgxwvb5f2YmF3TNA9MuHmH3FuodKDQvI3WmsriQm
         dMAh+LL1qkl/6kCZXDIRLTi37VYcN3yhF9WpoeeP0t0NRnWZNKv82E4hzn+xxqmSp5PO
         4ZdA083QHu2nqLkQsDMw5CpDN+fAliBkRWNv+LdE3y0as12ZLwgi+wWxkTVTcs+yolhn
         7XveiZaUWqHDI5HzNL3Wd3iqgBb/aHUxvtjvjQewP28Vcu/0fWnwJXYD2Gin5jvgJM8N
         KfADG5ed8Cm8P9xthfENabJDg8/+zUtAXV8c0org2AuvD4c/LWNGhW9VWhTExTmNyoRA
         elOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lLaoTqSkVwqSk2kesrGYJgFsDCH26vFshkH1oOI8pwo=;
        b=kDUF8j9qhzJtF5tQatdV6WlziNxQDEvyphx3bDNqbUXli8WOvaAwRwj936ock65k/7
         UD2//TNXxsui9VxDR0Q5G0NZ2ccfvyInxRCtzBZ3txZq58FtnIPd6UlDFjiEFggSjbpp
         uDzR3280fKQfWCmv4Zqw4lOMGyBhNAVkqLY0jPtqB86jz+mtKgZOlbbF01gD3ATqtKDD
         dFBZSAmanV0exZ2RfHogGZHG9P9QtgkUk/Jn9+wBnQGMbXfLtnsKCSr1ity0Radku1Hc
         4NI0qrEFSapDxsSIHaI5GazvGl0UxvNwD+tFBf1t22f/N2IKcZodcOMjsNcgmrt4+HxB
         uESw==
X-Gm-Message-State: AOAM532Qhz+btqrbiVdIW55U53AcwGOljFrzYOfGc+cQM1Yn+mCnWMzd
        JR+kOCVMgsEXz8avKTjo83JKqCIcwZk=
X-Google-Smtp-Source: ABdhPJzaO3cAu5cpAAZ9DHBxIBB1nK+e+HXCHSadJyqFA4sTOKKQikXRRxIZMZ2pZCaq/XPcKtkVoA==
X-Received: by 2002:aa7:d79a:: with SMTP id s26mr5706740edq.251.1602689489821;
        Wed, 14 Oct 2020 08:31:29 -0700 (PDT)
Received: from gmail.com (563B81C8.dsl.pool.telekom.hu. [86.59.129.200])
        by smtp.gmail.com with ESMTPSA id b6sm1951089edu.21.2020.10.14.08.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2020 08:31:29 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 14 Oct 2020 17:31:27 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kirill@shutemov.name, mhocko@kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 7/8] x86/cpu/intel: enable X86_FEATURE_NT_GOOD on Intel
 Broadwellx
Message-ID: <20201014153127.GB1424414@gmail.com>
References: <20201014083300.19077-1-ankur.a.arora@oracle.com>
 <20201014083300.19077-8-ankur.a.arora@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014083300.19077-8-ankur.a.arora@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ankur Arora <ankur.a.arora@oracle.com> wrote:

> System:           Oracle X6-2
> CPU:              2 nodes * 10 cores/node * 2 threads/core
> 		  Intel Xeon E5-2630 v4 (Broadwellx, 6:79:1)
> Memory:           256 GB evenly split between nodes
> Microcode:        0xb00002e
> scaling_governor: performance
> L3 size:          25MB
> intel_pstate/no_turbo: 1
> 
> Performance comparison of 'perf bench mem memset -l 1' for x86-64-stosb
> (X86_FEATURE_ERMS) and x86-64-movnt (X86_FEATURE_NT_GOOD):
> 
>               x86-64-stosb (5 runs)     x86-64-movnt (5 runs)       speedup
>               -----------------------   -----------------------     -------
>      size       BW        (   pstdev)          BW   (   pstdev)
> 
>      16MB      17.35 GB/s ( +- 9.27%)    11.83 GB/s ( +- 0.19%)     -31.81%
>     128MB       5.31 GB/s ( +- 0.13%)    11.72 GB/s ( +- 0.44%)    +121.84%
>    1024MB       5.42 GB/s ( +- 0.13%)    11.78 GB/s ( +- 0.03%)    +117.34%
>    4096MB       5.41 GB/s ( +- 0.41%)    11.76 GB/s ( +- 0.07%)    +117.37%

> +	if (c->x86 == 6 && c->x86_model == INTEL_FAM6_BROADWELL_X)
> +		set_cpu_cap(c, X86_FEATURE_NT_GOOD);

So while I agree with how you've done careful measurements to isolate bad 
microarchitectures where non-temporal stores are slow, I do think this 
approach of opt-in doesn't scale and is hard to maintain.

Instead I'd suggest enabling this by default everywhere, and creating a 
X86_FEATURE_NT_BAD quirk table for the bad microarchitectures.

This means that with new microarchitectures we'd get automatic enablement, 
and hopefully chip testing would identify cases where performance isn't as 
good.

I.e. the 'trust but verify' method.

Thanks,

	Ingo
