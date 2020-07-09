Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4670219FF5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jul 2020 14:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGIMZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jul 2020 08:25:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:54764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726615AbgGIMZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 08:25:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 09DF5AD1B;
        Thu,  9 Jul 2020 12:25:36 +0000 (UTC)
Date:   Thu, 9 Jul 2020 14:25:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [printk] 18a2dc6982: ltp.kmsg01.fail
Message-ID: <20200709122448.GJ4751@alley>
References: <20200707145932.8752-5-john.ogness@linutronix.de>
 <20200709071411.GR3874@shao2-debian>
 <20200709083323.GA572@jagdpanzerIV.localdomain>
 <874kqhm1v8.fsf@jogness.linutronix.de>
 <20200709105906.GC11164@alley>
 <20200709111310.GD11164@alley>
 <87zh89kkek.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zh89kkek.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-09 13:23:07, John Ogness wrote:
> On 2020-07-09, Petr Mladek <pmladek@suse.com> wrote:
> > I though more about it. IMHO, it will be better to modify
> > prb_first_seq() to do the same cycle as prb_next_seq()
> > and return seq number of the first valid entry.
> 
> Exactly!
> 
> Here is a patch that does just that. I added a prb_first_valid_seq()
> function and made prb_first_seq() static. (The ringbuffer still needs
> prb_first_seq() for itself.)

The fix looks fine to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

It means that we have two fixes on top of the original patchset. Could
you please send v5 with the two fixes integrated? I would just squash
them into the 4th patch.

Best Regards,
Petr


PS: I know that I am hurrying maybe too much at the moment.
Well, I will have vacation last two week in July. I think that this is
in good enough state for linux-next and I would like to have it there
at least few days before I leave.
