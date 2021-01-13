Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD612F489E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 11:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbhAMK0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 05:26:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhAMK0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 05:26:23 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB22CC061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 02:25:42 -0800 (PST)
Received: from zn.tnic (p200300ec2f0b5c00b2d62b1c55c494d5.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:5c00:b2d6:2b1c:55c4:94d5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5EBBD1EC0373;
        Wed, 13 Jan 2021 11:25:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1610533541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=YrWhdTH8kDug+GkXK6GHdC/vwXSmvtJtNlQYw3RAXqM=;
        b=ZPwIrpsol8Si09PNtsdvDBpYnQVgcMT1vkx4iI4TwCAGBRIdisTUoBAPOoMdD7y2gvbAmi
        TI8yvlv+j2K4qmCpc27kBUwLV4s7ZOymm7jOMw8Yrf+L3QYj7/lgiDJwZXBSmQ4SF/PnYV
        HTD0UhKNZKHatbVGsjwrIhD71gRqftI=
Date:   Wed, 13 Jan 2021 11:25:36 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Anand K Mistry <amistry@google.com>
Cc:     x86@kernel.org, asteinhauser@google.com, tglx@linutronix.de,
        joelaf@google.com, Anand K Mistry <amistry@chromium.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Julien Thierry <jthierry@redhat.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] x86/speculation: Add finer control for when to issue
 IBPB
Message-ID: <20210113102536.GC16960@zn.tnic>
References: <20210113194619.RFC.1.I8f559ecdb01ffa98d5a1ee551cb802f288a81a38@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210113194619.RFC.1.I8f559ecdb01ffa98d5a1ee551cb802f288a81a38@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 07:47:19PM +1100, Anand K Mistry wrote:
> When IB speculation is conditionally disabled for a process (via prctl()
> or seccomp), IBPB is issued whenever that process is switched to/from.
> However, this results more IBPBs than necessary. The goal is to protect
> a victim process from an attacker poisoning the BTB by issuing IBPB in
> the attacker->victim switch. However, the current logic will also issue
> IBPB in the victim->attacker switch, because there's no notion of
> whether the attacker or victim has IB speculation disabled.
> 
> Instead of always issuing IBPB when either the previous or next process
> has IB speculation disabled, add a boot flag to explicitly choose
> to issue IBPB when the IB spec disabled process is entered or left.
> 
> Signed-off-by: Anand K Mistry <amistry@google.com>
> Signed-off-by: Anand K Mistry <amistry@chromium.org>

Two SoBs by you, why?

> ---
> Background:
> IBPB is slow on some CPUs.
> 
> More detailed background:
> On some CPUs, issuing an IBPB can cause the address space switch to be
> 10x more expensive (yes, 10x, not 10%).

Which CPUs are those?!

> On a system that makes heavy use of processes, this can cause a very
> significant performance hit.

You're not really trying to convince reviewers for why you need to add
more complexity to an already too complex and confusing code. "some
CPUs" and "can cause" is not good enough.

> I understand this is likely to be very contentious. Obviously, this
> isn't ready for code review, but I'm hoping to get some thoughts on the
> problem and this approach.

Yes, in the absence of hard performance data, I'm not convinced at all.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
