Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B407277697
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgIXQWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:22:51 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:54400 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgIXQWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:22:51 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 751451801BE9B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 16:22:50 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B7B91837F24A;
        Thu, 24 Sep 2020 16:22:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2194:2199:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3870:3871:3872:3874:4321:5007:9108:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:21063:21080:21324:21451:21627:21939:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: light80_3401d5827160
X-Filterd-Recvd-Size: 1814
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Sep 2020 16:22:48 +0000 (UTC)
Message-ID: <0029e913324f9a8cfc7f90c8798cad6373d02d30.camel@perches.com>
Subject: Re: [PATCH] sound/soc/codecs: fix spelling typo in comments
From:   Joe Perches <joe@perches.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Wang Qing <wangqing@vivo.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Sep 2020 09:22:47 -0700
In-Reply-To: <20200924161249.GG4754@sirena.org.uk>
References: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
         <20200924123346.GE4754@sirena.org.uk>
         <062568971307793dcc80337f85545c4765241933.camel@perches.com>
         <20200924161249.GG4754@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-24 at 17:12 +0100, Mark Brown wrote:
> On Thu, Sep 24, 2020 at 09:01:21AM -0700, Joe Perches wrote:
> > On Thu, 2020-09-24 at 13:33 +0100, Mark Brown wrote:
> > > and compliment appears to be the one that
> > > is used in the datasheet for this part... 
> > It's difficult to fix datasheet typos.
> 
> Right, and if we search for the thing in the datasheet we should find
> the thing in the datasheet so it's best to follow the datsheet even if
> we don't think it's correct.

That's one opinion.

Another would be to use the correct word and
if necessary add some comment showing that the
datasheet writer didn't open a dictionary.

	complement (sic: compliment)

I don't believe that's necessary, but opinions
vary.


