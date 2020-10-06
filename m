Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C05F284761
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbgJFHen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:34:43 -0400
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:51024 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgJFHen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:34:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 56F99182CED28;
        Tue,  6 Oct 2020 07:34:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2553:2559:2562:2692:2693:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3872:4321:4605:5007:6119:10004:10400:10848:10967:11026:11232:11658:11914:12043:12297:12679:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21221:21451:21627:30054:30060:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: prose72_5d15fb9271c4
X-Filterd-Recvd-Size: 1996
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 07:34:41 +0000 (UTC)
Message-ID: <1396a58e7155f13b9c24daffabafa29d8d9106a5.camel@perches.com>
Subject: Re: [PATCH] scripts: kernel-doc: allow passing desired Sphinx C
 domain dialect
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Changbin Du <changbin.du@intel.com>,
        linux-kernel@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>
Date:   Tue, 06 Oct 2020 00:34:39 -0700
In-Reply-To: <20201006084207.125c88d5@coco.lan>
References: <ee1f16453ad40eae2603adfde5f6dda3ab1befc7.1601798520.git.mchehab+huawei@kernel.org>
         <20201005101736.7adf4f46@lwn.net> <20201006084207.125c88d5@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-06 at 08:42 +0200, Mauro Carvalho Chehab wrote:
> Em Mon, 5 Oct 2020 10:17:36 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
[]
> Sure. It should be easy to make the third argument optional, although
> the regex will be a little more harder to understand.
> 
> Something like this should do the trick:
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
[]
> @@ -466,12 +466,16 @@ while ($ARGV[0] =~ m/^--?(.*)/) {
>  	$show_not_found = 1;  # A no-op but don't fail
>      } elsif ($cmd eq "sphinx-version") {
>  	my $ver_string = shift @ARGV;
> -	if ($ver_string =~ m/^(\d+)\.(\d+)\.(\d+)/) {
> +	if ($ver_string =~ m/^(\d+)\.(\d+)(?:\.?(\d+)?)/) {

trivia: perhaps more readable as

	if ($ver_string =~ m/^(\d+)\.(\d+)(\.\d+)?/) {
	    $sphinx_major = $1;
	    $sphinx_minor = $2;
	    if (defined($3)) {
		$sphinx_patch = substr($3,1);
	    } else {
		$sphinx_patch = 0;
	    }


