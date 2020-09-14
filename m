Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D070D268B67
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 14:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgINMsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 08:48:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:55928 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726608AbgINMoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 08:44:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1AAE7AD25;
        Mon, 14 Sep 2020 12:44:21 +0000 (UTC)
Date:   Mon, 14 Sep 2020 14:44:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] printk: ringbuffer: avoid memcpy() on state_var
Message-ID: <20200914124404.GD11154@alley>
References: <20200914094803.27365-1-john.ogness@linutronix.de>
 <20200914094803.27365-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914094803.27365-2-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-09-14 11:54:03, John Ogness wrote:
> @state_var is copied as part of the descriptor copying via
> memcpy(). This is not allowed because @state_var is an atomic type,
> which in some implementations may contain a spinlock.

Great catch!

> Avoid using memcpy() with @state_var by explicitly copying the other
> fields of the descriptor. @state_var is set using atomic set
> operator before returning.

Just thinking loudly.

Strictly speaking, memcpy() might be used when the atomic variable
is later corrected by an atomic operation. And it is done by the first
patch.

I think that it is a matter of taste what solution is more error
prone. Either this function must be updated when a new field
is added into struct prb_desc or the atomic_long_set() must not
get removed.

Hmm, missing memcpy() should be rather easy to debug. While missing
atomic_long_set() is really subtle problem problem. So, the new
code is better from my POV.


> Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
