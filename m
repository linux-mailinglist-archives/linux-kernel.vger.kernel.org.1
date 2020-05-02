Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD3141C27EC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 21:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgEBTHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 15:07:21 -0400
Received: from smtprelay0123.hostedemail.com ([216.40.44.123]:51698 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728450AbgEBTHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 15:07:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id A59AC181D337B;
        Sat,  2 May 2020 19:07:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2197:2199:2200:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:4605:5007:7514:8531:8957:9108:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13069:13071:13311:13357:13439:14180:14181:14659:14721:21060:21080:21221:21433:21451:21611:21627:30054:30070:30080:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: line91_3ff29e6200207
X-Filterd-Recvd-Size: 2796
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat,  2 May 2020 19:07:19 +0000 (UTC)
Message-ID: <ed8ade7265429ab6fdeb2c4d05c02c67bcc57737.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix can't check for too long invalid commit
 id
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>, Markus.Elfring@web.de,
        kernel-janitors@vger.kernel.org
Date:   Sat, 02 May 2020 12:07:18 -0700
In-Reply-To: <20200502185041.GA9082@udknight>
References: <20200502185041.GA9082@udknight>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-05-03 at 02:50 +0800, Wang YanQing wrote:
> The current UNKNOWN_COMMIT_ID doesn't check for 41+ length commit id,
> and although GIT_COMMIT_ID will check for 41+ length commit id, but
> it willn't warn anything about it due to 41+ length commit will never
> be defined.
> 
> This patch moves the unknown commit id check for normal commit description
> to GIT_COMMIT_ID, and uses ERROR instead of WARN, because unknown commit
> id is total useless to track change history in changelog, it deserves the
> ERROR.
> 
> Signed-off-by: Wang YanQing <udknight@gmail.com>

Hi again.  Trivial notes:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2865,8 +2865,18 @@ sub process {
>  			($id, $description) = git_commit_info($orig_commit,
>  							      $id, $orig_desc);
>  
> +			if (!defined($id)) {
> +			    if ($long) {
> +				ERROR("GIT_COMMIT_ID",
> +				      "Unknown commit id '$orig_commit' is too long, maybe misspelled?\n" . $herecurr);

checkpatch always uses tab indentation.
Please convert from 4 spaces to 1
tab and reindent the rest.

"misspelled" word choice may not be the best here as a
SHA-1 isn't really something that is spelled.

Perhaps something like:
	"Invalid commit id '$orig_commit' length '" . length($orig_commit) . "' exceeds allowed maximum of 40\n",

Though maybe a recommended maximum of some constant should be used.

	my $recommended_sha_length = 12;


> @@ -2969,7 +2979,7 @@ sub process {
>  		}
>  
>  # check for invalid commit id
> -		if ($in_commit_log && $line =~ /(^fixes:|\bcommit)\s+([0-9a-f]{6,40})\b/i) {
> +		if ($in_commit_log && $line =~ /(^fixes:)\s+([0-9a-f]{6,40})\b/i) {

Likely this capture group around Fixes: isn't necessary any more.

>  			my $id;
>  			my $description;
>  			($id, $description) = git_commit_info($2, undef, undef);

$1 ?


