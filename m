Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE8A27681A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 07:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIXFIg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 01:08:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:53736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgIXFIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 01:08:35 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45C35235FD;
        Thu, 24 Sep 2020 05:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600924115;
        bh=zg0bwBBQ7NADrq7ZFAJdHhDztu1Z0TDV3IOYU5K9GzA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AXpnlCkRjFIf8sAjRTaiRzoM84ikPzcHNUwvtwGE3sV3lwnkRriyNiB/2neFhKz3i
         ya0psk3HIz1SVWpB5TB1D3HTB4Je97TJdL9aYnyPWZW0YP+Fc47ozL9lVoHrh48QpI
         iiiOYhJoCp3bqdIXCxHNwFAu5YuCwCgnBLfDpkLs=
Date:   Thu, 24 Sep 2020 07:08:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [PATCH v3 2/3] misc: bcm-vk: add Broadcom VK driver
Message-ID: <20200924050851.GA271310@kroah.com>
References: <20200825194400.28960-1-scott.branden@broadcom.com>
 <20200825194400.28960-3-scott.branden@broadcom.com>
 <20200907125530.GC2371705@kroah.com>
 <767f6b6a-07fc-f1b6-f43c-b974761f1505@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <767f6b6a-07fc-f1b6-f43c-b974761f1505@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 09:43:55PM -0700, Scott Branden wrote:
> >> +struct bcm_vk_tty {
> >> +	struct tty_port port;
> >> +	uint32_t to_offset;	/* bar offset to use */
> >> +	uint32_t to_size;	/* to VK buffer size */
> >> +	uint32_t wr;		/* write offset shadow */
> >> +	uint32_t from_offset;	/* bar offset to use */
> >> +	uint32_t from_size;	/* from VK buffer size */
> >> +	uint32_t rd;		/* read offset shadow */
> > nit, these "unit32_t" stuff really doesn't matter in the kernel, 'u32'
> > is a better choice overall.  Same for u8 and others, for this whole
> > driver.
> Other than personal preference, I don't understand how 'u32' is better.
> uint32_t follows the ANSI stdint.h.  It allows for portable code without
> the need to define custom u32 types.

The ANSI namespace does not work in the kernel, which is why we have our
own types that pre-date those, and work properly everywhere in the
kernel.

> stdint types are used in many drivers in the linux kernel already.
> We would prefer to keep our code as portable as possible and use
> stdint types in the driver.

You aren't porting this code to other operating systems easily, please
use the kernel types :)

And yes, these types are used in other parts, but when you have 25
million lines of code, some crud does slip in at times...

> >> +	pid_t pid;
> >> +	bool irq_enabled;
> >> +	bool is_opened;		/* tracks tty open/close */
> > Why do you need to track this?  Doesn't the tty core handle this for
> > you?
> I have tried using tty_port_kopened() and it doesn't seem to work.
> Will need to debug some more unless you have another suggested function to use.

You didn't answer _why_ you need to track this.  A tty driver shouldn't
care about this type of thing.

> >> +	struct workqueue_struct *tty_wq_thread;
> >> +	struct work_struct tty_wq_work;
> >> +
> >> +	/* Reference-counting to handle file operations */
> >> +	struct kref kref;
> > And a kref?
> >
> > What is controlling the lifetime rules of your structure?
> >
> > Why a kref?
> >
> > Why the tty ports?
> >
> > Why the misc device?
> >
> > This feels really crazy to me...
> Comments mostly from Desmond here:
> 
> Yes, we have created a PCIe centric driver that combines with both a misc devices on top (for the read/write/ioctrl), and also ttys.
> The device sits on PCIe but we are using the misc device for accessing it.
> tty is just another on top.  I don't think this is that uncommon to have a hybrid driver.

Ugh, yes, it is uncommon because those are two different things.  Why do
you need/want a misc driver to control a tty device?  Why do you need a
tty device?  What really is this beast?

We got rid of the old "control path" device nodes for tty devices a long
time ago, this feels like a return to that old model, is that why you
are doing this?

But again, I really don't understand what this driver is trying to
control/manage, so it's hard to review it without that knowledge.

> Since we have a hybrid of PCIe + misc + tty, it means that we could simultaneously have opening dev/node to read/write (multiple) + tty o going.

That's almost always a bad idea.

> Since the struct is embedded inside the primary PCIe structure, we need a way to know when all the references are done, and then at that point we could free the primary structure.
> That is the reason for the kref.  On PCIe device removal, we signal the user space process to stop first, but the data structure can not be freed until the ref goes to 0.

Again, you can not have multiple reference count objects controling a
single object.  That way is madness and buggy and will never work
properly.

You can have different objects with different lifespans, which, if you
really really want to do this, is the correct way.  Otherwise, stick
with one object and one reference count please.

thanks,

greg k-h
