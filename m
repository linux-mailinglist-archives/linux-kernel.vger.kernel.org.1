Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208CE21B207
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 11:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgGJJLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 05:11:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:47484 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbgGJJLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 05:11:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1F45CAD77;
        Fri, 10 Jul 2020 09:11:38 +0000 (UTC)
Date:   Fri, 10 Jul 2020 11:11:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] printk: replace ringbuffer
Message-ID: <20200710091137.GN4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200708152005.GF4751@alley>
 <87wo3d9nlo.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo3d9nlo.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-09 09:09:31, John Ogness wrote:
> On 2020-07-08, Petr Mladek <pmladek@suse.com> wrote:
> > OK, I think that we are ready to try this in linux-next.
> > I am going to push it there via printk/linux.git.
> >
> > [...]
> > 
> > Of course, there are still many potential problems. The following comes
> > to my mind:
> >
> > [...]
> >
> >    + Debugging tools accessing the buffer directly would need to
> >      understand the new structure. Fortunately John provided
> >      patches for the most prominent ones.
> 
> The next series in the printk-rework (move LOG_CONT handling from
> writers to readers) makes some further changes that, while not
> incompatible, could affect the output of existing tools. It may be a
> good idea to let the new ringbuffer sit in linux-next until the next
> series has been discussed/reviewed/merged. After the next series,
> everything will be in place (with regard to userspace tools) to finish
> the rework.

I know that it might be premature question. But I wonder what kind
of changes are expected because of the continuous lines.

Do you expect some changes in the ring buffer structures so that
the debugging tools would need yet another update to actually
access the data?

Or do you expect backward compatible changes that would allow
to pass related parts of the continuous lines via syslog/dev_kmsg
interface and join them later in userspace?

IMHO, it would make sense to wait only when the structures need
some modification. Concatenating related parts on the userspace
side will need to stay optional anyway.

As I say, this might be premature question. I just do not want
to unnecessary delay mainlining the current state. It would get
much wider testing there. And it is great when the changes might
be done in "small" steps.

Best Regards,
Petr
