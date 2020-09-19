Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CA427105B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 21:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgISTrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Sep 2020 15:47:49 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:33428 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726511AbgISTrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Sep 2020 15:47:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 90BB5837F24D;
        Sat, 19 Sep 2020 19:47:45 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:1801:2110:2197:2198:2199:2200:2393:2525:2551:2553:2560:2563:2682:2685:2691:2693:2828:2859:2895:2901:2909:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4184:4321:4470:4605:5007:6117:6119:7514:7576:7903:8531:9025:9040:10007:10848:11026:11232:11473:11658:11914:12043:12050:12294:12297:12438:12555:12740:12760:12895:12986:13255:13439:14180:14181:14659:14721:21060:21080:21221:21324:21347:21433:21450:21451:21627:21740:21819:21939:30003:30012:30016:30022:30030:30034:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: pull54_3e1238f27136
X-Filterd-Recvd-Size: 5743
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat, 19 Sep 2020 19:47:44 +0000 (UTC)
Message-ID: <6f612f0e19c0877763ce964e3164e3f062d28741.camel@perches.com>
Subject: Re: [PATCH] checkpatch: extend author Signed-off-by check for split
 From: header
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Sat, 19 Sep 2020 12:47:43 -0700
In-Reply-To: <CABJPP5Daf0UiKjeQp71_bViAkQQh7znWrArKAS1FqnjGU1nX4A@mail.gmail.com>
References: <20200919081225.28624-1-dwaipayanray1@gmail.com>
         <ad937bba6ebd306f6e467add90cfd857bb4f2391.camel@perches.com>
         <alpine.DEB.2.21.2009191950460.7901@felia>
         <f5d8124e54a50480b0a9fa638787bc29b6e09854.camel@perches.com>
         <alpine.DEB.2.21.2009192033030.7901@felia>
         <CABJPP5Daf0UiKjeQp71_bViAkQQh7znWrArKAS1FqnjGU1nX4A@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-20 at 01:08 +0530, Dwaipayan Ray wrote:
> On Sun, Sep 20, 2020 at 12:06 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > On Sat, 19 Sep 2020, Joe Perches wrote:
> > > On Sat, 2020-09-19 at 20:12 +0200, Lukas Bulwahn wrote:
> > > > On Sat, 19 Sep 2020, Joe Perches wrote:
> > > > > On Sat, 2020-09-19 at 13:42 +0530, Dwaipayan Ray wrote:
> > > > > > Checkpatch did not handle cases where the author From: header
> > > > > > was split into two lines. The author string went empty and
> > > > > > checkpatch generated a false NO_AUTHOR_SIGN_OFF warning.
> > > > > 
> > > > > It's good to provide an example where the current code
> > > > > doesn't work.
> > > > > 
> > > > Joe, as this is a linux-kernel-mentees patch, we discussed that before
> > > > reaching out to you; you can find Dwaipayan's own evaluation here:
> > > > 
> > > > https://lore.kernel.org/linux-kernel-mentees/CABJPP5BOTG0QLFSaRJTb2vAZ_hJf229OAQihHKG4sYd35i_WMw@mail.gmail.com/
> > > > 
> > > > Dwaipayan, Joe's comment is still valid; it would be good to describe
> > > > the reasons why patches might have split lines (as far as see, long
> > > > encodings for non-ascii names).
> > > > 
> > > > I will run my own evaluation of checkpatch.pl before and after patch
> > > > application on Monday and then check if I can confirm Dwaipayan's results.
> > > > 
> > > > > It likely would be better to do this by searching forward for
> > > > > any extension lines after a "^From:' rather than searching
> > > > > backwards as there can be any number of extension lines.
> > > > > 
> > > > Just to sure what you are talking about...
> > > > 
> > > > You mean just to access the next line through the lines array, rather
> > > > than using prevheader and trying to decode that one line twice.
> > > > 
> > > > I agree the logic is a bit redundant and complicated at the moment.
> > > > 
> > > > Once prevheader is non-empty, it already clear that author is '' and
> > > > prevheader decodes with that match, because that is the only way to
> > > > make prevheader non-empty in the first place; at least as far I see it
> > > > right now.
> > > 
> > > Yeah, something like this (completely untested):
> > > ---
> > >  scripts/checkpatch.pl | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 3e474072aa90..2c710d05b184 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -2679,9 +2679,13 @@ sub process {
> > >               }
> > > 
> > >  # Check the patch for a From:
> > > -             if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> > > +             if ($line =~ /^From:\s*(.*)/i) {
> > >                       $author = $1;
> > > -                     $author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
> > > +                     my $curline = $linenr;
> > > +                     while (defined($rawlines[$curline] && $rawlines[$curline++] =~ /^ \s*(.*)/) {
> > > +                             $author .= $1;
> > > +                     }
> > > +                     $author = encode("utf8", $author) if ($author =~ /=\?utf-8\?/i);
> > >                       $author =~ s/"//g;
> > >                       $author = reformat_email($author);
> > >               }
> > > 
> 
> Hi,
> 
> Yeah I think the backwards checking was pretty redundant after all. If the
> extended encoding went too long, the From: header would be split into
> more than two lines and my proposed solution would fail.
> 
> Thanks for the heads up, Joe!
> 
> > Yeah, I get how you would like to see that being implemented. I will work
> > with Dwaipayan to get that properly implemented, properly described and
> > tested.
> > 
> > But let us keep the fun of that task to Dwaipayan... that is what a
> > mentorship is all about :)
> > 
> > Lukas
> 
> Yes definitely, the task is interesting for me, and I would like to solve
> it in a proper way.
> 
> As for the fix, shouldn't we stop the author string concatenation once
> an email address is found? something like:
> 
>   last if  $rawlines[$curline] = ~/^\s*(\S+\@\S+)\s*/

Probably not.

I think it should follow the rfc standard with extension
lines starting with a space.

See rfc 5322, 2.2.3 Long Header Fields

> I will update the patch and sync up with Lukas on this.

Enjoy.

I believe I now have a working version, we can compare later.

cheers, Joe

