Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF39C2CC7ED
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgLBUhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:37:40 -0500
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:42372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgLBUhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:37:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 92772180A9F37;
        Wed,  2 Dec 2020 20:36:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3868:3871:4321:5007:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12679:12740:12760:12895:13069:13095:13255:13311:13357:13439:14659:21080:21433:21451:21627:21660:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: net61_25040e9273b6
X-Filterd-Recvd-Size: 1890
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Dec 2020 20:36:58 +0000 (UTC)
Message-ID: <0ae44ac0611db460faebda5380661f3b8cb80630.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add warning for lines starting with a
 '#' in commit log
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Wed, 02 Dec 2020 12:36:57 -0800
In-Reply-To: <20201202202229.120898-1-dwaipayanray1@gmail.com>
References: <20201202202229.120898-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 01:52 +0530, Dwaipayan Ray wrote:
> Commit log lines starting with a '#' can be dropped by git if
> the corresponding commit message is reworded by a maintainer.
> This minor error can be easily avoided if checkpatch warns
> for the same.

This makes no sense to me.

How about:

Commit log lines starting with # are dropped by git as comments so
emit a warning for these comment lines.

Add a --fix option to insert a space before leading # comments

> +# Check for lines starting with a #
> +		if ($in_commit_log && $line =~ /^#/) {
> +			if (WARN("COMMIT_COMMENT_SYMBOL",
> +				 "Commit log lines starting with a '#' will be dropped by git as a comment\n" . $herecurr) &&

Perhaps:

				 "Commit log lines starting with '#' are dropped by git as comments\n" . $herecurr) &&

> +			    $fix) {
> +				$fixed[$fixlinenr] =~ s/^#/\t#/;

I suggest using a space char and not a tab to avoid excess indentation.

				$fixed[$fixlinenr] =~ s/^/ /;


