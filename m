Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 692C819FD22
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Apr 2020 20:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDFS1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 14:27:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgDFS1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:27:14 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B902E206C3;
        Mon,  6 Apr 2020 18:27:12 +0000 (UTC)
Date:   Mon, 6 Apr 2020 14:27:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200406142711.47780ff5@gandalf.local.home>
In-Reply-To: <20200406152231.GQ20730@hirez.programming.kicks-ass.net>
References: <20200402123258.895628824@linutronix.de>
        <20200402124205.242674296@linutronix.de>
        <20200406122343.GA10683@infradead.org>
        <20200406144020.GP20730@hirez.programming.kicks-ass.net>
        <20200406151847.GA25147@infradead.org>
        <20200406152231.GQ20730@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Apr 2020 17:22:31 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Mon, Apr 06, 2020 at 08:18:47AM -0700, Christoph Hellwig wrote:
> > On Mon, Apr 06, 2020 at 04:40:20PM +0200, Peter Zijlstra wrote:  
> > > It is absolutely bonkers, but at the same time we can extend this
> > > infrastructure to scan for dubious code patterns we don't want to
> > > support. Like for instance direct manipulation of CR4.  
> > 
> > But that is not what this code does - it disables split lock detection.
> > If it failed to load the module the whole thing would make a little
> > more sense.  
> 
> If this lives, it'll be to just to fail module loading. IIRC the same
> was suggested elsewhere in the thread.

I believe I may have been the one to suggest it. It's no different than
breaking kabi if you ask me. If a module can't deal with a new feature,
than it should not be able to load. And let whoever owns that module fix it
for their users.

-- Steve
