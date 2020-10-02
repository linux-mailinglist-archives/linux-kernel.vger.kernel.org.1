Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD5E0281647
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 17:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388287AbgJBPOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 11:14:02 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:33604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388223AbgJBPOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 11:14:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 4C7821730842;
        Fri,  2 Oct 2020 15:14:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2692:2828:3138:3139:3140:3141:3142:3353:3865:3866:3867:3868:3870:3872:3873:3874:4250:4321:4641:5007:8957:10004:10400:10848:11026:11232:11658:11914:12043:12050:12295:12297:12438:12740:12760:12895:13069:13095:13161:13184:13199:13229:13311:13357:13439:14659:21080:21433:21451:21611:21627:21789:30012:30054:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: water67_2d10638271a5
X-Filterd-Recvd-Size: 2585
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Oct 2020 15:14:00 +0000 (UTC)
Message-ID: <cc3efa9aa8955e15255807fc852a4ad3d8ab7f44.camel@perches.com>
Subject: Re: external tool to remove embedded filenames
From:   Joe Perches <joe@perches.com>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Date:   Fri, 02 Oct 2020 08:13:58 -0700
In-Reply-To: <20201002144936.GA17987@Gentoo>
References: <1fd5f9188a14acdca703ca00301ee323de672a8d.camel@perches.com>
         <bab3ecae932cb41106834156abbd27159d937e67.camel@perches.com>
         <20201002144936.GA17987@Gentoo>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

( * removing mentors, I originally meant to send that to mentees )

On Fri, 2020-10-02 at 20:19 +0530, Bhaskar Chowdhury wrote:
> On 11:47 Thu 01 Oct 2020, Joe Perches wrote:
> > It's rather unnecessary for files to contain their
> > path/filename in source code comments.
> > 
> > Here's a trivial little script that can remove
> > embedded filenames in c90 style comments from files.
> > 
> > This requires git.
[]
> > Running it on today's -next gives:
> > 
> > $ perl remove_embedded_filenames.pl
> > $ git diff --shortstat
> > 2310 files changed, 354 insertions(+), 4239 deletions(-)
> > 
> > It's also possible to give any filename or path
> > as an argument to the script
> > 
> > For instance:
> > 
> > $ perl remove_embedded_filenames.pl drivers/net

The below was an attachment, it's odd that your
mailer quoted it.

> > #!/usr/bin/perl -w
[]
> > if ($modified && !$quiet) {
> >    print <<EOT;
> > Warning: these changes may not be correct.
> > 
> > These changes should be carefully reviewed manually and not combined with
> > any functional changes.
> > 
> > Compile, build and test your changes.
> > 
> > You should understand and be responsible for all object changes.
> > 
> > Make sure you read Documentation/SubmittingPatches before sending
> > any changes to reviewers, maintainers or mailing lists.
> > EOT
> > }
> 
> Suggestion.... please take those damn EOT lines out of it

No.  What's your actual problem with it?

It's a tool and it may not be perfect.

It merely emits a single message if it removes
filenames from files.


