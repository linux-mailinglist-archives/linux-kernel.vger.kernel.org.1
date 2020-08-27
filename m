Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B90B2550F1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 00:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgH0WMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 18:12:02 -0400
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:35818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgH0WMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:12:02 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 854B78123E2F;
        Thu, 27 Aug 2020 22:12:01 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 74415182CED34;
        Thu, 27 Aug 2020 22:12:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3871:3874:4321:4605:5007:7576:8531:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12740:12760:12895:13069:13311:13357:13439:14096:14097:14659:14721:21080:21324:21627:21990:30029:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: fly24_1910e5127070
X-Filterd-Recvd-Size: 2747
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Thu, 27 Aug 2020 22:11:58 +0000 (UTC)
Message-ID: <ca08f34a5aaa3e9031a934296dd97fc806dab66f.camel@perches.com>
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
From:   Joe Perches <joe@perches.com>
To:     David Laight <David.Laight@ACULAB.COM>,
        Julia Lawall <julia.lawall@inria.fr>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        cocci <cocci@systeme.lip6.fr>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "accessrunner-general@lists.sourceforge.net" 
        <accessrunner-general@lists.sourceforge.net>
Date:   Thu, 27 Aug 2020 15:11:57 -0700
In-Reply-To: <c3926f18f98e446daad957cd66a94890@AcuMS.aculab.com>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
         <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
         <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
         <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
         <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
         <cf9b1ea3716305447be43bffc8f90b7ef7292f5b.camel@perches.com>
         <c3926f18f98e446daad957cd66a94890@AcuMS.aculab.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-27 at 22:03 +0000, David Laight wrote:
> From: Joe Perches
> > Sent: 27 August 2020 21:30
> ...
> > Perhaps what's necessary is to find any
> > appropriate .show function and change
> > any use of strcpy/sprintf within those
> > function to some other name.
> > 
> > For instance:
> > 
> > drivers/isdn/mISDN/core.c-static ssize_t name_show(struct device *dev,
> > drivers/isdn/mISDN/core.c-                       struct device_attribute *attr, char *buf)
> > drivers/isdn/mISDN/core.c-{
> > drivers/isdn/mISDN/core.c:      strcpy(buf, dev_name(dev));
> > drivers/isdn/mISDN/core.c-      return strlen(buf);
> > drivers/isdn/mISDN/core.c-}
> > drivers/isdn/mISDN/core.c-static DEVICE_ATTR_RO(name);
> 
> That form ends up calculating the string length twice.
> Better would be:
> 	len = strlen(msg);
> 	memcpy(buf, msg, len);
> 	return len;

or given clang's requirement for stpcpy

	return stpcpy(buf, dev_name(dev)) - buf;

(I do not advocate for this ;)

