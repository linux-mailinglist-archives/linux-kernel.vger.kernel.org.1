Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DEBC2569E5
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 21:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbgH2TiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 15:38:17 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:57094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728370AbgH2TiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:38:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E46C9181D337B;
        Sat, 29 Aug 2020 19:38:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:5007:6120:10004:10400:10848:11232:11658:11914:12114:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: baby09_0a1426127080
X-Filterd-Recvd-Size: 1712
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Aug 2020 19:38:14 +0000 (UTC)
Message-ID: <489164b541e344f254b70429e4f6d467e1602931.camel@perches.com>
Subject: Re: [RFC PATCH] coccinelle: misc: add uninitialized_var.cocci script
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Date:   Sat, 29 Aug 2020 12:38:13 -0700
In-Reply-To: <alpine.DEB.2.22.394.2008292133360.3629@hadrien>
References: <20200811210127.11889-1-efremov@linux.com>
         <alpine.DEB.2.22.394.2008292133360.3629@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 21:36 +0200, Julia Lawall wrote:
> 
> On Wed, 12 Aug 2020, Denis Efremov wrote:
> 
> > Commit 63a0895d960a ("compiler: Remove uninitialized_var() macro") and
> > commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")
> > removed uninitialized_var() and deprecated it.
> > 
> > The purpose of this script is to prevent new occurrences of open-coded
> > variants of uninitialized_var().

> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Applied, without the commented out part.
> 
> I only got three warnings, though.  Perhaps the others have been fixed?

uninitialized_var does not exist in -next


