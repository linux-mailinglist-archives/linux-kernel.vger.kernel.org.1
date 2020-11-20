Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 254A22BA6B6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKTJ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:56:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:32932 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbgKTJ4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:56:13 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1B9F22244;
        Fri, 20 Nov 2020 09:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605866172;
        bh=VVkthN6PzsNwKav+jWWYSe0oOoxcnTuHAa2bW9xdrDk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JlrTMzujpVHAOquvVdCT/TeBVpQc9kSlLkdIIHP9135juQpOAi/z/xxwAM8ARp6Jc
         g7gIsav3XkXJ2n250Yjt7HUdDMJBusaeWwC7fss+cFVmZrHSWcXl55swf3T/6MCQAJ
         CHXtwiv8tpj+QdbNUoJpFPlDvUN9ZTcbIge9ZxjA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kg39G-00CDQp-FA; Fri, 20 Nov 2020 09:56:10 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 20 Nov 2020 09:56:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Andrew Jones <drjones@redhat.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Haibo Xu <Haibo.Xu@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        James Morse <james.morse@arm.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
In-Reply-To: <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com>
References: <20201119153901.53705-1-steven.price@arm.com>
 <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com>
 <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <d615a77783bbfb60d3b1a9ab4b33c1dc@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: steven.price@arm.com, drjones@redhat.com, peter.maydell@linaro.org, mark.rutland@arm.com, dgilbert@redhat.com, Haibo.Xu@arm.com, suzuki.poulose@arm.com, qemu-devel@nongnu.org, catalin.marinas@arm.com, quintela@redhat.com, richard.henderson@linaro.org, linux-kernel@vger.kernel.org, Dave.Martin@arm.com, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, tglx@linutronix.de, will@kernel.org, kvmarm@lists.cs.columbia.edu, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-20 09:50, Steven Price wrote:
> On 19/11/2020 19:11, Marc Zyngier wrote:

> Does this sound reasonable?
> 
> I'll clean up the set_pte_at() change and post a v6 later today.

Please hold on. I still haven't reviewed your v5, nor have I had time
to read your reply to my comments on v4.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
