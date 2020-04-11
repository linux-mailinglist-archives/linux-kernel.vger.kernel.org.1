Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D40461A52A5
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 17:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbgDKPs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Apr 2020 11:48:56 -0400
Received: from smtprelay0102.hostedemail.com ([216.40.44.102]:57636 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726054AbgDKPsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 11:48:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 4DFFD182CCCD0;
        Sat, 11 Apr 2020 15:48:55 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3870:3871:3872:3874:4321:5007:6691:7903:10004:10400:10848:11232:11658:11914:12043:12296:12297:12679:12740:12895:13069:13095:13311:13357:13439:13894:14180:14181:14659:14721:21060:21080:21212:21433:21627:21660:30054:30069:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cub63_13801b5604b35
X-Filterd-Recvd-Size: 1639
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Apr 2020 15:48:53 +0000 (UTC)
Message-ID: <d42889be3ae1c77c6ca33d9dbd87ab46c749cfff.camel@perches.com>
Subject: Re: [PATCH] usb: phy: jz4770: Add a missing '\n' in a log message
From:   Joe Perches <joe@perches.com>
To:     Paul Cercueil <paul@crapouillou.net>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     balbi@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Sat, 11 Apr 2020 08:46:49 -0700
In-Reply-To: <ZQKM8Q.561QQF8CXZTU3@crapouillou.net>
References: <20200411063811.6767-1-christophe.jaillet@wanadoo.fr>
         <ZQKM8Q.561QQF8CXZTU3@crapouillou.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-04-11 at 15:13 +0200, Paul Cercueil wrote:
> Hi Christophe,
> 
> Le sam. 11 avril 2020 à 8:38, Christophe JAILLET 
> <christophe.jaillet@wanadoo.fr> a écrit :
> > Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
> 
> Is that so?
> From what I could see these macros add the \n themselves if needed.

Not so.

> So the \n were omitted on purpose.

Just a trivial oversight really.

AFAIK: It's an issue _only_ in two cases:

p another process emits a printk with KERN_CONT (or pr_cont)
  that might extend this message in the log on the same line.

o this message wukk not be emitted into the log until another
  message arrives


