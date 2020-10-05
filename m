Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5E48283E3B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 20:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgJESXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 14:23:31 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:57194 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725960AbgJESXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 14:23:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id A95871822384E;
        Mon,  5 Oct 2020 18:23:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:4321:5007:6119:7576:7903:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:14777:21080:21221:21433:21451:21627:21819:30003:30012:30022:30026:30029:30030:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: air50_3900439271c0
X-Filterd-Recvd-Size: 1946
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Oct 2020 18:23:29 +0000 (UTC)
Message-ID: <14c9d8808feabe987e7fdac867d21ff88561011a.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Mon, 05 Oct 2020 11:23:28 -0700
In-Reply-To: <20201005173933.171074-1-dwaipayanray1@gmail.com>
References: <20201005173933.171074-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-05 at 23:09 +0530, Dwaipayan Ray wrote:
> The author signed-off-by checks are currently very vague.
> Cases like same name or same address are not handled separately.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +						if ($address1 =~ /(\S+)\+\S+(\@.*)/) {
> +							$address1 = $1.$2;

More common in this code is "$1" . "$2" not $1.$2

> @@ -6891,9 +6917,29 @@ sub process {
[]
> +			# 4 -> names match, addresses excuding mail extensions (subaddresses) match

excluding

perhaps "subaddress detail" instead of "mail extensions (subaddresses)"

And maybe add "from RFC 5233"

> +
> +			my $sob_msg = "'From: $author' != 'Signed-off-by: $author_sob'";
> +
> +			if ($authorsignoff == 0) {
> +				WARN("NO_AUTHOR_SIGN_OFF",
> +				     "Missing Signed-off-by: line by nominal patch author '$author'\n");
> +			} elsif ($authorsignoff == 2) {
> +				WARN("NO_AUTHOR_SIGN_OFF",
> +				     "From:/Signed-off-by: email name mismatch:\n$sob_msg\n");


Still no need for a newline to separate the output message.


