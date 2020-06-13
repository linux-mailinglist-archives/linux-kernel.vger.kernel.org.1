Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00F1F843F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 18:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgFMQOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 12:14:07 -0400
Received: from smtprelay0168.hostedemail.com ([216.40.44.168]:40384 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbgFMQOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:14:06 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 9D01E182CED34;
        Sat, 13 Jun 2020 16:14:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3351:3622:3865:3866:3871:4321:5007:6119:7903:10004:10400:10848:11026:11232:11658:11914:12048:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: snake37_150538726de6
X-Filterd-Recvd-Size: 1563
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 13 Jun 2020 16:14:04 +0000 (UTC)
Message-ID: <030bb11d193d13a2d1c161a133bb7b88093a1fe9.camel@perches.com>
Subject: Re: [PATCH v2 09/24] dyndbg: add maybe(str,"") macro to reduce code
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, akpm@linuxfoundation.org,
        gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk
Date:   Sat, 13 Jun 2020 09:14:02 -0700
In-Reply-To: <20200613155738.2249399-10-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
         <20200613155738.2249399-10-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-06-13 at 09:57 -0600, Jim Cromie wrote:
> reduce word count via macro, no actual object change.
> 
> OTOH, maybe() could be scrubbed if printk's default printing (iirc) of
> "(null)" pointers is deemed appropriate for the log-msg.
[]
> diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
[]
> @@ -114,6 +114,7 @@ do {								\
>  #define vpr_info(fmt, ...)	vnpr_info(1, fmt, ##__VA_ARGS__)
>  #define v2pr_info(fmt, ...)	vnpr_info(2, fmt, ##__VA_ARGS__)
>  
> +#define maybe(str, empty)	( str ? str : empty )

This macro is unnecessary.

An even shorter very commonly used gcc extension would be

	str ?: empty


