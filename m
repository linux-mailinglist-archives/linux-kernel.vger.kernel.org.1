Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762F62C5E29
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 00:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391949AbgKZXbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 18:31:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:49462 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391864AbgKZXa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 18:30:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DA85CAE59;
        Thu, 26 Nov 2020 23:30:57 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "tj@kernel.org" <tj@kernel.org>
Date:   Fri, 27 Nov 2020 10:30:50 +1100
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
In-Reply-To: <X75Pvp9q3XTckdwd@mtj.duckdns.org>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
 <20201109140141.GE7496@mtj.duckdns.org>
 <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
 <20201109161007.GF7496@mtj.duckdns.org>
 <87ft55nd6n.fsf@notabene.neil.brown.name>
 <X75Pvp9q3XTckdwd@mtj.duckdns.org>
Message-ID: <87v9drlmqd.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25 2020, tj@kernel.org wrote:

> Hello,
>
> On Fri, Nov 20, 2020 at 10:23:44AM +1100, NeilBrown wrote:
>> On Mon, Nov 09 2020, tj@kernel.org wrote:
>>=20
>> >                                                    Given that nothing =
on
>> > these types of workqueues can be latency sensitive
>>=20
>> This caught my eye and it seems worth drilling in to.  There is no
>> mention of "latency" in workqueue.rst or workqueue.h.  But you seem to
>> be saying there is an undocumented assumption that latency-sensitive
>> work items much not be scheduled on CM-workqueues.
>> Is that correct?
>
> Yeah, correct. Because they're all sharing execution concurrency, the
> latency consistency is likely a lot worse.
>
>> NFS writes are latency sensitive to a degree as increased latency per
>> request will hurt overall throughput.  Does this mean that handling
>> write-completion in a CM-wq is a poor choice?
>> Would it be better to us WQ_HIGHPRI??  Is there any rule-of-thumb that
>> can be used to determine when WQ_HIGHPRI is appropriate?
>
> I don't think it'd need HIGHPRI but UNBOUND or CPU_INTENSIVE would make
> sense. I think the rule of the thumb is along the line of if you're worri=
ed
> about cpu consumption or latency, let the scheduler take care of it (ie. =
use
> unbound workqueues).

Thanks.
For nfsiod there are two contexts where it is used.

 In one context there is normally a thread waiting for the work item
 to complete.  It doesn't run the work in-line because the thread needs
 to abort if signaled, but the work needs to happen anyway so that the
 client and server remain in-sync.  In this case the fact that a
 application is waiting suggests that latency could be a problem.

 The other context is completing an async READ or WRITE.  I'm not sure
 if latency at this stage of the request will actually affect
 throughput, but we do need a WQ_MEM_RECLAIM wq for the WRITE at least.

 Keep both types of users on the same wq is simplest, so making it
  WQ_UNBOUND | WQ_MEM_RECLAIM
 is probably safest and would ensure that a cpu-intensive iput_final()
 doesn't interfere with other requests unduly.
 Quite a few other filesystems do use WQ_UNBOUND, often with
  WQ_MEM_RECLAIM, but it is not easy to do a like-for-like comparison.

 I might have a go at updating the workqueue documentation to provide
 some guidance on how to choose a workqueue and when certain flags are
 needed.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl/AOqsOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbk/xw//cLs5oeFBcGb5JUV/XzEFJWrQlYSBdhI+dTTE
HLnubsWyIrWKb/QwzKXIcmWJ9PrWhW/rxcaFh9m04gfoPiliMx7saSSsGWaqk8OJ
2PfuoVOZlxRU13W7q4UDXwMlNvOxKUAxPOofXekPd7sgWhSibCHM448nnTENWiMB
YlvcqOvKVsIkMzkMr0wKIEk8HG0QP/Ys2nruG3uMjjWLN1FVgIjvbEi6lZ7psAna
T0gr/IlR075x0fNvsRq9zEUsk1A8FkqAeCc1WL0BQ+qm5Ago90utqex79ImugVyb
/dYlZW8Y0TK8alPlmgUjiCitlNknmG7+w/3GBlaa6465p+F1oqiWrxGYrhpiNm1t
KMOjOqflsMlCIlKUtiD6R8m8aItpoxlnYwgh+b2PKeLo7WKls9RmaHRm3RsqtOdh
ZkF7fojTVPOKSLlseNP6MuQUYISPe7HsPxf2DqUOyNby/67xSQyoBX/S5+6GY/gu
n4dYeQVGd4i2nM8/66cn+YPQbqM3mnL2X0aRAutWqr8kZC33PwftysF3zIUI+nUj
klT29avXRkB4xnQwv+8m38cVW1/mCmyG1rJCHN0QhGpmnNRf+9gXDdRFiYSXQhdq
By/sjthAKhtXB6cbGyp3BzFLSCWLE+wNq9mMDpFm7KjuEX1TZrRvaQjD0NmW8rbk
qRNPN+4=
=ep3o
-----END PGP SIGNATURE-----
--=-=-=--
