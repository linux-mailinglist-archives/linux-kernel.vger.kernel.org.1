Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D11425389C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgHZTyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 15:54:01 -0400
Received: from smtprelay0156.hostedemail.com ([216.40.44.156]:53306 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726798AbgHZTyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 15:54:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 40A721801BD68;
        Wed, 26 Aug 2020 19:54:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:10004:10226:10400:10848:10967:11026:11232:11658:11914:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21451:21627:21772:21990:30012:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: elbow93_170ed9027067
X-Filterd-Recvd-Size: 2163
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Aug 2020 19:53:58 +0000 (UTC)
Message-ID: <9bfb4c4bd1415a8ce527a913730672508a8e8330.camel@perches.com>
Subject: Re: [PATCH v3 2/2] dynamic debug: allow printing to trace event
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        jbaron@akamai.com, mingo@redhat.com,
        Nicolas Boichat <drinkcat@chromium.org>, kernel@axis.com,
        corbet@lwn.net, pmladek@suse.com, sergey.senozhatsky@gmail.com,
        john.ogness@linutronix.de, linux-kernel@vger.kernel.org
Date:   Wed, 26 Aug 2020 12:53:57 -0700
In-Reply-To: <20200826153203.1a65c35d@oasis.local.home>
References: <20200825153338.17061-1-vincent.whitchurch@axis.com>
         <20200825153338.17061-3-vincent.whitchurch@axis.com>
         <651f7ec449dfb28006bbc0b018d4f6e506bcda80.camel@perches.com>
         <20200826153203.1a65c35d@oasis.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 15:32 -0400, Steven Rostedt wrote:
> On Tue, 25 Aug 2020 08:53:25 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > > The print buffer is statically allocated and managed using code borrowed
> > > from __ftrace_trace_stack() and is limited to 256 bytes (four of these
> > > are allocated per CPU to handle the various contexts); anything larger
> > > will be truncated.  
> > 
> > There is an effort to avoid using trace_printk and the like
> > so perhaps this feature should have the same compile time
> > guard.
> 
> No, this is fine for being in a production kernel. Basically, these are
> simply debug printk()s that can also be put into the trace buffer. The
> key difference to trace_printk() is that they are an event that needs
> to be enabled to write into the buffer.

It just seems like a backdoor way to convert various pr_debug functions
(dev_dbg/netdev_dbg, et al) into tracing.

What's the real value?  Timing data?  Something else?


