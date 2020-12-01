Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7A42CAAC0
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 19:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391088AbgLASaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 13:30:20 -0500
Received: from smtprelay0017.hostedemail.com ([216.40.44.17]:44624 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727278AbgLASaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 13:30:15 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8DF91180A9F5E;
        Tue,  1 Dec 2020 18:29:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:1801:2197:2199:2393:2553:2559:2562:2691:2693:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6119:7514:7875:7903:8531:9545:10004:10400:10848:11026:11232:11658:11783:11889:11914:12043:12296:12297:12740:12895:13095:13161:13229:13439:13894:14093:14096:14097:14181:14659:14721:21067:21080:21221:21433:21451:21627:21740:21990:30012:30025:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:4,LUA_SUMMARY:none
X-HE-Tag: fire26_1e13536273ac
X-Filterd-Recvd-Size: 4268
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Tue,  1 Dec 2020 18:29:32 +0000 (UTC)
Message-ID: <f5c7211fc8521248fcb7409f95afadda932a7fe7.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: fix TYPO_SPELLING check for words with
 apostrophe
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Tue, 01 Dec 2020 10:29:31 -0800
In-Reply-To: <CABJPP5A75ufynVGn37XteQ=KBrTenr2dGHPPdz83n1=qg6vztA@mail.gmail.com>
References: <20201201072320.44544-1-dwaipayanray1@gmail.com>
         <2d507d3042a97613078554b1b5f1169ab8c41b42.camel@perches.com>
         <CABJPP5A75ufynVGn37XteQ=KBrTenr2dGHPPdz83n1=qg6vztA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-12-01 at 23:39 +0530, Dwaipayan Ray wrote:
> On Tue, Dec 1, 2020 at 11:32 PM Joe Perches <joe@perches.com> wrote:
> > On Tue, 2020-12-01 at 12:53 +0530, Dwaipayan Ray wrote:
> > > checkpatch reports a false TYPO_SPELLING warning for some words
> > > containing an apostrophe when run with --codespell option.
> > > 
> > > A false positive is "doesn't". Occurrence of the word causes
> > > checkpatch to emit the following warning:
> > > 
> > > "WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"
> > > 
> > > Modify the regex pattern to be more in line with the codespell
> > > default word matching regex. This fixes the word capture and
> > > avoids the false warning.
> > > 
> > > Suggested-by: Joe Perches <joe@perches.com>
> > > Reported-by: Peilin Ye <yepeilin.cs@gmail.com>
> > > Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Use the default codespell word regex.
> > > - Modify commit message to specify --codespell usage
> > > 
> > >  scripts/checkpatch.pl | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > []
> > > @@ -3106,7 +3106,7 @@ sub process {
> > >  # Check for various typo / spelling mistakes
> > >               if (defined($misspellings) &&
> > >                   ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> > > -                     while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> > > +                     while ($rawline =~ /(?:^|[^\w\-'`])($misspellings)(?:[^\w\-'`]|$)/gi) {
> > 
> > This regex seems to work well, thanks.
> > 
> > >                               my $typo = $1;
> > 
> > A trivial improvement might be to highlight the location of the
> > misspelled word with a caret using
> > 
> >                                 my $blank = copy_spacing($rawline);
> >                                 my $ptr = substr($blank, 0, $-[0] + 1) . "^";
> >                                 my $hereptr = "$hereline$ptr\n";
> > 
> > >                               my $typo_fix = $spelling_fix{lc($typo)};
> > >                               $typo_fix = ucfirst($typo_fix) if ($typo =~ /^[A-Z]/);
> > 
> > and using $hereptr and not $hereline when emitting the message.
> > 
> Sure I will do that.
> Is the color highlighting also supported in most systems?

I believe so, yes.

Color is only used when the output is to stdout and not redirected
and not otherwise specified on the checkpatch command line.

> Maybe a red colored word would be nice to notice as well.

Maybe, but that might make the code around the message output of
$hereptr a bit obscure.  Presumably the code would not use $hereline
but something else new and specific for this message.

The output is done via the report() function so adding optional color
for only a portion of the new $hereptr string might be a lot of code.

If you try it, maybe make the misspelled word color match the message
level and not just be red.  Also the caret line wouldn't have much 
value with that added color highlighting.

Try it and see what you prefer.


