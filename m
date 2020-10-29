Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10CDF29F04B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 16:42:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgJ2Pmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 11:42:38 -0400
Received: from smtprelay0181.hostedemail.com ([216.40.44.181]:52732 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727972AbgJ2Pmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 11:42:37 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id DFFDC180192CC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 15:42:13 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5B19E100E7B4B;
        Thu, 29 Oct 2020 15:41:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3873:3874:4321:5007:7514:9010:10004:10400:10848:10967:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: sleep71_340bb932728e
X-Filterd-Recvd-Size: 1560
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Oct 2020 15:41:12 +0000 (UTC)
Message-ID: <f998d7857bd6b51d2ca1d1b4f873efe95c9af11d.camel@perches.com>
Subject: Re: False positive from checkscript: git git://...
From:   Joe Perches <joe@perches.com>
To:     Jean Delvare <jdelvare@suse.de>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 29 Oct 2020 08:41:11 -0700
In-Reply-To: <20201029161144.3c7a4fb1@endymion>
References: <20201029143205.197ff58f@endymion>
         <24f8766403f881d4f56a9b721f29b6ee5d1173e2.camel@perches.com>
         <20201029161144.3c7a4fb1@endymion>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-29 at 16:11 +0100, Jean Delvare wrote:
> On Thu, 29 Oct 2020 07:55:25 -0700, Joe Perches wrote:
> > On Thu, 2020-10-29 at 14:32 +0100, Jean Delvare wrote:
> > > WARNING: Possible repeated word: 'git'
> > > #20: FILE: MAINTAINERS:5289:
> > > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-next
> > > 
> > > Obviously that's going to happen a lot as this is actually the proper
> > > way to list a git tree in that file. Could you please add an exception
> > > for that case?
> > 
> > Already done in -next
> 
> Perfect, thank you very much. 

Actually thanks to Dwaipayan Ray <dwaipayanray1@gmail.com>

