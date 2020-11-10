Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCD32ACB0B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 03:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbgKJC0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 21:26:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:35952 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKJC0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 21:26:36 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6520DAB95;
        Tue, 10 Nov 2020 02:26:34 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Peter Zijlstra <peterz@infradead.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Tue, 10 Nov 2020 13:26:27 +1100
Cc:     "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "tj@kernel.org" <tj@kernel.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
In-Reply-To: <20201109142016.GK2611@hirez.programming.kicks-ass.net>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
 <20201109142016.GK2611@hirez.programming.kicks-ass.net>
Message-ID: <87pn4mosks.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09 2020, Peter Zijlstra wrote:

> On Mon, Nov 09, 2020 at 01:50:40PM +0000, Trond Myklebust wrote:
>> On Mon, 2020-11-09 at 09:00 +0100, Peter Zijlstra wrote:
>
>> > I'm thinking the real problem is that you're abusing workqueues. Just
>> > don't stuff so much work into it that this becomes a problem. Or
>> > rather,
>> > if you do, don't lie to it about it.
>>=20
>> If we can't use workqueues to call iput_final() on an inode, then what
>> is the point of having them at all?
>
> Running short stuff, apparently.

Also running stuff that sleeps.  If only does work in short bursts, and
sleeps between the works, it can run as long as it likes.
It is only sustained bursts that are currently not supported with
explicit code.

>
>> Neil's use case is simply a file that has managed to accumulate a
>> seriously large page cache, and is therefore taking a long time to
>> complete the call to truncate_inode_pages_final(). Are you saying we
>> have to allocate a dedicated thread for every case where this happens?
>
> I'm not saying anything, but you're trying to wreck the scheduler
> because of a workqueue 'feature'. The 'new' workqueues limit concurrency
> by design, if you're then relying on concurrency for things, you're
> using it wrong.
>
> I really don't know what the right answer is here, but I thoroughly hate
> the one proposed.

Oh good - plenty for room for improvement then :-)

I feel strongly that this should work transparently.  Expecting people
too choose the right option to handle cases that don't often some up in
testing is naive.
A warning whenever a bound,non-CPU-intensive worker calls cond_resched()
is trivial to implement and extremely noise.  As mentioned, I get twenty
just to boot.

One amusing example is rhashtable which schedule a worker to rehash a
table.  This is expected to be cpu-intensive because it calls
cond_resched(), but it is run with schedule_work() - clearly not
realizing that will block other scheduled work on that CPU.

An amusing example for the flip-side is crypto/cryptd.c which creates a
WQ_CPU_INTENSIVE workqueue (cryptd) but the cryptd_queue_worker() has
a comment "Only handle one request at a time to avoid hogging crypto
workqueue." !!! The whole point of WQ_CPU_INTENSIVE is that you cannot
hog the workqueue!!

Anyway, I digress....  warning on ever cond_resched() generates lots of
warnings, including some from printk.... so any work item that might
ever print a message needs to be CPU_INTENSIVE???
I don't think that scales.

Is there some way the scheduler can help?  Does the scheduler notice
"time to check on that CPU over there" and then:
 - if it is in user-space- force it to schedule
 - if it is in kernel-space (and preempt is disabled), then leave it
 alone
 ??

If so, could there be a third case - if it is a bound,non-cpu-intensive
worker, switch it to cpu-intensive???

I wonder how long workers typically run - do many run long enough that
the scheduler might want to ask them to take a break?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+p+lMOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbkmURAAkHR6kDOsZoFw+EbfmtbJdJ7p7ffqHcGxk9JH
a1xngFazd+peJEahsg93p+8E04KEKkXbJW8Pn/7dwhJm2K0sub/sWf8cGquMsKHt
2pGN61qOkw3PAXJbVm4JWrvi1dXbAYLuj/D0BxKhHB6B8JVf0lTXwgjbGA1c1WsK
c3snQ2Iaon/y/r5gICHe/vQ3AHFPNZ6ikG3jVT9pyyYecF/UEh1Cdz3fxMzlkfZk
K3i5u6T9j8QPAkwedU8YY2AtFHba7sElJu8hQ8URQAhsUSh6huRAP5cs0qtviVqw
eQrEPHk6aPQhuPxgMp2EtjWzL3olu3pWdwLoCD387oRC9CLtTjx5WyTPKA9Pv6Hy
hqQj6odc+enoLmjz5tSbihaUvluW0Ae4ddRTKX3Jqeqt4BvJWjVlCs055iTMlh25
CUAop0/hcf6lkmA5teKG3EMlrMuJH/X+XWaV7VS28HnD+H76dL33wNpUIlfZDPrr
yEk3VU+hBA8Hr6lyiktIFW2XpeIolWA6lTXsmcoLZFpX3VQG3l70BQf4XWtmCenq
HPCcetsHK3vcCByxaCVj2K7AnNuv7dpQKRkiExBQBPviRKk4IBIC6MXAxAzNafUK
tWcb+rvDJgyGCSRL0F/OEiQQ8akcQwWRAc4ClYlvYlsq4QYQJWRKhH1oUA5Kx1Vc
TqV/4VE=
=z4yF
-----END PGP SIGNATURE-----
--=-=-=--
