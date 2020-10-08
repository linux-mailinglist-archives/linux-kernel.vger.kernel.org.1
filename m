Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51469287484
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 14:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730130AbgJHMst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 08:48:49 -0400
Received: from smtprelay0207.hostedemail.com ([216.40.44.207]:53024 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729769AbgJHMst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 08:48:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 3AD37182CF66A;
        Thu,  8 Oct 2020 12:48:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:969:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3874:4321:5007:10004:10400:10848:11026:11232:11658:11914:12296:12297:12740:12760:12895:13019:13069:13311:13357:13439:14181:14659:14721:21067:21080:21627:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: knee22_4611952271d8
X-Filterd-Recvd-Size: 1565
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu,  8 Oct 2020 12:48:47 +0000 (UTC)
Message-ID: <b6cd81b936671a8868fe98536d7c80771bdfd61c.camel@perches.com>
Subject: Re: checkpatch.pl: REPEATED_WORD: massive false positive in
 MAINTAINERS
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 08 Oct 2020 05:48:46 -0700
In-Reply-To: <alpine.DEB.2.21.2010081247510.19461@felia>
References: <alpine.DEB.2.21.2010081247510.19461@felia>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-08 at 13:50 +0200, Lukas Bulwahn wrote:
> Dear Joe, dear Dwaipayan,
> 
> while maintaining MAINTAINERS, I noticed that the REPEATED_WORD check, 
> which in general is a great addition to checkpatch.pl, generates a massive
> number of warnings due to one specific pattern in the MAINTAINERS file:

I didn't actually check if there were many
new false positives, but
clearly that's one.

Maybe exclude the MAINTAINERS file?

-		if ($rawline =~ /^\+/ || $in_commit_log) {
+		if (($rawline =~ /^\+/ || $in_commit_log) && $realfile ne "MAINTAINERS") {

Maybe add git to the check for "long long"?

-				next if ($first eq 'long');
+				next if ($first =~ /^(?:long|git)$/);



