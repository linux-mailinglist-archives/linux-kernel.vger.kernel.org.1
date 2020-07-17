Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6008C224487
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jul 2020 21:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbgGQTsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jul 2020 15:48:08 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:50058 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728480AbgGQTsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:48:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A5E6B180A8158;
        Fri, 17 Jul 2020 19:48:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2693:2828:2895:3138:3139:3140:3141:3142:3352:3622:3865:3867:3870:3872:4321:5007:7514:7576:7875:10004:10400:10848:11026:11232:11658:11914:12043:12048:12296:12297:12438:12555:12740:12760:12895:12986:13019:13069:13311:13357:13439:13972:14093:14096:14097:14181:14659:14721:21080:21433:21451:21627:21740:21939:21972:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: fan56_0b1792026f0d
X-Filterd-Recvd-Size: 2283
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Jul 2020 19:48:05 +0000 (UTC)
Message-ID: <278ef62c230d69d51ca1bb4a0bbd978483f6f501.camel@perches.com>
Subject: Re: [PATCH 07/25] Documentation: gpio/driver.h: fix sphinx warnings
From:   Joe Perches <joe@perches.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>, corbet@lwn.net,
        mchehab@kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 17 Jul 2020 12:48:04 -0700
In-Reply-To: <684c5c2e-1b2d-bcb4-1320-a3a0dbed9b70@infradead.org>
References: <20200717185624.2009393-1-dwlsalmeida@gmail.com>
         <20200717185624.2009393-7-dwlsalmeida@gmail.com>
         <684c5c2e-1b2d-bcb4-1320-a3a0dbed9b70@infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-17 at 12:37 -0700, Randy Dunlap wrote:
> On 7/17/20 11:56 AM, Daniel W. S. Almeida wrote:
> > From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> > 
> > Fix the following warnings:
> > 
> > warning: Function parameter or member 'gc' not described in
> > 'gpiochip_add_data'
> > 
> > warning: Excess function parameter 'chip' description in
> > 'gpiochip_add_data'
> > 
> > Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
> 
> Mauro has already fixed this one.

Not quite fixed though.

Both patches did not update the text for chip->base where
it should have been changed to gc->base

---
 include/linux/gpio/driver.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index db82451776fc..91ae7ad8730d 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -497,7 +497,7 @@ extern int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 
 /**
  * gpiochip_add_data() - register a gpio_chip
- * @gc: the chip to register, with chip->base initialized
+ * @gc: the chip to register, with gc->base initialized
  * @data: driver-private data associated with this chip
  *
  * Context: potentially before irqs will work



