Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894C21A8D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 23:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633674AbgDNVFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 17:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732446AbgDNVFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:05:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3E3A2074D;
        Tue, 14 Apr 2020 21:05:21 +0000 (UTC)
Date:   Tue, 14 Apr 2020 17:05:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        Julien Thierry <jthierry@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC][PATCH 00/36] objtool: Make recordmcount a subcommand
Message-ID: <20200414170520.4d347caa@gandalf.local.home>
In-Reply-To: <20200414204729.GJ2483@worktop.programming.kicks-ass.net>
References: <cover.1586468801.git.mhelsley@vmware.com>
        <3a3f70df-07b0-91d9-33e1-e997e72b0c5c@redhat.com>
        <20200414093506.7b91bbbb@gandalf.local.home>
        <064f41bd-0dfe-e875-df7c-214184c29fa7@redhat.com>
        <20200414115458.093e221b@gandalf.local.home>
        <20200414200910.GB118458@rlwimi.vmware.com>
        <20200414204729.GJ2483@worktop.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 22:47:29 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Apr 14, 2020 at 01:09:10PM -0700, Matt Helsley wrote:
> > I also noticed that, for example, sorttable uses the same ELF code /
> > patterns as recordmcount -- like the double-include trick. Of course
> > it operates on a larger scale than per-object-file and so there might
> > only be code maintenance savings there...  
> 
> I'm >< close to having objtool run on vmlinux in the link stage too :-)

Do we want that? Matters how long that takes. One reason I avoided running
recordmcount on vmlinux was because I didn't want to add to the build time
that much if I only needed to compile a single object.

If it's fast, then there shouldn't be anything to worry about, but if it
takes a minute on a common machine, that's one minute added to all builds,
no matter how little you had to compile.

-- Steve
