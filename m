Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0BD2B868A
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgKRVYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 16:24:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbgKRVYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 16:24:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605734693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KEFetNrz9oaXnh8tgOcWj7yDkYGvE3+srDGUNa21rsk=;
        b=cSyGT1ninVPDOIo5LcIYffC2qC3E9/gytBswvIHFiuHg6cPTHeUt3Hpn7T53rrZBSMUoXd
        8eU0oh2OhD02iwiN7BN/Muxa8UBmiu6v2u9uFjbMipnUGvgiatC2o51ObVCOHLJoBemDUc
        CM3vH9JhT531G24+uv/1IUGK8D8tZSo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-RQ9KstQPM4O4sGmFWuxI3A-1; Wed, 18 Nov 2020 16:24:49 -0500
X-MC-Unique: RQ9KstQPM4O4sGmFWuxI3A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA99384A5E0;
        Wed, 18 Nov 2020 21:24:47 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 16ACF1346F;
        Wed, 18 Nov 2020 21:24:40 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 0AILOeFo017597;
        Wed, 18 Nov 2020 16:24:40 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 0AILOcWa017593;
        Wed, 18 Nov 2020 16:24:38 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Wed, 18 Nov 2020 16:24:38 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Mike Snitzer <snitzer@redhat.com>
cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
In-Reply-To: <20201118160748.GA754@redhat.com>
Message-ID: <alpine.LRH.2.02.2011181611470.16933@file01.intranet.prod.int.rdu2.redhat.com>
References: <20201113225228.20563-1-rdunlap@infradead.org> <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com> <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org> <20201117163147.GA27243@redhat.com> <20201118154944.GB545@redhat.com>
 <20201118160748.GA754@redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 18 Nov 2020, Mike Snitzer wrote:

> On Wed, Nov 18 2020 at 10:49am -0500,
> Mike Snitzer <snitzer@redhat.com> wrote:
> 
> > I don't think my suggestion will help.. given it'd still leave
> > persistent_memory_claim() without a return statement.
> > 
> > Think it worthwhile to just add a dummy 'return 0;' after the BUG().
> 
> Decided to go with this, now staged for 5.11:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.11&id=a1e4865b4dda7071f3707f7e551289ead66e38b1

Hi

I would just use "return -EOPNOTSUPP;" and drop the "#ifdef 
DM_WRITECACHE_HAS_PMEM" that you added.

That BUG/return -EOPNOTSUPP code can't happen at all - if 
DM_WRITECACHE_HAS_PMEM is not defined, WC_MODE_PMEM(wc) always returns 
false - so persistent_memory_claim and BUG() can't ever be called. And if 
it can't be called, you don't need to add a code that prints an error in 
that case.

If we don't have DM_WRITECACHE_HAS_PMEM, the compiler optimizer will 
remove all the code guarded with if (WC_MODE_PMEM(wc)) as unreachable.

Mikulas


From: Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH] dm writecache: remove BUG() and fail gracefully insteadfor-nextdm-5.11

Building on arch/s390/ results in this build error:

cc1: some warnings being treated as errors
../drivers/md/dm-writecache.c: In function 'persistent_memory_claim':
../drivers/md/dm-writecache.c:323:1: error: no return statement in function returning non-void [-Werror=return-type]

Fix this by replacing the BUG() with a -EOPNOTSUPP return.

Fixes: 48debafe4f2f ("dm: add writecache target")
Cc: stable@vger.kernel.org	# v4.18+
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6/drivers/md/dm-writecache.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-writecache.c
+++ linux-2.6/drivers/md/dm-writecache.c
@@ -319,7 +319,7 @@ err1:
 #else
 static int persistent_memory_claim(struct dm_writecache *wc)
 {
-	BUG();
+	return -EOPNOTSUPP;
 }
 #endif
 

