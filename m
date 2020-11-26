Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1634C2C5E48
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 00:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403898AbgKZXoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 18:44:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:52202 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388598AbgKZXoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:44:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C5D88AC6A;
        Thu, 26 Nov 2020 23:44:19 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Hillf Danton <hdanton@sina.com>
Date:   Fri, 27 Nov 2020 10:44:14 +1100
Cc:     TJ <tj@kernel.org>, Trond Myklebust <trondmy@hammerspace.com>,
        PeterZ <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
In-Reply-To: <20201126100646.1790-1-hdanton@sina.com>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
 <20201109140141.GE7496@mtj.duckdns.org>
 <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
 <20201109161007.GF7496@mtj.duckdns.org>
 <20201118025820.307-1-hdanton@sina.com>
 <20201118055108.358-1-hdanton@sina.com>
 <20201120025953.607-1-hdanton@sina.com>
 <20201126100646.1790-1-hdanton@sina.com>
Message-ID: <87sg8vlm41.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26 2020, Hillf Danton wrote:

> On Fri, 20 Nov 2020 15:33:27 +1100 NeilBrown wrote:
>>
>>My first idea was to add WQ_CPU_INTENSIVE to the nfsiod workqueue, but
>>Trond wondered what was special about NFS.  Many filesystems call iput
>>from a workqueue, so finding a solution that helps them all is best.
>
> In terms of iput, I think we can splice WQ_CPU_INTENSIVE to
> WQ_MEM_RECLAIM.

I'm actually starting to think that WQ_CPU_INTENSIVE is a mistake.  If
you really have cpu-intensive work, you should be using WQ_UNBOUND.

It is possible that there might be work that is CPU intensive and which
must be run on a particular CPU - such as clearing out per-cpu lists of
recently freed slab allocations.  But I don't WQ_CPU_INTENSIVE is currently
used that way.

I cannot find *any* users of WQ_CPU_INTENSIVE which call cond_resched()
in the relevant work items.  And if the code doesn't call cond_resched()
(or similar), then it isn't really CPU-intensive.

>
>>I then suggested getting cond_resched() to do something more useful when
>>called by a worker.  PeterZ didn't like the overhead.
>>
>>Also, TJ seemed to be against auto-adjusting for cpu-intensive code,
>>preferring the right sort of workqueue to be chosen up front.
>
> Actually WQ_EVENTS_LONG sounds better than WQ_CPU_INTENSIVE, given that
> we have two events WQs with the same attr.

There is no WQ_EVENTS_LONG

>
> 	system_wq =3D alloc_workqueue("events", 0, 0);
> 	system_long_wq =3D alloc_workqueue("events_long", 0, 0);
>
> Then what are the boundaries we can draw in between WQ_MEM_RECLAIM,
> WQ_CPU_INTENSIVE and WQ_EVENTS_LONG?

I think system_long_wq is a design flaw.
Some code (mistakenly) schedules work on system_wq, calls
flush_workqueue(system_wq)) and expects that to complete reasonably quickly.
To ensure this can work, system_long_wq was created and work items that
might take a long time are encouraged to be run there.
Instead, the mistaken code should create its own work queue, schedule
work on that, and flush that queue.

Thanks,
NeilBrown

>
>
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -4261,6 +4261,9 @@ struct workqueue_struct *alloc_workqueue
>  	if ((flags & WQ_POWER_EFFICIENT) && wq_power_efficient)
>  		flags |=3D WQ_UNBOUND;
>=20=20
> +	if (flags & (WQ_MEM_RECLAIM | WQ_UNBOUND) =3D=3D WQ_MEM_RECLAIM)
> +		flags |=3D WQ_CPU_INTENSIVE;
> +
>  	/* allocate wq and format name */
>  	if (flags & WQ_UNBOUND)
>  		tbl_size =3D nr_node_ids * sizeof(wq->numa_pwq_tbl[0]);

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl/APc4OHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbkqUw/+P24X2JayGfJP6lqUeEKipsanaQMOV9GnIcpj
eFFHplLdG6CoTF9JTdycpzdsOPrKhTzrSZQNbBTkcVwQK9AZkLgFRzbopqHb+J51
DvlbyUwYZ+Nu79RF/hXi3+0Ua4qKxt/ZD0UdPPLd9E1lH9WfWStBjMpd9pva5O8N
KVqy4zraBBTn00dj6dsCPMg4cYaswJFPJU/94Z+owCXDGcBAW/70cfQJcGfZYjI7
gCgiC73/9rpKmxH0pgRhEC+rqoi3rZYLIUoYKIeCAFRouWVnl+pzpBBH/5b6j3Xu
lOtCAsj4CKXH3uefxM4+GW6cKBJpE45sJKs1NvbopYcpqnOsc9jcXEhegcSYVUdp
xMLuPlMuRYene1/i2Cwc2oJ4rnNB1vEgyuTGBbHB2Uag2d93U7Y0nOTKBI79P3ln
Qfm2T32SxFoK+nj/slR0MIbD0avLKbzY4TqUF23dPoq22k6i9tWM89/i4e4IdZli
u7E44r/ElVJt+bsKoMeaeEMkkuIJEWRkFU9tAAkMfdu8+50komu++mIWYW4uXEZd
z+28i+ApEmCidS3LpbgsdKr8qLZl7YaS1Zt8xkh3YdQ5rFGGIv8YYAX7U/5PcEqi
qUL5doU8zC9EwNFZLzkhwvupc9guT8Jksf7YAfDjvIuSOs3BOiEYfSjASGfOcepZ
iWHPFVo=
=5RGk
-----END PGP SIGNATURE-----
--=-=-=--
