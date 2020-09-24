Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6A3276B23
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgIXHsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbgIXHsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:48:15 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76488C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:48:15 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id b124so1358561pfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tK+cnu137uKn+/oEzjr3wNwYrT9PGTUO1Zz9Fsslk94=;
        b=G6+bSVvxw/c6725lYnz2rnFFdQSI7oUiaYE1aJwvxPiLyROiJIfKORi8VK3P8a73gn
         yPR7hkuQBpudEzEzjatdeECQkxo/A6C6O3/uz97CYdc1U6kWeA32PJtMdBpI2kOuRnjW
         0VjIrQCtsL1miITy/Rq6nDD4k0vs1JpolIaA9NQvKfmrvTU7jmbgrjfg3yLVMZzDpFrP
         j1yHa1iJAcAP70tVLGoFmquSBectX66hlRUt7inRKQaoz+3YrdGtHE7Xnx3WCkT0paj9
         xpTuqDf3Fq9V14USHdf32fG20WjrANKcFmS/vC0BJLvBqQTXs+nXu5e1rB/3vbFxdozi
         5/dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tK+cnu137uKn+/oEzjr3wNwYrT9PGTUO1Zz9Fsslk94=;
        b=bhG7ZXEbyp7d1Dillusz0thkn1L8I5lL576imJsFoNNRUHpTqk9yH8qHjWDSivXlHD
         G349iuZJ9bxpptVZGJRIXCjh3F6OgoOfCx1Eq1j6TpR9OCyC0Ensu9HZTjBLgfXiojsV
         uv46c1IoPVs7efKcCtiUNJQ3CJV9KE+UXJXOqSiu8iVgRVkev32QSPd4avVJt75CZ77a
         t2B7WHehw9aE/L4kts5cSmpRMVbOPYGMJLWlUKO7SMjOe4+UVXSX176MR+1dFeRRWk+M
         CoUx4QzaDGC84noBhcTRbDrDKR7WYGBI5PZIjCCHnjty4KcI4IZnfZD8smr4HBMmCPlQ
         lUkQ==
X-Gm-Message-State: AOAM530aUpQGLzjDd7nmRHvDTBbeVgz8qTh7DQPyqsqC8cdhhu6rc6eq
        cRhaghOc1ECuIYsxwkQ0BMKR6A==
X-Google-Smtp-Source: ABdhPJzZ9dlXrvCeps8DBV2ed64Pll2vOIuQNZbqGrIU+/FbJUTMQILoJxC1DNy9TOSVXvj2nO5H4g==
X-Received: by 2002:a62:4ed6:0:b029:142:2501:35ec with SMTP id c205-20020a624ed60000b0290142250135ecmr3557932pfb.76.1600933694696;
        Thu, 24 Sep 2020 00:48:14 -0700 (PDT)
Received: from google.com (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id w206sm1892054pfc.1.2020.09.24.00.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:48:14 -0700 (PDT)
Date:   Thu, 24 Sep 2020 07:48:10 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200924074810.GB1894729@google.com>
References: <20200909234422.76194-1-satyat@google.com>
 <20200909234422.76194-3-satyat@google.com>
 <20200924012103.GE10500@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200924012103.GE10500@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 09:21:03PM -0400, Mike Snitzer wrote:
> On Wed, Sep 09 2020 at  7:44pm -0400,
> Satya Tangirala <satyat@google.com> wrote:
> 
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Update the device-mapper core to support exposing the inline crypto
> > support of the underlying device(s) through the device-mapper device.
> > 
> > This works by creating a "passthrough keyslot manager" for the dm
> > device, which declares support for encryption settings which all
> > underlying devices support.  When a supported setting is used, the bio
> > cloning code handles cloning the crypto context to the bios for all the
> > underlying devices.  When an unsupported setting is used, the blk-crypto
> > fallback is used as usual.
> > 
> > Crypto support on each underlying device is ignored unless the
> > corresponding dm target opts into exposing it.  This is needed because
> > for inline crypto to semantically operate on the original bio, the data
> > must not be transformed by the dm target.  Thus, targets like dm-linear
> > can expose crypto support of the underlying device, but targets like
> > dm-crypt can't.  (dm-crypt could use inline crypto itself, though.)
> > 
> > When a key is evicted from the dm device, it is evicted from all
> > underlying devices.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Co-developed-by: Satya Tangirala <satyat@google.com>
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> > ---
> >  block/blk-crypto.c              |  1 +
> >  block/keyslot-manager.c         | 34 ++++++++++++
> >  drivers/md/dm-core.h            |  4 ++
> >  drivers/md/dm-table.c           | 52 +++++++++++++++++++
> >  drivers/md/dm.c                 | 92 ++++++++++++++++++++++++++++++++-
> >  include/linux/device-mapper.h   |  6 +++
> >  include/linux/keyslot-manager.h |  7 +++
> >  7 files changed, 195 insertions(+), 1 deletion(-)
> > 
> > diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> > index 2d5e60023b08..33555cf0e3e7 100644
> > --- a/block/blk-crypto.c
> > +++ b/block/blk-crypto.c
> > @@ -402,3 +402,4 @@ int blk_crypto_evict_key(struct request_queue *q,
> >  	 */
> >  	return blk_crypto_fallback_evict_key(key);
> >  }
> > +EXPORT_SYMBOL_GPL(blk_crypto_evict_key);
> > diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> > index 60ac406d54b9..e0f776c38d8a 100644
> > --- a/block/keyslot-manager.c
> > +++ b/block/keyslot-manager.c
> > @@ -416,6 +416,40 @@ void blk_ksm_unregister(struct request_queue *q)
> >  {
> >  	q->ksm = NULL;
> >  }
> > +EXPORT_SYMBOL_GPL(blk_ksm_unregister);
> > +
> > +/**
> > + * blk_ksm_intersect_modes() - restrict supported modes by child device
> > + * @parent: The keyslot manager for parent device
> > + * @child: The keyslot manager for child device, or NULL
> > + *
> > + * Clear any crypto mode support bits in @parent that aren't set in @child.
> > + * If @child is NULL, then all parent bits are cleared.
> > + *
> > + * Only use this when setting up the keyslot manager for a layered device,
> > + * before it's been exposed yet.
> > + */
> > +void blk_ksm_intersect_modes(struct blk_keyslot_manager *parent,
> > +			     const struct blk_keyslot_manager *child)
> > +{
> > +	if (child) {
> > +		unsigned int i;
> > +
> > +		parent->max_dun_bytes_supported =
> > +			min(parent->max_dun_bytes_supported,
> > +			    child->max_dun_bytes_supported);
> > +		for (i = 0; i < ARRAY_SIZE(child->crypto_modes_supported);
> > +		     i++) {
> > +			parent->crypto_modes_supported[i] &=
> > +				child->crypto_modes_supported[i];
> > +		}
> > +	} else {
> > +		parent->max_dun_bytes_supported = 0;
> > +		memset(parent->crypto_modes_supported, 0,
> > +		       sizeof(parent->crypto_modes_supported));
> > +	}
> > +}
> > +EXPORT_SYMBOL_GPL(blk_ksm_intersect_modes);
> >  
> >  /**
> >   * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
> > diff --git a/drivers/md/dm-core.h b/drivers/md/dm-core.h
> > index c4ef1fceead6..4542050eebfc 100644
> > --- a/drivers/md/dm-core.h
> > +++ b/drivers/md/dm-core.h
> > @@ -12,6 +12,7 @@
> >  #include <linux/kthread.h>
> >  #include <linux/ktime.h>
> >  #include <linux/blk-mq.h>
> > +#include <linux/keyslot-manager.h>
> >  
> >  #include <trace/events/block.h>
> >  
> > @@ -49,6 +50,9 @@ struct mapped_device {
> >  
> >  	int numa_node_id;
> >  	struct request_queue *queue;
> > +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> > +	struct blk_keyslot_manager ksm;
> > +#endif
> >  
> >  	atomic_t holders;
> >  	atomic_t open_count;
> 
> Any reason you placed the ksm member where you did?
As in, any reason why it's placed right after the struct request_queue
*queue? The ksm is going to be set up in the request_queue and is a part
of the request_queue is some sense, so it seemed reasonable to me to
group them together....but I don't think there's any reason it *has* to
be there, if you think it should be put elsewhere (or maybe I'm
misunderstanding your question :) ).
> 
> Looking at 'struct blk_keyslot_manager' I'm really hating adding that
> bloat to every DM device for a feature that really won't see much broad
> use (AFAIK).
> 
> Any chance you could allocate 'struct blk_keyslot_manager' as needed so
> that most users of DM would only be carrying 1 extra pointer (set to
> NULL)?
> 
> Thanks,
> Mike
> 
