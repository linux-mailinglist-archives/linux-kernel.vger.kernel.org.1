Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1C12728BF
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 16:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgIUOps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 10:45:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:48593 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727231AbgIUOpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 10:45:47 -0400
Received: (qmail 1214717 invoked by uid 1000); 21 Sep 2020 10:45:46 -0400
Date:   Mon, 21 Sep 2020 10:45:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Pavel Machek <pavel@denx.de>, gregkh@linuxfoundation.org,
        johan@kernel.org, gustavoars@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: yurex: Rearrange code not to need GFP_ATOMIC
Message-ID: <20200921144546.GB1213381@rowland.harvard.edu>
References: <20200920084452.GA2257@amd>
 <1600691092.2424.85.camel@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600691092.2424.85.camel@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 02:24:52PM +0200, Oliver Neukum wrote:
> Am Sonntag, den 20.09.2020, 10:44 +0200 schrieb Pavel Machek:
> > Move prepare to wait around, so that normal GFP_KERNEL allocation can
> > be used.
> > 
> > Signed-off-by: Pavel Machek (CIP) <pavel@denx.de>
> > Acked-by: Alan Stern <stern@rowland.harvard.edu>
> 
> Ehm. Please recheck.
> 
> > diff --git a/drivers/usb/misc/yurex.c b/drivers/usb/misc/yurex.c
> > index b2e09883c7e2..071f1debebba 100644
> > --- a/drivers/usb/misc/yurex.c
> > +++ b/drivers/usb/misc/yurex.c
> > @@ -489,10 +489,10 @@ static ssize_t yurex_write(struct file *file, const char __user *user_buffer,
> >  	}
> >  
> >  	/* send the data as the control msg */
> > -	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
> >  	dev_dbg(&dev->interface->dev, "%s - submit %c\n", __func__,
> >  		dev->cntl_buffer[0]);
> > -	retval = usb_submit_urb(dev->cntl_urb, GFP_ATOMIC);
> > +	retval = usb_submit_urb(dev->cntl_urb, GFP_KERNEL);
> 
> URB completes here. wake_up() returns the task to RUNNING.
> 
> > +	prepare_to_wait(&dev->waitq, &wait, TASK_INTERRUPTIBLE);
> 
> Task goes to TASK_INTERRUPTIBLE
> 
> >  	if (retval >= 0)
> >  		timeout = schedule_timeout(YUREX_WRITE_TIMEOUT);
> 
> Task turns into Sleeping Beauty until timeout
> 
> >  	finish_wait(&dev->waitq, &wait);
> 
> And here task goes into error reporting as it checks timeout.

Arrgh.  Now I feel stupid.  (Me and Pavel both, probably.)

Thanks for spotting this.

Alan Stern
