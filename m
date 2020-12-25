Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C72A82E2C0A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 18:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgLYRm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 12:42:56 -0500
Received: from smtprelay0120.hostedemail.com ([216.40.44.120]:34404 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725953AbgLYRm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 12:42:56 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C2F9A180A7FD6;
        Fri, 25 Dec 2020 17:42:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,coupons@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3871:3872:3873:3874:4250:4321:4605:5007:7652:9108:10004:10400:10848:11026:11232:11233:11658:11914:12297:12663:12740:12760:12895:13069:13095:13161:13229:13311:13357:13439:14659:21080:21433:21627:21939:30003:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: place81_01065612747b
X-Filterd-Recvd-Size: 2117
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 25 Dec 2020 17:42:13 +0000 (UTC)
Message-ID: <9ece49fa7b0025d1d639859082f0408bbe5f4f49.camel@perches.com>
Subject: Re: [PATCH 2/2] checkpatch: kconfig: add missing types to regex
From:   Joe Perches <coupons@perches.com>
To:     Nicolai Fischer <nicolai.fischer@fau.de>,
        linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de, akpm@linux-foundation.org
Date:   Fri, 25 Dec 2020 09:42:12 -0800
In-Reply-To: <4899798f-46b9-32ee-4d1e-ab2b5833da08@fau.de>
References: <a9797282-84c3-2c8f-73a0-d751a8201541@fau.de>
         <1f3b50a6f343dd252c043b2e5b7d47bca8514ee7.camel@perches.com>
         <5d7cef4f-071d-0504-74df-bd944a11dd70@fau.de>
         <fa637be6bb02336a3df6e3c3fdc800b9b17d079f.camel@perches.com>
         <4899798f-46b9-32ee-4d1e-ab2b5833da08@fau.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-12-25 at 18:27 +0100, Nicolai Fischer wrote:
> On 12/21/20 6:17 PM, Joe Perches wrote:
[]
> > The message you used:
> > +                               WARN("CONFIG_DESCRIPTION",
> > +                                       "help text is not indented 2 spaces more than the help keyword\n" . $herecurr);
> > 
> > is IMO a bit oddly phrased and could/should test only
> > the first line after the help keyword and show the help
> > line using $hereprev.
> > 
> > The problem with $herecurr is, that it always contains the first line of the Kconfig option.
> The loop which actually determines if the warning is to be displayed, leaves $herecurr and likewise $hereprev unaffected.
> 
> So printing $hereprev would unfortunately not be any more helpful than $herecurr.

> Because $herecurr and $hereprev also contain the line number, among other things, I am not sure what would be the best way
> to address this.

There is a mechanism to create an output message block: get_stat_real
that could be used.


