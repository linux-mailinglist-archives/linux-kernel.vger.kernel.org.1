Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3D28DA08
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgJNGjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:39:40 -0400
Received: from smtprelay0198.hostedemail.com ([216.40.44.198]:43246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726147AbgJNGjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:39:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 44E32100E7B48;
        Wed, 14 Oct 2020 06:39:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3870:3871:3872:3873:4321:5007:6120:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13019:13069:13311:13357:13439:14181:14659:14721:21080:21627:30045:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hot32_011615a27209
X-Filterd-Recvd-Size: 1707
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Oct 2020 06:39:38 +0000 (UTC)
Message-ID: <04325089b524f20d3de167051bfb81b05083d8b1.camel@perches.com>
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Ujjwal Kumar <ujjwalkumar0501@gmail.com>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 13 Oct 2020 23:39:36 -0700
In-Reply-To: <alpine.DEB.2.21.2010140829150.6186@felia>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
         <alpine.DEB.2.21.2010140734270.6186@felia>
         <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
         <alpine.DEB.2.21.2010140812370.6186@felia>
         <be7deeec0937327e0ddaadf8468d934ed363a533.camel@perches.com>
         <alpine.DEB.2.21.2010140829150.6186@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-14 at 08:36 +0200, Lukas Bulwahn wrote:
> 
> On Tue, 13 Oct 2020, Joe Perches wrote:
> 
> > On Wed, 2020-10-14 at 08:21 +0200, Lukas Bulwahn wrote:
> > > What does checkpatch.pl warn about and what does clang-format still warn 
> > > about, which is generally accepted okay as style in the kernel?
> > 
> > clang-format doesn't warn at all, it just reformats.
> > 
> You can run clang-format with --dry-run and then it would just state the 
> proposed changes, right?

clang-format through at least version 10 does not have
a --dry-run option.



