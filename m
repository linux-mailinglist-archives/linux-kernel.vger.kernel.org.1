Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FF8528E67C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 20:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388824AbgJNSf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 14:35:29 -0400
Received: from smtprelay0100.hostedemail.com ([216.40.44.100]:48380 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388112AbgJNSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 14:35:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id E8CC6702;
        Wed, 14 Oct 2020 18:35:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3871:3872:3873:3874:4184:4321:4605:5007:7903:8603:10004:10400:10848:11232:11658:11914:12296:12297:12663:12740:12760:12895:13069:13311:13357:13439:14093:14097:14180:14181:14659:14721:21060:21080:21221:21627:21740:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: paper27_54145cd2720e
X-Filterd-Recvd-Size: 2366
Received: from XPS-9350 (cpe-72-134-80-165.natsow.res.rr.com [72.134.80.165])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Oct 2020 18:35:26 +0000 (UTC)
Message-ID: <7d8c7d80aa7b0524cca49a6dfe24e878bea6ab12.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add new exception to repeated word check
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Wed, 14 Oct 2020 11:35:25 -0700
In-Reply-To: <CABJPP5DrSL7GoZUWc7P02CfLHfTBmfpLxrVOVQ08KH3pPontoA@mail.gmail.com>
References: <20201014163738.117332-1-dwaipayanray1@gmail.com>
         <ea011df1e30ce445d51e128287e2c6c38de20949.camel@perches.com>
         <CABJPP5DrSL7GoZUWc7P02CfLHfTBmfpLxrVOVQ08KH3pPontoA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-14 at 23:42 +0530, Dwaipayan Ray wrote:
> On Wed, Oct 14, 2020 at 11:33 PM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-10-14 at 22:07 +0530, Dwaipayan Ray wrote:
> > > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > > moved the repeated word test to check for more file types. But after
> > > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > > new warnings of the type:
> > 
> > Perhaps instead of adding more content checks so that
> > word boundaries are not something like \S but also
> > not punctuation so that content like
> > 
> >         git git://
> >         @size size
> > 
> > does not match?
> > 
> > 
> Hi,
> So currently the words are trimmed of non alphabets before the check:
> 
> while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
> my $first = $1;
> my $second = $2;
> 
> where, the word_pattern is:
> my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';

I'm familiar.

> So do you perhaps recommend modifying this word pattern to
> include the punctuation as well rather than trimming them off?

Not really, perhaps use the capture group position
markers @- @+ or $-[1] $+[1] and $-[2] $+[2] with the
substr could be used to see what characters are
before and after the word matches.
> 
> Thanks,
> Dwaipayan.

