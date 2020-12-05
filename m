Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E5B2CFE82
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgLETlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:41:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37193 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725379AbgLETlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607197217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Jx4pNA+S6F2smlgl2I3TOlYeja9SYzWFktTxb4UjzVE=;
        b=JB3y+/Lpns0wS+VdO6noVZ8MLgrrN0BoVaY8zPAT1IKX46p5Ir0bnyownyETKbFJyiW2dp
        RFVWjuCU/BT3Rf1lDM5ZwWl2+hTDdioHUmN/7yKzphw1rfANtMQ5MWMeHfmtaOzZ9Tr1B2
        Hi49ewPT0ivxGECpfzVn9U3kv4AtPYo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-CnwfKNwuO-WTgTeuck7hvA-1; Sat, 05 Dec 2020 14:40:16 -0500
X-MC-Unique: CnwfKNwuO-WTgTeuck7hvA-1
Received: by mail-wr1-f69.google.com with SMTP id w8so99892wrv.18
        for <linux-kernel@vger.kernel.org>; Sat, 05 Dec 2020 11:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jx4pNA+S6F2smlgl2I3TOlYeja9SYzWFktTxb4UjzVE=;
        b=HPMSzMwLUhQ4fjhfcOwMGJZBpvaU+1aKp35/V64PQ54NpZBRmGG3+2pwinakg9p/mT
         03u3qUjHrf0lHXzHRECP8gxcywYt/+4FBYsG+M7zAEXCuFRaE7acWUeR3SfO2tL0DvdR
         Sv6wIh8l8mdLqdGx8nUrWYv1Y/Pj+8kUIlGYTJzDxs1KCW8e7gVP+p4cleLjVe13dKwb
         HDRzeB/ylS3FZpe1zoFcAlj/Bn5sGMAyMRhkcwXZCODNbCx6Iuupi7x0Tz43ItrPQLGt
         bvGImSsczumHVjMgY/j62PIpBhEAKbwVmR1LGcH4J4tZDGUNGdUkLwPbdArR1XI2k5PA
         KwHQ==
X-Gm-Message-State: AOAM533i/oaapsj4wMRa/5j8OxlVnUc28uplAYAHEYiWDRkZM+vio1H6
        EmFhtyqCCJUwjq4y8PZh4fOvIBZSI37N70PQHLGlv/ut+7OfCflRiIHnJmzScZL95pxsrvMDE73
        TqROzCmaThUgbzKhALvQPT2P9
X-Received: by 2002:a5d:668d:: with SMTP id l13mr11206263wru.279.1607197214851;
        Sat, 05 Dec 2020 11:40:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxXk7UoVJhA4A1VvH2ldhQ49eVwwWeicyJcDlLXysVGnWYYCfqc9k7rMhYZLB3fRGmbIZUJJQ==
X-Received: by 2002:a5d:668d:: with SMTP id l13mr11206247wru.279.1607197214705;
        Sat, 05 Dec 2020 11:40:14 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id c187sm8886891wmd.23.2020.12.05.11.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Dec 2020 11:40:13 -0800 (PST)
Date:   Sat, 5 Dec 2020 14:40:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Yu1" <yu1.wang@intel.com>,
        "Liu, Shuo A" <shuo.a.liu@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Subject: Re: [char-misc-next 13/13] mei: virtio: virtualization frontend
 driver
Message-ID: <20201205143909-mutt-send-email-mst@kernel.org>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
 <20200818115147.2567012-14-tomas.winkler@intel.com>
 <20201125160326-mutt-send-email-mst@kernel.org>
 <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
 <20201203164859-mutt-send-email-mst@kernel.org>
 <X8lgSb9vB6UoJbVB@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8lgSb9vB6UoJbVB@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 03, 2020 at 11:01:45PM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 03, 2020 at 04:51:10PM -0500, Michael S. Tsirkin wrote:
> > On Wed, Nov 25, 2020 at 09:18:04PM +0000, Winkler, Tomas wrote:
> > > > 
> > > > On Tue, Aug 18, 2020 at 02:51:47PM +0300, Tomas Winkler wrote:
> > > > > +#ifndef VIRTIO_ID_MEI
> > > > > +#define VIRTIO_ID_MEI 0xFFFE /* virtio mei */ #endif
> > > > 
> > > > Just noticed now that this driver landed upstream.  Can I ask that you guys
> > > > please register IDs with the virtio TC and not just pick a number at random?
> > > > In particular this is way outside allowed range.
> > > > 
> > > > IDs should also be listed in include/uapi/linux/virtio_ids.h
> > > > 
> > > > If people just pick random numbers like this collistions are unavoidable.
> > > > 
> > > > List of IDs is part of virtio spec, chapter "Device Types".
> > > > 
> > > > Please do this change now before this goes out to production!
> > > Okay,  this was assigned by ACRN, my impression was it's already registered.
> > > Will take care of.
> > > Thanks
> > > Tomas
> > 
> > Well nothing happened yet.
> > 
> > I think at this point we really should revert this patch before Linux is
> > released so in the next version the correct ID can be used instead of a reserved one.
> > Otherwise Linux will be stuck supporting this forever and will conflict
> > with hypervisors using this for what this range is for which is
> > experimental use.
> > 
> > Greg, any opinion on that?
> 
> I will be glad to revert it, what's the git commit id?

commit d162219c655c8cf8003128a13840d6c1e183fb80
Author: Tomas Winkler <tomas.winkler@intel.com>
Date:   Tue Aug 18 14:51:47 2020 +0300

    mei: virtio: virtualization frontend driver
    

I sent a revert on list in case it makes things easier,
but it's just a result of a plain git revert,
build-tested.


> thanks,
> 
> greg k-h

