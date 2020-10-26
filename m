Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0AB0298CE5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 13:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775145AbgJZMaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 08:30:35 -0400
Received: from casper.infradead.org ([90.155.50.34]:38830 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1772574AbgJZMaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 08:30:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Znund5dzpNvYlhDHBzhUjlY+phwH7Vak7oEwCdGxkkc=; b=JjISarcW8F96RIHDmKzzcQjdsI
        RdmOxcC2njE+zbyedtE8cjk8bgjlQ5PYpRBuLR9momxqthEZt6iUyzxpidPRYplTFOHxIGxhGiu+w
        +aWH4WfIAviGcuNp3jZ9ksTZh5vKQB4Y5bI3F+8eOBGRdzgm6Qd0dp1KXbudp1BAVgTAfeQ5Kt5Mv
        2uLfelZ/7Y05lqf9IOuAca1hgXDbbmVEFdOPXX34iMUX1Zp5OSohywcdL1mSYXA/19d0G4+2LVR5a
        7xXfaSxGkYZVNrCB3HgrpaawHFR1vGOT5dbUBKThWrFrBxwkz+IB3ZiwEMkTLp5q2wYLH6Dd8UOpO
        D9G0nWFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kX1dw-0003Tp-Mn; Mon, 26 Oct 2020 12:30:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EBE1C302526;
        Mon, 26 Oct 2020 13:30:31 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D39D320325EC8; Mon, 26 Oct 2020 13:30:31 +0100 (CET)
Date:   Mon, 26 Oct 2020 13:30:31 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Filipe Manana <fdmanana@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: possible lockdep regression introduced by 4d004099a668
 ("lockdep: Fix lockdep recursion")
Message-ID: <20201026123031.GO2594@hirez.programming.kicks-ass.net>
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net>
 <20201026115541.GC28769@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026115541.GC28769@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 12:55:41PM +0100, Jan Kara wrote:
> > Make sure you have commit:
> > 
> >   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
> > 
> > (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?
> 
> Hum, I am at 5.10-rc1 now and above mentioned commit doesn't appear to be
> there? Also googling for the title doesn't help...

*groan*... I seem to have forgotten to push it out to tip/locking/urgent on
Friday :/

Find it here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/urgent


