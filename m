Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3497C202AE0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jun 2020 15:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730125AbgFUNyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Jun 2020 09:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729862AbgFUNyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:54:54 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49CBC061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 06:54:53 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 4D589C01A; Sun, 21 Jun 2020 15:54:52 +0200 (CEST)
Date:   Sun, 21 Jun 2020 15:54:37 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Alexander Kapshuk <alexander.kapshuk@gmail.com>
Cc:     linux-kernel@vger.kernel.org, christian.brauner@ubuntu.com,
        oleg@redhat.com, ebiederm@xmission.com, akpm@linux-foundation.org,
        liuzhiqiang26@huawei.com, joel@joelfernandes.org,
        paulmck@linux.vnet.ibm.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] kernel/signal.c: Export symbol __lock_task_sighand
Message-ID: <20200621135437.GA18092@nautica>
References: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200621133704.77896-1-alexander.kapshuk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Kapshuk wrote on Sun, Jun 21, 2020:
> Export symbol __lock_task_sighand, so it is accessible from code compiled
> as modules.
> This fixes the following modpost error:
> ERROR: modpost: "__lock_task_sighand" [net/9p/9pnet.ko] undefined!

This can't fix something that's not broken (yet)! :)

I think it'd make more sense to describe why you think we should export
it, rather than describe a precise usecase e.g. justify why this would
be interesting to use from modules (e.g. it would help modules like 9p
take a lock on the current signal handler safely and cleanly through
lock_task_sighand())



Christian, Andrew - assuming this passes reviews from someone else I'm
not sure how to go forward with this; it'd be simpler for me if I could
take it in the 9p tree as I need it for the patch Alexander pointed at,
but I'm not normally touching any file outside of the 9p tree.
Is it better to let either of you take it normally (I think it'd be
you?) and wait for that to land, or can I take it in my tree for the
next merge window?



If we don't want to export it for some reason, I'm the one who suggested
using lock_task_sighand() so would be interested in how to go forward as
well; 9p probably shouldn't mess with signals at all... That part of the
code is especially bad as it makes the task unkillable in a weird way.

Actually I do have a patch that makes flush asynchronous and removes the
need for this altogether, maybe it's time I finish that patch serie
instead :P


Thanks,
-- 
Dominique
