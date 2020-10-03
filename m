Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84D52823AE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 12:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgJCKqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 06:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJCKqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 06:46:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E914C0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 03:46:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601721989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1VRUsWyO1yj5q36awhvuHbtHiEkWL23xYdk+RuvW+rM=;
        b=EmxaGmQbCI8kX09kl/c5X9JCA/mrnzVhjjyb4KBrOA4Nnvdfdvk4jsXL9yUmbHDfMiUg5L
        kS8T7E+ceEcw26DVixWTgyglozNdbEd8tZr7LbbLvqRBqGe7iutF4cv2JV0zAZjU7wzXOn
        pu6WTpYYiqOY3a6ZXUb20DZW7cUOyObC/R1J2IJEk4cbD0bh/lKG2f2hKQbROGxD9onUcZ
        mFSsVixbwjRlO9uNRz5ZkKedvYP8o53eHw+qijPIE+gffMcvAdsBJ8LDM8/H7h7YFsDOr2
        MPo1K/LHIonl3AC6AlbRcrmtGUnXVYdZlwANSm/FUAMZp4OqNuoFs+99bMzsYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601721989;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1VRUsWyO1yj5q36awhvuHbtHiEkWL23xYdk+RuvW+rM=;
        b=aJv0JHpQK7HSDXkIz12bPt/CuDtBwaNJ5c18xkpvE/zECtOF0+A77vWuB8CHHaSo8SS4bO
        n4LpC9gE1YHQSVDg==
To:     "Luck\, Tony" <tony.luck@intel.com>
Cc:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>
Subject: Re: [PATCH 0/3] x86: Add initial support to discover Intel hybrid CPUs
In-Reply-To: <20201003021730.GA19361@agluck-desk2.amr.corp.intel.com>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com> <87r1qgccku.fsf@nanos.tec.linutronix.de> <20201003021730.GA19361@agluck-desk2.amr.corp.intel.com>
Date:   Sat, 03 Oct 2020 12:46:29 +0200
Message-ID: <87lfgnd1tm.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02 2020 at 19:17, Tony Luck wrote:

> On Sat, Oct 03, 2020 at 03:39:29AM +0200, Thomas Gleixner wrote:
>> On Fri, Oct 02 2020 at 13:19, Ricardo Neri wrote:
>> > Add support to discover and enumerate CPUs in Intel hybrid parts. A hybrid
>> > part has CPUs with more than one type of micro-architecture. Thus, certain
>> > features may only be present in a specific CPU type.
>> >
>> > It is useful to know the type of CPUs present in a system. For instance,
>> > perf may need to handle CPUs differently depending on the type of micro-
>> > architecture. Decoding machine check error logs may need the additional
>> > micro-architecture type information, so include that in the log.
>> 
>> 'It is useful' as justification just makes me barf.
>
> This isn't "hetero" ... all of the cores are architecturally the same.

The above clearly says:

>> > A hybrid part has CPUs with more than one type of micro-architecture.

Can you folks talk to each other and chose non-ambigous wording in
changelogs and cover letters?

> If CPUID says that some feature is supported, then it will be supported
> on all of the cores.

That's a different story.

> There might be some model specific performance counter events that only
> apply to some cores. Or a machine check error code that is logged in the
> model specific MSCOD field of IA32_MCi_STATUS. But any and all code can run
> on any core.

Ok. The perf side should be doable, IIRC we already have something like
that, but Peter should know better.

> Sure there will be some different power/performance tradeoffs on some
> cores. But we already have that with some cores able to achieve higher
> turbo frequencies than others.

Right, that's not a problem.

Thanks,

        tglx
