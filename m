Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6361F1F59CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jun 2020 19:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgFJRN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jun 2020 13:13:28 -0400
Received: from smtprelay0251.hostedemail.com ([216.40.44.251]:51044 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726979AbgFJRN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:13:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 59FF8180286EF;
        Wed, 10 Jun 2020 17:13:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3871:3872:3873:4321:5007:6691:8957:10004:10400:10848:11232:11658:11914:12043:12297:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: coat52_230528b26dcc
X-Filterd-Recvd-Size: 1882
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 10 Jun 2020 17:13:26 +0000 (UTC)
Message-ID: <c8851256aa453461481233e8a7fea878f9580c5b.camel@perches.com>
Subject: Re: [PATCH] .clang-format: update column limit
From:   Joe Perches <joe@perches.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jun 2020 10:13:24 -0700
In-Reply-To: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
References: <20200610125147.2782142-1-christian.brauner@ubuntu.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-10 at 14:51 +0200, Christian Brauner wrote:
> The provided clang-format file wraps at 80 chars. If noone minds I'd like
> to adjust this limit to 100 similar to what checkpatch (cf. [1]) uses now.
> 
> [1]: commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column warning")
> Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
[]
> diff --git a/.clang-format b/.clang-format
[]
> @@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
>  #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
>  BreakAfterJavaFieldAnnotations: false
>  BreakStringLiterals: false
> -ColumnLimit: 80
> +ColumnLimit: 100

Ii think this is a not a good change.

If you read the commit log you provided, it ways
"staying withing 80 columns is certainly still _preferred_"

With this change, clang would _always_ wrap to 100 columns.

clang would not make any reasonable attempt to use 80 when
it should.


