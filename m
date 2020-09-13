Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2434268096
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 19:26:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgIMR0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 13:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgIMR01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 13:26:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0883CC06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 10:26:27 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id w25so11594015otk.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 10:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UKGm1o6ci+6OzS/GEtQveNQ09fS6eC3dzYofKCv9jQc=;
        b=qfeOXAtlRDa585kNr3Der+wBnxr114EMqq17zu8BM5iDOIL7rR4XZJ9gPOtq/OLXwk
         mlzjCOSAnHKLHGp9YorzRuSiesr5Jv1Ib7M9zKA8uQrp8LBvDGpfk/wUlFCx2zfQh8EW
         9mocwO8Y/hevYAjd7ijjmYTV0pIlJMDNwCcbsZ/+e/206yAZM7iYQQLtTkvYrPwdCIFg
         EYNByJ/qCTNc5pRsNNAzu/UpLpT2LU1/MLeX4lohinXkl9/qI2dazlawWJ1lQsUZzm0R
         FqDLPW7JPhRCkbb8E32cM0YdxmwCqgZwuY5kHGn+WwOM5I/O4mazbd7R+rTTs745o3xE
         zFgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition:in-reply-to
         :user-agent;
        bh=UKGm1o6ci+6OzS/GEtQveNQ09fS6eC3dzYofKCv9jQc=;
        b=lM12+HrS0Sol0P9p0potA+NvNFbVwY5dJr36LupPSIq4JmcBmkMx/LA8cJMexl+qRm
         6QaUzpJimgMtnRu5vZSQLkFoAOdKaTX/NszRl4Zpybq5NNEl+uYo4P9kCwFq4kwWABLd
         z216es1acLyBnlxlqfh/GNfGMJzbXLfMy4+FIKpipMsEMJIwpwfTqbs3s2r/AkAXLcLJ
         o+JGuFUWhK0Xt5PIypWd3oT/mabYFSuiHz7jXdqATvdTk0QbnjOGK7W0iNrK2VyiGdrH
         Oz1B+Fpfxq7YmpQXY8zHwOOf2DwEvRJzgGa+GTo54L/JcizDVCuW/Z+wAXKqfkLLdeu8
         qOdQ==
X-Gm-Message-State: AOAM531nMa/+Qw9vPwJ+2MeQT3kAX/UaYplqhvQMKwcS96OBN2Fze4wy
        ds0yY/oHuH2/HSd1YzK3vw==
X-Google-Smtp-Source: ABdhPJxQBW52K8fMchI97XM8veaegh1EWnK6b/7ohJYYpJCQPgdzCRJda6/bFA8OLPJtg5yQNLJaTg==
X-Received: by 2002:a9d:2384:: with SMTP id t4mr6183643otb.337.1600017986230;
        Sun, 13 Sep 2020 10:26:26 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id l23sm1803466otk.79.2020.09.13.10.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 10:26:25 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:ecd3:d2ae:8b57:1a08])
        by serve.minyard.net (Postfix) with ESMTPSA id DEFCA180056;
        Sun, 13 Sep 2020 17:26:23 +0000 (UTC)
Date:   Sun, 13 Sep 2020 12:26:22 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tianxianting <tian.xianting@h3c.com>
Cc:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "openipmi-developer@lists.sourceforge.net" 
        <openipmi-developer@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipmi: retry to get device id when error
Message-ID: <20200913172622.GI15602@minyard.net>
Reply-To: minyard@acm.org
References: <20200913120203.3368-1-tian.xianting@h3c.com>
 <20200913123930.GH15602@minyard.net>
 <a5ac0e7e90a442e6b29ba243ae1920c0@h3c.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a5ac0e7e90a442e6b29ba243ae1920c0@h3c.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 02:10:01PM +0000, Tianxianting wrote:
> Hi Corey
> Thanks for your quickly reply,
> We didn't try the method you mentioned, actually, I didn't know it before you told me:(
> The issue ever occurred on our 2 ceph storage server both with low probability.
> We finally use this patch to solve the issue, it can automatically solve the issue when it happened. So no need to judge and reload ipmi driver manually or develop additional scripts to make it.
> The 1 second delay is acceptable to us.
> 
> If there really isn't a BMC out there, ipmi driver will not be loaded, is it right?

No, there are systems that have IPMI controllers that are specified in
the ACPI/SMBIOS tables but have no IPMI controller.

> 
> May be we can adjust to retry 3 times with 500ms interval? 

Maybe there is another way.  What I'm guessing is happening is not that
the interface is lossy, but that the BMC is in the middle of a reset or
an upgrade.  The D5 completion code means: Cannot execute command. Command,
or request parameter(s), not supported in present state.

That error is also returned from bt_start_transaction() in the driver if
the driver is not in the right state when starting a transaction,
which may point to a bug in the BT state machine.  Search for
IPMI_NOT_IN_MY_STATE_ERR in drivers/char/ipmi/ipmi_bt_sm.c.

If it's coming fron the state machine, it would be handy to know what
state it was in when the error happened to help trace the bug down.
That's what I would suggest first.  Fix the fundamental bug, if you can.
a pr_warn() added to the code there would be all that's needed, and
thats probably a good permanent addition.

I would be ok with a patch that retried some number of times if it got a
D5 completion code.  That wouldn't have any effect on other systems.
Plus you could add a D1 and D2 completion code, which are similar
things.  Add the new completion codes to include/uapi/linux/ipmi_msgdefs.h
and implement the retry.  That makes sense from a general point of view.

Thanks,

-corey

> 
> Thanks in advance if you can feedback again.
> 
> -----Original Message-----
> From: Corey Minyard [mailto:tcminyard@gmail.com] On Behalf Of Corey Minyard
> Sent: Sunday, September 13, 2020 8:40 PM
> To: tianxianting (RD) <tian.xianting@h3c.com>
> Cc: arnd@arndb.de; gregkh@linuxfoundation.org; openipmi-developer@lists.sourceforge.net; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ipmi: retry to get device id when error
> 
> On Sun, Sep 13, 2020 at 08:02:03PM +0800, Xianting Tian wrote:
> > We can't get bmc's device id with low probability when loading ipmi 
> > driver, it caused bmc device register failed. This issue may caused by 
> > bad lpc signal quality. When this issue happened, we got below kernel printks:
> > 	[Wed Sep  9 19:52:03 2020] ipmi_si IPI0001:00: IPMI message handler: device id demangle failed: -22
> > 	[Wed Sep  9 19:52:03 2020] IPMI BT: using default values
> > 	[Wed Sep  9 19:52:03 2020] IPMI BT: req2rsp=5 secs retries=2
> > 	[Wed Sep  9 19:52:03 2020] ipmi_si IPI0001:00: Unable to get the device id: -5
> > 	[Wed Sep  9 19:52:04 2020] ipmi_si IPI0001:00: Unable to register 
> > device: error -5
> > 
> > When this issue happened, we want to manually unload the driver and 
> > try to load it again, but it can't be unloaded by 'rmmod' as it is already 'in use'.
> 
> I'm not sure this patch is a good idea; it would cause a long boot delay in situations where there really isn't a BMC out there.  Yes, it happens.
> 
> You don't have to reload the driver to add a device, though.  You can hot-add devices using /sys/modules/ipmi_si/parameters/hotmod.  Look in Documentation/driver-api/ipmi.rst for details.
> 
> Does that work for you?
> 
> -corey
> 
> > 
> > We add below 'printk' in handle_one_recv_msg(), when this issue 
> > happened, the msg we received is "Recv: 1c 01 d5", which means the 
> > data_len is 1, data[0] is 0xd5.
> > 	Debug code:
> > 	static int handle_one_recv_msg(struct ipmi_smi *intf,
> >                                struct ipmi_smi_msg *msg) {
> >         	printk("Recv: %*ph\n", msg->rsp_size, msg->rsp);
> > 		... ...
> > 	}
> > Then in ipmi_demangle_device_id(), it returned '-EINVAL' as 'data_len < 7'
> > and 'data[0] != 0'.
> > 
> > We used this patch to retry to get device id when error happen, we 
> > reproduced this issue again and the retry succeed on the first retry, 
> > we finally got the correct msg and then all is ok:
> > Recv: 1c 01 00 01 81 05 84 02 af db 07 00 01 00 b9 00 10 00
> > 
> > So use retry machanism in this patch to give bmc more opportunity to 
> > correctly response kernel.
> > 
> > Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
> > ---
> >  drivers/char/ipmi/ipmi_msghandler.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/char/ipmi/ipmi_msghandler.c 
> > b/drivers/char/ipmi/ipmi_msghandler.c
> > index 737c0b6b2..bfb2de77a 100644
> > --- a/drivers/char/ipmi/ipmi_msghandler.c
> > +++ b/drivers/char/ipmi/ipmi_msghandler.c
> > @@ -34,6 +34,7 @@
> >  #include <linux/uuid.h>
> >  #include <linux/nospec.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/delay.h>
> >  
> >  #define IPMI_DRIVER_VERSION "39.2"
> >  
> > @@ -60,6 +61,9 @@ enum ipmi_panic_event_op {  #else  #define 
> > IPMI_PANIC_DEFAULT IPMI_SEND_PANIC_EVENT_NONE  #endif
> > +
> > +#define GET_DEVICE_ID_MAX_RETRY	5
> > +
> >  static enum ipmi_panic_event_op ipmi_send_panic_event = 
> > IPMI_PANIC_DEFAULT;
> >  
> >  static int panic_op_write_handler(const char *val, @@ -2426,19 
> > +2430,26 @@ send_get_device_id_cmd(struct ipmi_smi *intf)  static int 
> > __get_device_id(struct ipmi_smi *intf, struct bmc_device *bmc)  {
> >  	int rv;
> > -
> > -	bmc->dyn_id_set = 2;
> > +	unsigned int retry_count = 0;
> >  
> >  	intf->null_user_handler = bmc_device_id_handler;
> >  
> > +retry:
> > +	bmc->dyn_id_set = 2;
> > +
> >  	rv = send_get_device_id_cmd(intf);
> >  	if (rv)
> >  		return rv;
> >  
> >  	wait_event(intf->waitq, bmc->dyn_id_set != 2);
> >  
> > -	if (!bmc->dyn_id_set)
> > +	if (!bmc->dyn_id_set) {
> > +		msleep(1000);
> > +		if (++retry_count <= GET_DEVICE_ID_MAX_RETRY)
> > +			goto retry;
> > +
> >  		rv = -EIO; /* Something went wrong in the fetch. */
> > +	}
> >  
> >  	/* dyn_id_set makes the id data available. */
> >  	smp_rmb();
> > --
> > 2.17.1
> > 
