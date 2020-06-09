Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13501F3447
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 08:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgFIGrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 02:47:07 -0400
Received: from smtprelay0022.hostedemail.com ([216.40.44.22]:43134 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726917AbgFIGrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 02:47:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id E1047180424AA;
        Tue,  9 Jun 2020 06:47:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:4321:5007:6755:7875:8603:10004:10400:10848:11026:11232:11658:11914:12219:12296:12297:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:21972:21990:30029:30034:30054:30074:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: face18_3117c7126dc0
X-Filterd-Recvd-Size: 2021
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Tue,  9 Jun 2020 06:47:04 +0000 (UTC)
Message-ID: <e32b0a42aa00c20ef3868edd987c39a95ba68e95.camel@perches.com>
Subject: Re: [PATCH v2] overflow.h: Add flex_array_size() helper
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Mon, 08 Jun 2020 23:47:03 -0700
In-Reply-To: <20200609012233.GA3371@embeddedor>
References: <20200609012233.GA3371@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 20:22 -0500, Gustavo A. R. Silva wrote:
> Add flex_array_size() helper for the calculation of the size, in bytes,
> of a flexible array member contained within an enclosing structure.
[]
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
[]
> +/**
> + * flex_array_size() - Calculate size, in bytes, of a flexible array member
> + * within an enclosing structure. Read on for more details.

IMO: "Read on for more details" isn't useful here.
Perhaps better would be something like:

 * flex_array_size() - size of a flexible array (sizeof(typeof(member)) * count)

> + *
> + * @p: Pointer to the structure.
> + * @member: Name of the flexible array member.
> + * @count: Number of elements in the array.
> + *
> + * Calculates size, in bytes, of a flexible array @member of @count elements

IMO: "in bytes, " is redundant.  size is always bytes.

> + * within structure @p.
> + *
> + * Return: number of bytes needed or SIZE_MAX on overflow.
> + */
> +#define flex_array_size(p, member, count)					\
> +	array_size(count,							\
> +		    sizeof(*(p)->member) + __must_be_array((p)->member))
> +
>  #endif /* __LINUX_OVERFLOW_H */

