Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11831DF52C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 May 2020 08:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387621AbgEWGOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 May 2020 02:14:50 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:33310 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387446AbgEWGOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 02:14:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 71542182CED28;
        Sat, 23 May 2020 06:14:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:560:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3350:3622:3865:3867:3870:3872:4321:5007:7901:7903:7974:10004:10400:10848:10967:11232:11658:11914:12297:12740:12760:12895:13069:13072:13255:13311:13357:13439:14180:14659:14721:14777:21060:21080:21324:21325:21433:21627:21660:21819:30003:30022:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: list31_1c0598526d2d
X-Filterd-Recvd-Size: 1471
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 23 May 2020 06:14:48 +0000 (UTC)
Message-ID: <bebc39aff642692e63f52874a9b5bbd212611abf.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
From:   Joe Perches <joe@perches.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 22 May 2020 23:14:47 -0700
In-Reply-To: <20200523075720.64e24d11@coco.lan>
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
         <20200523075720.64e24d11@coco.lan>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-05-23 at 07:57 +0200, Mauro Carvalho Chehab wrote:
> Hi Shuah,
> 
> Em Fri, 22 May 2020 20:19:28 -0600
> Shuah Khan <skhan@linuxfoundation.org> escreveu:
> 
> > get_maintainer.pl picks only the first email address found in the file.
> > Reorder my email addresses so it finds my linuxfoundation.org email.
> 
> Next time someone would run the ordering script again, this patch
> would need to be re-applied.

Not so.
Reordering does not change maintainer emails entries.
Reordering only happens to file patterns.


