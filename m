Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7948E1E3274
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 00:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390562AbgEZW1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 18:27:22 -0400
Received: from smtprelay0004.hostedemail.com ([216.40.44.4]:34966 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389382AbgEZW1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:27:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 43B8718029139;
        Tue, 26 May 2020 22:27:21 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:560:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2692:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7901:7903:7974:10004:10400:10848:11232:11658:11914:12048:12296:12297:12663:12740:12760:12895:13069:13072:13076:13255:13311:13357:13439:14659:14721:14777:21080:21324:21325:21433:21627:21660:21819:30003:30022:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:52,LUA_SUMMARY:none
X-HE-Tag: rain73_061635826d4d
X-Filterd-Recvd-Size: 1963
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 May 2020 22:27:19 +0000 (UTC)
Message-ID: <b0854ec2906323d34514875a58a79d4cb74e44b0.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, mchehab+huawei@kernel.org,
        davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 26 May 2020 15:27:18 -0700
In-Reply-To: <661f53a3-b15c-76b0-f220-0d292b0843d5@linuxfoundation.org>
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
         <7366c990d4352e093ff7d17953079d7f0420c3a9.camel@perches.com>
         <661f53a3-b15c-76b0-f220-0d292b0843d5@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-26 at 11:04 -0600, Shuah Khan wrote:
> On 5/22/20 8:26 PM, Joe Perches wrote:
> > On Fri, 2020-05-22 at 20:19 -0600, Shuah Khan wrote:
> > > get_maintainer.pl picks only the first email address found in the file.
> > > Reorder my email addresses so it finds my linuxfoundation.org email.
> > 
> > OK.
[]
> Sadly, people that don't run get_maintainer.pl, leave alone running it
> with --noremove-duplicates option. So your suggestion doesn't really
> help me.
> 
> My preference is to get patches to both Inboxes if possible which isn't
> possible unless -noremove-duplicate is default. Having this option as
> default probably will annoy lot of people . So I am not asking for
> that.
> 
> That being said, I don't understand your comment. Are you recommending
> using just one email in these entries?

Yes.  And maybe set an autoforward rule in that email to
forward the received email to your other address.


