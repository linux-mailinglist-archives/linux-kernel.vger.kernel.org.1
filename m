Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7D124FD21
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 14:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbgHXMAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 08:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgHXMAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:00:45 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41151C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 05:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=JYP2GCXEu7go+Gvp89pNHC5SHYvaw/EwCONCZQ27CAk=; b=U8M11KISvweMSdTXSMge6KmvUH
        MBfyzSiMpsGJpXuhXjdG3c4hJNfuHkL3PdJ0QN4FvNPY/imLU/Om4zd2rR09EYk9uX7soVyLQHO5q
        UIRN7nVC206BWMetQSUpVT3rz8PGEvfLpSDy8fp1FBay+W7U9PTW/BXUICFkNqRdbSKFczGNY/tC4
        FKUb/sCEiz608akjRXZorYkiiCJxhsQx/D3AufLyZS6eB3oXwdriJojUHvLsVk9oiYsEvEXrcOVHs
        688Syg1P6iGTXt30qgsSQM5exRiQFlPgZxUx8LesbZYXUg6tCSVsM4sBxN4J4pgnyLB4Rwxgwg3ZB
        +ua361cQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kAB9B-0005md-HP; Mon, 24 Aug 2020 12:00:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A15AA3010D2;
        Mon, 24 Aug 2020 14:00:17 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 827D92B077D12; Mon, 24 Aug 2020 14:00:17 +0200 (CEST)
Date:   Mon, 24 Aug 2020 14:00:17 +0200
From:   peterz@infradead.org
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        "Josh Poimboeuf" <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v2 5/8] x86/debug: Simplify #DB signal code
Message-ID: <20200824120017.GU1362448@hirez.programming.kicks-ass.net>
References: <20200821093912.815135402@infradead.org>
 <20200821102053.034965283@infradead.org>
 <CALCETrVBB3YNCqCQ6bFBrSM10OTe354zyh=WbPFaEBxK1_Sa7g@mail.gmail.com>
 <20200824110501.GT1362448@hirez.programming.kicks-ass.net>
 <b5ff8a44-1039-645c-de3e-d5f085cbc3f0@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5ff8a44-1039-645c-de3e-d5f085cbc3f0@citrix.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 12:26:01PM +0100, Andrew Cooper wrote:

> > INT1 is a trap,
> > instruction breakpoint is a fault
> >
> > So if you have:
> >
> > 	INT1
> > 1:	some-instr
> >
> > and set an X breakpoint on 1, we'll loose the INT1, right?
> 
> You should get two.  First with a dr6 of 0 (ICEBP, RIP pointing at 1:),
> and a second with dr6 indicating the X breakpoint (again, RIP pointing
> at 1:).
> 
> SDM Vol3 6.9 PRIORITY AMONG SIMULTANEOUS EXCEPTIONS AND INTERRUPTS

Ooh, shiny. Clearly I didn't read enough SDM this morning.
