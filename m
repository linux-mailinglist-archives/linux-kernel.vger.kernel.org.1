Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA0B27CEC6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgI2NOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbgI2NOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:14:18 -0400
Received: from smtp1.goneo.de (smtp1.goneo.de [IPv6:2001:1640:5::8:30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE84EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 06:14:17 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp1.goneo.de (Postfix) with ESMTP id 29B0E23F0C2;
        Tue, 29 Sep 2020 15:14:15 +0200 (CEST)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.99
X-Spam-Level: 
X-Spam-Status: No, score=-2.99 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.090, BAYES_00=-1.9] autolearn=ham
Received: from smtp1.goneo.de ([127.0.0.1])
        by localhost (smtp1.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id H0o0PylUI-AA; Tue, 29 Sep 2020 15:14:14 +0200 (CEST)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp1.goneo.de (Postfix) with ESMTPSA id DC14323F0C4;
        Tue, 29 Sep 2020 15:14:13 +0200 (CEST)
Date:   Tue, 29 Sep 2020 15:14:09 +0200
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: Remove double assignment
Message-ID: <20200929131409.wfq663eb4yukvofg@lem-wkst-02.lemonage>
References: <20200929115808.2815382-1-poeschel@lemonage.de>
 <20200929122533.GA1193271@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200929122533.GA1193271@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 02:25:33PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Sep 29, 2020 at 01:58:08PM +0200, poeschel@lemonage.de wrote:
> > From: Lars Poeschel <poeschel@lemonage.de>
> > 
> > This removes an assignment in device_add. It assigned the parent
> > kobject to the kobject of the  new device. This is not necessary,
> > because the call to kobject_add a few lines later also does this same
> > assignment.
> > 
> > Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> > ---
> >  drivers/base/core.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index bb5806a2bd4c..03b5396cd192 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -2847,8 +2847,6 @@ int device_add(struct device *dev)
> >  		error = PTR_ERR(kobj);
> >  		goto parent_error;
> >  	}
> > -	if (kobj)
> > -		dev->kobj.parent = kobj;
> >  
> >  	/* use parent numa_node */
> >  	if (parent && (dev_to_node(dev) == NUMA_NO_NODE))
> > @@ -2856,7 +2854,7 @@ int device_add(struct device *dev)
> >  
> >  	/* first, register with generic layer. */
> >  	/* we require the name to be set before, and pass NULL */
> > -	error = kobject_add(&dev->kobj, dev->kobj.parent, NULL);
> > +	error = kobject_add(&dev->kobj, kobj, NULL);
> 
> That's very subtle, and might not really be correct for all users, have
> you checked?

Of course I have not checked for all users ;-), but I have checked this
for my system and I did not notice any difference. My system is an arm
based board that does several hundreds of calls to the device_add
function per kernel bootup.

> Anyway, I'd rather leave this as-is if possible, as we know this works
> correctly, and it is not going to save any time/energy to remove that
> assignment, right?

Of course it's up to you to leave this as is.
Pure binary size drops from 0x784 to 0x778 (12 bytes) with this patch
for the device_add function on arm with gcc 10.2.0.
So this saves a tiny amount of size and energy. If it's worth that, I
don't know.
And not to mention the time/energy you save when some time some random
guy again stubles upon this, sends you a patch and then you have to
reply. ;-)

Ok, as said:Taking this is up to you. I can also live without this.

Regards,
Lars

