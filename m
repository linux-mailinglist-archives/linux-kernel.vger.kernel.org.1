Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6641D9A3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 16:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728978AbgESOoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 10:44:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:44196 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbgESOn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:43:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 32DA7ABCB;
        Tue, 19 May 2020 14:44:00 +0000 (UTC)
Date:   Tue, 19 May 2020 16:43:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     Eugeniu Rosca <erosca@de.adit-jv.com>,
        linux-kernel@vger.kernel.org,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH 3/3] watchdog: Turn console verbosity on when
 reporting softlockup
Message-ID: <20200519144355.GN7340@linux-b0ei>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
 <20200315170903.17393-4-erosca@de.adit-jv.com>
 <20200317021818.GD219881@google.com>
 <20200318180525.GA5790@lxhi-065.adit-jv.com>
 <20200319064836.GB24020@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319064836.GB24020@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-03-19 15:48:36, Sergey Senozhatsky wrote:
> On (20/03/18 19:05), Eugeniu Rosca wrote:
> > My current standpoint is that as long as points [A-D] are met, it
> > should do no harm to accept a (partial) fix like seen in my series:
> > 
> >  - [A] the patch tackles at least a subset of problematic use-cases
> >  - [B] the fix is non-intrusive and easy to review
> >  - [C] there is hope to reuse it in the new lockless buffer based printk
> >  - [D] there are no regressions employing the major console knobs
> >        (ignore_loglevel, quiet, loglevel, etc) as it happened in
> >   a6ae928c25835c ("Revert "printk: make sure to print log on console."")
> 
> So the issue is that when we bump `console_loglevel' or `ignore_loglevel'
> we lift restrictions globally. For all CPUs, for all contexts which call
> printk(). This may have negative impact.

Another impact is that many more messages might suddenly appear on the
console even though admins wanted them quiet because they were slow.

The problem is to define what information is critical. In the ideal
world, all messages are visible on the console so that developers
could use them for debugging. The console loglevel is there to
keep it working in the real world.

IMHO, an acceptable solution would be:

  + Print a single critical message about that a lockup happened
  + Make it configurable which log level will get used for the
    details.

Note that there is a pending patchset that allows to show stacks
with a given loglevel, see
https://lore.kernel.org/linux-riscv/20200418201944.482088-1-dima@arista.com/

Well, I am slightly afraid that it might open a can with hundred of
printk-related options shuffling log level for various events.

The upcoming printk kthread might help to handle even more
messages on slow consoles. It might allow to increase the default
loglevel in these situations. But the problem will still be there.
The throughput will always be limited and different people have
different opinion on what messages are important.

Best Regards,
Petr
