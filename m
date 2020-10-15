Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5E28F248
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 14:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgJOMiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 08:38:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:44364 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbgJOMiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 08:38:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602765496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a+Pa0B5CN/PbWsmHhZzk3whTHIdiCe8IRTsjHXMe2xo=;
        b=UdiyIu1FGyq1WJCwRWhuWOx+RJ4Pir8gltvaxPcDzm5nBYGP2JVb02i3zl4niJGxBQBZPD
        1VTYeqN7ICyjk1QEfaykvLjJbOVBp+38Qu6jUPXUZxbw8JAjaZrwPHEHo+O/ZJFrXnmkzz
        8EUeJoYCbvnd2XEKjUvlSCChcR3+iRE=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 693C7B1A0;
        Thu, 15 Oct 2020 12:38:16 +0000 (UTC)
Date:   Thu, 15 Oct 2020 14:38:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     akpm@linux-foundation.org
Cc:     tj@kernel.org, hdanton@sina.com,
        Zqiang <qiang.zhang@windriver.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4] kthread_worker: Prevent queuing delayed work from
 timer_fn when it is being canceled
Message-ID: <20201015123815.GE8871@alley>
References: <20201014075048.15473-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014075048.15473-1-qiang.zhang@windriver.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-10-14 15:50:48, Zqiang wrote:
> There is a small race window when a delayed work is being canceled and
> the work still might be queued from the timer_fn:
> 
> 	CPU0						CPU1
> kthread_cancel_delayed_work_sync()
>    __kthread_cancel_work_sync()
>      __kthread_cancel_work()
>         work->canceling++;
> 					      kthread_delayed_work_timer_fn()
> 						   kthread_insert_work();
> 
> BUG: kthread_insert_work() should not get called when work->canceling
> is set.
> 
> Cc: <stable@vger.kernel.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Andrew, are you going to take this patch with -mm tree, please?

I think that you usually take the changes in kthread.c.

Best Regards,
Petr
