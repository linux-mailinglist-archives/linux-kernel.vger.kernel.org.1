Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834002BA17B
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 05:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgKTEdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 23:33:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:37792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgKTEdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 23:33:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 728DEAC23;
        Fri, 20 Nov 2020 04:33:33 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Hillf Danton <hdanton@sina.com>
Date:   Fri, 20 Nov 2020 15:33:27 +1100
Cc:     TJ <tj@kernel.org>, Trond Myklebust <trondmy@hammerspace.com>,
        PeterZ <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
In-Reply-To: <20201120025953.607-1-hdanton@sina.com>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
 <20201109140141.GE7496@mtj.duckdns.org>
 <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
 <20201109161007.GF7496@mtj.duckdns.org>
 <20201118025820.307-1-hdanton@sina.com>
 <20201118055108.358-1-hdanton@sina.com>
 <20201120025953.607-1-hdanton@sina.com>
Message-ID: <87d008odew.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20 2020, Hillf Danton wrote:

> On Fri, 20 Nov 2020 10:07:56 +1100 NeilBrown wrote:
>>On Wed, Nov 18 2020, Hillf Danton wrote:
>>> On Wed, 18 Nov 2020 16:11:44 +1100 NeilBrown wrote:
>>>> On Wed, Nov 18 2020, Hillf Danton wrote:
>>>> ...
>>>> I don't think this is a good idea.
>>>
>>> Let me add a few more words.
>>>
>>>> cond_resched() is expected to be called often.  Adding all this extra
>>>
>>> They are those only invoked in concurrency-managed worker contexts and
>>> are thus supposed to be less often than thought; what is more the calle=
rs
>>> know what they are doing if a schedule() follows up, needless to say it
>>> is an ant-antenna-size add-in to check WORKER_CPU_INTENSIVE given
>>> 	WARN_ON_ONCE(workqueue_mustnt_use_cpu())
>>> added in cond_resched().
>>
>>"supposed to be less often" is the central point here.
>
> No, it is not in any shape, see below.
>
>>Because the facts are that they sometime happen with high frequency
>>despite what is "supposed" to happen.
>
> Feel free to point me to a couple of such workers. I want to see
> how high it is and why.

The patch should suggest some.
Any work item which calls iput() might find it self in iput_final() and
then truncate_inode_pages_range() which will call cond_resched() once
for every 16 or fewer pages.  If there are millions of pages ....

When a reply is received for an async NFS request (e.g. WRITE, but
several others), the processing happens in a workqueue (nfsiod), and this
will often call iput(), but rarely will that lead to iput_final().
Also, lots of non-workqueue code calls iput(), so adding code to an
inner-loop would cost everyone.

Any worker which allocates memory might find itself in
should_reclaim_retry() which calls cond_resched().  I don't know how
frequently this will fire.

The slab memory allocator uses a system_wq worker to reap a cache.  I
don't know exactly what that means but cache_reap() seems to need to
call cond_resched() periodically.  Maybe it should use be a
WQ_CPU_INTENSIVE workqueue, but there isn't a system_cpu_wq....
Using system_unbound_wq() as it is doing per-CPU work.

>
>>Either the assumption that CM-workers don't call cond_resched() is
>>wrong, or the code that schedules such workers on CM-queues is wrong.
>>
>>I much prefer the perspective that the assumption is wrong.  If that is
>>agreed then we need to handle that circumstance without making
>>cond_resched() more expensive.
>
> This is the central point I think; it is a mile in between what
> you are trying to fix and what you are adding in cond_resched().

My latest patch only adds a WARNING to cond_resched(), so that we can
find problem code before it becomes a problem.  I did previously try
adding more to cond_resched(), and PeterZ didn't like that at all.

I agree that fixing the problem cannot be in cond_resched().  I think
that finding the scope of the problem is best done by instrumenting
cond_resched() (when DEBUG_KERNEL is selected).

>
>>Note that adding WARN_ON_ONCE() does not make it more expensive as it is
>>only enabled with KERNEL_DEBUG (and WQ_WATCHDOG, though the particular
>>config option could be changed). It isn't needed in production.
>
> Because cond_resched() is not the right place from the beginning
> for debugging like this, something in workqueue's backyard by
> design.  It's been there for a while, in production or not.

I don't understand your reasoning.  I don't see why one subsystem cannot
provide debugging to help some other subsystem.  Many subsystems add
"might_sleep()", not to detect bugs in themselves but to detect bugs in
their callers.  Adding a WARNING to cond_resched() helps us find bugs in
code that calls cond_resched()...

>>
>>If the workqueue maintainers are unmovable in the position that a
>
> They are open to any good thoughts, yesterday and tomorrow.
>
>>CM-workitem must not use excessive CPU ever, and so must not call
>>cond_resched(), then I can take that back to the NFS maintainers and
>>negotiate different workqueue settings.=20
>
> That sounds like an easy road to go without either touching
> cond_resched() or adding a couple of lines in workqueue.  But
> the rising question is why you are branching to a new direction
> overnight if you think your thoughts are fine to fix an issue
> you observed in wq's property.

I'm branching off because I'm getting push-back and so am trying to
explore the problem space.
My first idea was to add WQ_CPU_INTENSIVE to the nfsiod workqueue, but
Trond wondered what was special about NFS.  Many filesystems call iput
from a workqueue, so finding a solution that helps them all is best.
I then suggested getting cond_resched() to do something more useful when
called by a worker.  PeterZ didn't like the overhead.
Also, TJ seemed to be against auto-adjusting for cpu-intensive code,
preferring the right sort of workqueue to be chosen up front.

I'm not really well placed to assess the validity of any of these
objections, so I'm trying to respond to them without completely giving
in to any of them.  Hence the "new direction overnight".

As a "user" of workqueues I would much much rather there was only one,
and that it always did the right thing.  Maybe I would have to put up
with two, but we currently have
 system_wq, system_highpri_wq, system_long_wq,
 system_unbound_wq, system_freezable_wq, system_power_efficient_wq,
 system_freezable_power_efficient_wq
plus the ability to create your own.  It is an embarrassment of riches
and I really wonder how many people know how to choose the right one.

So I'm not very keen on "make sure you choose the right type of wq", but
if that really is best, I certainly want automatic help to know when
I've made a harmful choice.

>
>>But as I've said, I think this
>>is requiring the decision to be made in a place that is not well
>>positioned to make it.
>
> I say no to asking NFS to take a pill because WQ got a cold.

That's good to know!  I think that means that when a work item happens
to consume a lot of CPU, it needs to stop blocking other work items and
instead share the CPU with them.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+3RxcOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbkyBBAApAb08PGNBKdR/y9yg3xpnPoUypcW+qUxX1E8
NbcpQHSTV1XZ3FF2jJBvAIoxPiREWpAqcwO5jGthEMYcrA+sYBs7SgqjodNra5xr
2tL4Nr7YGSqmkDhYPWdBjTvS/QZSZxgRWHTY9yn3K30QOb0H0CoYYMcRMiufQb85
fVIODo7ZrXZ9aWAGPrS3aByyguxY2poB0SLF/SNUqc8Sug6PgA6qkqEbs95MNo3L
5zUNhfpDVPSfXs+PAxXVXxUUKb9j7iaBQWPKQmxH5wJm59DZDRy71hY3iBI9rhgQ
46zwuHpItlmtB09Z3pbCvptFcWHrHzL4yTEm4w1IeJyBiGCpqcZvWd/l3JyIWXp6
oxzhluIiLeLez6hgsmQzqfkLrONcnKAnA6V51gEGeiCYTzmuDFE/rKU05sl3ZZ1C
imh5ZOrGZOsJcLOEJ1ecLdPuDstEU+hQ16CU/8YTi+5ea7QLQZ2D/FoDlZlVpokv
fXL9BtVNz19UNZHOlR2kXjAnveq6R50iqbBoqroVSSzhVqg+GqGXD2SNM/Eull4B
fN0poOILQUgqWEjyjyIQJZBNchfKzi0jhqYMbKRlkUFfu7Ddqhe6R71t+RIp54PH
RueFzUNWe3q/FtR6ZwYUIEzV9VTrKwL+CahSRIbVwObmaOkNMcUT5GFW5P3cgWl/
/x9h3Z0=
=E5Rm
-----END PGP SIGNATURE-----
--=-=-=--
