Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB0E26F5E1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 08:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIRG0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 02:26:33 -0400
Received: from ozlabs.org ([203.11.71.1]:50781 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725886AbgIRG0c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 02:26:32 -0400
X-Greylist: delayed 66312 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 02:26:31 EDT
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Bt3ks3H7qz9sRK;
        Fri, 18 Sep 2020 16:26:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1600410390;
        bh=66IDvfqYhq/cJ6uDCcpX38A3C0anTkFpn4s2F7mfs2w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=cNndsfLtGUdLGgOoCrinazk+VMr1KXMXy9dd2TGqt3E9JdBOhBYJ9X5DDzGCzTxw/
         QIBS9Cqga2ubKLdDl76EuVj5250J8LufnfWTYIeNCmT4Jz9rV28Vg5Uin5Bz6v+0nN
         +KmaGQDIox/B7y/w4B5YVcuVN8slvuESXvFFkTWIyHM3we4F+F8Hg1uU57M9LaK9XG
         b6vTgFe5FzONVQJC1b2aDgb3L7MJqhX3VvYWYqsnmy4ivzdESlYSSb4VvSsLjLe+Pq
         ilMpwno0Ic1x6jOw275XLuzCUUyx6rVicKSbOW/lkIof4m14Pp8g0PMDemepiLYQJI
         xLwZlysNogciQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     David Miller <davem@davemloft.net>
Cc:     wangwensheng4@huawei.com, benh@kernel.crashing.org,
        paulus@samba.org, linux-ide@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] ide: Fix symbol undeclared warnings
In-Reply-To: <20200917.124445.1786301672047605176.davem@davemloft.net>
References: <20200916092333.77158-1-wangwensheng4@huawei.com> <87zh5oobnn.fsf@mpe.ellerman.id.au> <20200917.124445.1786301672047605176.davem@davemloft.net>
Date:   Fri, 18 Sep 2020 16:26:28 +1000
Message-ID: <87ft7fob1n.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller <davem@davemloft.net> writes:
> From: Michael Ellerman <mpe@ellerman.id.au>
> Date: Thu, 17 Sep 2020 22:01:00 +1000
>
>> Wang Wensheng <wangwensheng4@huawei.com> writes:
>>> Build the object file with `C=2` and get the following warnings:
>>> make allmodconfig ARCH=powerpc CROSS_COMPILE=powerpc64-linux-gnu-
>>> make C=2 drivers/ide/pmac.o ARCH=powerpc64
>>> CROSS_COMPILE=powerpc64-linux-gnu-
>>>
>>> drivers/ide/pmac.c:228:23: warning: symbol 'mdma_timings_33' was not
>>> declared. Should it be static?
>>> drivers/ide/pmac.c:241:23: warning: symbol 'mdma_timings_33k' was not
>>> declared. Should it be static?
>>> drivers/ide/pmac.c:254:23: warning: symbol 'mdma_timings_66' was not
>>> declared. Should it be static?
>>> drivers/ide/pmac.c:272:3: warning: symbol 'kl66_udma_timings' was not
>>> declared. Should it be static?
>>> drivers/ide/pmac.c:1418:12: warning: symbol 'pmac_ide_probe' was not
>>> declared. Should it be static?
>>>
>>> Signed-off-by: Wang Wensheng <wangwensheng4@huawei.com>
>>> ---
>>>  drivers/ide/pmac.c | 10 +++++-----
>>>  1 file changed, 5 insertions(+), 5 deletions(-)
>> 
>> TIL davem maintains IDE?
>> 
>> But I suspect he isn't that interested in this powerpc only driver, so
>> I'll grab this.
>
> I did have it in my queue, but if you want to take it that's fine too :)

That's OK, if you've got it already you take it. Thanks.

cheers
