Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E32297D27
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 17:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761755AbgJXPdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 11:33:50 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:47662 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1761745AbgJXPdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 11:33:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A98F918029123;
        Sat, 24 Oct 2020 15:33:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3870:3871:3873:3874:4321:5007:6119:7903:10004:10400:10848:11232:11658:11914:12297:12679:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14659:21080:21627:21660:21740:21939:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fan26_0d0677727263
X-Filterd-Recvd-Size: 1998
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 24 Oct 2020 15:33:47 +0000 (UTC)
Message-ID: <5c11f284872f3b2b017d9d27d4075582c1a40eab.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD
 warning
From:   Joe Perches <joe@perches.com>
To:     Aditya <yashsri421@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Date:   Sat, 24 Oct 2020 08:33:46 -0700
In-Reply-To: <c9512657-d7d0-bf04-0e40-b3463c9f5e1b@gmail.com>
References: <20201023133828.19609-1-yashsri421@gmail.com>
         <alpine.DEB.2.21.2010232104150.11676@felia>
         <c9512657-d7d0-bf04-0e40-b3463c9f5e1b@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-24 at 18:54 +0530, Aditya wrote:
> > Would you like to work on 
> > further rules that can be improved with your evaluation approach?
> 
> Yes, I would like work on further rules.

Some generic ideas:

How about working to reduce runtime and complexity by
making the rules extensible or separable at startup.

Maybe move each existing rules into a separate
directory as an individual file and aggregate them at
checkpatch startup.

Maybe look at the existing rules that do not have a
$fix option and add them as appropriate.

You could fix the multiline indentation where the
current warning and fix is only for a single line

	value = function(arg1,
		arg2,
		arg3);

where checkpatch emits only single warning and fix
for the line with arg2, but not the line with arg3);

Maybe try to make the coding styles supported more
flexible:

Allow braces in different places, support different
tab indentation sizes, spacing rules around operators,
function definition layouts, etc.



