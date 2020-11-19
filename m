Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954F42B9E24
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 00:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgKSXXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 18:23:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:52000 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgKSXXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 18:23:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 55E37AC2E;
        Thu, 19 Nov 2020 23:23:51 +0000 (UTC)
From:   NeilBrown <neilb@suse.de>
To:     "tj@kernel.org" <tj@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Fri, 20 Nov 2020 10:23:44 +1100
Cc:     "jiangshanlai@gmail.com" <jiangshanlai@gmail.com>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rfc] workqueue: honour cond_resched() more effectively.
In-Reply-To: <20201109161007.GF7496@mtj.duckdns.org>
References: <87v9efp7cs.fsf@notabene.neil.brown.name>
 <20201109080038.GY2594@hirez.programming.kicks-ass.net>
 <aec65c71c09e803285688d5974193a98b4422428.camel@hammerspace.com>
 <20201109140141.GE7496@mtj.duckdns.org>
 <d2c79d91e29134ef6184138de5fc856ca530d2a5.camel@hammerspace.com>
 <20201109161007.GF7496@mtj.duckdns.org>
Message-ID: <87ft55nd6n.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain

On Mon, Nov 09 2020, tj@kernel.org wrote:

>                                                    Given that nothing on
> these types of workqueues can be latency sensitive

This caught my eye and it seems worth drilling in to.  There is no
mention of "latency" in workqueue.rst or workqueue.h.  But you seem to
be saying there is an undocumented assumption that latency-sensitive
work items much not be scheduled on CM-workqueues.
Is that correct?

NFS writes are latency sensitive to a degree as increased latency per
request will hurt overall throughput.  Does this mean that handling
write-completion in a CM-wq is a poor choice?
Would it be better to us WQ_HIGHPRI??  Is there any rule-of-thumb that
can be used to determine when WQ_HIGHPRI is appropriate?

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJCBAEBCAAsFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAl+2/oAOHG5laWxiQHN1
c2UuZGUACgkQOeye3VZigbm8KxAAtKIpzJB8PC1aQMVBtitctNAScwsTSCh0ESxz
JeN7Tv+t2lMnzq2doyWiQIZbEQv2l/t6J1TGXNHZm4NIscPO7MmfkoVQlobxmA9n
sLS31PiFhje0IfqBHdNqSlP/GFH+zHA+ZLrIdpSbGFKWKJpyf+lksyUQ1Gidbonx
6tcdmKtM411PavZZaY7i8sZnuzTX8OSqBliMJtN8Zo8ebalUJIGr1oE4wuxa3pVU
WUHGK4afhueqJ47UQ+4ELi8ubP8D9+ncl0DDOmGiqSfRPNRUQM27qn+JU8Ypv213
EoujmFtiDsP93F1UKyfEYexjobHxm7l4KoM6BJK77Qmqozlf6mEuuhlgZpZ28NP/
EtpSTR7byZzhZucpB62cYyFqTAlxGW+vL2NH3MRAiVzspPZitnzS5SxuMOPY3etg
OwNHUKnrPP2sksQRxTG+TGrBUqJBVDJCfjW/n8w1847+bc8yq+8rM1fkHXFB5zR1
FbL10WY/tRHjpc/aSlP/XcaGbpA1K1C8x9Odqhiugm1SlVbgaMehix9FhAypkSt0
mPuaY4XiOE//rNKcSqijlpYm4M1DaRqHml8oX8z3xPKMub8xYGbQnC+oIFBS9nRQ
1iI2Qf834DSa8HvBPPaCMVShOWkVSIMbE63eCUdctDWjiWre/MexqjuzfprRouLP
QDJ5OMc=
=Jp9h
-----END PGP SIGNATURE-----
--=-=-=--
