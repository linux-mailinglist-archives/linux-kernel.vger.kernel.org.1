Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1282C2B886D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 00:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKRXdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 18:33:01 -0500
Received: from m12-18.163.com ([220.181.12.18]:33825 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbgKRXdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 18:33:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=9Oiao
        TJWFjQJvUQs6IlaEpuCvb1y/Q9Q3dl7UAP1V6E=; b=lpwl57yXmXy0evuN1YBN3
        r2hASigKh6Nuku2bVh941ExZjjYUsC0NmCeQCjbGyPd03Hf9yoOgnUixeI/HKQxr
        SkmqQK67s5mFME7+K9v0JP9sqkslwdC6UTRUjAc9Mirud6Mf2a5iPm2wmY2l+tEo
        aDPOLVXl4AGy+DWp41VINk=
Received: from localhost (unknown [122.194.9.171])
        by smtp14 (Coremail) with SMTP id EsCowADHWvyQrrVffkGeEw--.4252S2;
        Thu, 19 Nov 2020 07:30:25 +0800 (CST)
Date:   Thu, 19 Nov 2020 07:30:39 +0800
From:   Tao Zhou <t1zhou@163.com>
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Cc:     vincent.guittot@linaro.org, bsegall@google.com,
        dietmar.eggemann@arm.com, juri.lelli@redhat.com,
        zohooouoto@zoho.com.cn, mgorman@suse.de, mingo@redhat.com,
        ouwen210@hotmail.com, pauld@redhat.com, peterz@infradead.org,
        pkondeti@codeaurora.org, rostedt@goodmis.org,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Gavin Guo <gavin.guo@canonical.com>, halves@canonical.com,
        nivedita.singhvi@canonical.com, linux-kernel@vger.kernel.org,
        t1zhou@163.com
Subject: Re: [PATCH v3] sched/fair: fix unthrottle_cfs_rq for leaf_cfs_rq list
Message-ID: <20201118233039.GA6015@geo.homenetwork>
References: <17fc60a3-cc50-7cff-eb46-904c2f0c416e@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17fc60a3-cc50-7cff-eb46-904c2f0c416e@canonical.com>
X-CM-TRANSID: EsCowADHWvyQrrVffkGeEw--.4252S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr18ZF1UXr1DJF1fAr4ruFg_yoW8GF48pa
        18WrZ3Grs8uF1xJ397Wa1Sva48X395Jr1a9w1DG34ruFyaqr1avrWI9a9I9FZIkFnrKF10
        vr4qv3W2ga1DAaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UOo7NUUUUU=
X-Originating-IP: [122.194.9.171]
X-CM-SenderInfo: vwr2x0rx6rljoofrz/1tbiGhPgllaD772ROgAAsT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guilherme,

On Wed, Nov 18, 2020 at 07:56:38PM -0300, Guilherme G. Piccoli wrote:
> Hi Vincent (and all CCed), I'm sorry to ping about such "old" patch, but
> we experienced a similar condition to what this patch addresses; it's an
> older kernel (4.15.x) but when suggesting the users to move to an
> updated 5.4.x kernel, we noticed that this patch is not there, although
> similar ones are (like [0] and [1]).
> 
> So, I'd like to ask if there's any particular reason to not backport
> this fix to stable kernels, specially the longterm 5.4. The main reason
> behind the question is that the code is very complex for non-experienced
> scheduler developers, and I'm afraid in suggesting such backport to 5.4
> and introduce complex-to-debug issues.
> 
> Let me know your thoughts Vincent (and all CCed), thanks in advance.
> Cheers,
> 
> 
> Guilherme
> 
> 
> P.S. For those that deleted this thread from the email client, here's a
> link:
> https://lore.kernel.org/lkml/20200513135528.4742-1-vincent.guittot@linaro.org/
> 
> 
> [0]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fe61468b2cb
> 
> [1]
> https://lore.kernel.org/lkml/20200506141821.GA9773@lorien.usersys.redhat.com/
> <- great thread BTW!

Backport this patch to 5.4 need runnable_avg. but it is not introduced in 5.4
that time(please correct me if I am wrong).


Thanks,
Tao

