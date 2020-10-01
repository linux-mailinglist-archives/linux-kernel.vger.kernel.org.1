Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A9D27FA61
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 09:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731349AbgJAHjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 03:39:35 -0400
Received: from smtprelay0132.hostedemail.com ([216.40.44.132]:46424 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731131AbgJAHjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 03:39:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 67409180A68AD;
        Thu,  1 Oct 2020 07:39:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2899:2907:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7903:8603:10004:10400:10848:11026:11232:11473:11658:11914:12297:12663:12740:12760:12895:13069:13095:13138:13161:13229:13231:13311:13357:13439:14096:14097:14659:14721:14819:21063:21080:21324:21433:21627:21740:21809:21939:21990:30054:30070:30075:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: boats10_320b5cc27199
X-Filterd-Recvd-Size: 3019
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 07:39:32 +0000 (UTC)
Message-ID: <873100a17ac1a9fc1c435ff7957b63d2540ce7fc.camel@perches.com>
Subject: Re: [PATCH next v2 1/2] printk: avoid and/or handle record
 truncation
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 01 Oct 2020 00:39:31 -0700
In-Reply-To: <20201001072659.GB17717@alley>
References: <20200930090134.8723-1-john.ogness@linutronix.de>
         <20200930090134.8723-2-john.ogness@linutronix.de>
         <b4c2ea7ec34aaf05d53264b19a6c40245ed361c0.camel@perches.com>
         <20201001072659.GB17717@alley>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-01 at 09:26 +0200, Petr Mladek wrote:
> On Wed 2020-09-30 08:25:24, Joe Perches wrote:
> > On Wed, 2020-09-30 at 11:07 +0206, John Ogness wrote:
> > > If a reader provides a buffer that is smaller than the message text,
> > > the @text_len field of @info will have a value larger than the buffer
> > > size. If readers blindly read @text_len bytes of data without
> > > checking the size, they will read beyond their buffer.
> > > 
> > > Add this check to record_print_text() to properly recognize when such
> > > truncation has occurred.
> > > 
> > > Add a maximum size argument to the ringbuffer function to extend
> > > records so that records can not be created that are larger than the
> > > buffer size of readers.
> > > 
> > > When extending records (LOG_CONT), do not extend records beyond
> > > LOG_LINE_MAX since that is the maximum size available in the buffers
> > > used by consoles and syslog.
> > 
> > I still think it better to support backspace by rewinding
> > the buffer rather than truncation of the output.
> 
> IMHO, backspace support is not worth the complexity. It might do
> some fancy animation on console but it does not bring any advantage
> in static logs (dmesg, journalctl).
> 
> It is possible that it worked in the past when the log buffer was
> just an array of characters that were pushed to the console when
> they appeared.
> 
> But I am pretty sure that it has stopped working many years agl
> variable-length record buffer").

It's more that spinner or timer dots could fill the
buffer and any message after the spinner/dots like
success or failure is lost via truncation.

There aren't many spinners/dots, perhaps it's better
to find and delete them.


