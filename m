Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C242508E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgHXTJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:09:59 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:50168 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725976AbgHXTJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:09:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CE64A837F24A;
        Mon, 24 Aug 2020 19:09:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3868:3870:3871:4321:4384:5007:6119:7875:7904:9163:10004:10400:10848:11026:11232:11473:11658:11914:12043:12048:12114:12297:12438:12663:12740:12760:12895:13439:14096:14097:14659:14721:21080:21451:21627:21796:21990:30029:30036:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: lace57_3816ffb27055
X-Filterd-Recvd-Size: 2902
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Aug 2020 19:09:56 +0000 (UTC)
Message-ID: <1bf51283e26e6dd5f3c3e017d15cbb50dd84e507.camel@perches.com>
Subject: Re: [PATCH 2/3] dyndbg: refine export, rename to
 dynamic_debug_exec_queries()
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 12:09:55 -0700
In-Reply-To: <20200824185412.1617174-3-jim.cromie@gmail.com>
References: <20200824185412.1617174-1-jim.cromie@gmail.com>
         <20200824185412.1617174-3-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 12:54 -0600, Jim Cromie wrote:
> commit 59cf47e7df31 dyndbg: export ddebug_exec_queries
> left a few configs broken, fix them with ifdef-stubs.
> 
> Rename the export to dynamic_debug_exec_queries().  This is a more
> canonical function name, instead of exposing the 'ddebug' internal
> name prefix.  Do this now, before export hits v5.9.0
> 
> Implement as new function wrapping ddebug_exec_queries(now static
> again), which copies the query-string, preserving ddebug_exec_queries'
> in-place parsing, while allowing users to pass "const strings".
[]
> diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
[]
> @@ -210,6 +215,13 @@ static inline int ddebug_dyndbg_module_param_cb(char *param, char *val,
>  		print_hex_dump(KERN_DEBUG, prefix_str, prefix_type,	\
>  				rowsize, groupsize, buf, len, ascii);	\
>  	} while (0)
> -#endif
> +
> +static inline int dynamic_debug_exec_queries(const char *query, const char *modname)
> +{
> +	printk(KERN_WARNING "kernel not built w CONFIG_DYNAMIC_DEBUG_CORE\n");

pr_warn and w should be with

> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
[]
> @@ -557,7 +557,27 @@ int ddebug_exec_queries(char *query, const char *modname)
>  		return exitcode;
>  	return nfound;
>  }
> -EXPORT_SYMBOL_GPL(ddebug_exec_queries);
> +
> +/**
> + * dynamic_debug_exec_queries - apply changes to selected dynamic-debug prints
> + * @query: string with callsite-selectors +enablement+decorations
> + * @modname: string containing module name
> + *
> + * This implements the >/proc/dynamic_debug/control reader, allowing
> + * module authors to modify their dynamic-debug callsites. The modname
> + * is canonically struct module.mod_name, but can also be null or a
> + * module-wildcard, for example: "drm*".
> + */
> +int dynamic_debug_exec_queries(const char *query, const char *modname)
> +{
> +	char *qry = kmalloc(PAGE_SIZE, GFP_KERNEL);
> +	int rc;
> +	strncpy(qry, query, PAGE_SIZE);

kstrndup?


