Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0E127FFE1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 15:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732259AbgJANRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 09:17:25 -0400
Received: from smtprelay0124.hostedemail.com ([216.40.44.124]:46324 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732018AbgJANRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 09:17:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 6A323837F24A;
        Thu,  1 Oct 2020 13:17:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2901:3138:3139:3140:3141:3142:3353:3622:3653:3865:3867:3870:3871:3872:3873:4321:5007:6119:7903:9010:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:21990:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: jeans85_5b0b3032719b
X-Filterd-Recvd-Size: 2347
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Thu,  1 Oct 2020 13:17:22 +0000 (UTC)
Message-ID: <8e110121c89414ab1601071868dbcf410195a209.camel@perches.com>
Subject: Re: [PATCH RFC] checkpatch: fix multi-statement macro checks
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com
Date:   Thu, 01 Oct 2020 06:17:21 -0700
In-Reply-To: <20201001103314.136645-1-dwaipayanray1@gmail.com>
References: <20201001103314.136645-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-01 at 16:03 +0530, Dwaipayan Ray wrote:
> Checkpatch.pl doesn't have a check for excluding while (...) {...}
> blocks from MULTISTATEMENT_MACRO_USE_DO_WHILE error.
> 
> For example, running checkpatch.pl on the file mm/access.c in the
> kernel generates the following error:
> 
> ERROR: Macros with complex values should be enclosed in parentheses
> +#define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
> +	while (len >= sizeof(type)) {					\
> +		__get_kernel_nofault(dst, src, type, err_label);	\
> +		dst += sizeof(type);					\
> +		src += sizeof(type);					\
> +		len -= sizeof(type);					\
> +	}
> 
> The error is misleading for this case. Enclosing it in parantheses
> doesn't make any sense.

OK

> Checkpatch already has an exception list for such common macro types.
> Added a new exception for while (...) {...} style blocks to the same.
> This effectively fixed the wrong error message.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -5342,6 +5342,7 @@ sub process {
>  			    $dstat !~ /^\.$Ident\s*=/ &&				# .foo =
>  			    $dstat !~ /^(?:\#\s*$Ident|\#\s*$Constant)\s*$/ &&		# stringification #foo
>  			    $dstat !~ /^do\s*$Constant\s*while\s*$Constant;?$/ &&	# do {...} while (...); // do {...} while (...)
> +			    $dstat !~ /^while\s*$Constant\s*$Constant\s*$/ &&		# while (...) {...}

Did you try to output $dstat for some matching cases?
What was the $dstat value for the cases you tried?


