Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C615B218A39
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jul 2020 16:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729831AbgGHOfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jul 2020 10:35:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:53638 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729595AbgGHOfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:35:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0575EAC43;
        Wed,  8 Jul 2020 14:35:16 +0000 (UTC)
Date:   Wed, 8 Jul 2020 16:35:15 +0200
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
Subject: Re: [PATCH v4 4/4] printk: use the lockless ringbuffer
Message-ID: <20200708143514.GE4751@alley>
References: <20200707145932.8752-1-john.ogness@linutronix.de>
 <20200707145932.8752-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707145932.8752-5-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-07-07 17:05:32, John Ogness wrote:
> Replace the existing ringbuffer usage and implementation with
> lockless ringbuffer usage. Even though the new ringbuffer does not
> require locking, all existing locking is left in place. Therefore,
> this change is purely replacing the underlining ringbuffer.
> 
> Changes that exist due to the ringbuffer replacement:
> 
> - The VMCOREINFO has been updated for the new structures.
> 
> - Dictionary data is now stored in a separate data buffer from the
>   human-readable messages. The dictionary data buffer is set to the
>   same size as the message buffer. Therefore, the total required
>   memory for both dictionary and message data is
>   2 * (2 ^ CONFIG_LOG_BUF_SHIFT) for the initial static buffers and
>   2 * log_buf_len (the kernel parameter) for the dynamic buffers.
> 
> - Record meta-data is now stored in a separate array of descriptors.
>   This is an additional 72 * (2 ^ (CONFIG_LOG_BUF_SHIFT - 5)) bytes
>   for the static array and 72 * (log_buf_len >> 5) bytes for the
>   dynamic array.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
