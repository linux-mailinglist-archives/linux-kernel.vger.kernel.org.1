Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF312BAEEE
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 16:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbgKTP1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 10:27:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:33746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbgKTP1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 10:27:17 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 769352240B;
        Fri, 20 Nov 2020 15:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605886036;
        bh=zkypNPVntse5hesjdrXLwa0zi5Eu4BcMXLccRupOcic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QNHSEdTFBO8wQy1q4Af7SAAp0dtJLCmAoxTm5/L3gu4AwADVtUU8SmsdYcWxZ1C9v
         +Jq1xaflQIfNJAe2AuSUpk0FWcMwJEpddzWJsqXl9QXZVDoh9qmCLp3axXc2bgH2wt
         woubZobgT06zqSDAgHTQLIk4yFRYz44KkVSJVHrY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kg8Je-00CI9B-2v; Fri, 20 Nov 2020 15:27:14 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Nov 2020 15:27:14 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     tytso@mit.edu, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        broonie@kernel.org, andre.przywara@arm.com
Subject: Re: [PATCH] random: avoid arch_get_random_seed_long() when collecting
 IRQ randomness
In-Reply-To: <20201105152944.16953-1-ardb@kernel.org>
References: <20201105152944.16953-1-ardb@kernel.org>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d6cfb1487c1077a7b413276c838dc7aa@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, tytso@mit.edu, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com, broonie@kernel.org, andre.przywara@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-05 15:29, Ard Biesheuvel wrote:
> When reseeding the CRNG periodically, arch_get_random_seed_long() is
> called to obtain entropy from an architecture specific source if one
> is implemented. In most cases, these are special instructions, but in
> some cases, such as on ARM, we may want to back this using firmware
> calls, which are considerably more expensive.
> 
> Another call to arch_get_random_seed_long() exists in the CRNG driver,
> in add_interrupt_randomness(), which collects entropy by capturing
> inter-interrupt timing and relying on interrupt jitter to provide
> random bits. This is done by keeping a per-CPU state, and mixing in
> the IRQ number, the cycle counter and the return address every time an
> interrupt is taken, and mixing this per-CPU state into the entropy pool
> every 64 invocations, or at least once per second. The entropy that is
> gathered this way is credited as 1 bit of entropy. Every time this
> happens, arch_get_random_seed_long() is invoked, and the result is
> mixed in as well, and also credited with 1 bit of entropy.
> 
> This means that arch_get_random_seed_long() is called at least once
> per second on every CPU, which seems excessive, and doesn't really
> scale, especially in a virtualization scenario where CPUs may be
> oversubscribed: in cases where arch_get_random_seed_long() is backed
> by an instruction that actually goes back to a shared hardware entropy
> source (such as RNDRRS on ARM), we will end up hitting it hundreds of
> times per second.
> 
> So let's drop the call to arch_get_random_seed_long() from
> add_interrupt_randomness(), and instead, rely on crng_reseed() to call
> the arch hook to get random seed material from the platform.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Looks sensible. Having this on the interrupt path looks quite
heavy handed, and my understanding of the above is that it has
an adverse effect on the entropy pool.

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
