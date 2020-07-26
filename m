Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8683622E168
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jul 2020 18:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGZQmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jul 2020 12:42:10 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:33386 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726117AbgGZQmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 12:42:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 34F57837F24A;
        Sun, 26 Jul 2020 16:42:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2689:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:6248:7903:8957:10004:10400:10848:10967:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14039:14096:14097:14181:14659:14721:14777:21080:21433:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:16,LUA_SUMMARY:none
X-HE-Tag: bait17_2e011d426f5a
X-Filterd-Recvd-Size: 1933
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun, 26 Jul 2020 16:42:07 +0000 (UTC)
Message-ID: <5f5679b4c76bf0e16064f3a45319bc35938ad96b.camel@perches.com>
Subject: Re: Re: Re: Re: Re: checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        SeongJae Park <sjpark@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, apw@canonical.com,
        colin.king@canonical.com, jslaby@suse.cz, pavel@ucw.cz,
        SeongJae Park <sjpark@amazon.de>
Date:   Sun, 26 Jul 2020 09:42:06 -0700
In-Reply-To: <20200726153601.13855-1-sj38.park@gmail.com>
References: <20200726153601.13855-1-sj38.park@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-07-26 at 17:36 +0200, SeongJae Park wrote:
> On Sun, 26 Jul 2020 07:50:54 -0700 Joe Perches <joe@perches.com> wrote:
[]
> > I do not want to encourage relatively inexperienced people
> > to run checkpatch and submit inappropriate patches.
> 
> Me, neither.  But, I think providing more warnings and references is better for
> that.

Unfortunately, the inexperienced _do_ in fact run
checkpatch on files and submit inappropriate patches.

It's generally a time sink for the experienced
maintainers to reply.

> Simply limiting checks could allow people submitting inappropriate patches
> intorducing new uses of deprecated terms.

Tradeoffs...

I expect that patches being reviewed by maintainers
are preferred over files being inappropriately changed
by the inexperienced.

Those inappropriate changes should not be encouraged
by tools placed in the hands of the inexperienced.


