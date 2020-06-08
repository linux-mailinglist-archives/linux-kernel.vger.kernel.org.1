Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1AC1F21DF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 00:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgFHWez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 18:34:55 -0400
Received: from smtprelay0188.hostedemail.com ([216.40.44.188]:51220 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726725AbgFHWez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:34:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 47DA98019A3E;
        Mon,  8 Jun 2020 22:34:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3870:4321:5007:7875:8603:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14659:14721:21080:21627:21972:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: dress29_2b1397c26dbd
X-Filterd-Recvd-Size: 1866
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Jun 2020 22:34:53 +0000 (UTC)
Message-ID: <05ab102b936ce922c4fae67bf5dd3e323aff0b93.camel@perches.com>
Subject: Re: [PATCH] overflow.h: Add flex_array_size() helper
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Mon, 08 Jun 2020 15:34:52 -0700
In-Reply-To: <20200608221723.GA23644@embeddedor>
References: <20200608221723.GA23644@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 17:17 -0500, Gustavo A. R. Silva wrote:
> Add flex_array_size() helper for the calculation of the size, in bytes,
> of a flexible array member contained within an enclosing structure.
> 
> Example of usage:
> foo
> struct something {
> 	size_t count;
> 	struct foo items[];
> };
> 
> struct something *instance;
[]
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
[]
> +/**
> + * flex_array_size() - Calculate size of a flexible array member within
> + * an enclosing structure.

These comment descriptions do not match

> + * Calculates size of memory needed for flexible array @member of @count
> + * elements within structure @p.

The first comment shows the size of an array member.
The second shows the size of an array member * count

Also the struct_size and flex_array_size definitions
are using two different forms:

		sizeof(*(p)->member) + __must_be_array((p)->member),\
and
		sizeof((p)->member[0]) + __must_be_array((p)->member))

Consistency would be nice.


