Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E322F3638
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:55:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390866AbhALQys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390500AbhALQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:54:48 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CDB0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:54:07 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id m5so2042691pjv.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BvNPTfqT/5f4cwjyqGfBMaYw7woP/GveWw32QYUqvjQ=;
        b=m8vzTv31OLpB/Cx5Y7zqFtD1Mg1Ek0UYCQUnr2j8V7D+AXHUCqTa/U5XPzKqj56C1A
         KBQb7IbW9vKAUk11kd/UY2LKV4ipQijWbWIOShsmgx+Y0TWrzXgKtz+C3eeybAeZ5Bjw
         2/Mi2/orPtgb6Ezypwnixca4ZUv2FPG6xyKU9Zzry9TA7EwxugDm0HCqeZdBbTv42ziZ
         1uKFv5F9SzNVPL+ksK08s5q/Gp16+78QSSROeE+/YoG+Z6Y0C13LgnR40ua+ilJ8uFXf
         i1w7ED7IlE6sOnGL3yfMYWFVmcXFwPxFEMisoFK/3a+XAhYUaeZWODvqj+oSC9VaT9GK
         C6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BvNPTfqT/5f4cwjyqGfBMaYw7woP/GveWw32QYUqvjQ=;
        b=ufjoS7YfwYL9iRVXJPQG1ze1p76hcWoZM5t1y0dd68/TNHCKeSrF+1eE/1D1VUfwzm
         Bi+yIqEUoUZip1NFPMkCNYd0GUD82sJPqJTeYMMKTK+fxYDMOxydYqtDC3UyEdzeWEEc
         wuC/0Kb6kNEANFoMx61Yp9o0p6wBF3dw6fQPenp2SXbt7x0pMH2R8tudzOrcBehEFkLd
         w2XJeb/GdX9ZmoEhEjyfQEzL6zgZuwWsQM0+qfx3vpgDeghqBCEgNCxuBKSQsZNhUd9G
         ZN1nmTEsecwfvRKuGmVRsNcknFhe0cffhD95OrvP8zyTlcT1amsOoY2KgGmRSuqoAdMl
         TkWA==
X-Gm-Message-State: AOAM530MscRZB0ZTgZDLHhZEwlnm7mtxbUbtD7KUUqaSauBA26OhW92J
        b8FXhHH9w4D23nS14esPzMffNQ==
X-Google-Smtp-Source: ABdhPJyDT2FjXRhiezNWphPPvJWhCSrfs/NCvloIzCEVdKgu+rtZoKa3mNCAs3vrPbn9eMtLMSYZQQ==
X-Received: by 2002:a17:902:ee83:b029:da:3483:3957 with SMTP id a3-20020a170902ee83b02900da34833957mr92959pld.38.1610470446670;
        Tue, 12 Jan 2021 08:54:06 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id 21sm3742730pfx.84.2021.01.12.08.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:54:05 -0800 (PST)
Date:   Tue, 12 Jan 2021 08:53:59 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        syzbot <syzbot+e87846c48bf72bc85311@syzkaller.appspotmail.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <joro@8bytes.org>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: UBSAN: shift-out-of-bounds in kvm_vcpu_after_set_cpuid
Message-ID: <X/3UJ7EtyAb2Ww+6@google.com>
References: <000000000000d5173d05b7097755@google.com>
 <CALMp9eSKrn0zcmSuOE6GFi400PMgK+yeypS7+prtwBckgdW0vQ@mail.gmail.com>
 <X/zYsnfXpd6DT34D@google.com>
 <f1aa1f3c-1dac-2357-ee1c-ab505513382f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1aa1f3c-1dac-2357-ee1c-ab505513382f@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021, Paolo Bonzini wrote:
> On 12/01/21 00:01, Sean Christopherson wrote:
> > > Perhaps cpuid_query_maxphyaddr() should just look at the low 5 bits of
> > > CPUID.80000008H:EAX?
> 
> The low 6 bits I guess---yes, that would make sense and it would have also
> fixed the bug.

No, that wouldn't have fixed this specific bug.  In this case, the issue was
CPUID.80000008H:AL == 0; masking off bits 7:6 wouldn't have changed anything.

And, masking bits 7:6 is architecturally wrong.  Both the SDM and APM state that
bits 7:0 contain the number of PA bits.

KVM could reject guest.MAXPA > host.MAXPA, but arbitrarily dropping bits would
be wrong.
