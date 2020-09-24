Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AED472772BD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 15:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgIXNke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 09:40:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32953 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728072AbgIXNkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 09:40:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600954831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kYAYqqd7z+BNCAHCjT3gWlmfrOPX+NjKniGPI1/zmmY=;
        b=OCby7DVfSsKIKrUJcwwYmKMRRMBt6sY7pEmJiI1G0FmAKvjmexbcofNSmM1qb9EuldMIz3
        f3H+eZiw3KVyUEI730y2pl7ZG8+4DnBdDnsabnx6+Epe6FZ8Dlp88eaeURowmGMfihYDg5
        EjriH7NsEn38GuQFIFCxgfCeRNKzXK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377-WFyBiUTWPeC4OksGnGVzMg-1; Thu, 24 Sep 2020 09:40:27 -0400
X-MC-Unique: WFyBiUTWPeC4OksGnGVzMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 450AD800475;
        Thu, 24 Sep 2020 13:40:26 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1A717B7A2;
        Thu, 24 Sep 2020 13:40:22 +0000 (UTC)
Date:   Thu, 24 Sep 2020 09:40:22 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Eric Biggers <ebiggers@google.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, Alasdair Kergon <agk@redhat.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200924134021.GA13849@redhat.com>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
 <20200924012103.GE10500@redhat.com>
 <20200924074810.GB1894729@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924074810.GB1894729@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24 2020 at  3:48am -0400,
Satya Tangirala <satyat@google.com> wrote:

> On Wed, Sep 23, 2020 at 09:21:03PM -0400, Mike Snitzer wrote:
> > On Wed, Sep 09 2020 at  7:44pm -0400,
> > Satya Tangirala <satyat@google.com> wrote:
> > 
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Update the device-mapper core to support exposing the inline crypto
> > > support of the underlying device(s) through the device-mapper device.
> > > 
> > > This works by creating a "passthrough keyslot manager" for the dm
> > > device, which declares support for encryption settings which all
> > > underlying devices support.  When a supported setting is used, the bio
> > > cloning code handles cloning the crypto context to the bios for all the
> > > underlying devices.  When an unsupported setting is used, the blk-crypto
> > > fallback is used as usual.
> > > 
> > > Crypto support on each underlying device is ignored unless the
> > > corresponding dm target opts into exposing it.  This is needed because
> > > for inline crypto to semantically operate on the original bio, the data
> > > must not be transformed by the dm target.  Thus, targets like dm-linear
> > > can expose crypto support of the underlying device, but targets like
> > > dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> > > 
> > > When a key is evicted from the dm device, it is evicted from all
> > > underlying devices.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > Co-developed-by: Satya Tangirala <satyat@google.com>
> > > Signed-off-by: Satya Tangirala <satyat@google.com>
> > > ---
> > >  block/blk-crypto.c              |  1 +
> > >  block/keyslot-manager.c         | 34 ++++++++++++
> > >  drivers/md/dm-core.h            |  4 ++
> > >  drivers/md/dm-table.c           | 52 +++++++++++++++++++
> > >  drivers/md/dm.c                 | 92 ++++++++++++++++++++++++++++++++-
> > >  include/linux/device-mapper.h   |  6 +++
> > >  include/linux/keyslot-manager.h |  7 +++
> > >  7 files changed, 195 insertions(+), 1 deletion(-)
> > > 

> > > diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> > > index c4ef1fceead6..4542050eebfc 100644
> > > --- a/drivers/md/dm-core.h
> > > +++ b/drivers/md/dm-core.h
> > > @@ -12,6 +12,7 @@
> > >  #include <linux/kthread.h>
> > >  #include <linux/ktime.h>
> > >  #include <linux/blk-mq.h>
> > > +#include <linux/keyslot-manager.h>
> > >  
> > >  #include <trace/events/block.h>
> > >  
> > > @@ -49,6 +50,9 @@ struct mapped_device {
> > >  
> > >  	int numa_node_id;
> > >  	struct request_queue *queue;
> > > +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> > > +	struct blk_keyslot_manager ksm;
> > > +#endif
> > >  
> > >  	atomic_t holders;
> > >  	atomic_t open_count;
> > 
> > Any reason you placed the ksm member where you did?
>
> As in, any reason why it's placed right after the struct request_queue
> *queue? The ksm is going to be set up in the request_queue and is a part
> of the request_queue is some sense, so it seemed reasonable to me to
> group them together....but I don't think there's any reason it *has* to
> be there, if you think it should be put elsewhere (or maybe I'm
> misunderstanding your question :) ).

Placing the full struct where you did is highly disruptive to the prior
care taken to tune alignment of struct members within mapped_device.

Switching to a pointer will be less so, but even still it might be best
to either find a hole in the struct (not looked recently, but there may
not be one) or simply put it at the end of the structure.

The pahole utility is very useful for this kind of struct member
placement, etc.  But it is increasingly unavailable in modern Linux
distros...

Mike

