Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2D47290FC6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 08:00:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436886AbgJQGAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 02:00:54 -0400
Received: from smtprelay0145.hostedemail.com ([216.40.44.145]:52422 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2436878AbgJQGAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 02:00:51 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave04.hostedemail.com (Postfix) with ESMTP id C538418016EBE
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 04:42:46 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 16758180A7FE1;
        Sat, 17 Oct 2020 04:42:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:1801:2197:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3871:3872:3873:3874:4117:4184:4321:4605:5007:7903:8603:10004:10848:11026:11232:11658:11914:12295:12296:12297:12438:12555:12663:12740:12760:12895:12986:13439:14659:21060:21080:21221:21451:21611:21627:21740:21939:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: care04_3a11e6e27222
X-Filterd-Recvd-Size: 6288
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Oct 2020 04:42:45 +0000 (UTC)
Message-ID: <9465f2a318bee7e723c250ff39cf56d6b23780cd.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add new exception to repeated word check
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 16 Oct 2020 21:42:43 -0700
In-Reply-To: <CABJPP5DjmY8N18XOhikHymiwkF9h213Rwi-ffQiBvKSrw2WqyA@mail.gmail.com>
References: <20201014163738.117332-1-dwaipayanray1@gmail.com>
         <ea011df1e30ce445d51e128287e2c6c38de20949.camel@perches.com>
         <CABJPP5DrSL7GoZUWc7P02CfLHfTBmfpLxrVOVQ08KH3pPontoA@mail.gmail.com>
         <7d8c7d80aa7b0524cca49a6dfe24e878bea6ab12.camel@perches.com>
         <81b6a0bb2c7b9256361573f7a13201ebcd4876f1.camel@perches.com>
         <CABJPP5DjmY8N18XOhikHymiwkF9h213Rwi-ffQiBvKSrw2WqyA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-17 at 10:02 +0530, Dwaipayan Ray wrote:
> On Sat, Oct 17, 2020 at 8:26 AM Joe Perches <joe@perches.com> wrote:
> > On Wed, 2020-10-14 at 11:35 -0700, Joe Perches wrote:
> > > On Wed, 2020-10-14 at 23:42 +0530, Dwaipayan Ray wrote:
> > > > On Wed, Oct 14, 2020 at 11:33 PM Joe Perches <joe@perches.com> wrote:
> > > > > On Wed, 2020-10-14 at 22:07 +0530, Dwaipayan Ray wrote:
> > > > > > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > > > > > moved the repeated word test to check for more file types. But after
> > > > > > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > > > > > new warnings of the type:
> > > > > 
> > > > > Perhaps instead of adding more content checks so that
> > > > > word boundaries are not something like \S but also
> > > > > not punctuation so that content like
> > > > > 
> > > > >         git git://
> > > > >         @size size
> > > > > 
> > > > > does not match?
> > > > > 
> > > > > 
> > > > Hi,
> > > > So currently the words are trimmed of non alphabets before the check:
> > > > 
> > > > while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
> > > > my $first = $1;
> > > > my $second = $2;
> > > > 
> > > > where, the word_pattern is:
> > > > my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
> > > 
> > > I'm familiar.
> > > 
> > > > So do you perhaps recommend modifying this word pattern to
> > > > include the punctuation as well rather than trimming them off?
> > > 
> > > Not really, perhaps use the capture group position
> > > markers @- @+ or $-[1] $+[1] and $-[2] $+[2] with the
> > > substr could be used to see what characters are
> > > before and after the word matches.
> > 
> > Perhaps something like:
> > ---
> >  scripts/checkpatch.pl | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index fab38b493cef..a65eb40a5539 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -3054,15 +3054,25 @@ sub process {
> > 
> >                                 my $first = $1;
> >                                 my $second = $2;
> > +                               my $start_pos = $-[1];
> > +                               my $end_pos = $+[2];
> > 
> >                                 if ($first =~ /(?:struct|union|enum)/) {
> >                                         pos($rawline) += length($first) + length($second) + 1;
> >                                         next;
> >                                 }
> > 
> > -                               next if ($first ne $second);
> > +                               next if (lc($first) ne lc($second));
> >                                 next if ($first eq 'long');
> > 
> > +                               my $start_char = "";
> > +                               my $end_char = "";
> > +                               $start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > 0);
> > +                               $end_char = substr($rawline, $end_pos, 1) if (length($rawline) > $end_pos);
> > +
> > +                               next if ($start_char =~ /^\S$/);
> > +                               next if ($end_char !~ /^[\.\,\s]?$/);
> > +
> >                                 if (WARN("REPEATED_WORD",
> >                                          "Possible repeated word: '$first'\n" . $herecurr) &&
> >                                     $fix) {
> > 
> > 
> 
> Hi Joe,
> Thank you for the insight. I was also doing something similar:
> 
> ---
>  scripts/checkpatch.pl | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index f1a4e61917eb..82497a71ac96 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -595,6 +595,7 @@ our @mode_permission_funcs = (
>  );
> 
>  my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
> +my $punctuation_chars = '[,:;@\.\-]';
> 
>  #Create a search pattern for all these functions to speed up a loop below
>  our $mode_perms_search = "";
> @@ -3065,6 +3066,21 @@ sub process {
>   next if ($first ne $second);
>   next if ($first eq 'long');
> 
> + # check for character before and after the word matches
> + my $ca_first = substr($rawline, $-[1]-1, 1);
> + my $cb_first = substr($rawline, $+[1], 1);
> + my $ca_second = substr($rawline, $-[2]-1, 1);
> + my $cb_second = substr($rawline, $+[2], 1);
> +
> + if ($ca_first ne $ca_second || $cb_first ne $cb_second) {
> + if ($ca_first =~ /$punctuation_chars/ ||
> +     $ca_second =~ /$punctuation_chars/ ||
> +     $cb_first =~ /$punctuation_chars/ ||
> +     $cb_second =~ /$punctuation_chars/) {
> + next;
> + }
> + }
> +
>   if (WARN("REPEATED_WORD",
>   "Possible repeated word: '$first'\n" . $herecurr) &&
>       $fix) {
> 
> Does it look okay to you??

Not really, as ca_second and cb_first are both known
to be the same position and known to be a single space.


