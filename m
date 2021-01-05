Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBFDD2EA6B6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 09:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbhAEIpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 03:45:07 -0500
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:56742 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726202AbhAEIpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 03:45:06 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id BDF781801B771;
        Tue,  5 Jan 2021 08:44:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2194:2198:2199:2200:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3874:4321:5007:7652:8603:10004:10249:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:14096:14097:14659:21080:21324:21451:21627:21795:30051:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: print05_0a1526c274d7
X-Filterd-Recvd-Size: 1900
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Jan 2021 08:44:24 +0000 (UTC)
Message-ID: <50cc861121b62b3c1518222f24f679c3f72b868d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add a new check for strcpy/strlcpy uses
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 05 Jan 2021 00:44:23 -0800
In-Reply-To: <20210105082303.15310-1-dwaipayanray1@gmail.com>
References: <20210105082303.15310-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-01-05 at 13:53 +0530, Dwaipayan Ray wrote:
> strcpy() performs no bounds checking on the destination buffer.
> This could result in linear overflows beyond the end of the buffer.
> 
> strlcpy() reads the entire source buffer first. This read
> may exceed the destination size limit. This can be both inefficient
> and lead to linear read overflows.
> 
> The safe replacement to both of these is to use strscpy() instead.
> Add a new checkpatch warning which alerts the user on finding usage of
> strcpy() or strlcpy().

I do not believe that strscpy is preferred over strcpy.

When the size of the output buffer is known to be larger
than the input, strcpy is faster.

There are about 2k uses of strcpy.
Is there a use where strcpy use actually matters?
I don't know offhand...

But I believe compilers do not optimize away the uses of strscpy
to a simple memcpy like they do for strcpy with a const from

	strcpy(foo, "bar");

And lastly there is a existing strlcpy test in checkpatch.

commit 5dbdb2d87c29 ("checkpatch: prefer strscpy to strlcpy")


