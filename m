Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB131240B85
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 18:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbgHJQ7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 12:59:25 -0400
Received: from smtprelay0174.hostedemail.com ([216.40.44.174]:53414 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726720AbgHJQ7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:59:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id C4436100E7B42;
        Mon, 10 Aug 2020 16:59:23 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1537:1567:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3871:3872:3874:4321:5007:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13069:13095:13255:13311:13357:13439:14659:21080:21212:21433:21627:21660:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rub99_5617d8426fdb
X-Filterd-Recvd-Size: 1181
Received: from XPS-9350 (unknown [172.58.78.167])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon, 10 Aug 2020 16:59:22 +0000 (UTC)
Message-ID: <17256c5e44cf5489d6eb1505077edc0910e9f3b8.camel@perches.com>
Subject: Re: in_commit_log: is the wrong token being matched for the
 MAINTAINERS need updating message?
From:   Joe Perches <joe@perches.com>
To:     Claudio Fontana <cfontana@suse.de>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 10 Aug 2020 09:59:19 -0700
In-Reply-To: <540c6741-3f22-ec85-0a14-3165115430df@suse.de>
References: <540c6741-3f22-ec85-0a14-3165115430df@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-10 at 18:45 +0200, Claudio Fontana wrote:
> We can see that in the sample patch input we are matching the line
> 
>  sound/{ => ac97}/ac97_bus.c | 0
> 
> with the regex ($line =~ /\{\s*([\w\/\.\-]*)\s*\=\>\s*([\w\/\.\-]*)\s*\}/
> 
> Is this actually wanted?

Yes, If this line is found, it's not intended to
be part of a commit message.


