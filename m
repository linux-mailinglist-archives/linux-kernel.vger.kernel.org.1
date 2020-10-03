Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4547B2822DA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 11:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725805AbgJCJEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 05:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgJCJEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 05:04:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70ADC0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 02:04:40 -0700 (PDT)
Received: from zn.tnic (p200300ec2f1db40057382cf78206bf6d.dip0.t-ipconnect.de [IPv6:2003:ec:2f1d:b400:5738:2cf7:8206:bf6d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 644D91EC03D5;
        Sat,  3 Oct 2020 11:04:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1601715878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=1SH4DawKGxEBnhO6tanT/ub1CjAtxRG7qf1OcF1y/8s=;
        b=TZnuojTfjwJtSipbHXCP7Cioq6xQy829yAkzpGBy98Eq+9U3W3eVm6mBjPxpXOLW8E5bgM
        MoFKEHWJUytrEEaXrHQHDU2liXgzzgUf9B6f1kW7zj8hXvKGl4JeIuhcTFubLtmb+EwsEy
        ICBkToE8+7FygNovqqDFFbXiI+ExRUY=
Date:   Sat, 3 Oct 2020 11:04:29 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [PATCH 0/3] x86: Add initial support to discover Intel hybrid
 CPUs
Message-ID: <20201003090413.GB14035@zn.tnic>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
 <87r1qgccku.fsf@nanos.tec.linutronix.de>
 <20201003021730.GA19361@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201003021730.GA19361@agluck-desk2.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02, 2020 at 07:17:30PM -0700, Luck, Tony wrote:
> On Sat, Oct 03, 2020 at 03:39:29AM +0200, Thomas Gleixner wrote:
> > On Fri, Oct 02 2020 at 13:19, Ricardo Neri wrote:
> > > Add support to discover and enumerate CPUs in Intel hybrid parts. A hybrid
> > > part has CPUs with more than one type of micro-architecture. Thus, certain
> > > features may only be present in a specific CPU type.
> > >
> > > It is useful to know the type of CPUs present in a system. For instance,
> > > perf may need to handle CPUs differently depending on the type of micro-
> > > architecture. Decoding machine check error logs may need the additional
> > > micro-architecture type information, so include that in the log.
> > 
> > 'It is useful' as justification just makes me barf.
> 
> This isn't "hetero" ... all of the cores are architecturally the same.

But it says above "A hybrid part has CPUs with more than one type of
micro-architecture."

So which is it?

> If CPUID says that some feature is supported, then it will be supported
> on all of the cores.

Ok.

> There might be some model specific performance counter events that only
> apply to some cores.

That sounds like the perf counter scheduling code would have to pay
attention to what is supported. I think we have some functionality for
that due to some AMD parts but I'd prefer if Peter comments here.

> Or a machine check error code that is logged in the model specific
> MSCOD field of IA32_MCi_STATUS. But any and all code can run on any
> core.

As long as that is consumed only by userspace I guess that's ok. The
moment someone starts to want to differentiate on what kind of CPU
kernel code runs and acts accordingly, then it becomes ugly so we better
hash it out upfront.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
