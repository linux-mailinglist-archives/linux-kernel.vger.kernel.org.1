Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6446D2AE099
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 21:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgKJUTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 15:19:53 -0500
Received: from smtprelay0217.hostedemail.com ([216.40.44.217]:37880 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726179AbgKJUTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 15:19:53 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9C669180A8128;
        Tue, 10 Nov 2020 20:19:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3871:3872:4321:4605:5007:7652:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21063:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: nose45_0f11056272f7
X-Filterd-Recvd-Size: 2001
Received: from [192.168.0.160] (cpe-72-134-80-165.natsow.res.rr.com [72.134.80.165])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 10 Nov 2020 20:19:51 +0000 (UTC)
Message-ID: <c0751bb7fba5984ec4c7a14bc2cf924f1656e835.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add fix option for MISSING_SIGN_OFF
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 10 Nov 2020 12:19:50 -0800
In-Reply-To: <20201110190603.2193-1-yashsri421@gmail.com>
References: <20201110190603.2193-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-11 at 00:36 +0530, Aditya Srivastava wrote:
> Currently checkpatch warns us if there is no 'Signed-off-by' line
> for the patch.

trivial style and a comment:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2755,6 +2757,10 @@ sub process {
>  		if ($line =~ /^---$/) {
>  			$has_patch_separator = 1;
>  			$in_commit_log = 0;
> +			# to add missing sign off line before diff(s)
> +			if($patch_separator_linenr == 0) {

space after if

> +				$patch_separator_linenr = $linenr;
> +			}
[]
> @@ -7118,9 +7127,12 @@ sub process {
>  		      "Does not appear to be a unified-diff format patch\n");
>  	}
>  	if ($is_patch && $has_commit_log && $chk_signoff) {
> -		if ($signoff == 0) {
> -			ERROR("MISSING_SIGN_OFF",
> -			      "Missing Signed-off-by: line(s)\n");
> +		if ($signoff == 0 && !$non_standard_signature) {
> +			if (ERROR("MISSING_SIGN_OFF",
> +				  "Missing Signed-off-by: line(s)\n") &&
> +			    $fix) {
> +				fix_insert_line($patch_separator_linenr - 1, "Signed-off-by: $author");

Perhaps this needs to test $patch_separator_linenr to
make sure it's not 0.


