Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2FB26D7AA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 11:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgIQJas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 05:30:48 -0400
Received: from smtprelay0101.hostedemail.com ([216.40.44.101]:38664 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726200AbgIQJaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 05:30:46 -0400
X-Greylist: delayed 309 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 05:30:46 EDT
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id CF5B2800EEB2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 09:25:37 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 7514F182CF66A;
        Thu, 17 Sep 2020 09:25:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:4321:5007:6299:7903:8957:10004:10400:11026:11232:11473:11657:11658:11914:12043:12295:12296:12297:12438:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21221:21433:21627:21939:21990:30030:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: watch69_32046bb27121
X-Filterd-Recvd-Size: 2774
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 17 Sep 2020 09:25:32 +0000 (UTC)
Message-ID: <5341538083077360205d50683ac2f3df22cfa72a.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rtl8188eu: use __func__ in hal directory
From:   Joe Perches <joe@perches.com>
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 17 Sep 2020 02:25:31 -0700
In-Reply-To: <20200917071330.31740-1-straube.linux@gmail.com>
References: <20200917071330.31740-1-straube.linux@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-09-17 at 09:13 +0200, Michael Straube wrote:
> Use __func__ instead of hardcoded function names to clear
> checkpatch warnings.
[]
> diff --git a/drivers/staging/rtl8188eu/hal/odm.c b/drivers/staging/rtl8188eu/hal/odm.c
[]
> @@ -249,7 +249,7 @@ void odm_CommonInfoSelfUpdate(struct odm_dm_struct *pDM_Odm)
>  
>  void odm_CmnInfoInit_Debug(struct odm_dm_struct *pDM_Odm)
>  {
> -	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("odm_CmnInfoInit_Debug==>\n"));
> +	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("%s==>\n", __func__));
>  	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportPlatform=%d\n", pDM_Odm->SupportPlatform));
>  	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportAbility=0x%x\n", pDM_Odm->SupportAbility));
>  	ODM_RT_TRACE(pDM_Odm, ODM_COMP_COMMON, ODM_DBG_LOUD, ("SupportInterface=%d\n", pDM_Odm->SupportInterface));

These ODM_RT_TRACE macro uses are rather ugly.
Perhaps a rename to odm_dbg would be better.
So would removing the unnecessary parentheses from
the macro uses and fixing the macro definition

Maybe using a perl script something like the below:

our $balanced_parens = qr/(\((?:[^\(\)]++|(?-1))*\))/;

sub deparenthesize {
	my ($string) = @_;
	return "" if (!defined($string));

	while ($string =~ /^\s*\(.*\)\s*$/s) {
		$string =~ s@^\s*\(\s*@@s;
		$string =~ s@\s*\)\s*$@@s;
	}

	return $string;
}

foreach my $file (@ARGV) {
    my $FILE;
    my $count;
    open($FILE, '<', $file) or die("Can't read $file $!\n");
    undef $/;
    my $text = (<$FILE>);
    close($FILE);
    $count = $text =~ s/ODM_RT_TRACE\s*\(\s*([^,]*),\s*ODM_COMP_(\w+)\s*,\s*ODM_DBG_(\w+)\s*,\s*($balanced_parens)\s*\)\s*;/"odm_dbg($1, $2, $3, " . deparenthesize($4) . ");"/ge;
    if ($count > 0) {
	open($FILE, '>', $file) or die("Can't write $file $!\n");
	print $FILE $text;
	close($FILE);
    }
}


