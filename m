Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1ED276AF8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgIXHit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 03:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727160AbgIXHir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 03:38:47 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B195AC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:38:47 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id k13so1392433pfg.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 00:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/QqvBiEw9Gt+P3YHgYr+bWtezmhdKPwP2m5Qq1GcsHU=;
        b=Z1qNiD110OoTBunaz5mH/lzfaFLDg7xI1pk48kUrTkDdgKD+LwlEBxfuijD9u/v8Zh
         sKsLhHFZ/OAmWhbgFBZpDRWrsRPB9bcJ7o/Ri6hQo1gksLg9QWkuOKr5wZt5FcSC+jjT
         jIXc2hbjlU+X6idHsYaNi/Y4Y/B14HtcpONxvbHA7xmhAU/77Cx9XGBom8e0ceGtDSHM
         KH+ohR79tHOM9+Ldj+WzhE2h3YpTs+uE+JN4xFgBxBR0fy58mbpZWgMdBfCeqVrz7fEp
         swX3Yfh/zr9DYukBcTQZJr4/sY9CZbwMZzDyBDZjcl+FavL5gJ0+3nG66xJtHt7oUthE
         QQ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/QqvBiEw9Gt+P3YHgYr+bWtezmhdKPwP2m5Qq1GcsHU=;
        b=Xs28hxED2FWxvNN7O7rWLHrDwP5leItlib8+eC8ExfpOyWTe17xk3FoU6AuFhcVwSu
         jzivrunxiN5fuMbJYNAV5mQXiuUFvMgLrncdqVMF/i9ZnCvTjRWWAxCvkEhTRke7XJ/o
         xNw1/zqqwCzXGXqCfgyHZ9l/T6e5pegnrLpfl0EhoS9TxqDKsFZj9jyy23g9uyDO8ODk
         5jvCNv9Ge6NsGZD7Be++2GPtlX9TDi3xyraL3zORQU9CMJeYLRXJrnuUXKm4HvWLtlAi
         bqV/q4SjbA0cwO1mlJayeHNpNxlEe0cbZyVTNkmSYAxOowBWvlR+fEjD/tKegEZi+GHD
         B4tA==
X-Gm-Message-State: AOAM533Q8Apgil1/0bd8+ZB+lO3qLeg7GQvZnixtX/h7GjgHfS2MKZe8
        1Wa7dvazRQMTRCwg1yVobgCSSA==
X-Google-Smtp-Source: ABdhPJz6VQDT9+FEnimOkDrUbrnKtYN7Qcf2KHw/RUrvRZQCLUJOFfiid//U4dfanjU96NpT9qIOWw==
X-Received: by 2002:a05:6a00:14cb:b029:142:2501:34eb with SMTP id w11-20020a056a0014cbb0290142250134ebmr3234176pfu.68.1600933126956;
        Thu, 24 Sep 2020 00:38:46 -0700 (PDT)
Received: from google.com (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id 9sm1926053pgx.76.2020.09.24.00.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 00:38:46 -0700 (PDT)
Date:   Thu, 24 Sep 2020 07:38:42 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 2/3] dm: add support for passing through inline crypto
 support
Message-ID: <20200924073842.GA1894729@google.com>
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
> 
> Looking at 'struct blk_keyslot_manager' I'm really hating adding that
> bloat to every DM device for a feature that really won't see much broad
> use (AFAIK).
> 
> Any chance you could allocate 'struct blk_keyslot_manager' as needed so
> that most users of DM would only be carrying 1 extra pointer (set to
> NULL)?
I don't think there's any technical problem with doing that - the only
other thing that would need addressing is that the patch uses
"container_of" on that blk_keyslot_manager in dm_keyslot_evict() to get
a pointer to the struct mapped_device. I could try adding a "private"
field to struct blk_keyslot_manager and store a pointer to the struct
mapped_device there).
> 
> Thanks,
> Mike
> 
