Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D482AAD4D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 20:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgKHT5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 14:57:10 -0500
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:55314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbgKHT5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 14:57:10 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D8B9E837F24C;
        Sun,  8 Nov 2020 19:57:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3874:4250:4321:4605:5007:7576:7903:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:14777:21080:21433:21451:21627:21819:30022:30029:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: dog03_0a0812a272e6
X-Filterd-Recvd-Size: 2111
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Nov 2020 19:57:07 +0000 (UTC)
Message-ID: <e8fef5fbd71331b010988769b249af6a79048f48.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add fix for BAD_SIGN_OFF
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 08 Nov 2020 11:57:06 -0800
In-Reply-To: <20201108134317.25400-1-yashsri421@gmail.com>
References: <20201108134317.25400-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-08 at 19:13 +0530, Aditya Srivastava wrote:
> Currently, checkpatch warns us if the author of the commit signs-off
> as co-developed-by.
[]
> A quick manual check found out that all fixes were correct in those
> cases.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2827,8 +2827,11 @@ sub process {
>  # Check Co-developed-by: immediately followed by Signed-off-by: with same name and email
>  			if ($sign_off =~ /^co-developed-by:$/i) {
>  				if ($email eq $author) {
> -					WARN("BAD_SIGN_OFF",
> -					      "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline);
> +					if (WARN("BAD_SIGN_OFF",
> +						 "Co-developed-by: should not be used to attribute nominal patch author '$author'\n" . "$here\n" . $rawline) &&
> +					    $fix) {
> +						fix_delete_line($fixlinenr, $rawline);
> +					}
>  				}
>  				if (!defined $lines[$linenr]) {
>  					WARN("BAD_SIGN_OFF",

Looks OK to me.

Another option might be to add a Signed-off-by: line derived from
any "From:" line when:

	if ($is_patch && $has_commit_log && $chk_signoff) {
		if ($signoff == 0) {
			ERROR("MISSING_SIGN_OFF",
			      "Missing Signed-off-by: line(s)\n");

etc...

