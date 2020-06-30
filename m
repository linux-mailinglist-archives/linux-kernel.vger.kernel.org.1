Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF5920F937
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732342AbgF3QOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 12:14:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60452 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728998AbgF3QOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 12:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593533682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sUPToEOX4B/mGCL1pbKHYVjaKfSmKgEu2oySIFoO2KI=;
        b=b863bcVyBkq9b575jzRJWBhz9juylcJK1VZceUEO+YAhlzR9e5Xuk43ByYxpHjujJePegK
        iB3nijwyLhFiQEW9xz68XwCbKzVECs8BgOY3Z0oK604osYy+8C3+aieSDc+tPOus6eJV2w
        +KiEi6ToR+9Kf57ncWotG8DDHKmNXk4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-6SsKhYcYPXW-9xb2cIECEg-1; Tue, 30 Jun 2020 12:14:38 -0400
X-MC-Unique: 6SsKhYcYPXW-9xb2cIECEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3426587950E;
        Tue, 30 Jun 2020 16:14:37 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 376197FEA9;
        Tue, 30 Jun 2020 16:14:27 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 05UGEQBl030308;
        Tue, 30 Jun 2020 12:14:26 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 05UGEQ44030304;
        Tue, 30 Jun 2020 12:14:26 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 30 Jun 2020 12:14:26 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Michal Suchanek <msuchanek@suse.de>
cc:     linux-nvdimm@lists.01.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Jakub Staron <jstaron@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Yuval Shaia <yuval.shaia@oracle.com>,
        Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dm writecache: reject asynchronous pmem.
In-Reply-To: <alpine.LRH.2.02.2006301210270.24082@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2006301213080.24082@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2006301101210.24028@file01.intranet.prod.int.rdu2.redhat.com> <20200630154924.3283-1-msuchanek@suse.de> <alpine.LRH.2.02.2006301210270.24082@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 30 Jun 2020, Mikulas Patocka wrote:

> 
> 
> On Tue, 30 Jun 2020, Michal Suchanek wrote:
> 
> > The writecache driver does not handle asynchronous pmem. Reject it when
> > supplied as cache.
> > 
> > Link: https://lore.kernel.org/linux-nvdimm/87lfk5hahc.fsf@linux.ibm.com/
> > Fixes: 6e84200c0a29 ("virtio-pmem: Add virtio pmem driver")
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> 
> Acked-by: Mikulas Patocka <mpatocka@redhat.com>

BTW, we should also add

Cc: stable@vger.kernel.org	# v5.3+

> > ---
> >  drivers/md/dm-writecache.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
> > index 30505d70f423..5358894bb9fd 100644
> > --- a/drivers/md/dm-writecache.c
> > +++ b/drivers/md/dm-writecache.c
> > @@ -2266,6 +2266,12 @@ static int writecache_ctr(struct dm_target *ti, unsigned argc, char **argv)
> >  	}
> >  
> >  	if (WC_MODE_PMEM(wc)) {
> > +		if (!dax_synchronous(wc->ssd_dev->dax_dev)) {
> > +			r = -EOPNOTSUPP;
> > +			ti->error = "Asynchronous persistent memory not supported as pmem cache";
> > +			goto bad;
> > +		}
> > +
> >  		r = persistent_memory_claim(wc);
> >  		if (r) {
> >  			ti->error = "Unable to map persistent memory for cache";
> > -- 
> > 2.26.2
> > 
> 

