Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F032D93CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 09:11:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439038AbgLNIKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 03:10:40 -0500
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:34956 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725951AbgLNIKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 03:10:39 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id B8FF4365E;
        Mon, 14 Dec 2020 08:09:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:421:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3872:4321:5007:6119:10004:10400:10450:10455:10848:11232:11658:11914:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:19904:19999:21080:21433:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: ring24_110728927419
X-Filterd-Recvd-Size: 1791
Received: from XPS-9350.home (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Mon, 14 Dec 2020 08:09:57 +0000 (UTC)
Message-ID: <fa376fd6d0b70f98f1d52f61f2f35f5890ec7e81.camel@perches.com>
Subject: Re: [PATCH] scripts: add more corrections to spelling.txt
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Mon, 14 Dec 2020 00:09:56 -0800
In-Reply-To: <20201214075831.34282-1-dwaipayanray1@gmail.com>
References: <20201214075831.34282-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-12-14 at 13:28 +0530, Dwaipayan Ray wrote:
> Analyzing misspellings over the past 10k commit messages,
> a few more corrections are added to spelling.txt

I don't agree with all of these.

> diff --git a/scripts/spelling.txt b/scripts/spelling.txt
[]
> @@ -1253,6 +1260,7 @@ senarios||scenarios
>  sentivite||sensitive
>  separatly||separately
>  sepcify||specify
> +seperate||separate
>  seperated||separated
>  seperately||separately
>  seperate||separate

seperate is already here.

> @@ -1482,6 +1493,8 @@ unuseful||useless
>  unvalid||invalid
>  upate||update
>  upsupported||unsupported
> +upto|| up to

No space before correction

> +uptodate||up-to-date

This one is fairly commonly used as an identifier so it should not
be added here.

> @@ -1528,8 +1543,11 @@ wiil||will
>  wirte||write
>  withing||within
>  wnat||want
> +wont||won't

wont is a properly spelled word and also should not be added here.


