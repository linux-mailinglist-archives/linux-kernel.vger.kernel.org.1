Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3332629183A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 18:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgJRQHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 12:07:37 -0400
Received: from smtprelay0187.hostedemail.com ([216.40.44.187]:44952 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725776AbgJRQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 12:07:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8F1BF18224956;
        Sun, 18 Oct 2020 16:07:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2693:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:7903:9040:10004:10400:10848:11026:11232:11658:11914:12043:12262:12297:12438:12555:12660:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14180:14181:14659:14721:21060:21063:21080:21365:21627:21990:30029:30054:30070:30080:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: corn47_3708b142722f
X-Filterd-Recvd-Size: 2939
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sun, 18 Oct 2020 16:07:34 +0000 (UTC)
Message-ID: <fce55e74e4331c6e19c4030a4e02fb35ca5ee4f7.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Allow not using -f with files that are in
 git
From:   Joe Perches <joe@perches.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 18 Oct 2020 09:07:33 -0700
In-Reply-To: <CAMuHMdV8FEPhTp653RN00LK4UcQZHkuLByJzqiM85r2qoqhDvQ@mail.gmail.com>
References: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
         <CAMuHMdV8FEPhTp653RN00LK4UcQZHkuLByJzqiM85r2qoqhDvQ@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-18 at 16:03 +0200, Geert Uytterhoeven wrote:
> Hi Joe,
> 
> On Tue, Aug 25, 2020 at 2:12 AM Joe Perches <joe@perches.com> wrote:
> > If a file exists in git and checkpatch is used without the -f
> > flag for scanning a file, then checkpatch will scan the file
> > assuming it's a patch and emit:
> > 
> > ERROR: Does not appear to be a unified-diff format patch
> > 
> > Change the behavior to assume the -f flag if the file exists
> > in git.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> Thanks for your patch!
> 
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -976,6 +976,16 @@ sub seed_camelcase_includes {
> >         }
> >  }
> > 
> > +sub git_is_single_file {
> > +       my ($filename) = @_;
> > +
> > +       return 0 if ((which("git") eq "") || !(-e "$gitroot"));
> > +
> > +       my $output = `${git_command} ls-files -- $filename`;
> > +       my $count = $output =~ tr/\n//;
> > +       return $count eq 1 && $output =~ m{^${filename}$};
> > +}
> > +
> >  sub git_commit_info {
> >         my ($commit, $id, $desc) = @_;
> > 
> 
> This is now commit f5f613259f3fea81 ("checkpatch: allow not using -f
> with files that are in git"), causing:
> 
>     Global symbol "$gitroot" requires explicit package name (did you
> forget to declare "my $gitroot"?) at scripts/checkpatch.pl line 980.
>     Execution of scripts/checkpatch.pl aborted due to compilation errors.
> 
> FWIW, host system is running Ubuntu 18.04.5 LTS (upgrade to 20.04 LTS
> planned soon ;-).

I believe there is a dependency on another patch
in -next that wasn't pushed to Linus' tree.

commit 5ec1f7de97b26a3fa364bbb31fdd2e42c8e6fa22
Author: Joe Perches <joe@perches.com>
Date:   Thu Oct 8 11:53:44 2020 +1100

    checkpatch: test $GIT_DIR changes

So it'd be better to revert right now until
this other patch is accepted or pushed.

