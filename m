Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC318201A66
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 20:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgFSSaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 14:30:03 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:45746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731628AbgFSSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:30:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E136F181219B0;
        Fri, 19 Jun 2020 18:30:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2915:3138:3139:3140:3141:3142:3352:3622:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7901:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13161:13229:13311:13357:13439:13548:14096:14097:14181:14659:21080:21433:21451:21627:30054:30070:30083:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:16,LUA_SUMMARY:none
X-HE-Tag: whip03_3f001d726e1b
X-Filterd-Recvd-Size: 1692
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jun 2020 18:30:00 +0000 (UTC)
Message-ID: <f6102c402ae3f4232aebf4e102953f21fdb86cf6.camel@perches.com>
Subject: Re: [PATCH 1/2] drivers: cdrom: fix all errors reported by
 checkpatch
From:   Joe Perches <joe@perches.com>
To:     Simao Gomes Viana <devel@superboring.dev>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
Date:   Fri, 19 Jun 2020 11:29:59 -0700
In-Reply-To: <20200619180834.8032-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-19 at 20:08 +0200, Simao Gomes Viana wrote:
> This fixes all errors that scripts/checkpatch.pl
> reports about drivers/cdrom/*.c and a lot of warnings
> as well. I skipped warnings that I don't know whether
> fixing them will break anything.

This is too many changes in a single patch to verify
them easily.

If you really want to change this file, and it's likely
not particularly necessary, I suggest that you send a
patch series that where each patch individually does:

1: Horizontal whitespace only changes
   o Trim trailing whitespace
   o Add alignment whitespace
   o Add operator spacing whitespace
2: Vertical whitespace changes if any
3: Convert embedded assignments to multiple lines
4: Comment style updates

And whatever other specific style changes necessary
to properly and easily identify them as correct.


