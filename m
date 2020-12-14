Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C555B2DA0B9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 20:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441151AbgLNTmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 14:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439971AbgLNTmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 14:42:42 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA26C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 11:42:02 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id r4so9308675pls.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 11:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=tQ1Bpu5oHoBGvr4L4gTgzNHgLGZGVMAxov28riT0mIk=;
        b=nDBML6/9KtUJt5AWaYUKQflXKeK3VuKMTrX1RFv6y8ooY5/ol4lS8Z3W70b26pmrfJ
         NFKxUG8kf2HMgppCqREHwAYV8nUy5lGfa37TtU70cPxL/GaqaQLTGJo+8qlE5XynIajI
         rPbGO5xRmDDMJPJNVRwGzeTsRd6wf49l8kyue9oU0QQYQ7bf4bfqE4uxRiwUCnQWZBwP
         YE5IkCmrJg788kJaSY9NJ0D9cUcYwvGRrMGvuLqeai0iL3w4Oodhrk0PFg8Cd3mMKkBw
         YW9CqEIPYtqPE7ATJs56fNhuwVnoe8y8rus+HQcPwQZhzg2GA8ZuTg8kgZdRttEEetmW
         3MDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tQ1Bpu5oHoBGvr4L4gTgzNHgLGZGVMAxov28riT0mIk=;
        b=lazLC6H7c6sVrlVPSKeKWmOvB/BTkCck0UXnNkgAmttqarAnRNabFD6ZAFEtb8/kd+
         Ke+2BeZXQHKnFXre2A7fIx6LnKcUYsG6nbgN/B9IpFI1A2psEVacuwy5G6Eth//BfT4U
         YPJQ5R337gcD+/2r5JBIW49XuP6lxJCt5VCTdsOu9cBD+Hsa/smWD7Mo8upEM+9ZSRwI
         aDNCFXqgXOYaqJbWerBGFgHF7hTtZsh3rvQx3XF3oN1Nk5IXXdCd3f7gmgdLITEXgU6n
         p23eW+Ee0n7IbxOHnooIX+D2dx67Wtlq9yeZVMHMz2DYSDfuqY7HfET4UzocB5k71hyy
         4XfQ==
X-Gm-Message-State: AOAM531n6A0dBulsHYKeAycx46kVz+E1WjPD82WlsLuHcoEKzVyFcka4
        SpnlEw9GJhLHB0y+xHnFIEoxsg==
X-Google-Smtp-Source: ABdhPJxut0s9zU9vwkfccoPDTRKtBV5FQ6zi56LS/XeWZaLsLJSLO9kMNI9kNB9W9Klijp1XuHZZXg==
X-Received: by 2002:a17:90b:80d:: with SMTP id bk13mr22195210pjb.41.1607974921955;
        Mon, 14 Dec 2020 11:42:01 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id h7sm21031678pfr.210.2020.12.14.11.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Dec 2020 11:42:01 -0800 (PST)
Date:   Mon, 14 Dec 2020 11:41:54 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v5 12/34] KVM: SVM: Add initial support for a VMGEXIT
 VMEXIT
Message-ID: <X9fAAhF2LzOmZAtv@google.com>
References: <cover.1607620209.git.thomas.lendacky@amd.com>
 <c6a4ed4294a369bd75c44d03bd7ce0f0c3840e50.1607620209.git.thomas.lendacky@amd.com>
 <7bac31c8-a008-8223-0ed5-9c25012e380a@redhat.com>
 <33e98d2d-93b5-acd6-4608-f30c709019ad@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <33e98d2d-93b5-acd6-4608-f30c709019ad@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020, Tom Lendacky wrote:
> On 12/14/20 9:45 AM, Paolo Bonzini wrote:
> > On 10/12/20 18:09, Tom Lendacky wrote:
> >> @@ -3184,6 +3186,8 @@ static int svm_invoke_exit_handler(struct vcpu_svm
> >> *svm, u64 exit_code)
> >>           return halt_interception(svm);
> >>       else if (exit_code == SVM_EXIT_NPF)
> >>           return npf_interception(svm);
> >> +    else if (exit_code == SVM_EXIT_VMGEXIT)
> >> +        return sev_handle_vmgexit(svm);
> > 
> > Are these common enough to warrant putting them in this short list?
> 
> A VMGEXIT exit occurs for any of the listed NAE events in the GHCB
> specification (e.g. CPUID, RDMSR/WRMSR, MMIO, port IO, etc.) if those
> events are being intercepted (or triggered in the case of MMIO). It will
> depend on what is considered common. Since SVM_EXIT_MSR was already in the
> list, I figured I should add VMGEXIT.

I agree VMGEXIT should be added to the hot path, it could very well be the most
common exit reason due to all instruction-based emulation getting funneled
through VMGEXIT.
