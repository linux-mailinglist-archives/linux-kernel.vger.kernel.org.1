Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B630B2D6D89
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 02:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387780AbgLKB3K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 20:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgLKB2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 20:28:37 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880F6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:27:56 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id q22so5923531pfk.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 17:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fWr8U+kXnUtyCph460iKXgFKQR+fNvbC1nN6Nlkztp0=;
        b=ZaNxqRR6SZMZjPpbyKQMlaMsfq4kbnQKu5FGUzfr/tnasU8gwihwQRX9wnLifpdL1p
         ombS0U5LUkJwjZUht05LBHeIGje3niNFnIL7lQ9ZpeXGjEJkeWoKHpT0JMcvXCb83Y1s
         IBzgauqRon7Bu/Qr79VsjCFHfgPkREz+6CVfOlMuaRP0fyyej+ERPszh3Srnv20ExIIO
         DwOeWgCfzHTdNcZ75X/eSpV5dHEz1umHbASijwfWrmqFWulWziTZFCdrsX90Q/FGsCLR
         uF60anQyUXslPTSJEw9Qi0SA1uqzfMFikLSSunQzOoIur44TlNbSdQUpr83/54kDGLk1
         5sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fWr8U+kXnUtyCph460iKXgFKQR+fNvbC1nN6Nlkztp0=;
        b=bjQocel/hfCc1yDzbnbT2tOSEAAAaTSLLMKDJugDhidHlQz8zTqn0WK3tkVxSGvW0T
         JuTKHjcwbjRjXcyaTYHVUR2+RhRELFT2hpqS20aRcdjnJFz79lRdaobmwDvQ8HQ/2lH2
         veuQcYU7UqXoE5eE0+16tUNf0voR8ZxFsGpdtjjUvJj6c6DAhPVPSQJj43f5z10QC60t
         LHv0Phjz7VvJ2C8uGVC6gXmUxvneotVogNcv1GXbq7k6pvKl4WBHNXKxnSmUiVnB3oHb
         wYcpxjr5GYFHpG+q0ROTyyDPk2fMArYYDn/XYVXNM+gZVwTPLBRQeDSGDQeuXN/P0SnS
         1MXw==
X-Gm-Message-State: AOAM530ygzOZ592CiV5ynvV/PQk9WnnNn/nrw3NBoaAS4f49TX4JOev5
        0egwBcvDAyBSnCQS8MsJ7oTvpA==
X-Google-Smtp-Source: ABdhPJx+i1oAVoAOcuGDKv+cJFLCL/wYuUjwbeD1UVOF/7I/dRrQ8oXkRjiFg+ggxQx2FrmlgcuCsA==
X-Received: by 2002:a17:90b:4b02:: with SMTP id lx2mr10823934pjb.49.1607650075946;
        Thu, 10 Dec 2020 17:27:55 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id y19sm7657522pfp.211.2020.12.10.17.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 17:27:55 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:27:48 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Michael Roth <michael.roth@amd.com>,
        kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH] KVM: SVM: use vmsave/vmload for saving/restoring
 additional host state
Message-ID: <X9LLFMN5CNPIikSp@google.com>
References: <20201210174814.1122585-1-michael.roth@amd.com>
 <CALCETrXo+2LjUt_ObxV+6u6719gTVaMR4-KCrgsjQVRe=xPo+g@mail.gmail.com>
 <160763562772.1125101.13951354991725886671@vm0>
 <CALCETrV2-WwV+uz99r2RCJx6OADzwxaLxPUVW22wjHoAAN5cSQ@mail.gmail.com>
 <160764771044.1223913.9946447556531152629@vm0>
 <CALCETrVuCZ5itAN3Ns3D04qR1Z_eJiA9=UvyM95zLE076X=JEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrVuCZ5itAN3Ns3D04qR1Z_eJiA9=UvyM95zLE076X=JEA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael, please reply to all so that everyone can read along and so that the
conversation gets recorded in the various mailing list archives.

If you are replying all, then I think something funky is going on with AMD's
mail servers, as I'm not getting your responses (I double checked SPAM), nor are
they showing up on lore.

On Thu, Dec 10, 2020, Andy Lutomirski wrote:
> > On Dec 10, 2020, at 4:48 PM, Michael Roth <michael.roth@amd.com> wrote:
> >
> 
> >> I think there are two reasonable ways to do this:
> >>
> >> 1. VMLOAD before STGI.  This is obviously correct, and it's quite simple.
> >
> > For the testing I ended up putting it immediately after __svm_vcpu_run()
> > since that's where we restored GS base previously. Does that seem okay or did
> > you have another place in mind?
> 
> Looks okay.  If we get an NMI or MCE with the wrong MSR_GS_BASE, then
> we are toast, at least on Zen 2 and earlier.  But that spot has GI ==
> 0, so this won't happen.
