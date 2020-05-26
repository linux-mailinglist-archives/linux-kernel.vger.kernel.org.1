Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1391E33C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 01:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgEZXdM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 19:33:12 -0400
Received: from smtprelay0097.hostedemail.com ([216.40.44.97]:45352 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgEZXdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:33:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 59788837F24D;
        Tue, 26 May 2020 23:33:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:560:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1434:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2692:2693:2828:3138:3139:3140:3141:3142:3354:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:7809:7901:7903:7974:9010:10004:10226:10400:10450:10455:10848:11232:11658:11914:12048:12296:12297:12663:12740:12760:12895:13019:13255:13439:13891:14096:14097:14181:14659:14721:19904:19999:21080:21220:21324:21325:21433:21451:21627:21660:21819:30003:30022:30029:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: hate02_240191e26d4d
X-Filterd-Recvd-Size: 3226
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Tue, 26 May 2020 23:33:10 +0000 (UTC)
Message-ID: <fd6892ca0191b67491416318958d1ece23e840ff.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: Update my maintainer entries to reorder
 email addresses
From:   Joe Perches <joe@perches.com>
To:     Shuah Khan <skhan@linuxfoundation.org>, mchehab+huawei@kernel.org,
        davem@davemloft.net, robh@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Date:   Tue, 26 May 2020 16:33:09 -0700
In-Reply-To: <ea204501-84a3-badb-63f6-0a9d2fe12b19@linuxfoundation.org>
References: <20200523021928.67126-1-skhan@linuxfoundation.org>
         <7366c990d4352e093ff7d17953079d7f0420c3a9.camel@perches.com>
         <661f53a3-b15c-76b0-f220-0d292b0843d5@linuxfoundation.org>
         <b0854ec2906323d34514875a58a79d4cb74e44b0.camel@perches.com>
         <ea204501-84a3-badb-63f6-0a9d2fe12b19@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-26 at 16:54 -0600, Shuah Khan wrote:
> On 5/26/20 4:27 PM, Joe Perches wrote:
> > On Tue, 2020-05-26 at 11:04 -0600, Shuah Khan wrote:
> > > On 5/22/20 8:26 PM, Joe Perches wrote:
> > > > On Fri, 2020-05-22 at 20:19 -0600, Shuah Khan wrote:
> > > > > get_maintainer.pl picks only the first email address found in the file.
> > > > > Reorder my email addresses so it finds my linuxfoundation.org email.
> > > > 
> > > > OK.
> > []
> > > Sadly, people that don't run get_maintainer.pl, leave alone running it
> > > with --noremove-duplicates option. So your suggestion doesn't really
> > > help me.
> > > 
> > > My preference is to get patches to both Inboxes if possible which isn't
> > > possible unless -noremove-duplicate is default. Having this option as
> > > default probably will annoy lot of people . So I am not asking for
> > > that.
> > > 
> > > That being said, I don't understand your comment. Are you recommending
> > > using just one email in these entries?
> > 
> > Yes.  And maybe set an autoforward rule in that email to
> > forward the received email to your other address.
> > 
> > 
> Sounds good.

Another option would be to write your name
slightly differently in the 2 entries.

For instance, add "(LF)" to the linuxfoundation.org entry like:

CPU POWER MONITORING SUBSYSTEM
M:	Thomas Renninger <trenn@suse.com>
M:	Shuah Khan <shuah@kernel.org>
M:	Shuah Khan (LF) <skhan@linuxfoundation.org>
L:	linux-pm@vger.kernel.org
S:	Maintained
F:	tools/power/cpupower/

and then the get_maintainer.pl script won't
collapse the equally named but with different
email addresses into a single entry:

$ ./scripts/get_maintainer.pl -f tools/power/cpupower/
Thomas Renninger <trenn@suse.com> (maintainer:CPU POWER MONITORING SUBSYSTEM)
Shuah Khan <shuah@kernel.org> (maintainer:CPU POWER MONITORING SUBSYSTEM)
"Shuah Khan (LF)" <skhan@linuxfoundation.org> (maintainer:CPU POWER MONITORING SUBSYSTEM)
linux-pm@vger.kernel.org (open list:CPU POWER MONITORING SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)



