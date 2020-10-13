Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FAB28D4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgJMTsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 15:48:53 -0400
Received: from smtprelay0202.hostedemail.com ([216.40.44.202]:54066 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727665AbgJMTsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 15:48:53 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 789CC180A8142;
        Tue, 13 Oct 2020 19:48:51 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:966:968:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2196:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4385:5007:6119:7903:10004:10400:10848:11026:11232:11657:11658:11914:12043:12050:12297:12740:12760:12895:13069:13095:13149:13230:13311:13357:13439:14096:14097:14659:14721:21080:21433:21627:21939:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: grain34_5e09cac27205
X-Filterd-Recvd-Size: 1906
Received: from XPS-9350 (cpe-72-134-80-165.natsow.res.rr.com [72.134.80.165])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Tue, 13 Oct 2020 19:48:50 +0000 (UTC)
Message-ID: <575e7e2eb77ee5c26c3ac8fb6cb863890e971a16.camel@perches.com>
Subject: Re: sysfs filenames with spaces
From:   Joe Perches <joe@perches.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 13 Oct 2020 12:48:49 -0700
In-Reply-To: <20201013171754.GA29185@duo.ucw.cz>
References: <9b6f5c32d244131dbd63b55b085b3b4173144b4b.camel@perches.com>
         <20201013171754.GA29185@duo.ucw.cz>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-13 at 19:17 +0200, Pavel Machek wrote:
> On Mon 2020-10-05 19:41:15, Joe Perches wrote:
> > This doesn't seem like a great idea to me.
> > 
> > For my system I've got:
> > 
> > /sys/devices/platform/Fixed MDIO bus.0/
> > /sys/bus/platform/drivers/int3401 thermal/
> > /sys/bus/platform/drivers/int3403 thermal/
> > /sys/bus/platform/drivers/int3400 thermal/
> > /sys/bus/mdio_bus/drivers/Generic PHY/
> > /sys/bus/mdio_bus/drivers/Generic Clause 45 PHY/
> > /sys/bus/pnp/drivers/i8042 aux/
> > /sys/bus/pnp/drivers/i8042 kbd/
> > /sys/bus/i2c/drivers/CHT Whiskey Cove PMIC/
> > 
> > Could these filenames be avoided in the future or
> > even renamed today?
> 
> Does not look like great idea to me, either. Hmm. Is there filename
> with "/" in it? :-)
> 
> But I guess you'd need to cc relevant maintainers and that this is
> going to be a bit of whack-a-mole.

An option might be to convert any invalid filename
via an alloc and substitution in sysfs_add_file
and similar free in sysfs_remove_file.

Emitting a logging message describing any new name
would be useful too.


