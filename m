Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89E092A04D2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 12:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgJ3LyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 07:54:15 -0400
Received: from smtprelay0038.hostedemail.com ([216.40.44.38]:50028 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726078AbgJ3LyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 07:54:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B9A60100E7B46;
        Fri, 30 Oct 2020 11:54:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3834:3865:3866:3867:3868:3870:3871:3872:3874:4321:4560:5007:6119:7875:9010:10004:10400:10848:11026:11232:11473:11658:11914:12297:12438:12663:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:14777:21080:21433:21451:21627:21660:21819:30003:30022:30029:30034:30054:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: books89_2d0b00427295
X-Filterd-Recvd-Size: 2063
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Oct 2020 11:54:12 +0000 (UTC)
Message-ID: <9d5c8699f94481ab5bf2d37348199ca1d6343c8b.camel@perches.com>
Subject: Re: [PATCH] checkpatch: improve handling of email comments
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        yashsri421@gmail.com
Date:   Fri, 30 Oct 2020 04:54:11 -0700
In-Reply-To: <20201030090704.40533-1-dwaipayanray1@gmail.com>
References: <20201030090704.40533-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-30 at 14:37 +0530, Dwaipayan Ray wrote:
> checkpatch has limited support for parsing email comments. It only
> support single name comments or single after address comments.
> Whereas, RFC 5322 specifies that comments can be inserted in
> between any tokens of the email fields.
> 
> Improve comment parsing mechanism in checkpatch.
> 
> What is handled now:
> 
> - Multiple name/address comments
> - Comments anywhere in between name/address
> - Nested comments like (John (Doe))
>
> A brief analysis of checkpatch output on v5.0..v5.7 showed that
> after these modifications, the number of BAD_SIGN_OFF warnings
> came down from 2944 to 1424, and FROM_SIGN_OFF_MISMATCH came
> down from 2366 to 2330.
> 
> So, a total of 1556 false positives were resolved in total.

A mere reduction in messages emitted isn't necessarily good.

Please send me privately a complete list of these nominally
false positive messages that are no longer emitted.

I believe one of the relatively common incorrect messages is
for the cc: <stable@vger.kernel.org> where a version number is
continued on the same line after a #.

CC: stable@vger.kernel.org # for versions x.y.z and above



