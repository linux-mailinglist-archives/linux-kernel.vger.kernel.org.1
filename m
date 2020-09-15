Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2839326A282
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 11:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgIOJr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 05:47:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbgIOJr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 05:47:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E0476ACB5;
        Tue, 15 Sep 2020 09:48:12 +0000 (UTC)
Date:   Tue, 15 Sep 2020 11:47:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v5 0/6] printk: reimplement LOG_CONT handling
Message-ID: <20200915094756.GF11154@alley>
References: <20200914123354.832-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914123354.832-1-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-09-14 14:39:48, John Ogness wrote:
> Hello,
> 
> Here is v5 for the second series to rework the printk subsystem.
> (The v4 is here [0].) This series implements a new ringbuffer
> feature that allows the last record to be extended. Petr Mladek
> provided the initial proof of concept [1] for this.
> 
> Using the record extension feature, LOG_CONT is re-implemented
> in a way that exactly preserves its behavior, but avoids the
> need for an extra buffer. In particular, it avoids the need for
> any synchronization that such a buffer requires.

The series is ready for linux-next from my POV. I am going to push
it there tomorrow if nobody complains.

Best Regards,
Petr
