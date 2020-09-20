Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2CBC271610
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgITQyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 12:54:36 -0400
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:60800 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726267AbgITQyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:54:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1925D100E7B42;
        Sun, 20 Sep 2020 16:54:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1730:1747:1777:1792:1801:2110:2197:2199:2393:2553:2559:2562:2828:2895:3138:3139:3140:3141:3142:3355:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4050:4119:4321:4605:5007:6119:7514:7576:7903:8526:8825:10004:10848:11026:11232:11233:11473:11658:11914:12043:12291:12295:12297:12438:12555:12679:12683:12740:12895:13141:13161:13229:13230:13255:13439:13894:14659:21080:21221:21433:21451:21627:21819:21990:30003:30012:30022:30026:30029:30030:30054:30064:30070:30083:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: north86_030928e2713e
X-Filterd-Recvd-Size: 8245
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sun, 20 Sep 2020 16:54:34 +0000 (UTC)
Message-ID: <52ccb41c8922dda44ac325f2f3e09f81f1936611.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: extend author Signed-off-by check for
 split From: header
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Date:   Sun, 20 Sep 2020 09:54:32 -0700
In-Reply-To: <CABJPP5Chm2xd2PW77=Ru9t4C6Yvq3SyEmr1gKsaQGyF5AxRVfA@mail.gmail.com>
References: <20200920091706.56276-1-dwaipayanray1@gmail.com>
         <7958ded756c895ca614ba900aae7b830a992475e.camel@perches.com>
         <CABJPP5Chm2xd2PW77=Ru9t4C6Yvq3SyEmr1gKsaQGyF5AxRVfA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-09-20 at 21:52 +0530, Dwaipayan Ray wrote:
> On Sun, Sep 20, 2020 at 8:39 PM Joe Perches <joe@perches.com> wrote:
> > On Sun, 2020-09-20 at 14:47 +0530, Dwaipayan Ray wrote:
> > > Checkpatch did not handle cases where the author From: header
> > > was split into multiple lines. The author identity could not
> > > be resolved and checkpatch generated a false NO_AUTHOR_SIGN_OFF
> > > warning.
> > 
> I think there won't be any problem. Is my
> observation correct?

Likely true, it probably doesn't matter.
Still, I'd imagine it doesn't hurt either.

> > What I have does a bit more by saving any post-folding
> > 
> > "From: <name and email address>"
> > 
> > and comparing that to any "name and perhaps different
> > email address" in a Signed-off-by: line.
> > 
> > A new message is emitted if the name matches but the
> > email address is different.
> > 
> > Perhaps it's reasonable to apply your patch and then
> > update it with something like the below:
> > ---
> >  scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++----
> >  1 file changed, 28 insertions(+), 4 deletions(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > index 3e474072aa90..1ecc179e938d 100755
> > --- a/scripts/checkpatch.pl
> > +++ b/scripts/checkpatch.pl
> > @@ -1240,6 +1240,15 @@ sub same_email_addresses {
> >                $email1_address eq $email2_address;
> >  }
> > 
> > +sub same_email_names {
> > +       my ($email1, $email2) = @_;
> > +
> > +       my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
> > +       my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
> > +
> > +       return $email1_name eq $email2_name;
> > +}
> > +
> >  sub which {
> >         my ($bin) = @_;
> > 
> > @@ -2679,20 +2688,32 @@ sub process {
> >                 }
> > 
> >  # Check the patch for a From:
> > -               if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> > +               if ($line =~ /^From:\s*(.*)/i) {
> >                         $author = $1;
> > -                       $author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
> > +                       my $curline = $linenr;
> > +                       while (defined($rawlines[$curline]) && $rawlines[$curline++] =~ /^\s(\s+)?(.*)/) {
> > +                               $author .= ' ' if (defined($1));
> > +                               $author .= "$2";
> > +                       }
> > +                       if ($author =~ /=\?utf-8\?/i) {
> > +                               $author = decode("MIME-Header", $author);
> > +                               $author = encode("utf8", $author);
> > +                       }
> > +
> >                         $author =~ s/"//g;
> >                         $author = reformat_email($author);
> >                 }
> > 
> >  # Check the patch for a signoff:
> >                 if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
> > +                       my $sig = $1;
> >                         $signoff++;
> >                         $in_commit_log = 0;
> >                         if ($author ne '') {
> > -                               if (same_email_addresses($1, $author)) {
> > -                                       $authorsignoff = 1;
> > +                               if (same_email_addresses($sig, $author)) {
> > +                                       $authorsignoff = "1";
> > +                               } elsif (same_email_names($sig, $author)) {
> > +                                       $authorsignoff = $sig;
> >                                 }
> >                         }
> >                 }
> > @@ -6937,6 +6958,9 @@ sub process {
> >                 } elsif (!$authorsignoff) {
> >                         WARN("NO_AUTHOR_SIGN_OFF",
> >                              "Missing Signed-off-by: line by nominal patch author '$author'\n");
> > +               } elsif ($authorsignoff ne "1") {
> > +                       WARN("NO_AUTHOR_SIGN_OFF",
> > +                            "From:/SoB: email address mismatch: 'From: $author' != 'Signed-off-by: $authorsignoff'\n");
> >                 }
> >         }
> > 
> > 
> 
> Yes, this is definitely more logical !
> I was actually hoping to talk with you on this.

Hope granted, but only via email... (smile)

> The code you sent better handles name mismatches when
> email addresses are same. But I also have found several
> such commits in which the author have signed off using
> a different email address than the one which he/she used
> to send the patch.
> 
> For example, Lukas checked commits between v5.4 and
> v5.8 and he found:
>     175 Missing Signed-off-by: line by nominal patch authorrep
>     'Daniel Vetter <daniel.vetter@ffwll.ch>'
> 
> Infact in all of those commits he signed off using a different
> mail, Daniel Vetter <daniel.vetter@intel.com>.
> 
> So is it possible to resolve these using perhaps .mailmap
> entries? Or should only the name mismatch part be better
> handled? Or perhaps both?

Dunno.  It certainly can be improved...
Try adding some more logic and see what you come up with.

btw:

The most frequent NO_AUTHOR_SIGN_OFF messages for v5.7..v5.8 are

     98 WARNING: From:/SoB: email address mismatch: 'From: Daniel Vetter <daniel.vetter@ffwll.ch>' != 'Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>'
     24 WARNING: From:/SoB: email address mismatch: 'From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>' != 'Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>'
     19 WARNING: From:/SoB: email address mismatch: 'From: Wolfram Sang <wsa+renesas@sang-engineering.com>' != 'Signed-off-by: Wolfram Sang <wsa@kernel.org>'
     11 WARNING: From:/SoB: email address mismatch: 'From: Luke Nelson <lukenels@cs.washington.edu>' != 'Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>'
      8 WARNING: From:/SoB: email address mismatch: 'From: Christophe Leroy <christophe.leroy@c-s.fr>' != 'Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>'
      6 WARNING: From:/SoB: email address mismatch: 'From: Davidlohr Bueso <dave@stgolabs.net>' != 'Signed-off-by: Davidlohr Bueso <dbueso@suse.de>'
      5 WARNING: Missing Signed-off-by: line by nominal patch author '"Paul A. Clarke" <pc@us.ibm.com>'
      4 WARNING: Missing Signed-off-by: line by nominal patch author 'Huang Ying <ying.huang@intel.com>'
      3 WARNING: Missing Signed-off-by: line by nominal patch author '"Stephan Müller" <smueller@chronox.de>'

For the Missing Signed-off-by: lines above,
even after decoding, the email matches but
the names do not.

From: "Paul A. Clarke" <pc@us.ibm.com>
[...]
Signed-off-by: Paul Clarke <pc@us.ibm.com>

From: Huang Ying <ying.huang@intel.com>
[...]
Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

From: =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>
[...]
Signed-off-by: Stephan Mueller <smueller@chronox.de>

> Also, I would like to know if there are any more changes
> required for the current patch or if it is good to go?

I think it's fine.

cheers, Joe

