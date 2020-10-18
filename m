Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2808A291FC7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 22:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbgJRUT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 16:19:28 -0400
Received: from smtprelay0231.hostedemail.com ([216.40.44.231]:37566 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726422AbgJRUT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 16:19:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 2A1F212D5;
        Sun, 18 Oct 2020 20:19:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1538:1568:1593:1594:1711:1714:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:3871:3872:4321:5007:9040:10004:10400:10848:11232:11658:11914:12297:12740:12760:12895:13069:13311:13357:13439:14659:21080:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: test32_5216ff127231
X-Filterd-Recvd-Size: 1529
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Oct 2020 20:19:26 +0000 (UTC)
Message-ID: <49c87dede8d06ba90ecb3200b2a773860d61a3c8.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Allow --fix removal of unnecessary break
 statements
From:   Joe Perches <joe@perches.com>
To:     Tom Rix <trix@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Julia Lawall <julia.lawall@inria.fr>, linux-kernel@vger.kernel.org,
        cocci <cocci@systeme.lip6.fr>
Date:   Sun, 18 Oct 2020 13:19:24 -0700
In-Reply-To: <a15ada1f-9bad-612e-e841-934bff088f38@redhat.com>
References: <20201017160928.12698-1-trix@redhat.com>
         <f530b7aeecbbf9654b4540cfa20023a4c2a11889.camel@perches.com>
         <alpine.DEB.2.22.394.2010172016370.9440@hadrien>
         <dfe24da760056e31d90ff639b47c494263b5f4a7.camel@perches.com>
         <a15ada1f-9bad-612e-e841-934bff088f38@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-18 at 13:07 -0700, Tom Rix wrote:
> I like!
[]
> could add a '|break' here to catch the couple
[]
> break;
> 
> break;

Unfortunately, checkpatch is really stupid and it
wouldn't catch those
cases as there are blank lines
between the existing consecutive break
statements.

It would catch

	break;
	break;

but there aren't any of those so it seems unlikely
to be a very useful addition.


