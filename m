Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC6283177
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 10:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgJEIFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 04:05:52 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:34992 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725898AbgJEIFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 04:05:52 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5F708182CF668;
        Mon,  5 Oct 2020 08:05:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2689:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3874:4321:5007:7576:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13019:13069:13161:13229:13311:13357:13439:14181:14659:14721:14777:21080:21627:30003:30026:30029:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bite38_220bb4e271bc
X-Filterd-Recvd-Size: 1817
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Oct 2020 08:05:50 +0000 (UTC)
Message-ID: <c51588b4e8a2096c1453070b983da5ce8617a622.camel@perches.com>
Subject: Re: [PATCH RFC] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 05 Oct 2020 01:05:49 -0700
In-Reply-To: <CABJPP5BwVmWiFcxHKdCYnN_mOE1G=eHUDq8yqqHFaO3cYhp+oA@mail.gmail.com>
References: <20201005064842.33495-1-dwaipayanray1@gmail.com>
         <a5cba9bb723626091f8790c794efe8de4ab184b8.camel@perches.com>
         <CABJPP5BwVmWiFcxHKdCYnN_mOE1G=eHUDq8yqqHFaO3cYhp+oA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-05 at 13:10 +0530, Dwaipayan Ray wrote:
> On Mon, Oct 5, 2020 at 12:48 PM Joe Perches <joe@perches.com> wrote:
> > On Mon, 2020-10-05 at 12:18 +0530, Dwaipayan Ray wrote:
> > > The author signed-off-by checks are currently very vague.
> > > Cases like same name or same address are not handled separately.
[]
> > And for mismatches, it's really not known that
> > it should be one way or the or the other is it?
> > 
> 
> I think that's true. But since the mail in the
> From: part is the one which with others are being
> compared, I think maybe it should have the higher
> priority, and be treated as the expected one.

I rather expect it to be the other way around.

The Signed-off-by: line should be authoritative
as that is what is put in the commit log.



