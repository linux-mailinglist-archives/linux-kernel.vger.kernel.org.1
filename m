Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07051C6275
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 22:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgEEUyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 16:54:47 -0400
Received: from smtprelay0254.hostedemail.com ([216.40.44.254]:40852 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726593AbgEEUyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 16:54:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 66E1910054F00;
        Tue,  5 May 2020 20:54:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2551:2553:2559:2562:2689:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3867:3868:3871:3872:3873:4321:5007:7522:7903:8531:9040:9545:10004:10400:10848:11232:11658:11914:12043:12050:12295:12297:12555:12740:12895:12986:13071:13255:13439:13894:14180:14181:14659:14721:21060:21080:21221:21627:30012:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: play38_c63f55c33806
X-Filterd-Recvd-Size: 3100
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 May 2020 20:54:45 +0000 (UTC)
Message-ID: <5b68825bf74fb0df287d2c4df239dc08f8577cba.camel@perches.com>
Subject: Re: [kernel.org users] [PATCH v2] checkpatch: use patch subject
 when reading from stdin
From:   Joe Perches <joe@perches.com>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, users@linux.kernel.org
Date:   Tue, 05 May 2020 13:54:43 -0700
In-Reply-To: <20200505204015.44ibvg4bapnalrct@pali>
References: <20200505132613.17452-1-geert+renesas@glider.be>
         <1b0b4e6562cbbf4621e71042e511ae3cd0b542f6.camel@perches.com>
         <20200505204015.44ibvg4bapnalrct@pali>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 22:40 +0200, Pali Rohár wrote:
> Hello!
> 
> On Tuesday 05 May 2020 12:57:37 Joe Perches wrote:
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index eac40f0abd56a9f4..3355358697d9e790 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -1057,6 +1057,10 @@ for my $filename (@ARGV) {
> > >  	}
> > >  	while (<$FILE>) {
> > >  		chomp;
> > > +		if ($vname eq 'Your patch') {
> > > +			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
> > > +			$vname = '"' . $subject . '"' if $subject;
> > > +		}
> > >  		push(@rawlines, $_);
> > >  	}
> > >  	close($FILE);
> > 
> > There's a less cpu intensive way to do this,
> > for small patches, on my little laptop it's a
> > few dozen milliseconds faster, and for very
> > large patches multiple seconds faster to use
> > the following patch:
> > 
> > Substitute Geert's patch with the below but:
> > 
> > Acked-by: Joe Perches <joe@perches.com>
> > 
> > ---
> > 
> >  scripts/checkpatch.pl | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index f0092104ff7b..29786a097862 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1062,6 +1062,7 @@ for my $filename (@ARGV) {
> >  	while (<$FILE>) {
> >  		chomp;
> >  		push(@rawlines, $_);
> > +		$vname = "\"$1\"" if ($filename eq '-' && $_ =~ /^Subject:\s*(.*)/);
> 
> Hint: You can use qq operator to make code more readable (no need to
> escape quote character). And maybe you should match Subject as
> case-insensitive and expects at least one space after colon.
> As a Perl developer I would write above code as:
> 
> +		$vname = qq("$1") if $filename eq '-' && $_ =~ m/^Subject:\s+(.+)/i;
> 
> Anyway, what would happen if subject line contains quotes?

Hi Pali.

bad things... ;) so your suggestion is better.

But/And checkpatch uses parens for if statements.

cheers and thanks, Joe

