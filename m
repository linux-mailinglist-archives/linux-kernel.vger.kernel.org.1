Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87D0B26A122
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 10:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgIOInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 04:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726122AbgIOInU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 04:43:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3292C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 01:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gPWjjj+GEm0phhGhPA/UBCYH87qq+66qidJCKcgCVto=; b=EzwBj3zYLSed25LzNLifTiZlQz
        Xgcfdh+BlMYrhowWaE6nZoBNO28uuQLlns8hCIbcC+JB9UEmGcTxtNmHdQpUdVsAyeHqOSu5KQgvk
        Ji6imwJ7/7gkmEkoHvBMTO5hOAmTnWWPXdhRa2b06X0CBZ8WzytHEjhEaWA2We5fbYUyn1C/kD6WF
        lvoB/yV8cQqYRT3GzMY9XYjrxqqlwbYc4zP/S1tueZo/7/upQfMz9QGH/kGAqgeOE5fYsvdv1G5SD
        UMzK6AWPWhQXj2fRr4bENYAKp6viBeydOpsr+PY/9ydLC2KalJIsHFCqvxOM/4GCGjOYrKxYsEGeN
        xaXzGISQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kI6YL-0007MC-Nd; Tue, 15 Sep 2020 08:43:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7CFFB3019CE;
        Tue, 15 Sep 2020 10:43:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6DAFC2C639FCF; Tue, 15 Sep 2020 10:43:04 +0200 (CEST)
Date:   Tue, 15 Sep 2020 10:43:04 +0200
From:   peterz@infradead.org
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH] x86/unwind/fp: Fix FP unwinding in ret_from_fork
Message-ID: <20200915084304.GU1362448@hirez.programming.kicks-ass.net>
References: <f366bbf5a8d02e2318ee312f738112d0af74d16f.1600103007.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f366bbf5a8d02e2318ee312f738112d0af74d16f.1600103007.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 14, 2020 at 12:04:22PM -0500, Josh Poimboeuf wrote:
> There have been some reports of "bad bp value" warnings printed by the
> frame pointer unwinder:
> 
>   WARNING: kernel stack regs at 000000005bac7112 in sh:1014 has bad 'bp' value 0000000000000000
> 
> This warning happens when unwinding from an interrupt in
> ret_from_fork().  If entry code gets interrupted, the state of the frame
> pointer (rbp) may be undefined, which can confuse the unwinder,
> resulting in warnings like the above.
> 
> There's an in_entry_code() check which normally silences such warnings
> for entry code.  But in this case, ret_from_fork() is getting
> interrupted.  It recently got moved out of .entry.text, so the
> in_entry_code() check no longer works.
> 
> We could move it back into .entry.text, but that would break the noinstr
> validation because of the call to schedule_tail().
> 
> Instead, initialize each new task's RBP to point to the task's entry
> regs via an encoded frame pointer.  That will allow the unwinder to
> reach the end of the stack gracefully.
> 
> Fixes: b9f6976bfb94 ("x86/entry/64: Move non entry code into .text section")
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
