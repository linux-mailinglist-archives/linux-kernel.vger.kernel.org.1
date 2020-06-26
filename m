Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF4520BC11
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jun 2020 00:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgFZWBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Jun 2020 18:01:35 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:42576 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbgFZWBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:01:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E4384837F24A;
        Fri, 26 Jun 2020 22:01:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:116:355:379:599:800:901:960:967:968:973:988:989:1260:1263:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2525:2553:2560:2563:2682:2685:2687:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3657:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4037:4250:4321:5007:6117:7875:7901:8599:9025:9388:10004:10400:10848:10967:11232:11658:11854:11914:12043:12297:12555:12679:12740:12760:12776:12895:12986:13069:13161:13229:13311:13357:13439:13845:14094:14096:14181:14651:14659:14721:14764:21080:21627:21881:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: silk04_4e0f1b526e58
X-Filterd-Recvd-Size: 2139
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 26 Jun 2020 22:01:32 +0000 (UTC)
Message-ID: <58f25e61b285362ab28d14ac55d1cd632c460fa8.camel@perches.com>
Subject: Re: [PATCH v2] Replace HTTP links with HTTPS ones: Documentation/arm
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     mchehab+samsung@kernel.org, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com, robh@kernel.org,
        j.neuschaefer@gmx.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Jun 2020 15:01:31 -0700
In-Reply-To: <20200626150911.3d4f9ca7@lwn.net>
References: <20200626194408.61245-1-grandmaster@al2klimov.de>
         <20200626150911.3d4f9ca7@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-26 at 15:09 -0600, Jonathan Corbet wrote:
> On Fri, 26 Jun 2020 21:44:08 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.
[]
> >  Changes in v2:
> >  Undone all handhelds.org changes and 0 of 0 wearablegroup.org changes.
> 
> I wasn't asking that the changes be undone, I was asking that those links
> simply be removed.  They are actively harmful - much more so than any http:
> links - and shouldn't be there.  *Sigh*.  I guess I'll just do that.

One argument to mark old/invalid links differently somehow is
that the wayback machine at archive.org may still have them.

But when the domain has been transferred to a 3rd party, it is
possibly harmful.

Another option might be to grab any archive.org content and
put it into a Documentation/archived/outdated directory or
the like.

For instance:

https://web.archive.org/web/20090423133742/http://www.handhelds.org/projects/h1940.html

Then gain, this might as well be prehistoric content.

