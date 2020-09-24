Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2079327692F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 08:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgIXGqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 02:46:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:52994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIXGqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 02:46:19 -0400
Received: from localhost (unknown [84.241.198.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 437C220708;
        Thu, 24 Sep 2020 06:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600929977;
        bh=jTGnd+ntgnJLJnuchvfkw/TnKBaAgEKEsUlfdbYcOvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2PWPTIUA/3OnZI+IuG7kcrAWaSYZxzDfRw7nt0SbSbccCrKjd1DNMLQUKElAwip8
         5LIQhsK6c6rFjrN0LDvQKYQtoz/h45ILIa/pIgd3dWFF92+X9rlw2WFxbIIv4Jbkap
         +iWF217vR+N2gGhLtudHgmw5sCRRtiPPV8vOsvV4=
Date:   Thu, 24 Sep 2020 08:46:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Maximilian Luz <luzmaximilian@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        =?utf-8?B?Qmxhxb4=?= Hrastnik <blaz@mxxn.io>,
        Dorian Stoll <dorian.stoll@tmsp.io>
Subject: Re: [RFC PATCH 8/9] surface_aggregator: Add DebugFS interface
Message-ID: <20200924064614.GA593984@kroah.com>
References: <20200923151511.3842150-1-luzmaximilian@gmail.com>
 <20200923151511.3842150-9-luzmaximilian@gmail.com>
 <20200923161416.GA3723109@kroah.com>
 <7d571ed4-862e-cfbd-44d4-0fda25f03294@gmail.com>
 <20200923182948.GA107114@kroah.com>
 <33ebf267-0216-4480-4217-2e5cbf9dbe52@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33ebf267-0216-4480-4217-2e5cbf9dbe52@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 12:06:54AM +0200, Maximilian Luz wrote:
> On 9/23/20 8:29 PM, Greg Kroah-Hartman wrote:
> > On Wed, Sep 23, 2020 at 08:03:38PM +0200, Maximilian Luz wrote:
> > > On 9/23/20 6:14 PM, Greg Kroah-Hartman wrote:
> 
> [...]
> 
> > > So the -EFAULT returned by put_user should have precedence? I was aiming
> > > for "in case it fails, return with the first error".
> > 
> > -EFAULT trumps everything :)
> 
> Perfect, thanks!
> 
> > > > Listen, I'm all for doing whatever you want in debugfs, but why are you
> > > > doing random ioctls here?  Why not just read/write a file to do what you
> > > > need/want to do here instead?
> > > 
> > > Two reasons, mostly: First, the IOCTL allows me to execute requests in
> > > parallel with just one open file descriptor and not having to maintain
> > > some sort of back-buffer to wait around until the reader gets to reading
> > > the thing. I've used that for stress-testing the EC communication in the
> > > past, which had some issues (dropping bytes, invalid CRCs, ...) under
> > > heavy(-ish) load. Second, I'm considering adding support for events to
> > > this device in the future by having user-space receive events by reading
> > > from the device. Events would also be enabled or disabled via an IOCTL.
> > > That could be implemented in a second device though. Events were also my
> > > main reason for adding a version to this interface: Discerning between
> > > one that has event support and one that has not.
> > 
> > A misc device can also do this, much simpler, right?  Why not use that?
> 
> Sorry to ask so many questions, just want to make sure I understand you
> correctly:
> 
>  - So you suggest I go with a misc device instead of putting this into
>    debugfs?

Yes.

>  - And I keep the IOCTL?

If you need it, although the interface Arnd says might be much simpler
(read/write)

>  - Can I still tell people to not use it and that it's not my fault if a
>    change in the interface breaks their tools if it's not in debugfs?

Yes :)

>  - Also load it via a separate module (module_misc_device, I assume)?

That works.

> One reason why the platform_device approach is practical in this
> scenario is that I can leverage the driver core to defer probing and
> thus defer creating the device if the controller isn't there yet.

That's fine, and is a nice abuse of the platform driver interface.  I
say "abuse" because we really don't have a simpler way to do this at the
moment, but this really isn't a platform device...

> Similarly, the driver is automatically unbound if the controller goes
> away and the device should be destroyed. All of this should currently be
> handled via the device link created by ssam_client_bind() (unless I
> really misunderstood those).

That all is fine, just create the misc device when your driver binds to
the device, just like you create the debugfs file entries today.
There's no difference except you get a "real" char device node instead
of a debugfs file.

> I should be able to handle that by having the device refuse to open the
> file if the controller isn't there. Holding the state-lock during the
> request execution should ensure that the controller doesn't get shut
> down.

Nah, no need for that, again, keep the platform driver/device and then
create the misc device (and remove it) where you are creating/removing
the debugfs files.

> > A simple misc device would make it very simple and easy to do instead,
> > why not do that?
> 
> Again, I considered the probe deferring of the platform driver fairly
> handy (in addition to having the implicit debugfs warning of "don't rely
> on this"), but if you prefer me implementing this as misc device, I'll
> do that.

The "joy" of creating a user api is that no matter how much you tell
people "do not depend on this", they will, so no matter the file being
in debugfs, or a misc device, you might be stuck with it for forever,
sorry.

thanks,

greg k-h
