Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A50722852E3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 22:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgJFUJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 16:09:48 -0400
Received: from smtprelay0160.hostedemail.com ([216.40.44.160]:56374 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725962AbgJFUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 16:09:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5607F100E7B4C;
        Tue,  6 Oct 2020 20:09:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3872:3873:4250:4321:4384:5007:7576:8957:10004:10400:10848:11026:11232:11658:11914:12297:12438:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:14777:21080:21433:21627:21740:21819:21987:30003:30022:30029:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: event64_5d11b9e271c9
X-Filterd-Recvd-Size: 2155
Received: from XPS-9350 (unknown [172.58.35.183])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 20:09:45 +0000 (UTC)
Message-ID: <cd8fb6742e4776a98412278815fc86b568820b6e.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 06 Oct 2020 13:09:42 -0700
In-Reply-To: <CABJPP5Awe=CDC7riYBBVDf9WRO4aAMXK2QROYdtGyJXNjqB-ew@mail.gmail.com>
References: <20201006185114.168358-1-dwaipayanray1@gmail.com>
         <8553d6679f97ae9d285a9ffd61198f5e3c11dc35.camel@perches.com>
         <CABJPP5Awe=CDC7riYBBVDf9WRO4aAMXK2QROYdtGyJXNjqB-ew@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-07 at 00:31 +0530, Dwaipayan Ray wrote:
> On Wed, Oct 7, 2020 at 12:25 AM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-10-07 at 00:21 +0530, Dwaipayan Ray wrote:
> > > The author signed-off-by checks are currently very vague.
> > > Cases like same name or same address are not handled separately.
> > > 
> > > For example, running checkpatch on commit be6577af0cef
> > > ("parisc: Add atomic64_set_release() define to avoid CPU soft lockups"),
> > > gives:
> > 
> > Aren't you still missing emitting an message for cases like
> > 
> > From: "J. Random Developer" <jrd@bigcorp.com>
> > [...]
> > Signed-off-by: "J. Random Developer" (BigCorp) <jrd@bigcorp.com>
> > 
> > Where a comment does not match?
> > 
> > 
> 
> Yes, messages for comments were not emitted previously too
> cause the same_email_address() function just matches name
> and email (discarding name comments and email comments).
> 
> So should I add it to this patch, or should I work on it in a different
> patch perhaps because it involves change on another subroutine?

I suggest adding it to this patch.


