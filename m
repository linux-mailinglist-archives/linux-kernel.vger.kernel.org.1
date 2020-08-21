Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D724C99B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 03:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgHUBmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 21:42:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:33604 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbgHUBme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:42:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCE4CB1E7;
        Fri, 21 Aug 2020 01:43:00 +0000 (UTC)
Date:   Thu, 20 Aug 2020 18:27:50 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        oleg@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] mm/kmemleak: rely on rcu for task stack scanning
Message-ID: <20200821012750.qxiklfhuaryajvhn@linux-p48b>
Mail-Followup-To: Qian Cai <cai@lca.pw>, akpm@linux-foundation.org,
        catalin.marinas@arm.com, oleg@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
References: <20200820203902.11308-1-dave@stgolabs.net>
 <20200821002554.GB4622@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200821002554.GB4622@lca.pw>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020, Qian Cai wrote:

>On Thu, Aug 20, 2020 at 01:39:02PM -0700, Davidlohr Bueso wrote:
>> kmemleak_scan() currently relies on the big tasklist_lock
>> hammer to stabilize iterating through the tasklist. Instead,
>> this patch proposes simply using rcu along with the rcu-safe
>> for_each_process_thread flavor (without changing scan semantics),
>> which doesn't make use of next_thread/p->thread_group and thus
>> cannot race with exit. Furthermore, any races with fork()
>> and not seeing the new child should be benign as it's not
>> running yet and can also be detected by the next scan.
>
>It is not entirely clear to me what problem the patch is trying to solve. If
>this is about performance, we will probably need some number.

So in this case avoiding the tasklist_lock could prove beneficial for performance
considering the scan operation is done periodically. I have seen improvements
of 30%-ish when doing similar replacements on very pathological microbenchmarks
(ie stressing get/setpriority(2)).

However my main motivation is that it's one less user of the global lock,
something that Linus has long time wanted to see gone eventually (if ever)
even if the traditional fairness issues has been dealt with now with qrwlocks.
Of course this is a very long ways ahead. This patch also kills another user
of the deprecated tsk->thread_group.

Thanks,
Davidlohr
