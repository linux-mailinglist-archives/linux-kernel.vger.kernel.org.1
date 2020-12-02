Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C957E2CC784
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgLBULQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:11:16 -0500
Received: from smtprelay0248.hostedemail.com ([216.40.44.248]:40246 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729186AbgLBULQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:11:16 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id D1CEE181D337B;
        Wed,  2 Dec 2020 20:10:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:968:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2693:2828:2902:2911:3138:3139:3140:3141:3142:3355:3622:3865:3866:3867:3868:3870:3871:3872:3873:3874:4184:4250:4321:4419:4425:4605:5007:7514:7652:7903:8957:10004:10400:10848:11026:11232:11473:11658:11783:11914:12043:12297:12438:12555:12663:12740:12895:13095:13439:13618:13894:14096:14097:14180:14181:14659:14721:21060:21080:21324:21433:21451:21627:21660:21740:21809:21939:30054:30070:30080:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: teeth55_5c01c8d273b5
X-Filterd-Recvd-Size: 3695
Received: from [192.168.1.142] (unknown [172.58.19.39])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Dec 2020 20:10:33 +0000 (UTC)
Message-ID: <f6db65a7f3744b35da84d7d4be77b2f89da1102a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add warning for lines starting with a '#'
 in commit log
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Wed, 02 Dec 2020 12:10:29 -0800
In-Reply-To: <CABJPP5DSEb5G6G1O1Gvga_E3bT0DftTp6qcgh4RPSKL8cfus-Q@mail.gmail.com>
References: <20201202101448.8494-1-dwaipayanray1@gmail.com>
         <CABJPP5DSEb5G6G1O1Gvga_E3bT0DftTp6qcgh4RPSKL8cfus-Q@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 01:30 +0530, Dwaipayan Ray wrote:
> On Wed, Dec 2, 2020 at 3:45 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
> > 
> > Commit log lines starting with a '#' can be dropped by git if
> > the corresponding commit message is reworded by a maintainer.
> > This minor error can be easily avoided if checkpatch warns
> > for the same.
> > 
> > Add a new check which emits a warning on finding lines starting
> > with a '#'. Also add a quick fix by adding a tab in front of
> > such lines.
> > 
> > Suggested-by: Peilin Ye <yepeilin.cs@gmail.com>
> > Tested-by: Peilin Ye <yepeilin.cs@gmail.com>
> > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > ---
> >  scripts/checkpatch.pl | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index e8c1ed0b1fad..a12edcf4f63a 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -2966,6 +2966,15 @@ sub process {
> >                         $commit_log_possible_stack_dump = 0;
> >                 }
> > 
> > +# Check for lines starting with a #
> > +               if ($in_commit_log && $line =~ /^#/) {
> > +                       if (WARN("POSSIBLE_IGNORED_LINE",
> > +                                "Commit log lines starting with a '#' might be dropped by git.\n" . $herecurr)
> > +                           && $fix) {
> > +                               $fixed[$fixlinenr] =~ s/^#/\t#/;
> > +                       }
> > +               }
> > +
> >  # Check for git id commit length and improperly formed commit descriptions
> >                 if ($in_commit_log && !$commit_log_possible_stack_dump &&
> >                     $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
> > --
> > 2.27.0
> > 
> Hi,
> This patch may seem trivial but I wanted to send it to you for review
> nevertheless.
> 
> Peilin had earlier faced this problem in one of his patches which was
> mainlined. There were some '#define' lines in the commit log. Due to
> some reason the Maintainer had to reword the commit message, and
> ultimately those '#define' lines were lost in the tree that was merged.
> 
> I am not sure if it would be exactly helpful for regular committers but for
> new contributers it might be nice to avoid such a mistake. Do you think
> it deserves inclusion in checkpatch?

Even regular committers face this.

Please fix the && $fix so that the && is at EOL and change the
'might be dropped' to 'will be dropped by git as a comment' and
remove the period.

"POSSIBLE_IGNORED_LINE" could be something like "COMMIT_COMMENT_SYMBOL".


