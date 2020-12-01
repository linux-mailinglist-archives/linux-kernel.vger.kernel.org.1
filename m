Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF272CAB1A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgLASxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:53:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgLASxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:53:53 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF9DC0613D6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 10:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PvixetNBTkwDipyboOvyhGP073UdIatZGn4wq/qiTm0=; b=Th9Xcx2EcMqZGowWHALwp5peGn
        KYhBzaBfUtlWATgq11F78bWvlNGbsHnR1SjPkrKjBcAVE4CZY30lGCsthuNJRN/NvUeDl9g2E1kAf
        jm3a2cYhQcMR9fu5ARzbdV1YITZzNslld4Lvn8ky19fKux68RO2CogO228UGAXWW4Hwiv10ms96t6
        oywJRnXPQ1XyqPYbzJEoH1gS/gCgOiy4+IiMbEX+nUeQZVqkpIItGA5VHVJZxVreh+N+UxNLb7qwi
        rZdZNdiSte5JBX9XnWVPLRGFI7q+dh+RJZAD31Yl2DOJ+dfwuq3rscequ1RnYYL/GcFzodj2obUVz
        GIp4sC9w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkAlu-0000RM-Ug; Tue, 01 Dec 2020 18:53:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5E4F4304D58;
        Tue,  1 Dec 2020 19:53:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4021A2BF16C02; Tue,  1 Dec 2020 19:53:05 +0100 (CET)
Date:   Tue, 1 Dec 2020 19:53:05 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     X86 ML <x86@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Anton Blanchard <anton@ozlabs.org>
Subject: Re: [PATCH 3/3] membarrier: Propagate SYNC_CORE and RSEQ actions
 more carefully
Message-ID: <20201201185305.GU3040@hirez.programming.kicks-ass.net>
References: <cover.1606758530.git.luto@kernel.org>
 <5495e4c344dc09011ff57756c7e0a1330830eafc.1606758530.git.luto@kernel.org>
 <20201201101637.GU2414@hirez.programming.kicks-ass.net>
 <CALCETrUZHWvjO8otEWat6SDwDFRdV0iSp=RZDaHnyytJ=4a6cg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrUZHWvjO8otEWat6SDwDFRdV0iSp=RZDaHnyytJ=4a6cg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 10:09:22AM -0800, Andy Lutomirski wrote:
> On Tue, Dec 1, 2020 at 2:16 AM Peter Zijlstra <peterz@infradead.org> wrote:
> > >  - membarrier() does not explicitly sync_core() remote CPUs either;
> > >    instead, it relies on the assumption that an IPI will result in a
> > >    core sync.  On x86, I think this may be true in practice, but
> > >    it's not architecturally reliable.  In particular, the SDM and
> > >    APM do not appear to guarantee that interrupt delivery is
> > >    serializing.
> >
> > Right, I don't think we rely on that, we do rely on interrupt delivery
> > providing order though -- as per the previous email.

order, not serializing.

> I looked for a bit, and I couldn't find anything in the SDM or APM to
> support this, and I would be rather surprised if other architectures
> synchronize their instruction streams on interrupt delivery.  On
> architectures without hardware I$ coherency and with actual fast
> interrupts, I would be surprised if interrupts ensured I$ coherency
> with prior writes from other cores.

Data, not I$. smp_mb() has nothing on I$. The claim is that smp_mb() at
the start of an IPI is pointless (as a means of ordering against the CPU
raising the IPI).

Doing smp_mb() before raising the IPI does make sense and is actually
done IIRC.


