Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA042D3D32
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 09:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgLIIR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 03:17:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgLIIRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 03:17:25 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B251C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  9 Dec 2020 00:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7DbXicEP14682gFH5lbRgzIsZ1ZZPjA3ihyvb2YqmuY=; b=qWkGuRldOYs++JE0EgNIrR+fcB
        LIWr7c4fS2+kEFIWlRNvsvnyJLQToQqAUjMsU00zXGtx8Cc+UXUCaqcbJNUfQANibRI5MQFYROwZY
        S1Z6qAtleDO4qyyW1PtoMxa3qpeLPLXXb5stOEt29NFxcWVwsfwfQU8NLAZtn8bszr3G9y79VbQbC
        kzIW5LXtSlses9e3AJVkpkTyn3hiPdplROmkSPLahscqYNdd6fDrull9FdeS0Aaw/+mSCF/xDWJrs
        WKtBpwbiqpE00FCCtf6cMxLB0jk5P9oRtCzZzhiANRNQv4oBiBReyEoygDSpP+LrJvMcfLxOgWP7E
        wDG7Rg5A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kmueA-0000ob-7I; Wed, 09 Dec 2020 08:16:27 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7F4A830477A;
        Wed,  9 Dec 2020 09:16:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6748F200F8CC1; Wed,  9 Dec 2020 09:16:23 +0100 (CET)
Date:   Wed, 9 Dec 2020 09:16:23 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v2 2/3] printk: change @clear_seq to atomic64_t
Message-ID: <20201209081623.GI2414@hirez.programming.kicks-ass.net>
References: <20201201205341.3871-1-john.ogness@linutronix.de>
 <20201201205341.3871-3-john.ogness@linutronix.de>
 <X8n9a2DWUFE/giyB@alley>
 <X8/jS9k/eMIL+Acw@jagdpanzerIV.localdomain>
 <875z5c9bhn.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z5c9bhn.fsf@jogness.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 08, 2020 at 11:36:44PM +0106, John Ogness wrote:
> For the state variable we chose atomic_long_t instead of atomic64_t for
> this reason. atomic_long_t operations are available atomically on all
> architectures.

Please put on your eye cancer gear and inspect the atomic implementation
of PA-RISC, Sparc32, feh, I forgot who else.

Those SMP capable architectures are gifted with just one XCHG like
atomic instruction :/ Anyway, as said in the other email, they also
don't have NMIs so it mostly works.
