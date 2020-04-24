Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1521B7854
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 16:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgDXObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 10:31:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:34736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgDXObd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:31:33 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 053FD20736;
        Fri, 24 Apr 2020 14:31:32 +0000 (UTC)
Date:   Fri, 24 Apr 2020 10:31:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
Message-ID: <20200424103131.7987f890@gandalf.local.home>
In-Reply-To: <579fbe97-9aae-2b67-03ff-01291b9cbb7d@i-love.sakura.ne.jp>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
        <20200424092816.62a61b1d@gandalf.local.home>
        <579fbe97-9aae-2b67-03ff-01291b9cbb7d@i-love.sakura.ne.jp>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 23:00:01 +0900
Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp> wrote:

> Since KERN_NO_CONSOLES is for -ENOMEM situations (GFP_KERNEL allocation which
> can sleep needs to invoke the OOM killer, or GFP_ATOMIC allocation which cannot
> sleep has failed), we can't create buffer on demand. For process context, it
> would be possible to create buffer upon fork() time. But for atomic context,
> it is so difficult to create buffer on demand. We could allocate shared buffer
> like logbuf but it means that we have to replicate what printk() is doing (too
> much code), for when atomic memory allocation happens resembles when printk()
> is called. Borrowing printk()'s logbuf is simpler.

I would have a buffer allocated for this at start up.

What exactly would you be "replicating" in printk? The point of printk is
to print to a console, not to be a generic ring buffer. This change is
breaking printk's most useful feature.

-- Steve
