Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7794A2BABAC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 15:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgKTOIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 09:08:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726561AbgKTOIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 09:08:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605881324;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aGTiEL+52RoWS+9nd1Ms/clbRnrmeizFKg1laIg8ttk=;
        b=jVlVn/G72N0HCSwV9sN3r8VKcg7slmk/em9TWmkqHA1w7QOT4wFoJSLKWchHeFvvz8luEX
        yrRCwJEIggsc3QrbdxoogxduxMYu49tbtYsZqaHoJUl6cp9Ikb5ZgHjuzqvCkt/qr2Djdn
        jE3MlR+5WEmTypWywdmw5ADn2CWNJdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-jDTPSWkfN9q9QjQ53M0X-Q-1; Fri, 20 Nov 2020 09:08:42 -0500
X-MC-Unique: jDTPSWkfN9q9QjQ53M0X-Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F640814410;
        Fri, 20 Nov 2020 14:08:41 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7663519C46;
        Fri, 20 Nov 2020 14:08:37 +0000 (UTC)
Date:   Fri, 20 Nov 2020 09:08:20 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: md: dm-writeback: add __noreturn to BUG-ging function
Message-ID: <20201120140819.GA7359@redhat.com>
References: <20201113225228.20563-1-rdunlap@infradead.org>
 <344abf76-9405-58ba-2dc4-27cab88c974d@de.ibm.com>
 <c29eeb5d-0683-49eb-f729-38b14fac7745@infradead.org>
 <20201117163147.GA27243@redhat.com>
 <20201118154944.GB545@redhat.com>
 <20201118160748.GA754@redhat.com>
 <alpine.LRH.2.02.2011181611470.16933@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2011181611470.16933@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18 2020 at  4:24pm -0500,
Mikulas Patocka <mpatocka@redhat.com> wrote:

> 
> 
> On Wed, 18 Nov 2020, Mike Snitzer wrote:
> 
> > On Wed, Nov 18 2020 at 10:49am -0500,
> > Mike Snitzer <snitzer@redhat.com> wrote:
> > 
> > > I don't think my suggestion will help.. given it'd still leave
> > > persistent_memory_claim() without a return statement.
> > > 
> > > Think it worthwhile to just add a dummy 'return 0;' after the BUG().
> > 
> > Decided to go with this, now staged for 5.11:
> > https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-5.11&id=a1e4865b4dda7071f3707f7e551289ead66e38b1
> 
> Hi
> 
> I would just use "return -EOPNOTSUPP;" and drop the "#ifdef 
> DM_WRITECACHE_HAS_PMEM" that you added.
> 
> That BUG/return -EOPNOTSUPP code can't happen at all - if 
> DM_WRITECACHE_HAS_PMEM is not defined, WC_MODE_PMEM(wc) always returns 
> false - so persistent_memory_claim and BUG() can't ever be called. And if 
> it can't be called, you don't need to add a code that prints an error in 
> that case.
> 
> If we don't have DM_WRITECACHE_HAS_PMEM, the compiler optimizer will 
> remove all the code guarded with if (WC_MODE_PMEM(wc)) as unreachable.
> 
> Mikulas

Fair enough.

