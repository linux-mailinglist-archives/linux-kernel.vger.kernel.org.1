Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7BB296272
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901586AbgJVQOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:14:50 -0400
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:34006 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2901579AbgJVQOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:14:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 27835180A8459;
        Thu, 22 Oct 2020 16:14:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:3872:3873:3874:4321:5007:7514:8603:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12663:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21627:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: plant29_570b19927252
X-Filterd-Recvd-Size: 1688
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 22 Oct 2020 16:14:47 +0000 (UTC)
Message-ID: <3b706950110fe35c566dd00b684dc426867261e5.camel@perches.com>
Subject: Re: [PATCH RFC] checkpatch: extend attributes check to handle more
 patterns
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Thu, 22 Oct 2020 09:14:45 -0700
In-Reply-To: <CABJPP5AQwRkT_2FozYxgTgUZ2RWS=k1TNN_QOvs6F5se-V-6ow@mail.gmail.com>
References: <20201022145224.645538-1-dwaipayanray1@gmail.com>
         <CABJPP5AQwRkT_2FozYxgTgUZ2RWS=k1TNN_QOvs6F5se-V-6ow@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-22 at 20:29 +0530, Dwaipayan Ray wrote:
> On Thu, Oct 22, 2020 at 8:22 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > It is generally preferred that the macros from
> > include/linux/compiler_attributes.h are used, unless there
> > is a reason not to.
[]
> I am a bit worried about the code size though. Is it better altogether
> to have a shared function for parameterized/non parameterized
> __attribute__ arguments? Might have to categorize the macros then.
> 
> What do you think is better?

I think A single shared mechanism better and more extensible.

Renaming all the code types from PREFER_<FOO> to something else
like PREFER_DEFINED_ATTRIBUTE_MACRO would be OK.


