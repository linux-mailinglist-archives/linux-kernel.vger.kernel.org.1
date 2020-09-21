Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750D72732CE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 21:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbgIUT3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 15:29:33 -0400
Received: from smtprelay0205.hostedemail.com ([216.40.44.205]:45316 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726471AbgIUT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 15:29:32 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A321118029124;
        Mon, 21 Sep 2020 19:29:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 30,2,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3834:3865:3866:3867:3868:3871:4321:5007:9390:10010:10400:10848:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13095:13311:13357:13439:14659:14721:21080:21433:21627:21939:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: linen39_0e1404b27147
X-Filterd-Recvd-Size: 1634
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 21 Sep 2020 19:29:30 +0000 (UTC)
Message-ID: <88110ffe6b08a2b403f30f4ea7463d5dad50b80b.camel@perches.com>
Subject: Re: [PATCH 1/2] dyndbg: dont panic over bad input
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>
Date:   Mon, 21 Sep 2020 12:29:29 -0700
In-Reply-To: <20200921190433.1149521-2-jim.cromie@gmail.com>
References: <20200921190433.1149521-1-jim.cromie@gmail.com>
         <20200921190433.1149521-2-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-09-21 at 13:04 -0600, Jim Cromie wrote:
> This BUG_ON, from 2009, caught the impossible case of a word-char both
> starting and ending a string (loosely speaking).  A bad (reverted)
> patch finally hit this case, but even "impossibly bad input" is no
> reason to panic the kernel.  Instead pr_err and return -EINVAL.
[]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
[]
> @@ -259,7 +259,10 @@ static int ddebug_tokenize(char *buf, char *words[], int maxwords)
>  		} else {
>  			for (end = buf; *end && !isspace(*end); end++)
>  				;
> -			BUG_ON(end == buf);
> +			if (end == buf) {
> +				pr_err("expected non-empty bareword");

missing newline

This message is also unintelligible.
What is a non-empty bareword?


