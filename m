Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA262C65CF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 13:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgK0MjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 07:39:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:44462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725985AbgK0MjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 07:39:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1606480756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S40mvgFHdlEpWQWWOkmkDIIHSMDH7gWDGXCALvGZ7L0=;
        b=Kvrrd0TbDOdxYUHo8IBi/wiRJH6O/5B3Pj4cn0DyCRdybnAgsF34+NEKJfb8waYPB3EUs6
        QG2OTowYvI8+kTlZm8YZsMRu5x/ItCXj8mmNj4UtUbpfnHHcIYBRTjlfdX8s1sUntAbAZt
        2/R1aAQvMkaYbBsfIf6+c2a7pEY/lxs=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 24174AC2E;
        Fri, 27 Nov 2020 12:39:16 +0000 (UTC)
Date:   Fri, 27 Nov 2020 13:39:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Atish Patra <atishp@atishpatra.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: finalize records with trailing newlines
Message-ID: <X8DzctH5tYpM2/sd@alley>
References: <20201126114836.14750-1-john.ogness@linutronix.de>
 <53ab7746-5871-992b-7ab8-853b7c08ae13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53ab7746-5871-992b-7ab8-853b7c08ae13@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-11-26 20:32:18, Kefeng Wang wrote:
> 
> On 2020/11/26 19:48, John Ogness wrote:
> > Any record with a trailing newline (LOG_NEWLINE flag) cannot
> > be continued because the newline has been stripped and will
> > not be visible if the message is appended. This was already
> > handled correctly when committing in log_output() but was
> > not handled correctly when committing in log_store().
> > 
> > Fixes: f5f022e53b87 ("printk: reimplement log_cont using record extension")
> > Signed-off-by: John Ogness <john.ogness@linutronix.de>
> > ---
> >   This is an important bugfix for continuous messages and should
> >   be part of the 5.10 release.
> > 
> >   If not applied, newlines will vanish when concatenating
> >   continuous with trailing newlines.
> Thanks for you quick fix.
> 
> Reported-and-tested-by:  Kefeng Wang <wangkefeng.wang@huawei.com>

The patch is committed in printk/linux.git, branch
for-5.10-pr_cont-fixup.

I do not have much experience with pushing fixes this late in the
release cycle.

Normally, I would prefer to give it few days in linux-next. But
the fix is quite trivial. And it would be better to have it
in 10-rc6 rather than in rc7 that might be the last rc before
release.

Thanks a lot for report, fix, and testing.

Best Regards,
Petr
