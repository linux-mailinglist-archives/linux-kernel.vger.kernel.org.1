Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A253B1FC0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 23:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729605AbgFPVFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 17:05:31 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:34358 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726804AbgFPVFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 17:05:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 59FFD18029210;
        Tue, 16 Jun 2020 21:05:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:6119:6755:7903:10004:10400:10848:11026:11232:11473:11658:11914:12219:12297:12740:12760:12895:13069:13153:13228:13255:13311:13357:13439:14659:14799:21080:21212:21324:21433:21627:21939:21972:30012:30054:30074:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: act63_4314fc526e02
X-Filterd-Recvd-Size: 2034
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 16 Jun 2020 21:05:29 +0000 (UTC)
Message-ID: <5b0fade06c46da0a469266738c684ba55d8e39f0.camel@perches.com>
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
From:   Joe Perches <joe@perches.com>
To:     Petr Mladek <pmladek@suse.com>, Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux@rasmusvillemoes.dk
Date:   Tue, 16 Jun 2020 14:05:27 -0700
In-Reply-To: <20200616134507.GO31238@alley>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
         <20200613155738.2249399-21-jim.cromie@gmail.com>
         <20200616134507.GO31238@alley>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-16 at 15:45 +0200, Petr Mladek wrote:
> On Sat 2020-06-13 09:57:34, Jim Cromie wrote:
> > There are *lots* of ad-hoc debug printing solutions in kernel,
> > this is a 1st attempt at providing a common mechanism for many of them.
> 
> I agree that it might make sense to provide some common mechanism.
[]
> My problem with this approach is that it is too generic. Each class
> would have different meaning in each subsystem.
> 
> It might help to replace any existing variants. But it would be hard
> for developers debugging the code. They would need to study/remember
> the meaning of these groups for particular subsystems. They would
> need to set different values for different messages.
> 
> Could you please provide more details about the potential users?
> Would be possible to find some common patterns and common
> meaning of the groups?

I doubt the utility of common patterns.
Verbosity is common but groupings are not.

Look at the DRM patterns vs other groups.

$ git grep 'MODULE_PARM_DESC.*debug'


