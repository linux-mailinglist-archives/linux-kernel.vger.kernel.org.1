Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDEC1A12DA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDGRl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 13:41:59 -0400
Received: from smtprelay0206.hostedemail.com ([216.40.44.206]:46050 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726277AbgDGRl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:41:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id DE91A180A7352;
        Tue,  7 Apr 2020 17:41:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3870:3871:3873:3874:4321:4425:5007:6119:7903:10004:10400:10848:10967:11232:11658:11914:12219:12296:12297:12740:12760:12895:13019:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21627:21660:21740:30054:30074:30075:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: cover48_2e216e91cf159
X-Filterd-Recvd-Size: 1771
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  7 Apr 2020 17:41:56 +0000 (UTC)
Message-ID: <5d05fca7bcdeb57ed31fbbfc66d4cf7224e56f92.camel@perches.com>
Subject: Re: get_maintainer.pl sends bogus addresses to git send-email
From:   Joe Perches <joe@perches.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     Jeff King <peff@peff.net>, linux-kernel@vger.kernel.org,
        git@vger.kernel.org
Date:   Tue, 07 Apr 2020 10:39:58 -0700
In-Reply-To: <20200407192949.586159e7.olaf@aepfle.de>
References: <20200407154046.GA15368@aepfle.de>
         <20200407170257.GA1844923@coredump.intra.peff.net>
         <2e6975d606846c834a387c07ee11cdce52356586.camel@perches.com>
         <20200407192949.586159e7.olaf@aepfle.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-07 at 19:29 +0200, Olaf Hering wrote:
> Am Tue, 07 Apr 2020 10:18:41 -0700
> schrieb Joe Perches <joe@perches.com>:
> 
> > You need to add --norolestats on the get_maintainer command line
> 
> Thanks, this can be used as a workaround for the time being.
> Not sure why anyone would actually care about such details in default mode...

Because the default is
"tell me more about the maintainers of a particular file".
which can include not just the default maintainers of
a particular file within a subsystem, but the also info
about the people that actually apply patches to files.

For instance, a patch made to a file often has a nominal
maintainer that doesn't actually apply the patches but
that maintainer may review or approve but not actually
be the upstream path for acceptance of the patch.



