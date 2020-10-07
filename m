Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31F4E28679F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728197AbgJGSou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 14:44:50 -0400
Received: from smtprelay0111.hostedemail.com ([216.40.44.111]:37170 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727293AbgJGSot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 14:44:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C06281802915B;
        Wed,  7 Oct 2020 18:44:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:5007:7514:10004:10400:11026:11232:11473:11658:11914:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21433:21627:21740:30003:30029:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: edge71_3e0bdaf271d1
X-Filterd-Recvd-Size: 2066
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed,  7 Oct 2020 18:44:47 +0000 (UTC)
Message-ID: <b1f15283f770c71923920fef8fc6c643433d1ef9.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 07 Oct 2020 11:44:46 -0700
In-Reply-To: <CABJPP5B_nscUwm4m+PySN67Cp=i1aR8KXKRuAf2YdAj_950j2Q@mail.gmail.com>
References: <20201007063315.41585-1-dwaipayanray1@gmail.com>
         <CABJPP5AEELQz0t2+34xYQOJ5e5nQzTUUU6UT8ZH0fqm-tacOmg@mail.gmail.com>
         <a2db6d34e964bd5ca65f59d1a536a61df71fc955.camel@perches.com>
         <CABJPP5B_nscUwm4m+PySN67Cp=i1aR8KXKRuAf2YdAj_950j2Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-08 at 00:08 +0530, Dwaipayan Ray wrote:
> On Wed, Oct 7, 2020 at 11:48 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-10-07 at 12:08 +0530, Dwaipayan Ray wrote:
> > > On Wed, Oct 7, 2020 at 12:03 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > > > The author signed-off-by checks are currently very vague.
> > > > Cases like same name or same address are not handled separately.
> > 
> > Likely now, the type should be changed from NO_AUTHOR_SIGN_OFF
> > to a single something else for all the other types of messages.
> > 
> > 
> Since BAD_SIGNOFF is being used for a different context, then
> probably BAD_AUTHOR_SIGNOFF.
>
> Should this work or anything else you have in mind?

That may be a bit too strong a wording as these aren't
significant/bad defects.

Maybe something like FROM_SIGNOFF_MISMATCH.

It's not anything that would reject the patch.

It's a pity type uses both SIGNOFF and SIGN_OFF.


