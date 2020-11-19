Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D87E22B95AA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 16:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgKSPC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 10:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgKSPC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 10:02:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A45C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 07:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QXCOSnjJzv6+kMylUuxg36Vf5y0gSWMInG77AGsBW0Q=; b=D953w/npFj813PHioY+cJ1N7YX
        ua66cINcF/HMqAlrOB3UwB+1jvH11hos+HiAioAyC2aq5+9IOfv/2jxoKZlRZprQIhlSyPWt0SXuH
        kxDFGFVJYj+8WTj0Ld7dV9bEJExpzmKxPh00Lc36rGchpFjBK94PYSkwX/1tB+soMh52HnlpjKe2r
        z7rmuLjzEtLYHqIBs/MWqsHlFVyKhYcl6hfTxXFRzvHwI+Mmc+xJknokKjLYfFkifrX3XF4nynd0n
        FJslcnfTYiVS6hDiAJiFsuidMteCCEI9NMdvlEp2mp/71rGfBFF0FtGWeCscsoZ8O3VTNCtVbDtFf
        C1MR26jg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kflRz-000207-6x; Thu, 19 Nov 2020 15:02:19 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 34B90300F7A;
        Thu, 19 Nov 2020 16:02:17 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DCF89200E0A45; Thu, 19 Nov 2020 16:02:17 +0100 (CET)
Date:   Thu, 19 Nov 2020 16:02:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: Deadlock cpuctx_mutex / pmus_lock / &mm->mmap_lock#2
Message-ID: <20201119150217.GH3121429@hirez.programming.kicks-ass.net>
References: <1185a97a-3780-3bce-d97d-ff9c2830e35d@gmail.com>
 <20201119130244.GN3121392@hirez.programming.kicks-ass.net>
 <160579231162.30679.12645532537616868812@build.alporthouse.com>
 <20201119141914.GO3121392@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119141914.GO3121392@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 19, 2020 at 03:19:14PM +0100, Peter Zijlstra wrote:
> On Thu, Nov 19, 2020 at 01:25:11PM +0000, Chris Wilson wrote:
> > Quoting Peter Zijlstra (2020-11-19 13:02:44)
> > > 
> > > Chris, I suspect this is due to i915 calling stop machine with all sorts
> > > of locks held. Is there anything to be done about this? stop_machine()
> > > is really nasty to begin with.
> > > 
> > > What problem is it typing to solve?
> > 
> > If there is any concurrent access through a PCI bar (that is exported to
> > userspace via mmap) as the GTT is updated, results in undefined HW
> > behaviour (where that is not limited to users writing to other system
> > pages).
> > 
> > stop_machine() is the most foolproof method we know that works.
> 
> Sorry, I don't understand. It tries to do what? And why does it need to
> do that holding locks.
> 
> Really, this is very bad form.

Having poked around at the code; do I get it correct that this is using
stop-machine to set IOMMU page-table entries, because the hardware
cannot deal with two CPUs writing to the same device page-tables; which
would be possible because that memory is exposed through PCI bars?

Can't you simply exclude that memory from being visible through the PCI
bar crud? Having to use stop-machine seems tragic, doubly so because
nobody should actually be having that memory mapped in the first place.


