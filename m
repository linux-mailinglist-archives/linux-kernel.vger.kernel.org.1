Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA341C8186
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 07:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgEGFaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 01:30:22 -0400
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:45214 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgEGFaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 01:30:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 5006C801BB77;
        Thu,  7 May 2020 05:30:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2525:2561:2564:2682:2685:2691:2693:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:6691:7903:8603:9025:9391:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12438:12533:12555:12663:12740:12760:12895:12986:13069:13075:13146:13230:13311:13357:13439:14093:14096:14097:14181:14659:14721:14777:21080:21433:21611:21627:21740:21795:21819:21990:30012:30051:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: stone12_3cf6bbc82ed17
X-Filterd-Recvd-Size: 3335
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 05:30:18 +0000 (UTC)
Message-ID: <16aacc2a1ac272da356b778217406288abb7377e.camel@perches.com>
Subject: Re: [PATCH] printk: Add loglevel for "do not print to consoles".
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>,
        Michal Hocko <mhocko@suse.com>,
        Yafang Shao <laoar.shao@gmail.com>
Date:   Wed, 06 May 2020 22:30:17 -0700
In-Reply-To: <36db0dfe-9d7e-0616-cbe6-4bfb99a1f470@i-love.sakura.ne.jp>
References: <20200424024239.63607-1-penguin-kernel@I-love.SAKURA.ne.jp>
         <20200425004609.GE8982@jagdpanzerIV.localdomain>
         <842ff40b-a232-6098-4333-996a3033b30a@i-love.sakura.ne.jp>
         <20200427062117.GC486@jagdpanzerIV.localdomain>
         <4dae86af-1d9a-f5a8-cff6-aa91ec038a79@i-love.sakura.ne.jp>
         <344199f1-639b-ee93-2388-57b0549641f9@i-love.sakura.ne.jp>
         <dfe10cb0359c37dff46c93dfacf909dd33b2593f.camel@perches.com>
         <0d513c80-8c8e-17b6-5b9c-73c7bca77252@i-love.sakura.ne.jp>
         <63f58a1c334d8d44ddf1788091be9b2232054b03.camel@perches.com>
         <36db0dfe-9d7e-0616-cbe6-4bfb99a1f470@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 14:13 +0900, Tetsuo Handa wrote:
> On 2020/05/07 10:02, Joe Perches wrote:
> > > > printk_get_level / printk_skip_level and the various
> > > > uses of %pV using printk_get_level
> > > > 
> > > 
> > > Excuse me, but what do you mean?
> > > 
> > > I wish printk() accepts "loglevel" argument detached from "fmt" argument (e.g.
> > 
> > I think that's a bad idea as it would expand
> > _every_ use of printk with another argument
> > and overall code size would increase for very
> > little value.
> 
> I'm not saying that we should add loglevel argument to all printk() callers.
> I'm saying that we could add a variant of printk() which accepts loglevel
> argument (say, e.g. printkl() and vprintkl()).
> 
> I think that some of printk_get_level() users are using printk_get_level() only
> for detaching loglevel argument from fmt argument.

I believe wrote all of those.

> I don't know how the lockless logbuf will replace printk_safe_flush_buffer(). But I guess
> it is possible to avoid printk_safe_flush_buffer() and printk_skip_level() as demonstrated
> by https://lkml.kernel.org/r/5e192ca2-3b24-0b45-fc13-51feec43c216@i-love.sakura.ne.jp .
> 
> Then, printk_skip_headers() will be the only user of printk_skip_level(). I don't know how
> vkdb_printf() works, but vkdb_printf() is currently using printk_skip_level() in order to
> remove loglevel argument. We can avoid printk_skip_level() if loglevel argument is detached
>  from fmt argument.

a vprintk_emit variant would probably do.

I proposed awhile back making functions for pr_<level>
https://lore.kernel.org/lkml/1466739971-30399-1-git-send-email-joe@perches.com/

Maybe it's time for that and something appropriate
like it for your next use too.


