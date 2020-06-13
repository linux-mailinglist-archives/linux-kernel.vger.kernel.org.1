Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1509B1F84E0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 21:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgFMTWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 15:22:10 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:35372 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726304AbgFMTWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:22:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 96E1E1F08;
        Sat, 13 Jun 2020 19:22:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3351:3622:3866:3867:3868:3870:3871:3872:4184:4321:5007:10004:10400:10848:11658:11914:12048:12296:12297:12740:12760:12895:13069:13142:13230:13255:13311:13357:13439:14180:14659:14721:21060:21080:21212:21627:21740:21990:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: rain66_2f09add26de7
X-Filterd-Recvd-Size: 1517
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 13 Jun 2020 19:22:07 +0000 (UTC)
Message-ID: <fa8b72be8316e6ed50371e24be1a7ad9c6be5127.camel@perches.com>
Subject: Re: [PATCH v2 20/24] dyndbg: WIP towards debug-print-class based
 callsite controls
From:   Joe Perches <joe@perches.com>
To:     Jim Cromie <jim.cromie@gmail.com>, jbaron@akamai.com,
        linux-kernel@vger.kernel.org, akpm@linuxfoundation.org,
        gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk
Date:   Sat, 13 Jun 2020 12:22:06 -0700
In-Reply-To: <20200613155738.2249399-21-jim.cromie@gmail.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
         <20200613155738.2249399-21-jim.cromie@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-06-13 at 09:57 -0600, Jim Cromie wrote:
> 3- pr_class:5 gives 32 print-classes
>    we can map [1-9a-w] to select any pr_class with 1 char
>    then "12", "af" work as noted.
>    it is succinct, but arcane.

arcane generally isn't useful.

>    but it does allow mnemonic choices of pr_class
>    - l,m,h	low, mid, hi
>    - l,r	left right

I believe there to be no value in mnemonic input
to debug_<class>

I think 0x<hex_mask>, 0b<binary_bits>, 0<octal_bits>
and <decimal> level is more than enough.

And likely just 0x<hex> and <decimal> is enough.

