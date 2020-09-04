Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD2125E1F5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 21:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgIDT13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 15:27:29 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:34226 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726221AbgIDT12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:27:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id C44731800EC27;
        Fri,  4 Sep 2020 19:27:26 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2692:2828:2859:2892:2904:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4250:4321:4470:5007:6691:8531:9010:9025:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12555:12740:12760:12895:12986:13019:13095:13439:14181:14659:14721:21080:21324:21433:21627:21939:30029:30054:30056:30075:30080:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: land29_56048e2270b4
X-Filterd-Recvd-Size: 3930
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri,  4 Sep 2020 19:27:24 +0000 (UTC)
Message-ID: <897438bf3fbbd38ee92e964ce5b9d1dc2bccd2ec.camel@perches.com>
Subject: Re: printk: Add process name information to printk() output.
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Changki Kim <changki.kim@samsung.com>, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, rostedt@goodmis.org,
        changbin.du@intel.com, masahiroy@kernel.org, rd.dunlap@gmail.com,
        krzk@kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 04 Sep 2020 12:27:23 -0700
In-Reply-To: <20200904103541.GB2693206@kroah.com>
References: <CGME20200904082449epcas2p4420d5df2083325b328a182c79f5c0948@epcas2p4.samsung.com>
         <20200904082438.20707-1-changki.kim@samsung.com>
         <874kod6fgh.fsf@jogness.linutronix.de> <20200904103541.GB2693206@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-09-04 at 12:35 +0200, Greg KH wrote:
> On Fri, Sep 04, 2020 at 11:53:42AM +0206, John Ogness wrote:
> > On 2020-09-04, Changki Kim <changki.kim@samsung.com> wrote:
> > > Printk() meesages are the most basic and useful debug method.
> > > However, additional information needs in multi-processor.
> > > If we add messages with processor id and process name, we can find
> > > a problem only with messages when the problem occurs with H/W IP or CPU.
> > > This is very useful in narrowing down the scope of the problems.
> > 
> > [...]
> > 
> > > diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
> > > index e6302da041f9..fcefe9516606 100644
> > > --- a/kernel/printk/printk_ringbuffer.h
> > > +++ b/kernel/printk/printk_ringbuffer.h
> > > @@ -21,6 +22,12 @@ struct printk_info {
> > >  	u8	flags:5;	/* internal record flags */
> > >  	u8	level:3;	/* syslog level */
> > >  	u32	caller_id;	/* thread id or processor id */
> > > +#ifdef CONFIG_PRINTK_PROCESS
> > > +	int	pid;			/* process id */
> > > +	u8	cpu_id;			/* processor id */
> > > +	u8	in_interrupt;		/* interrupt conext */
> > > +	char process[TASK_COMM_LEN];	/* process name */
> > > +#endif
> > >  };
> > 
> > I can understand the desire to have more information with messages. But
> > IMHO adding it to the ringbuffer descriptor is the wrong place for
> > it. The descriptor should really be limited to data that the printk
> > subsystem needs for _itself_. With respect to LOG_CONT, I think we can
> > agree that @caller_id is not enough. But there has been discussions [0]
> > of having @caller_id provide a better context representation.
> > 
> > If we want to support adding more meta information to messages, I would
> > prefer that the information is either prepended directly to the message
> > text string or appended to the dictionary text string. We could even go
> > so far as providing a boot argument where a list of information could be
> > specified, what should be automatically added to the text/dict strings
> > of each message. That would not require any ringbuffer changes and would
> > allow new types of information to be added later.
> > 
> > Something like:
> > 
> >     printk.format=ts,cpu,comm,pid,in_atomic
> > 
> > John Ogness
> > 
> > [0] https://lkml.kernel.org/r/20200719143527.GA566@jagdpanzerIV.localdomain
> 
> Ah, finally a good use of the "dictionary" that we all can agree makes
> sense :)
> 
> This does seem like a better solution overall, thanks.

__func__ too please so that it could optionally be enabled per
subsystem using %pS, __builtin_return_address(<appropriate_level>)

That way a lot of %s:..., __func__ could be removed from
specific printk instances.



