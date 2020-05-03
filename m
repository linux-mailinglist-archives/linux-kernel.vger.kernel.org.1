Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1563D1C2F49
	for <lists+linux-kernel@lfdr.de>; Sun,  3 May 2020 22:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgECUre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 16:47:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:36770 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729002AbgECUre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 16:47:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 64416AAC7;
        Sun,  3 May 2020 20:47:33 +0000 (UTC)
Date:   Sun, 3 May 2020 13:43:15 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, tglx@linutronix.de, mingo@kernel.org,
        mgorman@techsingularity.net, bp@suse.de,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>,
        oleg@redhat.com
Subject: Re: [PATCH] kernel/sys: do not use tasklist_lock to set/get
 scheduling priorities
Message-ID: <20200503204315.lmk66kludmjaoxbq@linux-p48b>
References: <20200502030539.32581-1-dave@stgolabs.net>
 <20200502093105.GJ3762@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200502093105.GJ3762@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc'ing Oleg who iirc also like this stuff.

On Sat, 02 May 2020, Peter Zijlstra wrote:

>On Fri, May 01, 2020 at 08:05:39PM -0700, Davidlohr Bueso wrote:
>> For both setpriority(2) and getpriority(2) there's really no need
>> to be taking the tasklist_lock at all - for which both share it
>> for the entirety of the syscall. The tasklist_lock does not protect
>> reading/writing the p->static_prio and task lookups are already rcu
>> safe, providing a stable pointer.
>
>RCU-safe, as in, it will not crash.. However, without tasklist_lock the
>thread iterations (for PRIO_PGRP/PRIO_USER) now race against fork().
>
>That is a user observable change in behaviour.
>
>Do we care about it? No idea, and your Changelog also doesn't provide
>clue.

Yeah, that was convenient of me to leave out, sorry. So copy_process()
will hlist_add_rcu() under the writer tasklist_lock, but pid->tasks rculist
traversals are safe. As such afaiu this fork serialization is for concurrent
changes, something these syscalls do not do.

In any case, we could at least keep the changes to getpriority(2) as even
if there is a race in the list the new priority won't be any higher than
what was observed already, thus maintaining semantics.

Thanks,
Davidlohr
