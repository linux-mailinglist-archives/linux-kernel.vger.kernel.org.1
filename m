Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8087234AC8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 20:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbgGaSUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 14:20:25 -0400
Received: from smtprelay0096.hostedemail.com ([216.40.44.96]:34920 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387651AbgGaSUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:20:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 97275182CF666;
        Fri, 31 Jul 2020 18:20:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1978:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3872:4250:4321:5007:10004:10400:10848:11026:11232:11658:11914:12048:12296:12297:12740:12760:12895:13069:13255:13311:13357:13439:14096:14097:14659:14721:21080:21627:21796:30034:30036:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rest28_1711f9a26f85
X-Filterd-Recvd-Size: 2325
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri, 31 Jul 2020 18:20:22 +0000 (UTC)
Message-ID: <f8f423cd6afeca88cfa635f20a0b2bf85ddda3c5.camel@perches.com>
Subject: Re: [PATCH v2 2/3] lib/vsprintf: Replace custom spec to print
 decimals with generic one
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh@kernel.org>,
        Grant Likely <grant.likely@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>
Date:   Fri, 31 Jul 2020 11:20:21 -0700
In-Reply-To: <20200731180825.30575-2-andriy.shevchenko@linux.intel.com>
References: <20200731180825.30575-1-andriy.shevchenko@linux.intel.com>
         <20200731180825.30575-2-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-31 at 21:08 +0300, Andy Shevchenko wrote:
> When printing phandle via %pOFp the custom spec is used. First of all,
> it has a SMALL flag which makes no sense for decimal numbers. Second,
> we have already default spec for decimal numbers. Use the latter in
> the %pOFp case as well.
[]
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
[]
> @@ -1979,12 +1979,6 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  	char *buf_start = buf;
>  	struct property *prop;
>  	bool has_mult, pass;
> -	static const struct printf_spec num_spec = {
> -		.flags = SMALL,
> -		.field_width = -1,
> -		.precision = -1,
> -		.base = 10,
> -	};
>  
>  	struct printf_spec str_spec = spec;
>  	str_spec.field_width = -1;
> @@ -2024,7 +2018,7 @@ char *device_node_string(char *buf, char *end, struct device_node *dn,
>  			str_spec.precision = precision;
>  			break;
>  		case 'p':	/* phandle */
> -			buf = number(buf, end, (unsigned int)dn->phandle, num_spec);
> +			buf = number(buf, end, (unsigned int)dn->phandle, default_dec_spec);

Could changing .precision = -1 to 0 change any output?


