Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EA728D9C7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 08:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbgJNGCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 02:02:01 -0400
Received: from smtprelay0222.hostedemail.com ([216.40.44.222]:50432 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725983AbgJNGCB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 02:02:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 810FD180A7FDE;
        Wed, 14 Oct 2020 06:02:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:1963:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6119:6120:6691:7903:8957:10004:10400:10848:11232:11658:11914:12297:12663:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:21939:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: camp63_4004aec27209
X-Filterd-Recvd-Size: 1769
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Wed, 14 Oct 2020 06:01:59 +0000 (UTC)
Message-ID: <316d5a53351d10cd1a26ce0c54883da05642c898.camel@perches.com>
Subject: Re: [RFC PATCH v2] checkpatch: add shebang check to
 EXECUTE_PERMISSIONS
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Ujjwal Kumar <ujjwalkumar0501@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Tue, 13 Oct 2020 23:01:58 -0700
In-Reply-To: <alpine.DEB.2.21.2010140734270.6186@felia>
References: <20201013120129.1304101-1-ujjwalkumar0501@gmail.com>
         <alpine.DEB.2.21.2010140734270.6186@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-14 at 07:46 +0200, Lukas Bulwahn wrote:
> Just one bigger project example: Comparing clang-format suggestions on 
> patches against checkpatch.pl suggestions are fine-tuning both of them to fit to 
> the actual kernel style.

Eek no.

Mindless use of either tool isn't a great thing.

Linux source code has generally be created with
human readability in mind by humans, not scripts.

Please don't try to replace human readable code
with mindless tools.

If there's something inappropriate in checkpatch,
please mention it.

There is a _lot_ of relatively inappropriate
output in how clang-format changes existing code
in the kernel.

Try it and look at the results.

Improving how .clang-format is created and its
mechanisms (for example: continually out of date
ForEachMacros lists) could be reasonably be done.


