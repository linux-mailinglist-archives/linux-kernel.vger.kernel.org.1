Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE9DC28202F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 03:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgJCBjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 21:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbgJCBjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 21:39:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6D1C0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 18:39:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601689169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvJj+HSH0Ju5woOAeCpiSB83Gd2F5p1g+Rg4kXFcYPg=;
        b=GBQA8cl2QWn1FxCagUH1Y740o551bzNHs0yObGofP2BMx2yC5LvoT6UabyXDsQ6mvgWuCE
        hTn9HVx5EqtNc37bYkvD5qz6Nz4nBAntv1iWBw/Im2GtEFa9giI72Aq1lgbsr6IvSfg9lU
        Sdxz0wddpwQAOiNAgq3tkmS8JMJNMPlVcbTV4feOjHYWdeQM0febM7iP9kxv9vRNOMKppp
        oSeN0XXeiXJXcqTXHNnaPPmqNNWnWcuxShwe8n8coYqZgeW5cIOtDTPullZLtIGUjjKdja
        t4LUw0uv/C5xwwpFNKPkhbwZ6cmBgupe101FesFhZKRyTZuN8waWtb7NaPnJXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601689169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zvJj+HSH0Ju5woOAeCpiSB83Gd2F5p1g+Rg4kXFcYPg=;
        b=L3U50frbBz1Ix3gIL2MrVdit5q77q3U0MWSN3vAoDFoglAiUwAnM8XCj0MycpodZJDVN+e
        pGbgXqFGdh9RvDBw==
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        x86@kernel.org, Borislav Petkov <bp@suse.de>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Subject: Re: [PATCH 0/3] x86: Add initial support to discover Intel hybrid CPUs
In-Reply-To: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
References: <20201002201931.2826-1-ricardo.neri-calderon@linux.intel.com>
Date:   Sat, 03 Oct 2020 03:39:29 +0200
Message-ID: <87r1qgccku.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 02 2020 at 13:19, Ricardo Neri wrote:
> Add support to discover and enumerate CPUs in Intel hybrid parts. A hybrid
> part has CPUs with more than one type of micro-architecture. Thus, certain
> features may only be present in a specific CPU type.
>
> It is useful to know the type of CPUs present in a system. For instance,
> perf may need to handle CPUs differently depending on the type of micro-
> architecture. Decoding machine check error logs may need the additional
> micro-architecture type information, so include that in the log.

'It is useful' as justification just makes me barf.

> A hybrid part can be identified by reading a new CPUID feature bit.
> Likewise, CPUID contains information about the CPU type as well as a new
> native model ID. Details can be found in the Intel manual (SDM, [1]).
>
> This series adds support for Intel hybrid parts in two areas: a) adding
> the hybrid feature bit as well as struct cpuinfo_x86; and b) decode machine
> check errors on hybrid parts.

Bla, bla, bla.

> A later submission will use the proposed functionality to expose the CPU
> topology to user space.

The only patch which is accepted for now is:

    	if (boot_cpu_has(X86_FEATURE_HYBRID_CPU))
        	panic("Unsuppported insanity\n");

I'm not all all willing to take anything else unless you or someone else
provides a reasonable explanation for the overall approach of supporting
this mess inlcuding stable kernels.

This has been clearly communicated years ago when the topic was
discussed at one of the Intel Techday events. It's not my problem if
Intel internal communication is disfunctional.

Just to bring you up to speed:

     1) The whole CPU enumeration of x86 sucks and is in no way prepared
        to deal with heterogenous CPU faetures

        Boris and I have discussed this with Intel and on LKML and there
        are ideas how to clean up that mess.

        This needs to be solved first before we even start to talk about
        this CPU has FOO but the other does not.

     2) Intel has been told clearly that a prerequisite of adding any of
        this is a well defined programming model and a proper design of
        dealing with it at the kernel level.

        Since that discussion at one of the Intel events I haven't heard
        and seen anything related to that.

        If Intel thinks that some magic PDF and some Intel internal
        'works for me' patches are solving it, then I just have to give
        up because explaining the requirements again is just waste of
        time.

So I'm taking Patch 1/3 which defines the misfeature flag and then put
something like the above on top which will prevent booting on any of
these machines.

These two patches are going to be marked for stable simply because any
attempt to use any of these asymetric features is a recipe to
disaster. And that disaster is going to happen simply because user space
can use CPUID to figure out what a CPU supports. I'm not at all
interested in the resulting wreckage reports.

It's a sad state of affairs that the only outcome of a dicsussion which
touched all of the above is a patch set which paves the path to hell.

Not going to happen.

Thanks,

        tglx


