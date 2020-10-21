Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183C0294D72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441546AbgJUNYx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:24:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441531AbgJUNYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:24:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8997AC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KNjLuE+NLkfGPbq1lu/To3yOPZPN2B2pNyqLHOolRRE=; b=jpm9Ut78bP+z8IZy7hhv9lPDjj
        +u0TZX6ynhTZ16ryDXa1eFRPeAol5c/2piLqoi+vttL524MzbavLgv3i+FlQvJR5wrjuql+F73Xu6
        MAerW0fo93osvxcJJlAiBbF7s06tu0Gshtflz3ng+CccXSZwweBj3+95dYsRGh/kj+/UWfwtNNJZs
        yPcTDBsQqdwjA/LHNKucLTO382Kr+8lYD1TjzhseoXHJqlRt9+SSAzeZvugPP2qnlYTJ+gWdD9ugP
        F7lpmsKf5KgpU+UZrYONND+w4v+7WSwwJhwTrKMGr/bEFiRYCpBxFlq81yu1N3pleurFCUXWHoMfW
        aC7aEK2w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVE6X-0000xK-MF; Wed, 21 Oct 2020 13:24:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDD5930377D;
        Wed, 21 Oct 2020 15:24:33 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3450F203CC4BF; Wed, 21 Oct 2020 15:24:33 +0200 (CEST)
Date:   Wed, 21 Oct 2020 15:24:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Sultan Alsawaf <sultan@kerneltoast.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        kitsunyan <kitsunyan@airmail.cc>,
        "Brown, Len" <len.brown@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/msr: do not warn on writes to OC_MAILBOX
Message-ID: <20201021132433.GI2628@hirez.programming.kicks-ass.net>
References: <20200908172558.GG25236@zn.tnic>
 <CAHmME9pKfvPGf97BM1=VdUL1uU_8aOoc4+QOu6b51XnPz3SkRA@mail.gmail.com>
 <20200908173656.GI25236@zn.tnic>
 <CAHmME9pVO01mj8vgKPEX7a6pZDRSfX62e2Ow8R=L79hLSJoaMA@mail.gmail.com>
 <20200908180112.GK25236@zn.tnic>
 <20200908191838.GA2014@sultan-box.localdomain>
 <20200908193029.GM25236@zn.tnic>
 <fa447f6b7c7f03cc0c55573d5736889cee81a1e6.camel@linux.intel.com>
 <20201019171539.GF24325@zn.tnic>
 <ae3367ab7d4eb4778b51f798436ab975d7f8a303.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae3367ab7d4eb4778b51f798436ab975d7f8a303.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 10:21:48AM -0700, Srinivas Pandruvada wrote:
> On Mon, 2020-10-19 at 19:15 +0200, Borislav Petkov wrote:

> These command id are model specific. There is no guarantee that even
> meaning changes. So I don't think we should write any code in kernel
> which can't stick.
> 
> 
> > In any case, my point is that we could have a sysfs interface for
> > those userspace-suppliable values like the undervolt value at
> > [31:21],
> > dunno if the index can be inferred by the kernel automatically or
> > enumerated and the commands we should issue ourselves depending on
> > the
> > functionality, etc.

Why not have a full undervolt driver. That is, don't expose OC_MAILBOX
_at_all_, but have a model specific driver that provides undervolt
capabilities.

Someone is now maintaining this thing in userspace, might as well do it
as a kernel driver and keep all the icky bits inside.
