Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7BB1DC04B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 May 2020 22:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgETUgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 May 2020 16:36:52 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:54170 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgETUgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 16:36:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id BD62F100E7B47;
        Wed, 20 May 2020 20:36:50 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3874:4321:4605:4837:5007:6120:7875:9010:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14659:14721:21080:21451:21627:21740:21809:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: shake90_010f55826d18
X-Filterd-Recvd-Size: 2078
Received: from XPS-9350 (unknown [172.58.35.10])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 20 May 2020 20:36:48 +0000 (UTC)
Message-ID: <19a8c717f8d9dc76f2b09e6dd19f3fbb71bf29c5.camel@perches.com>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Wed, 20 May 2020 13:36:45 -0700
In-Reply-To: <20200520121000.GF520@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
         <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
         <20200520044127.GB938@jagdpanzerIV.localdomain>
         <ae3aff79301c130aa15b3fe0ff801804bb019384.camel@perches.com>
         <20200520121000.GF520@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-05-20 at 21:10 +0900, Sergey Senozhatsky wrote:
> On (20/05/19 21:58), Joe Perches wrote:
> [..]
> > >  Maybe we can
> > > use here something rather random and much shorter instead. E.g.
> > > 256 chars. Hmm. How 
> > 
> > 	min(some_max like 132/256, PRINTK_LOG_LINE_MAX)
> > 
> > would work.
> 
> An alternative approach would be to do what we do in the
> print_modules() (the list of modules which can definitely
> be longer than 1K chars).
> 
> We can split command line in a loop - memchr(pos, ' ') - and
> pr_cont() parts of the command line. pr_cont() has overflow
> control and it flushes cont buffer before it overflows, so
> we should not lose anything.

It doesn't matter much here, but I believe
there's an 8k max buffer for pr_cont output.

include/linux/printk.h:#define CONSOLE_EXT_LOG_MAX      8192

Anyway, no worries, it simplifies the loop if
done that way.


