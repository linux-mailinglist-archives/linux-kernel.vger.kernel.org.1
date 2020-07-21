Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9EF22751F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 04:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728214AbgGUCAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jul 2020 22:00:24 -0400
Received: from smtprelay0252.hostedemail.com ([216.40.44.252]:38822 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgGUCAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:00:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 3BA2118020C26;
        Tue, 21 Jul 2020 02:00:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:3873:4321:4605:5007:7901:7903:9038:10004:10400:11026:11232:11658:11914:12043:12296:12297:12740:12760:12895:13069:13161:13229:13255:13311:13357:13439:14659:14721:21080:21627:21990:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sheep38_3d1250f26f29
X-Filterd-Recvd-Size: 2277
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Jul 2020 02:00:21 +0000 (UTC)
Message-ID: <b38a439b2bdd1122805aa182da9a1802e673f53e.camel@perches.com>
Subject: Re: [PATCH] ipmi/watchdog: add missing newlines when printing
 parameters by sysfs
From:   Joe Perches <joe@perches.com>
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, minyard@acm.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, guohanjun@huawei.com
Date:   Mon, 20 Jul 2020 19:00:20 -0700
In-Reply-To: <908fcbf2-efbb-b3f4-0666-2da79fbe99c4@huawei.com>
References: <1595210605-27888-1-git-send-email-wangxiongfeng2@huawei.com>
         <20200720195234.GC2952@minyard.net>
         <908fcbf2-efbb-b3f4-0666-2da79fbe99c4@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-21 at 09:20 +0800, Xiongfeng Wang wrote:
> On 2020/7/21 3:52, Corey Minyard wrote:
> > On Mon, Jul 20, 2020 at 10:03:25AM +0800, Xiongfeng Wang wrote:
> > > When I cat some ipmi_watchdog parameters by sysfs, it displays as
> > > follows. It's better to add a newline for easy reading.
[]
> > > diff --git a/drivers/char/ipmi/ipmi_watchdog.c b/drivers/char/ipmi/ipmi_watchdog.c
[]
> > > @@ -232,12 +232,16 @@ static int set_param_str(const char *val, const struct kernel_param *kp)
> > >  static int get_param_str(char *buffer, const struct kernel_param *kp)
> > >  {
> > >  	action_fn fn = (action_fn) kp->arg;
> > > -	int       rv;
> > > +	int rv, len;
> > >  
> > >  	rv = fn(NULL, buffer);
> > >  	if (rv)
> > >  		return rv;
> > > -	return strlen(buffer);
> > > +
> > > +	len = strlen(buffer);
> > > +	len += sprintf(buffer + len, "\n");
> > 
> > sprintf is kind of overkill to stick a \n on the end of a line.  How
> > about:
> > 
> > 	buffer[len++] = '\n';
> > 
> > Since you are returning the length, you shouldn't need to nil terminate
> > the string.

You never quite know for sure so I suggest making
the string null terminated just in case.

i.e.:

	buffer[len++] = '\n';
	buffer[len] = 0;


