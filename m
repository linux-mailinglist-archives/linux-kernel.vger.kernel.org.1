Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 176A01AB605
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Apr 2020 04:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389043AbgDPCsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 22:48:46 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:47726 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732153AbgDPCsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 22:48:41 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B8401100E7B42;
        Thu, 16 Apr 2020 02:48:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1431:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2893:3138:3139:3140:3141:3142:3352:3622:3866:3867:3870:3871:3872:3873:3874:4321:5007:6119:6120:10004:10400:10848:10967:11232:11658:11914:12043:12296:12297:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: beef17_2e584604c5507
X-Filterd-Recvd-Size: 1880
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 Apr 2020 02:48:38 +0000 (UTC)
Message-ID: <c8c8f37f20625922eb114574c544ebb6332ac025.camel@perches.com>
Subject: Re: [PATCH v3 0/3] lib/vsprintf: Introduce %ptT for time64_t
From:   Joe Perches <joe@perches.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Wed, 15 Apr 2020 19:46:27 -0700
In-Reply-To: <20200416023425.GB30641@jagdpanzerIV.localdomain>
References: <20200415170046.33374-1-andriy.shevchenko@linux.intel.com>
         <20200415132011.624f35f6@gandalf.local.home>
         <20200416023425.GB30641@jagdpanzerIV.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-16 at 11:34 +0900, Sergey Senozhatsky wrote:
> On (20/04/15 13:20), Steven Rostedt wrote:
> > On Wed, 15 Apr 2020 20:00:43 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > > It is a logical continuation of previously applied %ptR for struct rtc_time.
> > > We have few users of time64_t that would like to print it.
> > > 
> > > Andrew, since Petr can't pay attention on this perhaps it can be passed thru
> > > your tree?
> > > 
> > > Sergey, Steven, what do you think?
> > 
> > I'm fine with these changes. Sergey, what do you think?
> 
> I'm not against it in general, I'm slightly concerned if "two users"
> is enough of a justification for new vsprintf() specifier.

Me too as separate functions could be used here.


