Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78F21C7F8A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 03:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgEGBCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 21:02:40 -0400
Received: from smtprelay0245.hostedemail.com ([216.40.44.245]:44924 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbgEGBCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 21:02:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8377E180A7339;
        Thu,  7 May 2020 01:02:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2910:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6691:8603:10004:10400:10848:11026:11232:11473:11658:11914:12297:12533:12740:12760:12895:13069:13146:13230:13311:13357:13439:14093:14096:14097:14659:14721:21080:21433:21627:21795:21939:21990:30012:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fear98_341a2ebcbb61a
X-Filterd-Recvd-Size: 2824
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 01:02:37 +0000 (UTC)
Message-ID: <63f58a1c334d8d44ddf1788091be9b2232054b03.camel@perches.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 06 May 2020 18:02:36 -0700
In-Reply-To: <0d513c80-8c8e-17b6-5b9c-73c7bca77252@i-love.sakura.ne.jp>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <20200425004609.GE8982@jagdpanzerIV.localdomain>
         <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
         <20200427062117.GC486@jagdpanzerIV.localdomain>
         <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
         <344199f1-639b-ee93-2388-57b0549641f9@i-love.sakura.ne.jp>
         <dfe10cb0359c37dff46c93dfacf909dd33b2593f.camel@perches.com>
         <0d513c80-8c8e-17b6-5b9c-73c7bca77252@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 09:50 +0900, Tetsuo Handa wrote:
> On 2020/05/07 0:26, Joe Perches wrote:
> > On Wed, 2020-05-06 at 18:45 +0900, Tetsuo Handa wrote:
> > > On 2020/04/28 20:33, Tetsuo Handa wrote:
> > > > On 2020/04/27 15:21, Sergey Senozhatsky wrote:
> > > > > > KERN_NO_CONSOLES is for type of messages where "saved for later analysis" is
> > > > > > important but "printed for immediate notification" is not important.
> > > > > > In other words, KERN_NO_CONSOLES is NOT for dying messages where "printed for
> > > > > > immediate notification" is important.
> > > > > 
> > > > > per-console loglevel is a user configurable parameter.
> > > > > KERN_NO_CONSOLES is a hard-coded policy.
> > > > 
> > > > But given that whether to use KERN_NO_CONSOLES is configurable via e.g. sysctl,
> > > > KERN_NO_CONSOLES will become a user configurable parameter. What's still wrong?
> > > > 
> > > 
> > > Any problems remaining?
> > 
> > printk_get_level / printk_skip_level and the various
> > uses of %pV using printk_get_level
> > 
> 
> Excuse me, but what do you mean?
> 
> I wish printk() accepts "loglevel" argument detached from "fmt" argument (e.g.

I think that's a bad idea as it would expand
_every_ use of printk with another argument
and overall code size would increase for very
little value.

And do look at the code and uses of printk_get_level.


