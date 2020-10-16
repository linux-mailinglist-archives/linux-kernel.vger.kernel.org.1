Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5657290632
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 15:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407660AbgJPNVN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 16 Oct 2020 09:21:13 -0400
Received: from smtp.h3c.com ([60.191.123.50]:14386 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406024AbgJPNVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 09:21:13 -0400
Received: from DAG2EX01-BASE.srv.huawei-3com.com ([10.8.0.64])
        by h3cspam02-ex.h3c.com with ESMTPS id 09GDKblJ010960
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 16 Oct 2020 21:20:37 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) by
 DAG2EX01-BASE.srv.huawei-3com.com (10.8.0.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 16 Oct 2020 21:20:41 +0800
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074])
 by DAG2EX03-BASE.srv.huawei-3com.com ([fe80::5d18:e01c:bbbd:c074%7]) with
 mapi id 15.01.1713.004; Fri, 16 Oct 2020 21:20:41 +0800
From:   Tianxianting <tian.xianting@h3c.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mm: vmscan: avoid a unnecessary reschedule in
 shrink_slab()
Thread-Topic: [PATCH] mm: vmscan: avoid a unnecessary reschedule in
 shrink_slab()
Thread-Index: AQHWo29cMaRbAMdQE0ycFn5GylDeeqmZnPOAgACJFdD//4YYAIAAiVZw
Date:   Fri, 16 Oct 2020 13:20:41 +0000
Message-ID: <8a25eacf4b37460897911ade338754d3@h3c.com>
References: <20201016033952.1924-1-tian.xianting@h3c.com>
 <20201016120749.GG22589@dhcp22.suse.cz>
 <9a2b772b13f84bdd9517b17d8d72aa89@h3c.com>
 <20201016130208.GI22589@dhcp22.suse.cz>
In-Reply-To: <20201016130208.GI22589@dhcp22.suse.cz>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.99.141.128]
x-sender-location: DAG2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 09GDKblJ010960
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks
I understood what you said :)
But whether it is proper to check reschedule in every loop when lock is taken? 

By the way, I did not met a issue for this , I just learn this code and come up with one possible optimization based my understanding.

-----Original Message-----
From: Michal Hocko [mailto:mhocko@suse.com] 
Sent: Friday, October 16, 2020 9:02 PM
To: tianxianting (RD) <tian.xianting@h3c.com>
Cc: akpm@linux-foundation.org; linux-mm@kvack.org; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: vmscan: avoid a unnecessary reschedule in shrink_slab()

On Fri 16-10-20 12:48:23, Tianxianting wrote:
> Thanks, my understanding is,
> In shrink_slab(), do_shrink_slab() will do the real reclaim work, which will occupy current cpu and consume more cpu time, so we need to trigger a reschedule after reclaim.
> But if it jumps to 'out' label, that means we don't do the reclaim work at this time, it won't cause other thread getting starvation, so we don't need to call cond_resched() in this case.
> Is it right?

You are almost right. But consider situation when the lock is taken for quite some time. do_shrink_slab cannot make any forward progress and effectivelly busy loop. Unless the caller does cond_resched it might cause soft lockups.

Anyway let me try to ask again. Why does would this be any problem that deserves a fix?

> 
> -----Original Message-----
> From: Michal Hocko [mailto:mhocko@suse.com]
> Sent: Friday, October 16, 2020 8:08 PM
> To: tianxianting (RD) <tian.xianting@h3c.com>
> Cc: akpm@linux-foundation.org; linux-mm@kvack.org; 
> linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] mm: vmscan: avoid a unnecessary reschedule in 
> shrink_slab()
> 
> On Fri 16-10-20 11:39:52, Xianting Tian wrote:
> > In shrink_slab(), it directly goes to 'out' label only when it can't 
> > get the lock of shrinker_rwsew. In this case, it doesn't do the real 
> > work of shrinking slab, so we don't need trigger a reschedule by 
> > cond_resched().
> 
> Your changelog doesn't explain why this is not needed or undesirable. Do you see any actual problem?
> 
> The point of this code is to provide a deterministic scheduling point regardless of the shrinker_rwsew.
> 
> > 
> > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> > ---
> >  mm/vmscan.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c index 466fc3144..676e97b28
> > 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -687,8 +687,9 @@ static unsigned long shrink_slab(gfp_t gfp_mask, int nid,
> >  	}
> >  
> >  	up_read(&shrinker_rwsem);
> > -out:
> > +
> >  	cond_resched();
> > +out:
> >  	return freed;
> >  }
> >  
> > --
> > 2.17.1
> > 
> 
> --
> Michal Hocko
> SUSE Labs

--
Michal Hocko
SUSE Labs
