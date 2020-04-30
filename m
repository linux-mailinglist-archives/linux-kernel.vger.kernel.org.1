Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1906C1C0093
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 17:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbgD3PlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 11:41:22 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:37512 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726346AbgD3PlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:41:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id DCA6C18224D6A;
        Thu, 30 Apr 2020 15:41:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2693:2731:2827:2911:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4425:5007:6119:7903:8957:10004:10400:10848:11026:11232:11473:11658:11783:11914:12297:12555:12679:12740:12895:13069:13071:13161:13229:13311:13357:13618:13894:14180:14181:14659:21080:21433:21451:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: thing45_28b1dc48c5410
X-Filterd-Recvd-Size: 2578
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 30 Apr 2020 15:41:19 +0000 (UTC)
Message-ID: <30efd2838a876029600806e9b53e3284ccabc88d.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add support to check 'Fixes:' tag format
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>
Cc:     Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Date:   Thu, 30 Apr 2020 08:41:18 -0700
In-Reply-To: <20200430125614.GA30691@udknight>
References: <20200429163645.GA13810@udknight>
         <4112ab7e-1f06-d880-e471-084c78bc84d4@web.de>
         <20200430125614.GA30691@udknight>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-30 at 20:56 +0800, Wang YanQing wrote:
> On Wed, Apr 29, 2020 at 07:40:21PM +0200, Markus Elfring wrote:
> > > “...
> > > Do not split the tag across multiple
> > > lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
> > > parsing scripts
> > > ...”
> > 
> > Why do you not like the reformatting of the quotation so far
> > (if such change descriptions should cope also with specific
> > Unicode characters)?
> > 
> > “…
> > Do not split the tag across multiple lines, tags are exempt from
> > the "wrap at 75 columns" rule in order to simplify parsing scripts.
> > …”
> > 
> > 
> 
> Sigh. I will fix it, but I want to hear from Joe Perches before
> next patch version.

Hello YanQing.

Just ignore Markus' replies here, he's well meaning
but perhaps overly focused on trying to impose formal,
but somewhat antique grammar and word choice uses that
aren't particularly important for review.

The most common variant I see here is someone writes

Fixes: SHA1 ("Truncated commit description...")

to apparently avoid a long line.

btw:

you can test your patch using checkpatch and --git like:

$ git log -10000 --no-merges --grep="Fixes:" --format=%H | \
  while read commit ; do \
    ./scripts/checkpatch.pl --git $commit --types=GIT_COMMIT_ID --quiet --nosummary; \
  done

You could filter that either by modifying the patch
changing to "GIT_COMMIT_ID_TEST" and changing to
types=GIT_COMMIT_ID_TEST just for Fixes or maybe
use another grep like grep -B3 -A3 "Fixes:" -i


