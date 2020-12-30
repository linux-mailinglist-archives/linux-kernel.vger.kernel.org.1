Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F362E77EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 12:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgL3LDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 06:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgL3LDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 06:03:44 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250FEC061799
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 03:03:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 3so4446766wmg.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Dec 2020 03:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WS30afWY3GKACZJXCkkdeuRXpGLieFQFBc+EFWHXZ8I=;
        b=mcpxu45JEAPmoccMikSFXPzTHkYmNC9Cr2PxZF40ApQKLEt8ZByo+t4Jg+RtvlgioZ
         KPFZPvQog2EMXmEuRxbQyh1m8Tgk0umqTlpZKvxJUo2DJucEj9nfKymKPAPUqWFAD9cO
         VYzGwqDMiJn+rq4wPNXnI3mmw0MGIG408+6RDbnHSbM81z7fptRzXUanxDddqvV6JwKw
         4P6vsMKVg5ADZEBJVnbIoINXwH3okfS0SYIXIG1pW9wX36MQ5b/4XwpAYWA6Mc6UXq5Z
         SGY8fG+SjE0UUOIQdOSxaWjRr8S/Xouoc3xoINaMgpjvsBwb3pXklmthHBqXNoVcw2gD
         O+Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WS30afWY3GKACZJXCkkdeuRXpGLieFQFBc+EFWHXZ8I=;
        b=IJL3Kfx49RMQ01Z18mVK3sfNgN9Hw8oypfe3Qly9awxQU2foWsNdnnDtYNGuN3MMS/
         T8/PJYg/CaUYmEdxANd/G0POHadub8vClDYUaPCFt201R2zfkOQCDthnbF3vrx4Wgx7m
         hruCh75zYZCOqNdMP46RWBuYifqSp938gKie3xjRlPhruShqoS+GCNk7I5n+Wsy+i+Ch
         4xloqMh+C4ZLoBf6LTle+ylXCGYwCM8GMkVatp3EpT5uyjgSrE9ZV02WndHdle61FFEx
         SXdY5gpdwe262MYyROa2728qYwVpljM1qvYY1RLOKj/fwy/FaLcW3ljwAmFk7kafoGqc
         CMug==
X-Gm-Message-State: AOAM532kuEYN/GAAAWWFmdgq0nHX+ESTE1KjsMX3STSylPFzVvnVopRq
        S2/Tg/zXjD+Zw7mcPmgaH+esTA==
X-Google-Smtp-Source: ABdhPJzRBv6eAt8+sGkPthVC4MF6WX/caLmzGEjiLKFuGvqf5bNuQxrUjMah5pk6tT2ykIwAJbZmTw==
X-Received: by 2002:a1c:4156:: with SMTP id o83mr7146093wma.178.1609326182577;
        Wed, 30 Dec 2020 03:03:02 -0800 (PST)
Received: from google.com ([2a01:4b00:8523:2d03:b0e4:997:fb3:e517])
        by smtp.gmail.com with ESMTPSA id y130sm7256253wmc.22.2020.12.30.03.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 03:03:01 -0800 (PST)
Date:   Wed, 30 Dec 2020 11:03:00 +0000
From:   David Brazdil <dbrazdil@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     kvmarm@lists.cs.columbia.edu, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH] KVM: arm64: Allow PSCI SYSTEM_OFF/RESET to return
Message-ID: <20201230110300.a2wei7ojhjkqfkgk@google.com>
References: <20201229160059.64135-1-dbrazdil@google.com>
 <229d84b8d7818a170adf489535ea2d43@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <229d84b8d7818a170adf489535ea2d43@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 29, 2020 at 05:16:41PM +0000, Marc Zyngier wrote:
> Hi David,
> 
> On 2020-12-29 16:00, David Brazdil wrote:
> > The KVM/arm64 PSCI relay assumes that SYSTEM_OFF and SYSTEM_RESET should
> > not return, as dictated by the PSCI spec. However, there is firmware out
> > there which breaks this assumption, leading to a hyp panic. Make KVM
> > more robust to broken firmware by allowing these to return.
> > 
> > Signed-off-by: David Brazdil <dbrazdil@google.com>
> > ---
> >  arch/arm64/kvm/hyp/nvhe/psci-relay.c | 13 +++++--------
> >  1 file changed, 5 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> > b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> > index e3947846ffcb..8e7128cb7667 100644
> > --- a/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> > +++ b/arch/arm64/kvm/hyp/nvhe/psci-relay.c
> > @@ -77,12 +77,6 @@ static unsigned long psci_forward(struct
> > kvm_cpu_context *host_ctxt)
> >  			 cpu_reg(host_ctxt, 2), cpu_reg(host_ctxt, 3));
> >  }
> > 
> > -static __noreturn unsigned long psci_forward_noreturn(struct
> > kvm_cpu_context *host_ctxt)
> > -{
> > -	psci_forward(host_ctxt);
> > -	hyp_panic(); /* unreachable */
> > -}
> > -
> >  static unsigned int find_cpu_id(u64 mpidr)
> >  {
> >  	unsigned int i;
> > @@ -251,10 +245,13 @@ static unsigned long psci_0_2_handler(u64
> > func_id, struct kvm_cpu_context *host_
> >  	case PSCI_0_2_FN_MIGRATE_INFO_TYPE:
> >  	case PSCI_0_2_FN64_MIGRATE_INFO_UP_CPU:
> >  		return psci_forward(host_ctxt);
> > +	/*
> > +	 * SYSTEM_OFF/RESET should not return according to the spec.
> > +	 * Allow it so as to stay robust to broken firmware.
> > +	 */
> >  	case PSCI_0_2_FN_SYSTEM_OFF:
> >  	case PSCI_0_2_FN_SYSTEM_RESET:
> > -		psci_forward_noreturn(host_ctxt);
> > -		unreachable();
> > +		return psci_forward(host_ctxt);
> >  	case PSCI_0_2_FN64_CPU_SUSPEND:
> >  		return psci_cpu_suspend(func_id, host_ctxt);
> >  	case PSCI_0_2_FN64_CPU_ON:
> 
> Thanks for having tracked this.
> 
> I wonder whether we should also taint the kernel in this case,
> because this is completely unexpected, and a major spec violation.
> 
> Ideally, we'd be able to detect this case and prevent pKVM from
> getting initialised at all, but I guess there is no way to detect
> the sucker without ... calling SYSTEM_RESET?

Yeah, there are no bits to check, unfortunately. :(

David
