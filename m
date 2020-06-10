Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5F31F4EAA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 09:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgFJHNq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 03:13:46 -0400
Received: from smtprelay0218.hostedemail.com ([216.40.44.218]:46140 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbgFJHNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 03:13:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 76A34181D3762;
        Wed, 10 Jun 2020 07:13:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7576:7807:7875:8957:9010:10004:10400:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30012:30054:30064:30070:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brain48_4312e6726dc9
X-Filterd-Recvd-Size: 2457
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 07:13:44 +0000 (UTC)
Message-ID: <016a2c771e5535a872b9f20d90e4cc5683ea7a55.camel@perches.com>
Subject: Re: [PATCH v3 1/2] checkpatch: support deprecated terms checking
From:   Joe Perches <joe@perches.com>
To:     SeongJae Park <sjpark@amazon.com>, akpm@linux-foundation.org,
        apw@canonical.com
Cc:     colin.king@canonical.com, sj38.park@gmail.com,
        linux-kernel@vger.kernel.org, SeongJae Park <sjpark@amazon.de>
Date:   Wed, 10 Jun 2020 00:13:42 -0700
In-Reply-To: <20200610065223.29894-2-sjpark@amazon.com>
References: <20200610065223.29894-1-sjpark@amazon.com>
         <20200610065223.29894-2-sjpark@amazon.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 08:52 +0200, SeongJae Park wrote:
> From: SeongJae Park <sjpark@amazon.de>
> 
> Some terms could be deprecated for various reasons, but it is hard to
> update the entire old usages.  That said, we could at least encourage
> new patches to use the suggested replacements.  This commit adds check
> of deprecated terms in the 'checkpatch.pl' for that.  The script will
> get deprecated terms and suggested replacements of those from
> 'scripts/deprecated_terms.txt' file and warn if the deprecated terms are
> used.  The mechanism and the format of the file are almost the same as
> that of 'spelling.txt'.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +# Load deprecated terms and build regular expression list.
> +my $deprecated_terms;
> +my %deprecated_terms_fix;
> +
> +if (open(my $deprecates, '<', $deprecated_terms_file)) {
> +	while (<$deprecates>) {
> +		my $line = $_;
> +
> +		$line =~ s/\s*\n?$//g;
> +		$line =~ s/^\s*//g;
> +
> +		next if ($line =~ m/^\s*#/);
> +		next if ($line =~ m/^\s*$/);
> +
> +		my ($suspect, $fix) = split(/\|\|/, $line);
> +
> +		$deprecated_terms_fix{$suspect} = $fix;
> +	}
> +	close($deprecates);
> +} else {
> +	warn "No deprecated term will be found - file '$deprecated_terms_file': $!\n";
> +}
> +
> +$deprecated_terms = join("|", sort keys %deprecated_terms_fix) if keys %deprecated_terms_fix;
> +

This is a direct copy of the spelling dictionary
loading code, so maybe these could be consolidated.


