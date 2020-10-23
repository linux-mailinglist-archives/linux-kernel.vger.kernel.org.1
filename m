Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3C4296B0D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375743AbgJWITA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375702AbgJWIS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:18:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD2FC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 01:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=stzXLcertnxjcHxj9S/NayCOgc2UuLQLBH/tsK9ikag=; b=kL7f//b4QGvaawNEB2aOSjzyAi
        lU7hWMVV00f2cKVW6PT0tQZ8aDdTFFDkg9fJ54G7zR7qIVNHAzQkFiCJ5vCO5Vk5hvBgZezTIHElw
        n9ugiVyifHLZJufAIIvtTM8tmBDI/feTq7y3ssHq0f1PYo1MGUqMhAjqIzO1Z7Uc4rodvzlJHs2Zh
        7uJt8J6oHmWJsEEVOa3f0kCuEq1ReuRwKxdZaYptrPkWaSPN9X4wCa4NkXPo1lLNrDQuuHOlJ67AZ
        50+s8fnUv4ue2tH1hx14YqEcORR1qTHLLZ5s77pTrYkX865vj/QuMpQPmT8CKms0KKMr/a+Gw+Ju5
        77V1Qjtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVsHg-0007kq-O6; Fri, 23 Oct 2020 08:18:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4ABC1304D28;
        Fri, 23 Oct 2020 10:18:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 097C92BB222F0; Fri, 23 Oct 2020 10:18:47 +0200 (CEST)
Date:   Fri, 23 Oct 2020 10:18:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     syzbot <syzbot+53f8ce8bbc07924b6417@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: BUG: using __this_cpu_read() in preemptible code in
 trace_hardirqs_on
Message-ID: <20201023081847.GO2611@hirez.programming.kicks-ass.net>
References: <000000000000e921b305b18ba0a7@google.com>
 <20201013091743.12c371a8@gandalf.local.home>
 <20201021131733.GH2628@hirez.programming.kicks-ass.net>
 <20201021103433.38fed220@gandalf.local.home>
 <20201021151237.GK2628@hirez.programming.kicks-ass.net>
 <20201021112757.0945a922@gandalf.local.home>
 <20201022103028.GC2611@hirez.programming.kicks-ass.net>
 <20201022163247.5bb93ab3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022163247.5bb93ab3@gandalf.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 22, 2020 at 04:32:47PM -0400, Steven Rostedt wrote:
> On Thu, 22 Oct 2020 12:30:28 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Subject: lockdep: Fix preemption WARN for spurious IRQ-enable
> > From: Peter Zijlstra <peterz@infradead.org>
> > Date: Thu Oct 22 12:23:02 CEST 2020
> > 
> > It is valid (albeit uncommon) to call local_irq_enable() without first
> > having called local_irq_disable(). In this case we enter
> > lockdep_hardirqs_on*() with IRQs enabled and trip a preemption warning
> > for using __this_cpu_read().
> > 
> > Use this_cpu_read() instead to avoid the warning.
> 
> I was wondering why you were using __this_cpu_read() in the first place.

Well, because all other sites are actually with IRQs disabled :/ It's
just this spurious enable thing that's an exception.

> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks!
