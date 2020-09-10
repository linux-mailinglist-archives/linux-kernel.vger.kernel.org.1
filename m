Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970622648DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 17:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbgIJPfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 11:35:33 -0400
Received: from smtprelay0026.hostedemail.com ([216.40.44.26]:60906 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731335AbgIJPdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:33:49 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 07CE118353A5E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 14:43:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 41FA812FD;
        Thu, 10 Sep 2020 14:42:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3867:3871:3874:4321:5007:7903:10004:10400:10848:11232:11658:11914:12050:12297:12533:12740:12760:12895:13019:13069:13160:13229:13311:13357:13439:14659:14721:14777:21080:21451:21627:30026:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bomb99_3c0c88c270e6
X-Filterd-Recvd-Size: 1556
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Thu, 10 Sep 2020 14:42:34 +0000 (UTC)
Message-ID: <73afd93d520c15edd00b7729e12f578028f8913e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: accept longer commit description lines
From:   Joe Perches <joe@perches.com>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Thu, 10 Sep 2020 07:42:33 -0700
In-Reply-To: <20200910143208.3837-1-penguin-kernel@I-love.SAKURA.ne.jp>
References: <20200910143208.3837-1-penguin-kernel@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-10 at 23:32 +0900, Tetsuo Handa wrote:
> Given that commit bdc48fa11e46f867 ("checkpatch/coding-style: deprecate
> 80-column warning") was introduced because nowadays most of us are using
> screens that can print more than 100 columns, most of us will be also
> using mail clients that can print more than 100 columns. Since 75 chars
> limit for commit description lines is sometimes inconvenient for obeying
> 'commit <12+ chars of sha1> ("<title line>")' style or embedding URLs,
> loosen the limit by 20 chars.

My inclination ks to say thanks, but no thanks.

My standard terminal window is a different width than
my standard editing window.



