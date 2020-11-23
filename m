Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF5F32C1207
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 18:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390362AbgKWRdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 12:33:33 -0500
Received: from smtprelay0151.hostedemail.com ([216.40.44.151]:41386 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730356AbgKWRdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 12:33:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id DE947837F24F;
        Mon, 23 Nov 2020 17:33:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3874:4321:5007:6120:7901:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14096:14097:14181:14659:14721:21080:21212:21627:21660:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: woman80_51130f927367
X-Filterd-Recvd-Size: 1792
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Nov 2020 17:33:30 +0000 (UTC)
Message-ID: <148208ef84344069a6c95d3f686a86ca1199be90.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add fix and improve warning msg for
 Non-standard signature
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>, lukas.bulwahn@gmail.com
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Nov 2020 09:33:29 -0800
In-Reply-To: <20201123172430.12854-1-yashsri421@gmail.com>
References: <CAKXUXMx8siSm67jkBP_r+OKyKALfT2EDcX_SfX7JGBy3YisXcQ@mail.gmail.com>
         <20201123172430.12854-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-23 at 22:54 +0530, Aditya Srivastava wrote:
> Currently, checkpatch.pl warns for BAD_SIGN_OFF on non-standard signature
> styles.

I think this proposed change is unnecessary.
 
> This warning occurs because of incorrect use of signature tags,
> e.g. an evaluation on v4.13..v5.8 showed the use of following incorrect
> signature tags, which may seem correct, but are not standard:

Standards are useful, but standards are not constraints.

> 1) Requested-by (count: 48) => Suggested-by
> Rationale: In an open-source project, there are no 'requests', just
> 'suggestions' to convince a maintainer to accept your patch

There's nothing really wrong with some non-standard signatures.
And I think leaving humor like brown-paper-bag-by: is useful.

Just telling people that they are using a non-standard signature
I think is enough.

