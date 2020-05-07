Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890CF1C9873
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 19:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbgEGRzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 May 2020 13:55:38 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:42220 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:55:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8625B180184E5;
        Thu,  7 May 2020 17:55:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6119:7903:7974:10004:10400:10848:10967:11232:11658:11914:12114:12297:12663:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21325:21627:21990:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: army02_139717869533e
X-Filterd-Recvd-Size: 2081
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 17:55:34 +0000 (UTC)
Message-ID: <f0e6f50e910238366b1d8f398c91d3066baac7cf.camel@perches.com>
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Date:   Thu, 07 May 2020 10:55:33 -0700
In-Reply-To: <20200507133024.18dbe349@gandalf.local.home>
References: <20200507110625.37254-1-yanaijie@huawei.com>
         <jhjpnbg6lkf.mognet@arm.com> <20200507132828.1af39b80@gandalf.local.home>
         <20200507133024.18dbe349@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 13:30 -0400, Steven Rostedt wrote:
> On Thu, 7 May 2020 13:28:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > It's perfectly safe to return 0/1 in a boolean function; that said seeing
> > > as this is the second attempt at "fixing" this I'm tempted to say we should
> > > pick it up...
> > >   
> > 
> > Actually, I disagree. We should push back on the check to not warn on 0/1
> > of boolean. Why is this a warning?
> 
> If anything, we can teach people to try to understand their fixes, to see
> if something is really a fix or not. Blindly accepting changes like this,
> is no different than blindly submitting patches because some tool says its
> an issue.

<shrug>

Most people seem to prefer bool returns with apparent bool constants
even though true and false are enumerator constants (int) of 1 and 0
in the kernel.

from include/linux/stddef.h:

enum {
	false	= 0,
	true	= 1
};


