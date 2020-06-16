Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 071121FBBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 18:44:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgFPQln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729427AbgFPQlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 12:41:42 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE27AC06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:41:41 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p20so3723237iop.11
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 09:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgiLLSBGA223H5TAhCSj/hgR01Hlhe8S8Wf2/KW6kvo=;
        b=Dz34/32BNL3fRPgXVmyh382Ts453LNFzg6pWaO+lG/7y4IpLrZO5cPJnUBQf7MGm8q
         h6CmPHJdU/VT6XT0rIr8qzcjDt1xxlMY7tjFC6DoqY8/LsKYOxwVWoQ+PGOCFWibXpPH
         quMmgd8Ji43xjSOhfreGqrpRVaLoCYL+X3HNf50ItsxFtVUzE2c/Ntn2TNJ1RpV1GnfB
         Unml7k5oEVJke9b3uoEjSAnB/bbYE+QppQuYhuFQAjVLWwnDUAEORP2amD26AtEkSJBR
         ggv8hPI8wroyHcprg7iOQTAKokcfRYnCcEMdWBCVqxQJ4uE1A3Pe3sdceMo/C/sb/Q1n
         z+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgiLLSBGA223H5TAhCSj/hgR01Hlhe8S8Wf2/KW6kvo=;
        b=sc+8XXRznfRQs3xQ+Ao1akJzXKZuOFOW5zx5a7TizRVI8PfzZJS1IudH7T4MJFLu9+
         9scZex//KGsShh/06aBGVo/Mp09oAusAJ3w0CNqhZBCG23+iMtL49tMAbhASA3JlBGWi
         uUhx87O2Nu+GTIg0PCXg0GzIM4DfgX786jV5KU/sXVZX93oYKNce5R1V9L02P1fiZxRM
         1p9FtupBrfrqgjTF4R9ff4deckWDJIX6BPCuGDpXGgIiJXyvQgbxcV2xLtAPzftsByvK
         /nwD4nM5VNBvW9H6qbY7TYGU9anjywiLeUKZyNC1qqcqkPpKpkaAtmAvUJ/SfP6Wh7PM
         agvg==
X-Gm-Message-State: AOAM5314Vp/ywOOYsCgNx/HECldAa46G74Ok+A5dJIXAAgr3ae/r8mPO
        AsNYOP/fe2H07Igk1yQGBL90+Lt72FtGj6YMyN0VbA==
X-Google-Smtp-Source: ABdhPJwJJwzHoE6NPuipPgyqZfWjjpU4O9UdIax1EBMqoQKVk3er+lO+1smvpiFw2laMT0nQM2ojwIg9x8UY+CLCpiY=
X-Received: by 2002:a05:6602:1616:: with SMTP id x22mr4061778iow.70.1592325700791;
 Tue, 16 Jun 2020 09:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200616073307.16440-1-xiaoyao.li@intel.com> <20200616082042.GE26491@linux.intel.com>
In-Reply-To: <20200616082042.GE26491@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 16 Jun 2020 09:41:30 -0700
Message-ID: <CALMp9eQLTgUBhZCEj3iY6z0tuWxKQJU=uwndFSHW=uqscoAR8g@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix MSR range of APIC registers in X2APIC mode
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 1:20 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Tue, Jun 16, 2020 at 03:33:07PM +0800, Xiaoyao Li wrote:
> > Only MSR address range 0x800 through 0x8ff is architecturally reserved
> > and dedicated for accessing APIC registers in x2APIC mode.
> >
> > Fixes: 0105d1a52640 ("KVM: x2apic interface to lapic")
> > Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> > ---
>
> And perhaps more importantly, there are real MSRs that are overlapped,
> e.g. MSR_IA32_TME_ACTIVATE.  This probably warrants a Cc to stable; as you
> found out the hard way, this breaks ignore_msrs.
>
> Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>

Excellent find!

Reviewed-by: Jim Mattson <jmattson@google.com>
