Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E39D820C897
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 16:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgF1Oxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 10:53:44 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:35450 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbgF1Oxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:53:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C1D57180A7A94;
        Sun, 28 Jun 2020 14:53:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1381:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2919:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3871:3872:3874:4321:4362:4470:5007:7904:10004:10400:10848:11026:11232:11658:11914:12043:12297:12438:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: son96_2a15f4c26e67
X-Filterd-Recvd-Size: 1599
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 28 Jun 2020 14:53:42 +0000 (UTC)
Message-ID: <09010c9aa795a8dcbd4408ceb2a39ddc57c85037.camel@perches.com>
Subject: Re: [REPORT] False positive errors found while using
 scripts/checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 28 Jun 2020 07:53:41 -0700
In-Reply-To: <20200628140046.imqmf5vy2vvbwkzo@pesu-pes-edu>
References: <20200628140046.imqmf5vy2vvbwkzo@pesu-pes-edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-28 at 10:00 -0400, B K Karthik wrote:
> The following are reported while using checkpatch.pl on 
> drivers/staging/fbtft/fbtft-bus.c
> 
> ERROR: space prohibited before that close parenthesis ')'
> #65: FILE: drivers/staging/fbtft/fbtft-bus.c:65:
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> 
> ERROR: space prohibited before that close parenthesis ')'
> #67: FILE: drivers/staging/fbtft/fbtft-bus.c:67:
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> 
> These are false positives as correcting these issues breaks the build.

Thanks, there's no capability to recognize this in checkpatch.
checkpatch is not a compiler.

Perhaps a reasonable solution is to add a comment around the
macro uses that show it's an unusual case.



