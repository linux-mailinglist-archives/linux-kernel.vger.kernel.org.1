Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 990222FC186
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbhASUr5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:47:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbhASUrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:47:01 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A120AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:46:21 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id g15so13705917pgu.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 12:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iVHb643PwDFlofq8s/dHziMEEHQYbNdqvRh+4/Hot4U=;
        b=rbGn08ZsGPZ1g2+KJMh7UvzpuWhxqUe8k+Cfah3ZW5zm7Xc68WepvKeaF3+kqelkiY
         oEtZeXsXQJMtGl3u1lIiMYEXoMMIkfG8Mm8c8WUzSJd86fyrt8YE+m5jAPaflgO1Barg
         yFYrN9AF2Jd1rDI7E4Nt5Tx1cJ0qsUaNNI1mfIjk9clAYae9FD8y8jsmMFZftYxx9yJO
         89brRJ23bmL1s252JC98dnKd8xif0OCIdt25Wdwdxfv4zcaM6XpuiByXor4+IwJtFP7f
         oUaFLRnKEzwJKjHGRDJzoHnls/4XL1B64ArVtAswOXICDuBQsljWnU8FeaX37FPt7iN2
         8jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iVHb643PwDFlofq8s/dHziMEEHQYbNdqvRh+4/Hot4U=;
        b=dfV3dp4Xt9OggTrQKv1AMhilsQQ6nlx+RgiVeLcG8UyH5RGdln4RKcYAKq40Z6IUmP
         0da0lAgnUdjki42/Cg+ehzb9qJ6lQheroTuzQGCsLOuZs8gY0PmHg2IFxW/U2t8FkEkU
         xqb73Hp31sWFM83AQYLFf0ZkkoXZ4V5z1PGMVuXPJF/mmaeBItKP22HjKze73ORoOqLQ
         lLgMHEykbj0Mi8BOeJCeWKTTW3pVMx2TMtlcqmz/bVlL3TSGZT/+t/Wf9FMeQmL/l8Bz
         ExHQBplG+1IImylXaXZtYTz9LVduHDRw0J/jSPyqUWDwQQIYgaBy769mdSABKnMKe0Nh
         x73g==
X-Gm-Message-State: AOAM532cvrh/zfLO0Btvs83Bu5NU8sI5ZgZjnsY5IXLqqzC1r9VOhejn
        gqZauhM7XiBl59/m1TkCVveNSw==
X-Google-Smtp-Source: ABdhPJwWvSVvaoZkDa1qqRtpM2kSMBHHOM3tSYS8tomDckDnTz1Hnf69mnXzBhKRBWnPfRSiqc1jlw==
X-Received: by 2002:a63:1a44:: with SMTP id a4mr6014377pgm.41.1611089181130;
        Tue, 19 Jan 2021 12:46:21 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id t5sm4258770pjr.22.2021.01.19.12.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 12:46:20 -0800 (PST)
Date:   Tue, 19 Jan 2021 12:46:13 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Cun Li <cun.jia.li@gmail.com>
Cc:     vkuznets@redhat.com, pbonzini@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: update depracated and inappropriate jump label API
Message-ID: <YAdFFdyMZrTe0SFa@google.com>
References: <87h7nn8ke8.fsf@vitty.brq.redhat.com>
 <20210116055009.118377-1-cun.jia.li@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116055009.118377-1-cun.jia.li@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

s/depracated/deprecated

And maybe reword the shortlog to be more explicit?  E.g.

  KVM: Stop using deprecated jump label APIs

On Sat, Jan 16, 2021, Cun Li wrote:
> The use of 'struct static_key' and 'static_key_false' is
> deprecated. Use the new API.
> 
> mmu_audit_key can only be true or false so it would be nice to use
> static_branch_enable()/static_branch_disable() for it and not
> static_key_slow_inc()/static_key_slow_dec().

Does anyone even build with CONFIG_KVM_MMU_AUDIT=y, let alone actually use the
auditing capabilities?
