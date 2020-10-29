Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E40229EEE0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgJ2Oz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:55:28 -0400
Received: from smtprelay0070.hostedemail.com ([216.40.44.70]:57926 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726375AbgJ2Oz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:55:28 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 201F01EE6;
        Thu, 29 Oct 2020 14:55:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3867:3870:3871:3873:3874:4321:5007:9010:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13311:13357:13439:14180:14181:14659:14721:21060:21080:21451:21627:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: roll95_4e0637c2728e
X-Filterd-Recvd-Size: 1243
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 29 Oct 2020 14:55:26 +0000 (UTC)
Message-ID: <24f8766403f881d4f56a9b721f29b6ee5d1173e2.camel@perches.com>
Subject: Re: False positive from checkscript: git git://...
From:   Joe Perches <joe@perches.com>
To:     Jean Delvare <jdelvare@suse.de>, Andy Whitcroft <apw@canonical.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Thu, 29 Oct 2020 07:55:25 -0700
In-Reply-To: <20201029143205.197ff58f@endymion>
References: <20201029143205.197ff58f@endymion>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-29 at 14:32 +0100, Jean Delvare wrote:
> Hi Andy, Joe,
> > I have hit this false positive from checkscript:
> 
> WARNING: Possible repeated word: 'git'
> #20: FILE: MAINTAINERS:5289:
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git dmi-for-next
> 
> Obviously that's going to happen a lot as this is actually the proper
> way to list a git tree in that file. Could you please add an exception
> for that case?
>

Already done in -next


