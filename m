Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC542E0852
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:53:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgLVJxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:53:32 -0500
Received: from smtprelay0042.hostedemail.com ([216.40.44.42]:45686 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725811AbgLVJxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:53:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1A3B21822186D;
        Tue, 22 Dec 2020 09:52:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1434:1437:1515:1516:1518:1534:1543:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:6119:6248:7576:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12296:12297:12555:12679:12740:12895:13439:13894:14096:14097:14181:14659:14721:21080:21324:21433:21451:21627:30012:30029:30054:30070:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: straw06_580ca3a2745f
X-Filterd-Recvd-Size: 3803
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue, 22 Dec 2020 09:52:50 +0000 (UTC)
Message-ID: <6ea843411793073040bb8d518fca84f5b66b86aa.camel@perches.com>
Subject: Re: [PATCH] usb: musb: add printf attribute to log function
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>, trix@redhat.com
Cc:     b-liu@ti.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 22 Dec 2020 01:52:48 -0800
In-Reply-To: <X+Gzvo3vPBFGKAy+@kroah.com>
References: <20201221162547.3756889-1-trix@redhat.com>
         <X+Gzvo3vPBFGKAy+@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-22 at 09:52 +0100, Greg KH wrote:
> On Mon, Dec 21, 2020 at 08:25:47AM -0800, trix@redhat.com wrote:
> > From: Tom Rix <trix@redhat.com>
> > 
> > Attributing the function allows the compiler to more thoroughly
> > check the use of the function with -Wformat and similar flags.
> > 
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> >  drivers/usb/musb/musb_debug.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/usb/musb/musb_debug.h b/drivers/usb/musb/musb_debug.h
> > index e5b3506c7b3f..dfc0d02695fa 100644
> > --- a/drivers/usb/musb/musb_debug.h
> > +++ b/drivers/usb/musb/musb_debug.h
> > @@ -17,6 +17,7 @@
> >  #define INFO(fmt, args...) yprintk(KERN_INFO, fmt, ## args)
> >  #define ERR(fmt, args...) yprintk(KERN_ERR, fmt, ## args)
> >  
> > 
> > +__printf(2, 3)
> >  void musb_dbg(struct musb *musb, const char *fmt, ...);
> 
> While I understand the need for this, did this find any problems?
> If not, then it's not worth adding,

I have to disagree with that Greg.  While the driver isn't in active
development, a trivial mod to make it less likely a defect is introduced
by any additional code is still a useful addition.

> the driver-specific debugging macros
> should be removed entirely and just use dev_dbg() and friends instead.

Read the suggested change I posted in reply.

btw: the musb_dbg function is actually a trace function and not a
dmesg/logging mechanism.

drivers/usb/musb/musb_trace.c:void musb_dbg(struct musb *musb, const char *fmt, ...)
drivers/usb/musb/musb_trace.c-{
drivers/usb/musb/musb_trace.c-  struct va_format vaf;
drivers/usb/musb/musb_trace.c-  va_list args;
drivers/usb/musb/musb_trace.c-
drivers/usb/musb/musb_trace.c-  va_start(args, fmt);
drivers/usb/musb/musb_trace.c-  vaf.fmt = fmt;
drivers/usb/musb/musb_trace.c-  vaf.va = &args;
drivers/usb/musb/musb_trace.c-
drivers/usb/musb/musb_trace.c-  trace_musb_log(musb, &vaf);
drivers/usb/musb/musb_trace.c-
drivers/usb/musb/musb_trace.c-  va_end(args);
drivers/usb/musb/musb_trace.c-}

drivers/usb/musb/musb_trace.h:TRACE_EVENT(musb_log,
drivers/usb/musb/musb_trace.h-  TP_PROTO(struct musb *musb, struct va_format *vaf),
drivers/usb/musb/musb_trace.h-  TP_ARGS(musb, vaf),
drivers/usb/musb/musb_trace.h-  TP_STRUCT__entry(
drivers/usb/musb/musb_trace.h-          __string(name, dev_name(musb->controller))
drivers/usb/musb/musb_trace.h-          __dynamic_array(char, msg, MUSB_MSG_MAX)
drivers/usb/musb/musb_trace.h-  ),
drivers/usb/musb/musb_trace.h-  TP_fast_assign(
drivers/usb/musb/musb_trace.h-          __assign_str(name, dev_name(musb->controller));
drivers/usb/musb/musb_trace.h-          vsnprintf(__get_str(msg), MUSB_MSG_MAX, vaf->fmt, *vaf->va);
drivers/usb/musb/musb_trace.h-  ),
drivers/usb/musb/musb_trace.h-  TP_printk("%s: %s", __get_str(name), __get_str(msg))
drivers/usb/musb/musb_trace.h-);

Is that trace mechanism useful though?  I think it's somewhat odd.

