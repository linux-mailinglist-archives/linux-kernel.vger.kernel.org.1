Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A612C51B0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 11:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387477AbgKZJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 04:58:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733240AbgKZJ6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 04:58:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606384723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Txczrzj5TdjarWdFax7+8SYyUhh5Cpy1wHDBd4VU294=;
        b=Xmer9I53hNE8qBR6cmMYWAbOCZ9Sr0p4s6d1Lb0+AzqkuVYOFtwqcjTTp91+rbluzFP8jP
        omJR1kI3f7AhsSer4bZOpvlltZU3d9nEDs5oNyE7NDQZZl9dNtFvH00N1r3lEwGXnKRgeT
        AUcBGs45XDA56mGTyGsJc2v338I7Tt0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-XpqSkcBoN3STqXpLuYK3Zg-1; Thu, 26 Nov 2020 04:58:40 -0500
X-MC-Unique: XpqSkcBoN3STqXpLuYK3Zg-1
Received: by mail-wr1-f71.google.com with SMTP id e6so963984wrx.13
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 01:58:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Txczrzj5TdjarWdFax7+8SYyUhh5Cpy1wHDBd4VU294=;
        b=pestEgNTF/2PamgrMNqqGZJjCG3WXtddR7dDnZOFk2xfRuvyxoS4+RdNr4cRNpTtha
         F5G4uGR6PK3su9jv232YDpecmTJygLxSKho0YlMeg9ufCo2nzLhyGxpoEjXt1q5k6ss9
         Yp47dJ9sI+WCEcA6RO/WLwqDg9tKVc+NSosY5fzJh9DWbO8PRu2uv0Gl4cU+0MmpprmX
         vZ5ifXTk095ZqwM9siZEf6K/n6hbXv0WPfUxHj6qT7bFkdfhDfPHY4HOQoGA+I+z/N2b
         Vhmr53XZvZ8izT7io++E551TCNdf7U/2/smhd62fuEjR5+TjUeS8+/qb8cacotB4uEXG
         7+Qw==
X-Gm-Message-State: AOAM532G7V5xK7g3AmT9wUoLmkmpYATiZLKrnhWQmIlWTNFbcvKBQiif
        MWJh1Z0s9zs23fbxQMpztoeIGb6ulIdnR1X4+GdI4WcKazT+fF2JhVMOqTz9a68uTwxCz0z7vcY
        KFCAuvNmQYXxORXxfnE5PWs9r
X-Received: by 2002:a5d:45c5:: with SMTP id b5mr2905661wrs.14.1606384719446;
        Thu, 26 Nov 2020 01:58:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyagAdyUIvb+LKXexDjMlDWFtLBvBaCo07L82J8DsJVdjOnXKdy37em+fIHldUz7GbM31ozGg==
X-Received: by 2002:a5d:45c5:: with SMTP id b5mr2905644wrs.14.1606384719288;
        Thu, 26 Nov 2020 01:58:39 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id f16sm7462115wmh.7.2020.11.26.01.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 01:58:38 -0800 (PST)
Date:   Thu, 26 Nov 2020 04:58:35 -0500
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
Message-ID: <20201126045340-mutt-send-email-mst@kernel.org>
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

Found this:
https://projectacrn.github.io/latest/developer-guides/hld/hld-virtio-devices.html

Supported Virtio Devices
All the BE virtio drivers are implemented using the ACRN virtio APIs, and the FE drivers are reusing the standard Linux FE virtio drivers. For the devices with FE drivers available in the Linux kernel, they should use standard virtio Vendor ID/Device ID and Subsystem Vendor ID/Subsystem Device ID. For other devices within ACRN, their temporary IDs are listed in the following table.

Table 5 Virtio Devices without existing FE drivers in Linux
virtio device	Vendor ID	Device ID	Subvendor ID	Subdevice ID
RPMB	0x8086	0x8601	0x8086	0xFFFF
HECI	0x8086	0x8602	0x8086	0xFFFE
audio	0x8086	0x8603	0x8086	0xFFFD
IPU	0x8086	0x8604	0x8086	0xFFFC
TSN/AVB	0x8086	0x8605	0x8086	0xFFFB
hyper_dmabuf	0x8086	0x8606	0x8086	0xFFFA
HDCP	0x8086	0x8607	0x8086	0xFFF9
COREU	0x8086	0x8608	0x8086	0xFFF8
I2C	0x8086	0x860a	0x8086	0xFFF6
GPIO	0x8086	0x8609	0x8086	0xFFF7

so IIUC what you are using is a temporary ID which is fine for
experimentation but not for production.

Note it does take a couple of weeks for a TC to vote on reserving an ID
so pls do not delay this too much.

-- 
MST

