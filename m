Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC9381DD2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 May 2020 18:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgEUQJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 May 2020 12:09:45 -0400
Received: from smtprelay0012.hostedemail.com ([216.40.44.12]:56624 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728517AbgEUQJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:09:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C19DC180143E1;
        Thu, 21 May 2020 16:09:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3873:4321:5007:6120:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21324:21627:21939:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: form95_5f0de8926d1f
X-Filterd-Recvd-Size: 1701
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Thu, 21 May 2020 16:09:42 +0000 (UTC)
Message-ID: <e0d86bc30a0415674859b81f66db661fb443aaf9.camel@perches.com>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
From:   Joe Perches <joe@perches.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Thu, 21 May 2020 09:09:38 -0700
In-Reply-To: <20200521155931.GA568639@rani.riverdale.lan>
References: <cover.1589916689.git.joe@perches.com>
         <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
         <20200521155931.GA568639@rani.riverdale.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-21 at 11:59 -0400, Arvind Sankar wrote:
> On Tue, May 19, 2020 at 12:42:35PM -0700, Joe Perches wrote:
> > ARM may have its longest possible command line larger than the longest
> > possible printk.
[]
> I might be missing something, but this seems broken:

probably, note the "untested" bit.

> (1) If there is a ' ', the memchr will set pos to the ' ' the first time
> through the inner loop, and then go into an infinite loop? You want
> memrchr here but the kernel doesn't seem to have one.

Right.  I did look and didn't find one and didn't
want to add it just for this use.


