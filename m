Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57DA3029E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 19:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbhAYSR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 13:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:50358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730969AbhAYSRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:17:09 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83D2E22583;
        Mon, 25 Jan 2021 18:16:25 +0000 (UTC)
Date:   Mon, 25 Jan 2021 13:16:24 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH V2] x86/entry/64: De-Xen-ify our NMI code further
Message-ID: <20210125131624.612be16b@gandalf.local.home>
In-Reply-To: <4415FFC4-995A-4C77-9A96-744ED697AF05@amacapital.net>
References: <20210125123859.39b244ca@gandalf.local.home>
        <4415FFC4-995A-4C77-9A96-744ED697AF05@amacapital.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 09:51:45 -0800
Andy Lutomirski <luto@amacapital.net> wrote:

> > The problem I see with this is that exc_nmi is called with the thread
> > stack, if it were to take an exception, NMIs would be enabled allowing for
> > a nested NMI to run. From what I can tell, I don't see anything stopping
> > that NMI from executing over the currently running NMI. That is, this means
> > that NMI handlers are now re-entrant.  
> 
> That was intentional in my part. The C code checks for this condition and handles it, just like it does on 32-bit kernels.

I vaguely remember you implementing this, and me reviewing it. I'm getting
to that age that there's less and less I remember doing :-/

I'll include a comment about that in my rewrite. But first, I'll re-review
your changes to make sure there's no one offs that happen with the mixture
of nmi stack handling and the x86_32 version doing the same thing.

Thanks for the reminder.

-- Steve
