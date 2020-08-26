Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05815253488
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Aug 2020 18:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgHZQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Aug 2020 12:14:54 -0400
Received: from smtprelay0065.hostedemail.com ([216.40.44.65]:51500 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727860AbgHZQOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 12:14:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 420C018224506;
        Wed, 26 Aug 2020 16:14:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2110:2393:2553:2559:2562:2828:2917:3138:3139:3140:3141:3142:3352:3622:3865:3866:3868:3870:3871:3872:4321:5007:10004:10400:11026:11232:11658:11914:12297:12663:12740:12760:12895:13069:13161:13229:13311:13357:13439:14001:14096:14097:14180:14659:21080:21433:21627:21990:30012:30025:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: rail44_10129d627065
X-Filterd-Recvd-Size: 2123
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 26 Aug 2020 16:14:19 +0000 (UTC)
Message-ID: <973f4d54da796db4fcc9b643b10889cbc8839989.camel@perches.com>
Subject: Re: [PATCH v1] driver core: Annotate dev_err_probe() with
 __must_check
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Date:   Wed, 26 Aug 2020 09:14:17 -0700
In-Reply-To: <20200826155507.GV1891694@smile.fi.intel.com>
References: <20200826104459.81979-1-andriy.shevchenko@linux.intel.com>
         <9635eaa4ccc1141fb0dd8c3687f46da7149206ad.camel@perches.com>
         <20200826155507.GV1891694@smile.fi.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-26 at 18:55 +0300, Andy Shevchenko wrote:
> On Wed, Aug 26, 2020 at 08:44:30AM -0700, Joe Perches wrote:
> > On Wed, 2020-08-26 at 13:44 +0300, Andy Shevchenko wrote:
> 
> ...
> 
> > > -int dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > > +int __must_check dev_err_probe(const struct device *dev, int err, const char *fmt, ...);
> > 
> > Generally, the __must_check should go before the return type
> > and the extern isn't necessary and is also generally not used
> > in device.h, so I'd prefer:
> > 
> > __printf(3, 4)
> > __must_check int dev_err_probe(...);
> 
> I grepped the current code... I don't see support of your preference.
> Maybe I missed something? (I'm talking about include/*)

Hey Andy.

The __must_check location is just personal belief
as it makes grep significantly easier

<qualifiers> type function(args...)

is a much easier grep pattern than

<qualifiers> type <qualifiers> function(args...)

extern function declarations are generally unnecessary
and should be avoided.

cheers, Joe

