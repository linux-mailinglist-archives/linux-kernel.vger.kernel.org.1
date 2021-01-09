Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809672EFF29
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jan 2021 12:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbhAILb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 06:31:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:59610 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbhAILb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 06:31:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 68D9723A23;
        Sat,  9 Jan 2021 11:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610191875;
        bh=09a9eyew0opPWwZP8+/q7WDJtBnABE4xSNOExLWTpHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tx2JYtJIppHLwV45w/Eu/Nh2LduEKP4qHinV7Oj3TsQyUzPqGqy8Ymja4W9DGCBTM
         qGGOUxcjo9pV510vJgh17xYezAZvnq7zgEdwRQZ8x/IHa6fVVeU/ZdRtOW3+NMkPAO
         xaBLC8K8lZnQZFozrhGX5p2Y3PaCMaTsuTwESYlE=
Date:   Sat, 9 Jan 2021 12:31:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] misc: pvpanic: introduce module parameter 'events'
Message-ID: <X/mT/9qKswNUIWTc@kroah.com>
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
 <20210108135223.2924507-3-pizhenwei@bytedance.com>
 <X/hnF0W+TMj36LDN@kroah.com>
 <58eca97c-f72e-66a7-2696-611124ce0943@redhat.com>
 <X/h3BAdea48p+L+p@kroah.com>
 <2729803e-c9b2-abc9-e93f-ace19f521945@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2729803e-c9b2-abc9-e93f-ace19f521945@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 04:26:17PM +0100, Paolo Bonzini wrote:
> On 08/01/21 16:15, Greg KH wrote:
> > On Fri, Jan 08, 2021 at 04:04:24PM +0100, Paolo Bonzini wrote:
> > > On 08/01/21 15:07, Greg KH wrote:
> > > > >    static void __iomem *base;
> > > > > +static unsigned int events = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> > > > > +module_param(events, uint, 0644);
> > > > > +MODULE_PARM_DESC(events, "set event limitation of pvpanic device");
> > > > I do not understand you wanting a module parameter as well as a sysfs
> > > > file.  Why is this needed?  Why are you spreading this information out
> > > > across different apis and locations?
> > > 
> > > It can be useful to disable some functionality, for example in case you want
> > > to fake running on an older virtualization host.  This can be done for
> > > debugging reasons, or to keep uniform handling across a fleet that is
> > > running different versions of QEMU.
> > 
> > And where is this all going to be documented?
> 
> I don't disagree.
> 
> > And what's wrong with just making the sysfs attribute writable?
> 
> Isn't it harder to configure it at boot?  Also the sysfs attribute added by
> patch 1 is documenting what is supported by the device, while the module
> parameter can be set to any value (you can think of the module parameter as
> of a "what to log" option, except the logging happens on another machine).

But the module parameter is global, and not device specific.

And yes, it would be harder to configure this at boot, is this something
that is required?  If so, please document that somewhere.

> Therefore, if you make the sysfs attribute writable, you would actually need
> _two_ attributes, one for the in-use capabilities and one for the device
> capabilities.  And sysfs files are runtime values, which is different
> concept than 0444 module parameters (which are more like just
> configuration).

That's not the module parameter mode setting in this patch :(

> So you would have to decide whether it's valid to write 2
> to the in-use capabilities file when the device capabilities are "1", and I
> don't really have a good answer for that.
> 
> Also considering that there will not be more than one copy of this device
> (it doesn't make sense as they would all do exactly the same thing), in this
> case a module parameter really seems to be the simplest way to configure it.

So you never can have more than one of these in the system at one time?
Because if this ever becomes not true, the module parameter is a mess...

thanks,

greg k-h
