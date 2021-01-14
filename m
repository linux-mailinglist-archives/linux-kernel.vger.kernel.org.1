Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1B22F6768
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 18:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbhANRUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 12:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbhANRUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 12:20:30 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D4EC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:19:49 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id h10so3733936pfo.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 09:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1u0hHUSEEliOo8V4yriPq3cyKn6ullY8YW9KiIkobfk=;
        b=ZLp3EJqLl7TKSrMFy/TKrGf2U1rKvMJs7XG0MKq6/Jv5xjQ0FqkHFtNPKAGDqSEUg6
         FAxAKuhq+I5/NhJcaO9RflWofjeog+IfggZW7hrHLRI+3AU3KyzSELXgPqy7dOL+yQde
         jkiWFBfTWTXHCMUcNRWG/kMxZHrELQoalbMyGYO9d13qzinFZm/H9Dx3eEEnmJXGpKmh
         m+cw4LuXB47cfFpnAQ920Tx4rmWPmanVu3SLTovBylVQ8s9zBmPSFN4pD8QY7d+PrQ2F
         rGrrTcjZVFW2bBNhHodDOF5izfhgO2crwZQpgaY/bek9Rb1uMO/qNO8Zd11+rebZoiCV
         Mwqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1u0hHUSEEliOo8V4yriPq3cyKn6ullY8YW9KiIkobfk=;
        b=ZnXcKPdlYZkped4YK2T4v8pDwZIMrXqAyo/TdWov+xnq/V9NZPXy32zY52FN6BZB39
         xDb7uR7X4oiX1y1ChP872ypZJSibU2TN/4dlAbkCamwhiPzX3rGLcO2lBmu8MkXbHj3e
         y2G2OA/cHS/jraT9cDFqU97O15PZ58IVUalrQ1OGwI1OXGarXRl4qdpg9TbUvyd74k/8
         2bP9LPEm2KosScZnJCawZJTwC1RCvomnUU8lbHJBvXly9TWh0MlBrfTcgCNiFC/3YKk3
         +ljpf/Fo9T/NBh1UfjC3ryGefhDNS/vYdZyN4vrCuyHn7d9mMgHnAtgaDQsPuyscC+Wj
         BD4A==
X-Gm-Message-State: AOAM5312gMAKKjSsyK7ODGXnbDpJP5+qceIbqi70H9O3Z2G4xeOvlWo+
        ABh6RE8L/Cgpxow/BOmjT3LHLw==
X-Google-Smtp-Source: ABdhPJweuJc1T4THuTPmRtUm+GC8wnx68SsRpiLogsaNQieDiFp+SxU8TeWgZA5DbFRruL9nXzfBTw==
X-Received: by 2002:a63:4b16:: with SMTP id y22mr8432122pga.203.1610644788272;
        Thu, 14 Jan 2021 09:19:48 -0800 (PST)
Received: from google.com ([2620:15c:f:10:1ea0:b8ff:fe73:50f5])
        by smtp.gmail.com with ESMTPSA id u189sm5721402pfb.51.2021.01.14.09.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 09:19:47 -0800 (PST)
Date:   Thu, 14 Jan 2021 09:19:40 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     Bandan Das <bsd@redhat.com>, Wei Huang <wei.huang2@amd.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, vkuznets@redhat.com, joro@8bytes.org,
        bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        jmattson@google.com, wanpengli@tencent.com, dgilbert@redhat.com
Subject: Re: [PATCH 1/2] KVM: x86: Add emulation support for #GP triggered by
 VM instructions
Message-ID: <YAB9LIIVg8iEfXsb@google.com>
References: <20210112063703.539893-1-wei.huang2@amd.com>
 <X/37QBMHxH8otaMa@google.com>
 <jpgsg76kjsm.fsf@linux.bootlegged.copy>
 <db574a30f50a2f556dc983f18f78f28c933fdac7.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db574a30f50a2f556dc983f18f78f28c933fdac7.camel@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021, Maxim Levitsky wrote:
> On Tue, 2021-01-12 at 15:00 -0500, Bandan Das wrote:
> > Sean Christopherson <seanjc@google.com> writes:
> > ...
> > > > -	if ((emulation_type & EMULTYPE_VMWARE_GP) &&
> > > > -	    !is_vmware_backdoor_opcode(ctxt)) {
> > > > -		kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
> > > > -		return 1;
> > > > +	if (emulation_type & EMULTYPE_PARAVIRT_GP) {
> > > > +		vminstr = is_vm_instr_opcode(ctxt);
> > > > +		if (!vminstr && !is_vmware_backdoor_opcode(ctxt)) {
> > > > +			kvm_queue_exception_e(vcpu, GP_VECTOR, 0);
> > > > +			return 1;
> > > > +		}
> > > > +		if (vminstr)
> > > > +			return vminstr;
> > > 
> > > I'm pretty sure this doesn't correctly handle a VM-instr in L2 that hits a bad
> > > L0 GPA and that L1 wants to intercept.  The intercept bitmap isn't checked until
> > > x86_emulate_insn(), and the vm*_interception() helpers expect nested VM-Exits to
> > > be handled further up the stack.
> 
> Actually IMHO this exactly what we want. We want L0 to always intercept
> these #GPs, and hide them from the guest.
> 
> What we do need to do (and I prepared and attached a patch for that, is that
> if we run a guest, we want to inject corresponding vmexit (like
> SVM_EXIT_VMRUN) instead of emulating the instruction.

Yes, lack of forwarding to L1 as a nested exit is what I meant by "doesn't
correctly handle".
