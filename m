Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404F31C12CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 15:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728874AbgEANYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 09:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgEANYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:24:06 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5BE920757;
        Fri,  1 May 2020 13:24:05 +0000 (UTC)
Date:   Fri, 1 May 2020 09:24:04 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC][PATCH] x86/ftrace: Have ftrace trampolines turn read-only
 at the end of system boot up
Message-ID: <20200501092404.06d1adcb@gandalf.local.home>
In-Reply-To: <20200501051706.4wkrqwovybt2p6hr@treble>
References: <20200430202147.4dc6e2de@oasis.local.home>
        <20200501044733.eqf6hc6erucsd43x@treble>
        <20200501051706.4wkrqwovybt2p6hr@treble>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 May 2020 00:17:06 -0500
Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> > Would it be easier to just call a new __text_poke_bp() which skips the
> > SYSTEM_BOOTING check, since you know the trampoline will always be
> > read-only?
> > 
> > Like:  
> 
> early_trace_init() is called after mm_init(), so I thought it might
> work, but I guess not:

Yeah, I was about to say that this happens before mm_init() ;-)

It's why we already have magic for enabling function tracing the first time.

Do you see anything wrong with this current solution? It probably needs
more comments, but I wanted to get acceptance on the logic before I go and
pretty it up and send a non RFC patch.

-- Steve
