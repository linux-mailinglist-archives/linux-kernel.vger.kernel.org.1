Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C462B9DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:11:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgKSXII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:08:08 -0500
Received: from mx2.suse.de ([195.135.220.15]:43634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726123AbgKSXII (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:08:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9C96CAC2E;
        Thu, 19 Nov 2020 23:08:06 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     Hillf Danton <hdanton@sina.com>
Date:   Fri, 20 Nov 2020 10:07:56 +1100
Cc:     "tj@kernel.org" <tj@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
In-Reply-To: <20201118055108.358-1-hdanton@sina.com>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
 <20201109140141.GE7496@mtj.duckdns.org>
 <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
 <20201109161007.GF7496@mtj.duckdns.org>
 <20201118025820.307-1-hdanton@sina.com>
 <20201118055108.358-1-hdanton@sina.com>
Message-ID: <87ima1ndwz.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Wed, Nov 18 2020, Hillf Danton wrote:

> On Wed, 18 Nov 2020 16:11:44 +1100 NeilBrown wrote:
>> On Wed, Nov 18 2020, Hillf Danton wrote:
>> ...
>> I don't think this is a good idea.
>
> Let me add a few more words.
>
>> cond_resched() is expected to be called often.  Adding all this extra
>
> They are those only invoked in concurrency-managed worker contexts and
> are thus supposed to be less often than thought; what is more the callers
> know what they are doing if a schedule() follows up, needless to say it
> is an ant-antenna-size add-in to check WORKER_CPU_INTENSIVE given
> 	WARN_ON_ONCE(workqueue_mustnt_use_cpu())
> added in cond_resched().

"supposed to be less often" is the central point here.
Because the facts are that they sometime happen with high frequency
despite what is "supposed" to happen.
Either the assumption that CM-workers don't call cond_resched() is
wrong, or the code that schedules such workers on CM-queues is wrong.

I much prefer the perspective that the assumption is wrong.  If that is
agreed then we need to handle that circumstance without making
cond_resched() more expensive.
Note that adding WARN_ON_ONCE() does not make it more expensive as it is
only enabled with KERNEL_DEBUG (and WQ_WATCHDOG, though the particular
config option could be changed). It isn't needed in production.

If the workqueue maintainers are unmovable in the position that a
CM-workitem must not use excessive CPU ever, and so must not call
cond_resched(), then I can take that back to the NFS maintainers and
negotiate different workqueue settings.  But as I've said, I think this
is requiring the decision to be made in a place that is not well
positioned to make it.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+2+swOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbmVrhAAtBrowxp9TFgqtJLZvEVdzsx263N2pdNZovl7
3k/yivCxvp5ESCISTp66WC17VCPg4dFAEXSiiK40wgH+Cmho2a9Aamf7lt67If19
XKl90PHV6fPxr76ez/6IaWYmVdSWRI3O1j9BnkeAN7oXp8RgxXlum7tV2C3nDeDw
5zCLKFsbctgB8xKkp0GgQD1zcZ4bXCQYelDXLc7t5hT7E/FIcOvbm/ld+rDp2H3K
mL3ZGTGUjDaU7waMihOQfaIig53G9G7+IOk6XvcGXQ7Gfca6WIIurSIim6uvoMRD
srws6NS4LsBHTZGHt55tMkclwC4j/tzXwoaD3Rih7p2oK9V7cD3FKSTMucTndoFy
S++6fYHjhSHxDBaEcwguCIaXfzkXansoWQytnfFsudVp/xx/ujPt8ZVRd9yr+esB
UJ/dRipkndiZ4mZyhDKlIg1ALF/lQoWoTSdnugvg2ANIdtd0DCeZMoBk6o1HGhQS
K1CCb0YjjCV8wcBHqdchbbUeD0PG8vb5OT17crSli//25n4URSqf9cZ+qPY9DSW9
YuGUHfeXHdpFvKYN5i0bI/r2NnMjaVU4oNojJ2/BbeO/KPlu3GiCqrESoUkrTaqo
sjL2Mshmq0tKWH1v55aXIcg9aj5+9uodjqLwSJF2x26vqeat4fNGPi+pSYh4JGhY
hsLf0rs=
=YlsI
-----END PGP SIGNATURE-----
--=-=-=--
