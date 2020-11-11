Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6372AF137
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 13:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgKKMsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 07:48:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21615 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725859AbgKKMsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 07:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605098924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zGXJ8V4La1S/QeUFBtdnXjusm+8Mn5insAGmUISpfHs=;
        b=F1PZsI4a6hTKkBvvX/ZppGYJoY5vAo+DeBNUieutbG+qSQl07V3bNko6OnLkEZPg2w7XmQ
        mpwv3wzSJqHa0iDkcmhY0RhqY3+1N06gCV7qw7WOgAgMPYz8cuQ8s5kgE2amRbBHl/hL8E
        8j6nrQEh5oXFpEYzf41h7FI4KITPKss=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-lcVvIXfUPISu5xto5fD0XA-1; Wed, 11 Nov 2020 07:48:42 -0500
X-MC-Unique: lcVvIXfUPISu5xto5fD0XA-1
Received: by mail-wm1-f71.google.com with SMTP id z7so851670wme.8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 04:48:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zGXJ8V4La1S/QeUFBtdnXjusm+8Mn5insAGmUISpfHs=;
        b=SSYykomFuy/VZmKgIQtsZ43Pub1t8sc+j+TLQUC2Y4tVLz4JxDlSZT+Y30Wgz5uBTy
         B7v81WPdug47sqGPicse4Ss71YGvbErw3eVchl8NAPBnVBgj60gtT7PWuoPHPOnBKsqf
         ObwKEWsEUREa7PBC+NrQFNOgfr1ll0rf9izBEuN3bjKx0pio5VS2MnyY/p0GkE1e8vQW
         CG4ql3OtFPIMqePm1+SLD8Q5nlZU310rBvYCuae0kZA1YLCIXJFP9FRzyzXQvM7tJOee
         7bZDMWG8vA9aLhU8/I9LeQvP3X82aZT/JHpksCZCBaPd3SI4U/VjBcywoTRx+hUK2ABC
         ymiw==
X-Gm-Message-State: AOAM533NrdBHWX/NEMOm6fnbJ/BNJodTsFXzw/hvCe/K+hoHSPBnI08p
        dHRp1+RcGIgo+NMxMmhEVwF2cVhztvfD5m6elXW+FjZLk70eIeXs8+ZfwBVk1bBwiUK1UeR7khZ
        FRORW+ay9/iFfeQND5WHhXAqx
X-Received: by 2002:a5d:5446:: with SMTP id w6mr20336612wrv.122.1605098921358;
        Wed, 11 Nov 2020 04:48:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzBamKw/bg5c7+XjuuJx3l1SVoJhclL/t8sfniS6v7UD+Th0hPny5TfD72A5b6eS01hmH1NbQ==
X-Received: by 2002:a5d:5446:: with SMTP id w6mr20336594wrv.122.1605098921214;
        Wed, 11 Nov 2020 04:48:41 -0800 (PST)
Received: from redhat.com (bzq-79-181-34-244.red.bezeqint.net. [79.181.34.244])
        by smtp.gmail.com with ESMTPSA id y11sm2305471wmj.36.2020.11.11.04.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 04:48:40 -0800 (PST)
Date:   Wed, 11 Nov 2020 07:48:36 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20201111074811-mutt-send-email-mst@kernel.org>
References: <20201102124327.2f82b2a7@canb.auug.org.au>
 <20201102051822-mutt-send-email-mst@kernel.org>
 <20201111171015.631ffd0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201111171015.631ffd0e@canb.auug.org.au>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 05:10:15PM +1100, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Mon, 2 Nov 2020 05:19:06 -0500 "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >
> > On Mon, Nov 02, 2020 at 12:43:27PM +1100, Stephen Rothwell wrote:
> > > 
> > > After merging the drm-misc tree, today's linux-next build (arm
> > > multi_v7_defconfig) failed like this:
> > > 
> > > In file included from drivers/gpu/drm/nouveau/nouveau_ttm.c:26:
> > > include/linux/swiotlb.h: In function 'swiotlb_max_mapping_size':
> > > include/linux/swiotlb.h:99:9: error: 'SIZE_MAX' undeclared (first use in this function)
> > >    99 |  return SIZE_MAX;
> > >       |         ^~~~~~~~
> > > include/linux/swiotlb.h:7:1: note: 'SIZE_MAX' is defined in header '<stdint.h>'; did you forget to '#include <stdint.h>'?
> > >     6 | #include <linux/init.h>
> > >   +++ |+#include <stdint.h>
> > >     7 | #include <linux/types.h>
> > > include/linux/swiotlb.h:99:9: note: each undeclared identifier is reported only once for each function it appears in
> > >    99 |  return SIZE_MAX;
> > >       |         ^~~~~~~~
> > > 
> > > Caused by commit
> > > 
> > >   abe420bfae52 ("swiotlb: Introduce swiotlb_max_mapping_size()")
> > > 
> > > but only exposed by commit
> > > 
> > >   4dbafbd30aef ("drm/nouveu: fix swiotlb include")
> > > 
> > > I applied the following fix for today:
> > > 
> > > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Date: Mon, 2 Nov 2020 12:34:57 +1100
> > > Subject: [PATCH] swiotlb: using SIZE_MAX needs limits.h included
> > > 
> > > Fixes: abe420bfae52 ("swiotlb: Introduce swiotlb_max_mapping_size()")
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>  
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> > 
> > I guess it makes sense to pick this up for this release directly.
> > I'll merge this unless there are any objections.
> 
> Christoph is right that the include should not be conditional.  But I
> have not tested that that does not introduce some other problems.

If there's a problem it will be a build failure - I'll put
it in next for a while, this way we'll find out.

> -- 
> Cheers,
> Stephen Rothwell


