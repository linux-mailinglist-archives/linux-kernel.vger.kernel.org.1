Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2272CAD44
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392456AbgLAUZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:25:55 -0500
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:56378 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389343AbgLAUZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:25:54 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 94328180A8123;
        Tue,  1 Dec 2020 20:25:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:2895:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3872:3873:4321:4362:5007:6119:7904:8531:9545:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12740:12895:13069:13311:13357:13439:13894:14180:14181:14659:14721:21080:21221:21451:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: touch68_2b14747273ad
X-Filterd-Recvd-Size: 2075
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  1 Dec 2020 20:25:12 +0000 (UTC)
Message-ID: <09c24ef1aa2f1c4fe909d76f5426f08780b9d81c.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: fix TYPO_SPELLING check for words with
 apostrophe
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Tue, 01 Dec 2020 12:25:11 -0800
In-Reply-To: <7f29e46d73c0b12ce53e659f0bcd3ec194522f2e.camel@perches.com>
References: <20201201190729.169733-1-dwaipayanray1@gmail.com>
         <7f29e46d73c0b12ce53e659f0bcd3ec194522f2e.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 11:32 -0800, Joe Perches wrote:
> On Wed, 2020-12-02 at 00:37 +0530, Dwaipayan Ray wrote:
> > checkpatch reports a false TYPO_SPELLING warning for some words
> > containing an apostrophe when run with --codespell option.

Hey Andrew.  If Dwaipayan doesn't mind, can you update this
when you apply it to extend the length of the caret printed?

> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> > @@ -3106,15 +3106,18 @@ sub process {
> >  # Check for various typo / spelling mistakes
> >  		if (defined($misspellings) &&
> >  		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> > -			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> > +			while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
> >  				my $typo = $1;
> > +				my $blank = copy_spacing($rawline);
> > +				my $ptr = substr($blank, 0, $-[1]) . "^";

Changing this to:

				my $ptr = substr($blank, 0, $-[1]) . "^" x length($typo);

makes the matched misspelling more obvious

Thanks, Joe

