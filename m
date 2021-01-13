Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBEA2F5052
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 17:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbhAMQq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 11:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbhAMQqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 11:46:55 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E054C061794
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:46:14 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id be12so1383852plb.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 08:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9DZGQQ6YS0FM27yVOlqK/RB1htOmSrpb6OR+gLuEAdA=;
        b=L3oEpqEAI23s33JBbqwLbts1JqaGwcUIxp37zD+7ODdPNQyjGvNdMSJy3hsmrhInlU
         m92g3W3GfLosjqnnzp2VHSBNMWVAnMwNYaXXLkxsxzmfBl8/hQhU2OJ/pSBYCRujdvnw
         1A/4OETHZ2IJs/CK88PWrGoXAabG8wThJwUiSnKEgTS74wReXjeAOHsFrhaRr2jleQ7p
         5P+aiwC9etXkNfoISD3wwp+Xn9uyRWtBcqZXSQxNOHWeo591cZGvnjL1vSbeNK7JDpAU
         iqdfXb0psWz6D5gt0In6ntq4vFQS2macvsm0g/hGekJh3yu1CD+Ep/R13CTuABWiMRpf
         52cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9DZGQQ6YS0FM27yVOlqK/RB1htOmSrpb6OR+gLuEAdA=;
        b=ESN9PlsvwcPzhO8zeaCgTp94NI0jyyo9uZDw94A91fDUI6ma1spwOv/yokIjxRuei2
         Ht2MU6RfP24s98H81XwB3tKFivhK+vN1mmDyioaBsuHZo6pf/ixxly6obsALXngvzFno
         yDfg5rIgnc7FoO2EghxT2MPnQ4cFOUgiASV2H2t/paUloqCN1GKQ2TkCtV4p2JJsF4FR
         3bclEsVs4uEvw+PnJzz1r4BLC77rEGN7DLh7YqDXuph3iq0UT499Z+BNvtyNj06rdePb
         +FO21ULFVF+3LFfjN6pXAgLgzhAc8xcy1hV+HS3Cdb3FKihfk1yWtpnY9KLHisBG5tkJ
         OcQg==
X-Gm-Message-State: AOAM532BVK+x26LYQODY78oEuM6K39RZymVWqTQ2VMelaGIag10ieUD6
        aW5S2raBgmiicIV05g9KoQ/pyQ==
X-Google-Smtp-Source: ABdhPJxdMPm27J2Oc6/EugaAxG/gkAcbAmOOs1mD5eP6nFldX6vpLxzKg9sJbkAC7ohQt1KieDWrYQ==
X-Received: by 2002:a17:90b:11d8:: with SMTP id gv24mr148563pjb.232.1610556373964;
        Wed, 13 Jan 2021 08:46:13 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id i67sm3195965pfc.153.2021.01.13.08.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 08:46:13 -0800 (PST)
Date:   Wed, 13 Jan 2021 08:46:06 -0800
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
Message-ID: <X/8jzqzDV35mAnIF@google.com>
References: <000000000000d5173d05b7097755@google.com>
 <CALMp9eSKrn0zcmSuOE6GFi400PMgK+yeypS7+prtwBckgdW0vQ@mail.gmail.com>
 <X/zYsnfXpd6DT34D@google.com>
 <f1aa1f3c-1dac-2357-ee1c-ab505513382f@redhat.com>
 <X/3UJ7EtyAb2Ww+6@google.com>
 <d3cc2a46-6b8b-cf7c-66f0-22fe4c05465e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3cc2a46-6b8b-cf7c-66f0-22fe4c05465e@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021, Paolo Bonzini wrote:
> On 12/01/21 17:53, Sean Christopherson wrote:
> > And, masking bits 7:6 is architecturally wrong.  Both the SDM and APM state that
> > bits 7:0 contain the number of PA bits.
> 
> They cannot be higher than 52,

Drat, I was going to argue that it could be >52 with a new paging mode, but both
the SDM and APM explicitly call out 52 as the max.  Spending cycles on the stuff
that really matters here... :-)

> therefore bits 7:6 are (architecturally)
> always zero.  In other words, I interpret "bit 7:0 contain the number of PA
> bits" as "you need not do an '& 63' yourself", which is basically the
> opposite of "bit 7:6 might be nonzero".  If masking made any difference, it
> would be outside the spec already.
> 
> In fact another possibility to avoid UB is to do "& 63" of both s and e in
> rsvd_bits.  This would also be masking bits 7:6 of the CPUID leaf, just done
> differently.

Hmm, 'e' is hardcoded in all call sites except kvm_mmu_reset_all_pte_masks(),
and so long as 'e <= 63' holds true, 's &= 63' is unnecessary.  What if we add
compile-time asserts on hardcoded values, and mask 'e' for the rare case where
the upper bound isn't hardcoded?  That way bogus things like rsvd_bits(63, 65)
will fail the build.

diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
index 581925e476d6..261be1d2032b 100644
--- a/arch/x86/kvm/mmu.h
+++ b/arch/x86/kvm/mmu.h
@@ -44,8 +44,15 @@
 #define PT32_ROOT_LEVEL 2
 #define PT32E_ROOT_LEVEL 3

-static inline u64 rsvd_bits(int s, int e)
+static __always_inline u64 rsvd_bits(int s, int e)
 {
+       BUILD_BUG_ON(__builtin_constant_p(e) && __builtin_constant_p(s) && e < s);
+
+       if (__builtin_constant_p(e))
+               BUILD_BUG_ON(e > 63);
+       else
+               e &= 63;
+
        if (e < s)
                return 0;
