Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165B5251C54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 17:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHYPck (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 11:32:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:39616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726627AbgHYPcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:32:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 12256B579;
        Tue, 25 Aug 2020 15:33:08 +0000 (UTC)
Date:   Tue, 25 Aug 2020 17:32:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 1/5] printk: implement pr_cont_t
Message-ID: <20200825153236.GW4353@alley>
References: <20200819232632.13418-1-john.ogness@linutronix.de>
 <20200819232632.13418-2-john.ogness@linutronix.de>
 <20200820101625.GE4353@alley>
 <fb47baa77ff940e99224feac85a2f2d7@AcuMS.aculab.com>
 <20200825131041.GV4353@alley>
 <0f3e3efffad64739a223273cc7c738bc@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f3e3efffad64739a223273cc7c738bc@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-08-25 13:38:57, David Laight wrote:
> From: Petr Mladek
> > Sent: 25 August 2020 14:11
> > 
> > On Thu 2020-08-20 12:33:23, David Laight wrote:
> > > From: Petr Mladek
> > > > Sent: 20 August 2020 11:16
> > > ...
> > > > Now that I think about it. This is the biggest problem with any temporary buffer
> > > > for pr_cont() lines. I am more and more convinced that we should just
> > > > _keep the current behavior_. It is not ideal. But sometimes mixed
> > > > messages are always better than lost ones.
> > >
> > > Maybe a marker to say 'more expected' might be useful.
> > > OTOH lack of a trailing '\n' probably signifies that a
> > > pr_cont() is likely to be next.
> > 
> > The problem is the "probably". Lack of trailing '\n' might also mean
> > that the author did not care. Note that newline is not strictly
> > required at the moment. The next message is concatenated only when
> > pr_cont() is used from the same process.
> 
> Thinks.... (smoke comes out of ears...):
> If the 'trace entry' contained the pid and whether it was a pr_cont
> then the trace reader could merge continuation lines even if
> there was a small number of interleaved other traces.
> 
> So anything reading continuously might break a continuation
> (as might happen if there is a trace from an ISR).
> But the output from dmesg and /var/log/messages will
> almost always be correct.
> 
> This moves all the complexity away from the trace writing code.

Yeah, this was the original plan. Unfortunately, it would require
changes on the reader side and it would break existing readers (userspace),
see
https://lore.kernel.org/lkml/20200811160551.GC12903@alley/

And it is not acceptable, see
https://lore.kernel.org/lkml/CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com/

Best Regards,
Petr
