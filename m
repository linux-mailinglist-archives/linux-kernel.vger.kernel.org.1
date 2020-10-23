Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94FAA297862
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 22:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756289AbgJWUmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 16:42:20 -0400
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:50956 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1756266AbgJWUmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 16:42:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8D97D18224D86;
        Fri, 23 Oct 2020 20:42:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3873:4184:4321:5007:6120:7901:7903:10004:10400:10848:11232:11658:11783:11914:12043:12297:12740:12895:13069:13071:13161:13229:13311:13357:13439:13894:14180:14659:14721:21060:21080:21221:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:18,LUA_SUMMARY:none
X-HE-Tag: bite17_5c072682725c
X-Filterd-Recvd-Size: 2218
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Oct 2020 20:42:15 +0000 (UTC)
Message-ID: <8710630d8c01bf6f3749e3d11d193a805f2d2048.camel@perches.com>
Subject: Re: [PATCH RFC v2] checkpatch: extend attributes check to handle
 more patterns
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 23 Oct 2020 13:42:14 -0700
In-Reply-To: <2a3b90ee-b9bd-2586-9d68-45cbf7e499a9@gmail.com>
References: <20201023094307.20820-1-dwaipayanray1@gmail.com>
         <d2b05b45adbcf3f1d16692b054862a7aa7353f6d.camel@perches.com>
         <CABJPP5Dx4qj-_0gOx0bmaWvJj3okB-tNGJg5-8Y3KF2LnCjowQ@mail.gmail.com>
         <2e8279841d604dde8a3335c092db921007f6744e.camel@perches.com>
         <2a3b90ee-b9bd-2586-9d68-45cbf7e499a9@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-24 at 00:44 +0530, Dwaipayan Ray wrote:
> Hi,

Hi again.

> I modified the check to check the attributes from the map.
> There are two checks - one for the normal attributes and
> one for the ones with arguments, which needs just a bit more
> processing.
> 
> So attributes like __packed__ as well as those like
> __aligned__(x) are handled.
> 
> What do you think?
> 
> ---
> +            $line =~ /__attribute__\s*\(\s*($balanced_parens)\s*\)/)
> {
> +            my $attr = trim($1);
> +            $attr =~ s/\(\s*_*(.*)\)/$1/;
> +            while($attr =~ s/(.*)_$/$1/) {}  # Remove trailing
> underscores

	I think this could be a single test like:

		while ($attr =~ /\s*(\w+)\s*(${balanced_parens})?/g) {
			my $curr_attr = $1;
			my $parens = $2;
			$curr_attr = s/^_*(.*)_*$/$1/;
			
> +            my %attr_list = (
> +                "alias"            => "__alias",
> +                "aligned"        => "__aligned",

These might be better using tab alignment.

And you might special case format(printf/scanf here too


