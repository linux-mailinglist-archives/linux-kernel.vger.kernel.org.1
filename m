Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767252EE693
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbhAGUJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:09:49 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47892 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbhAGUJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:09:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 107K94xC017256;
        Thu, 7 Jan 2021 14:09:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1610050144;
        bh=tKyO9cE76P78PZWHYaweoQ34KnXpT+8wACdMQoB/Qeg=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ZBHPOaYbN6hS6zhP2XuYlLUBH3NhuT48J17y5+dCQ6WSBw4xvmSWqETYHYsEynUhK
         DUuwDWw6AVm9a44Ai3MtAl4AXGfw1jy+dqG0J4CwwFnUoIAtZ4T3FTHIc0bHooNCfB
         10iyVGXkUJNVQRvf5FX0P8y9P/8n9/FiXiQzbHmc=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 107K92di018493
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 7 Jan 2021 14:09:04 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 7 Jan
 2021 14:09:03 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 7 Jan 2021 14:09:03 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 107K93m9044584;
        Thu, 7 Jan 2021 14:09:03 -0600
Date:   Thu, 7 Jan 2021 14:09:03 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Joe Perches <joe@perches.com>
CC:     Greg KH <gregkh@linuxfoundation.org>, <trix@redhat.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: musb: add printf attribute to log function
Message-ID: <20210107200903.GA7456@iaqt7>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Joe Perches <joe@perches.com>,
        Greg KH <gregkh@linuxfoundation.org>, trix@redhat.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20201221162547.3756889-1-trix@redhat.com>
 <X+Gzvo3vPBFGKAy+@kroah.com>
 <6ea843411793073040bb8d518fca84f5b66b86aa.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ea843411793073040bb8d518fca84f5b66b86aa.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 22, 2020 at 01:52:48AM -0800, Joe Perches wrote:
> On Tue, 2020-12-22 at 09:52 +0100, Greg KH wrote:
> > On Mon, Dec 21, 2020 at 08:25:47AM -0800, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > Attributing the function allows the compiler to more thoroughly
> > > check the use of the function with -Wformat and similar flags.
> > > 
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >  drivers/usb/musb/musb_debug.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
> > > index e5b3506c7b3f..dfc0d02695fa 100644
> > > --- a/drivers/usb/musb/musb_debug.h
> > > +++ b/drivers/usb/musb/musb_debug.h
> > > @@ -17,6 +17,7 @@
> > >  #define INFO(fmt, args...) yprintk(KERN_INFO, fmt, ## args)
> > >  #define ERR(fmt, args...) yprintk(KERN_ERR, fmt, ## args)

These should be converted to dev_info or dev_err. I believe the work was only
done on those actively used platform drivers.

Further cleanup patches are welcomed.

> > >  
> > > 
> > > +__printf(2, 3)
> > >  void musb_dbg(struct musb *musb, const char *fmt, ...);
> > 
> > While I understand the need for this, did this find any problems?
> > If not, then it's not worth adding,
> 
> I have to disagree with that Greg.  While the driver isn't in active
> development, a trivial mod to make it less likely a defect is introduced
> by any additional code is still a useful addition.
> 
> > the driver-specific debugging macros
> > should be removed entirely and just use dev_dbg() and friends instead.
> 
> Read the suggested change I posted in reply.
> 
> btw: the musb_dbg function is actually a trace function and not a
> dmesg/logging mechanism.

Yes, musb_dbg() generates ftrace logs instead.

> 
> drivers/usb/musb/musb_trace.c:void musb_dbg(struct musb *musb, const char *fmt, ...)
> drivers/usb/musb/musb_trace.c-{
> drivers/usb/musb/musb_trace.c-  struct va_format vaf;
> drivers/usb/musb/musb_trace.c-  va_list args;
> drivers/usb/musb/musb_trace.c-
> drivers/usb/musb/musb_trace.c-  va_start(args, fmt);
> drivers/usb/musb/musb_trace.c-  vaf.fmt = fmt;
> drivers/usb/musb/musb_trace.c-  vaf.va = &args;
> drivers/usb/musb/musb_trace.c-
> drivers/usb/musb/musb_trace.c-  trace_musb_log(musb, &vaf);
> drivers/usb/musb/musb_trace.c-
> drivers/usb/musb/musb_trace.c-  va_end(args);
> drivers/usb/musb/musb_trace.c-}
> 
> drivers/usb/musb/musb_trace.h:TRACE_EVENT(musb_log,
> drivers/usb/musb/musb_trace.h-  TP_PROTO(struct musb *musb, struct va_format *vaf),
> drivers/usb/musb/musb_trace.h-  TP_ARGS(musb, vaf),
> drivers/usb/musb/musb_trace.h-  TP_STRUCT__entry(
> drivers/usb/musb/musb_trace.h-          __string(name, dev_name(musb->controller))
> drivers/usb/musb/musb_trace.h-          __dynamic_array(char, msg, MUSB_MSG_MAX)
> drivers/usb/musb/musb_trace.h-  ),
> drivers/usb/musb/musb_trace.h-  TP_fast_assign(
> drivers/usb/musb/musb_trace.h-          __assign_str(name, dev_name(musb->controller));
> drivers/usb/musb/musb_trace.h-          vsnprintf(__get_str(msg), MUSB_MSG_MAX, vaf->fmt, *vaf->va);
> drivers/usb/musb/musb_trace.h-  ),
> drivers/usb/musb/musb_trace.h-  TP_printk("%s: %s", __get_str(name), __get_str(msg))
> drivers/usb/musb/musb_trace.h-);
> 
> Is that trace mechanism useful though?  I think it's somewhat odd.

The intention was to convert runtime debug log to ftrace for efficiency.
Some of the original printk() are converted to trace points. Other
unclassified prints are converted to musb_dbg() for further clean up.

-Bin.
