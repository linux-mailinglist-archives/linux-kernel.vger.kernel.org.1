Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30001E5DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 13:06:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbgE1LGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 07:06:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:41842 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387995AbgE1LGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:06:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D44B5ACA0;
        Thu, 28 May 2020 11:06:46 +0000 (UTC)
Date:   Thu, 28 May 2020 13:06:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v2] twist: allow converting pr_devel()/pr_debug() into
 snprintf()
Message-ID: <20200528110646.GC11286@linux-b0ei>
References: <e3b30905-4497-29b4-4636-a313283dbc56@i-love.sakura.ne.jp>
 <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528065603.3596-1-penguin-kernel@I-love.SAKURA.ne.jp>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-05-28 15:56:03, Tetsuo Handa wrote:
> syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
> ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
> because pr_debug() was no-op [1].
> 
>   pr_debug("fallback-read subflow=%p",
>            mptcp_subflow_ctx(ssock->sk));
>   copied = sock_recvmsg(ssock, msg, flags);
> 
> Thus, let's allow fuzzers to always evaluate pr_devel()/pr_debug()
> messages, by redirecting no-op pr_devel()/pr_debug() calls to snprintf().
> 
> [1] https://syzkaller.appspot.com/bug?id=12be9aa373be9d8727cdd172f190de39528a413a
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Petr Mladek <pmladek@suse.com>
> Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> ---
>  include/linux/dev_printk.h    | 16 ++++++++++++++++
>  include/linux/dynamic_debug.h | 14 ++++++++++++--
>  include/linux/printk.h        | 10 ++++++++++
>  lib/Kconfig.twist             | 12 ++++++++++++
>  4 files changed, 50 insertions(+), 2 deletions(-)

I am fine with pushing this into linux-next for testing purposes.
But I am against pushing this to Linus' tree in this form.

Now, it requires lib/Kconfig.twist that is added by a patch in
Andrew's tree. One approach is to push this into linux-next
via Andrew's -mm tree.

Another possibility would be to remove lib/Kconfig.twist
changes from this patch and replace
CONFIG_TWIST_ALWAYS_EVALUATE_PRINTK_ARGUMENTS with
CONFIG_TWIST_FOR_SYZKALLER_TESTING.
Then I could push it into linux-next via printk/linux.git tree.

Best Regards,
Petr
