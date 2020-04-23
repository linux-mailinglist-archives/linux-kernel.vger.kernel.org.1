Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8D91B6620
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Apr 2020 23:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgDWVYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Apr 2020 17:24:22 -0400
Received: from smtprelay0235.hostedemail.com ([216.40.44.235]:35206 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbgDWVYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 17:24:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 99358180286C8;
        Thu, 23 Apr 2020 21:24:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:968:981:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3871:3872:3873:3874:4321:5007:6119:7903:9389:10004:10400:10848:11232:11658:11914:12296:12297:12679:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21433:21451:21627:21740:21939:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: boy57_8a90577b1303
X-Filterd-Recvd-Size: 2656
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 23 Apr 2020 21:24:19 +0000 (UTC)
Message-ID: <572b03bdc3eed286c5ed20887d42f674bd93336e.camel@perches.com>
Subject: Re: linux-kernel: Unused static inline functions
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Dan Carpenter <error27@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Greg KH <gregkh@linuxfoundation.org>
Date:   Thu, 23 Apr 2020 14:22:01 -0700
In-Reply-To: <CAKwvOdnW-xvSnT3RS8MWufyp+3=NM-Mb+bv0r2u2soNnyVvXBg@mail.gmail.com>
References: <1583509304-28508-1-git-send-email-cai@lca.pw>
         <CAKwvOd=V44ksbiffN5UYw-oVfTK_wdeP59ipWANkOUS_zavxew@mail.gmail.com>
         <a7503afc9d561ae9c7116b97c7a960d7ad5cbff9.camel@perches.com>
         <442b7ace85a414c6a01040368f05d6d219f86536.camel@perches.com>
         <CAKwvOdmdaDL4bhJc+7Xms=f4YXDw-Rr+WQAknd0Jv6UWOBUcEA@mail.gmail.com>
         <4603e761a5f39f4d97375e1e08d20d720c526341.camel@perches.com>
         <CAKwvOdnW-xvSnT3RS8MWufyp+3=NM-Mb+bv0r2u2soNnyVvXBg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(adding Julia Lawall and Dan Carpenter who may have ideas too)

On Thu, 2020-04-23 at 11:57 -0700, Nick Desaulniers wrote:
> I've been mulling over teaching a class internally at Google on
> getting started contributing to the Linux kernel.  I think this idea
> (removing dead static inline functions) is perfect for having lots of
> small little tasks that are clear wins.  Do you have any other ideas
> for work that there's a lot of?  Like lots of small little bite sized
> tasks?  Maybe more fallthrough conversion? Anything else?

Some generic ideas:

o look for always unused/unreferenced, or always static
  value function arguments and remove them

o int function returns constrained to 0 or 1 could be
  converted to bool.

And some logging ideas:

o printk to tracing conversions

o removal of printks used just for function tracing
  as ftrace works well

o pr_<level> macro conversions to functions to save
  object space

o singletons for pr_fmt

o default use of #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
  and removal of the ~1200 current defines treewide

> Happy to have folks use your script and add your suggested by tag.

Suggested-by doesn't have much value to me,
especially for scripted stuff.

I'd be happy enough that it gets done eventually.

