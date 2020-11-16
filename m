Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02FA82B43DE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 13:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgKPMki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 07:40:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:49322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbgKPMkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 07:40:37 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0D1020855;
        Mon, 16 Nov 2020 12:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605530437;
        bh=bnRBIAdk2TK++2iHRYZosXliTCu3OhJv4rdoa2NVmfc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=C+oCIIJGqLI68KPl/ac6T0nLWv4BxqB2Qz8BM1c0poeVLdfo9EQ45dutdqrK6+SEW
         PcGUDLNaPuo5rzZfBnu89Gj8a0GA6dDFBXUezlABZ318hrbzUg5UwJurDquQrfeagG
         IHXngfRu+tLaihN9baJrEjNYH+UZjNZ6J+rWOHUg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kedoA-00B0ja-Od; Mon, 16 Nov 2020 12:40:34 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 16 Nov 2020 12:40:34 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     David Brazdil <dbrazdil@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Quentin Perret <qperret@google.com>,
        Andrew Scull <ascull@google.com>,
        Andrew Walbran <qwandor@google.com>, kernel-team@android.com
Subject: Re: [PATCH v1 13/24] kvm: arm64: Add CPU entry point in nVHE hyp
In-Reply-To: <20201116114952.ybj24wx44lofqs25@google.com>
References: <20201109113233.9012-1-dbrazdil@google.com>
 <20201109113233.9012-14-dbrazdil@google.com>
 <7b8f9dec846f172c2919e1d3f3c65245@kernel.org>
 <20201116114952.ybj24wx44lofqs25@google.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <549d918182c28d88550d27c068b772be@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: dbrazdil@google.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org, dennis@kernel.org, tj@kernel.org, cl@linux.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, qperret@google.com, ascull@google.com, qwandor@google.com, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-16 11:49, David Brazdil wrote:
>> >  #ifdef CONFIG_CPU_PM
>> >    DEFINE(CPU_CTX_SP,		offsetof(struct cpu_suspend_ctx, sp));
>> > diff --git a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
>> > b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
>> > index 1697d25756e9..f999a35b2c8c 100644
>> > --- a/arch/arm64/kvm/hyp/nvhe/hyp-init.S
>> > +++ b/arch/arm64/kvm/hyp/nvhe/hyp-init.S
>> > @@ -6,6 +6,7 @@
>> >
>> >  #include <linux/arm-smccc.h>
>> >  #include <linux/linkage.h>
>> > +#include <linux/irqchip/arm-gic-v3.h>
>> 
>> This should probably be included from the file that provides 
>> init_el2_state.
> 
> Agreed. This is a workaround for the fact that the arm-gic* headers 
> don't play
> nice with each other (define the same constants).

Ah, that...

> Including arm-gic-v3.h in
> kvm_asm.h will trigger macro redefine warnings in vgic*-v2.c because 
> they
> include arm-gic.h.

Boo.

> Another option is to create a header just for el2 init. Would that be
> preferable? Other ideas?

Having an asm/el2_setup.h file feels like a better option. After all, it
is in no way KVM specific, and having the macros hanging around in
asm/kvm_asm.h feels odd.

         M.
-- 
Jazz is not dead. It just smells funny...
