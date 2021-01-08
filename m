Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9E12EF4A3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 16:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbhAHPOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 10:14:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:55294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727686AbhAHPOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 10:14:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 991FB238EC;
        Fri,  8 Jan 2021 15:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610118839;
        bh=FU6YJ6OzFzRwqjZwosAJf0qhhdxi/v39d2WUwr1YBnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQvlOZqrO/hPxBalKwgIXr35TibRlvjk/YAd/x7pkZN8ZHuSSgT+r+aHdkWOcZD6q
         VH+R5Bz5XhFTrbWEpJm7iY7/KpzjfuSvnbvNXJVhx6YjH/fkK3wTxbFeSF4ILBgh0M
         yRoanJ8JhCe6skNHD9fNYHF09q6cbNpDdbTrD6kU=
Date:   Fri, 8 Jan 2021 16:15:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     zhenwei pi <pizhenwei@bytedance.com>, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] misc: pvpanic: introduce module parameter 'events'
Message-ID: <X/h3BAdea48p+L+p@kroah.com>
References: <20210108135223.2924507-1-pizhenwei@bytedance.com>
 <20210108135223.2924507-3-pizhenwei@bytedance.com>
 <X/hnF0W+TMj36LDN@kroah.com>
 <58eca97c-f72e-66a7-2696-611124ce0943@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58eca97c-f72e-66a7-2696-611124ce0943@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 04:04:24PM +0100, Paolo Bonzini wrote:
> On 08/01/21 15:07, Greg KH wrote:
> > >   static void __iomem *base;
> > > +static unsigned int events = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
> > > +module_param(events, uint, 0644);
> > > +MODULE_PARM_DESC(events, "set event limitation of pvpanic device");
> > I do not understand you wanting a module parameter as well as a sysfs
> > file.  Why is this needed?  Why are you spreading this information out
> > across different apis and locations?
> 
> It can be useful to disable some functionality, for example in case you want
> to fake running on an older virtualization host.  This can be done for
> debugging reasons, or to keep uniform handling across a fleet that is
> running different versions of QEMU.

And where is this all going to be documented?

And what's wrong with just making the sysfs attribute writable?

thanks,

greg k-h
