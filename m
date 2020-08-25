Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F104251DD6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 19:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgHYRKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 13:10:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:33576 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgHYRKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:10:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 02E9AAE68;
        Tue, 25 Aug 2020 17:10:28 +0000 (UTC)
Date:   Tue, 25 Aug 2020 19:09:55 +0200
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
Subject: Re: [PATCH v2 1/7][next] printk: ringbuffer: rename
 DESC_COMMITTED_MASK flag
Message-ID: <20200825170955.GX4353@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824103538.31446-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-08-24 12:41:32, John Ogness wrote:
> The flag DESC_COMMITTED_MASK has a much longer name compared to the
> other state flags and also is in past tense form, rather than in
> command form. Rename the flag to DESC_COMMIT_MASK in order to match
> the other state flags.

I am not a native speaker. But the command form sounds a bit misleading to me.

I see that the new name will make more sense after adding the state "FINAL".
But "FINAL" will not be a command form either.

I am fine with the change but I would prefer a better commit message.
What about something like?

"A comming support for continuous lines will allow to reopen records
with DESC_COMMITTED_MASK set. As a result, the flag will not longer
describe the final committed state. Rename it to DESC_COMMIT_MASK
as a preparation step."


With the updated commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
