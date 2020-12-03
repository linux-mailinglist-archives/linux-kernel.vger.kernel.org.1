Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073732CE12B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 22:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgLCVwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 16:52:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37543 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726707AbgLCVwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 16:52:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607032278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Dxg9ZG8en8JStMPYODB9TaL+S3BZxMLpWtTyZT8lIX0=;
        b=VSLRnqDyYx8IOigJ5NYRzYZnNlAcAeQqWQkC0DOdNOASXa56hdjwDwDCxuXeYg0XpTmlnS
        07PgByZRpaJu8gbtcBOzXSuXicgL9OAHPLtOTTOMttQfJ50w8KtqEBJ3QsEklqJ4emu0hM
        3TQkCB2yrQEzEktWxNORnztcSovV5Z0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-vWXOmjMPMvONySH4vfPxAg-1; Thu, 03 Dec 2020 16:51:17 -0500
X-MC-Unique: vWXOmjMPMvONySH4vfPxAg-1
Received: by mail-wr1-f70.google.com with SMTP id f4so1719884wru.21
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 13:51:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Dxg9ZG8en8JStMPYODB9TaL+S3BZxMLpWtTyZT8lIX0=;
        b=gLbAVY1iD/wlQHn1172tuv0MxHIGtMbsTq8yUCowwTgtQ56C5RQ3Agvr+pnY1UocBL
         lvJu4FcdQ3GCsYm7Z5IhdH2GxL3nEsiKH3NbSMefz1JjIgP0CP6wQUR6t63SsMmndt0A
         jjutzIvo1qUHzZEU5f01sIEHz7O6IB9EZ7LGpBt0cL9k/+Fkmt1raOYZqdsVge3dptgs
         ZIgTHmREB9R38Y3r0fVhZybg2xQZrrIBFS1pRPbAbAX5QyN8kmQlLb5KNp803qWJgUGt
         jcl7JyJYYUE6Cjxq7kZRSjGov1HC7PgZXdaaH0OnIawxH1l1ckbaLc3KtU8A+CpBBP4k
         +2TQ==
X-Gm-Message-State: AOAM532MKU7j8To1JtJN1X1XERPA9ptaicRuXLVf6EmV/7bUN+BuQen4
        Mbf5DNOStBhexxC0u8DOIA3U/OdZgujpOFDryOdpkUBwT2ZWyT8t93aPzmnFtAHvYo8QQH0QZpC
        rzFMsK3Q+LXiOqinRwcqwqPAl
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr867066wmb.124.1607032275899;
        Thu, 03 Dec 2020 13:51:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyP3AxCP3QvFgsJS1C5W/75mdJC72qefimowseEMBt8Y9GscUVzRW+c3oghTAHrrAgIQ/VGRA==
X-Received: by 2002:a1c:cc19:: with SMTP id h25mr867054wmb.124.1607032275646;
        Thu, 03 Dec 2020 13:51:15 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id 138sm743977wma.41.2020.12.03.13.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:51:13 -0800 (PST)
Date:   Thu, 3 Dec 2020 16:51:10 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Wang, Yu1" <yu1.wang@intel.com>,
        "Liu, Shuo A" <shuo.a.liu@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Subject: Re: [char-misc-next 13/13] mei: virtio: virtualization frontend
 driver
Message-ID: <20201203164859-mutt-send-email-mst@kernel.org>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
 <20200818115147.2567012-14-tomas.winkler@intel.com>
 <20201125160326-mutt-send-email-mst@kernel.org>
 <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f6181d8e80d4efb9464e9ec436800b7@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 09:18:04PM +0000, Winkler, Tomas wrote:
> > 
> > On Tue, Aug 18, 2020 at 02:51:47PM +0300, Tomas Winkler wrote:
> > > +#ifndef VIRTIO_ID_MEI
> > > +#define VIRTIO_ID_MEI 0xFFFE /* virtio mei */ #endif
> > 
> > Just noticed now that this driver landed upstream.  Can I ask that you guys
> > please register IDs with the virtio TC and not just pick a number at random?
> > In particular this is way outside allowed range.
> > 
> > IDs should also be listed in include/uapi/linux/virtio_ids.h
> > 
> > If people just pick random numbers like this collistions are unavoidable.
> > 
> > List of IDs is part of virtio spec, chapter "Device Types".
> > 
> > Please do this change now before this goes out to production!
> Okay,  this was assigned by ACRN, my impression was it's already registered.
> Will take care of.
> Thanks
> Tomas

Well nothing happened yet.

I think at this point we really should revert this patch before Linux is
released so in the next version the correct ID can be used instead of a reserved one.
Otherwise Linux will be stuck supporting this forever and will conflict
with hypervisors using this for what this range is for which is
experimental use.

Greg, any opinion on that?

-- 
MST

