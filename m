Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E67D21B152
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jul 2020 10:29:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728112AbgGJI2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jul 2020 04:28:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:50322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727861AbgGJI2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:28:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 45237AB7A;
        Fri, 10 Jul 2020 08:28:34 +0000 (UTC)
Date:   Fri, 10 Jul 2020 10:28:33 +0200
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
Subject: Re: [PATCH v5 0/4] printk: replace ringbuffer
Message-ID: <20200710082833.GM4751@alley>
References: <20200709132344.760-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709132344.760-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-07-09 15:29:40, John Ogness wrote:
> Hello,
> 
> Here is a v5 for the first series to rework the printk
> subsystem. The v4 is here [0]. This first series
> only replaces the existing ringbuffer implementation. No locking
> is removed. The semantics/behavior of printk are kept the same
> except for a minor optimization that is reverted (patch 3).
> 
> John Ogness (4):
>   crash: add VMCOREINFO macro to define offset in a struct declared by
>     typedef
>   printk: add lockless ringbuffer
>   Revert "printk: lock/unlock console only for new logbuf entries"
>   printk: use the lockless ringbuffer

The patchset is committed in printk/linux.git, branch printk-rework.

I did not add any target kernel version into the topic branch name.
We could use it for the entire rework. The pieces would go into
mainline when we and linux-next are happy.

Best Regards,
Petr
