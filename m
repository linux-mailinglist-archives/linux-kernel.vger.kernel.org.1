Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B7927761C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 18:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgIXQBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 12:01:25 -0400
Received: from smtprelay0040.hostedemail.com ([216.40.44.40]:49926 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728381AbgIXQBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 12:01:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1629A18029140;
        Thu, 24 Sep 2020 16:01:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3868:3870:3871:3872:3874:4321:5007:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21063:21080:21451:21611:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: sign82_1c0725327160
X-Filterd-Recvd-Size: 1336
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 24 Sep 2020 16:01:22 +0000 (UTC)
Message-ID: <062568971307793dcc80337f85545c4765241933.camel@perches.com>
Subject: Re: [PATCH] sound/soc/codecs: fix spelling typo in comments
From:   Joe Perches <joe@perches.com>
To:     Mark Brown <broonie@kernel.org>, Wang Qing <wangqing@vivo.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Sep 2020 09:01:21 -0700
In-Reply-To: <20200924123346.GE4754@sirena.org.uk>
References: <1600929860-28862-1-git-send-email-wangqing@vivo.com>
         <20200924123346.GE4754@sirena.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-24 at 13:33 +0100, Mark Brown wrote:
> On Thu, Sep 24, 2020 at 02:43:59PM +0800, Wang Qing wrote:
> > Modify the comment typo: "compliment" -> "complement".
> 
> These are both English words,

with rather different meanings.

> and compliment appears to be the one that
> is used in the datasheet for this part... 

It's difficult to fix datasheet typos.


