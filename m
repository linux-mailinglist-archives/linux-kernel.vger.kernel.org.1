Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EC0298090
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 07:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1767608AbgJYGG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 02:06:57 -0400
Received: from smtprelay0014.hostedemail.com ([216.40.44.14]:48612 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1767601AbgJYGG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 02:06:56 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A1F3F181D341E;
        Sun, 25 Oct 2020 06:06:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3868:3871:3874:4250:4321:5007:7974:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21325:21627:21660:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: page69_21078c427268
X-Filterd-Recvd-Size: 1451
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 25 Oct 2020 06:06:54 +0000 (UTC)
Message-ID: <252e2adc7ae9e2886171189f1421e2fe3c33629a.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: fix false positives in REPEATED_WORD
 warning
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Aditya <yashsri421@gmail.com>, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Date:   Sat, 24 Oct 2020 23:06:53 -0700
In-Reply-To: <alpine.DEB.2.21.2010250627370.6697@felia>
References: <20201023133828.19609-1-yashsri421@gmail.com>
         <alpine.DEB.2.21.2010232104150.11676@felia>
         <c9512657-d7d0-bf04-0e40-b3463c9f5e1b@gmail.com>
         <5c11f284872f3b2b017d9d27d4075582c1a40eab.camel@perches.com>
         <alpine.DEB.2.21.2010250627370.6697@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-25 at 06:51 +0100, Lukas Bulwahn wrote:
> We can identify a set of rules and clear automatic fixes that
> maintainers can simply run this script over the patches they pick
> up when they pick them up.

checkpatch --fix-inplace does that now.

But realistically, this is more an interactive bit that IMO
should be a separate script on top of checkpatch.


