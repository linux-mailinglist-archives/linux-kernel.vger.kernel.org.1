Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB8B278407
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgIYJat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:30:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:46110 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgIYJas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:30:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601026247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nXd+mXCMbmsTLP7rK+54OhNZjULaCQtIhy9qCSBAxq0=;
        b=JAIkaSDO4LCWnEDGmTh7n1oh86mHdq6XpReUjxEI3/LHzGPLvXXe2lB4fEchbNq4B3cxoS
        eLsmM2uYr/+vFVSDL2OmzXDZh4/MbXoooDaTWlG/omvSLlqbIbgaSia5eYaCj/XiG3MFkN
        +P4VuWXBnuMkcDhQflCWrH6frNQqxsE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F3A8B119;
        Fri, 25 Sep 2020 09:30:47 +0000 (UTC)
Date:   Fri, 25 Sep 2020 11:30:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     qiang.zhang@windriver.com
Cc:     tj@kernel.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kernel/kthread.c: kthread_worker: add work status
 check in timer_fn
Message-ID: <20200925093046.GM29288@alley>
References: <20200925050759.20805-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925050759.20805-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-09-25 13:07:59, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> When queue delayed work to worker, at some point after that the timer_fn
> will be call, add work to worker's work_list, at this time, the work may
> be cancel, so add "work->canceling" check current work status.

Great catch!

I was able to understand the problem from the description. Though I
would still try to improve it a bit. I suggest:

<new_text>
Subject: kthread_worker: Prevent queuing delayed work from timer_fn when it is being canceled

There is a small race window when a delayed work is being canceled and
the work still might be queued from the timer_fn:

CPU0					CPU1

kthread_cancel_delayed_work_sync()
  __kthread_cancel_work_sync()
    __kthread_cancel_work()
	work->canceling++;

					kthread_delayed_work_timer_fn()
					  kthread_insert_work();

BUG: kthread_insert_work() should not get called when work->canceling
is set.
</new_text>

> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

With the above subject and commit message:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
