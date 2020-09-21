Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369B3271C28
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 09:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgIUHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbgIUHjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 03:39:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30953C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:39:41 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id z23so16218078ejr.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 00:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=BodLV2Cx3aSBcZ8i8dZwdtWx8R9mhFqXf0hcFRpAqxE=;
        b=UHq/2f4R+TcDITq9cLAVlgIdzEwJ7enL5pTLzZt+6MrQLYk9JCmmmdSv2KbuXYsmjY
         3834W5I+6J1m20g6LmdXUUFy3JvylArAGQypx+Sie2BwWpYXkXER+HF6cp0J9qNblmK/
         X/nU1Ah6BU/YnxjZ2Zty8uGqD5OzS9xMbIwZyCpM7f/iFw7RF4WM44YIa3WW/Xr2CIaZ
         NqEPucUa0g3yx+DHfU8FCbYT48o+WscYuHvQ8Y80geV4eq6NF1/tfHjKKYLPxBaDMbxQ
         rQRRoRgG/ZOjTJWA8w+16HHp4Q/oUtAq2C8hM7AjfFIkUXIERpOJo4+shIsMbtN4D7IZ
         z1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=BodLV2Cx3aSBcZ8i8dZwdtWx8R9mhFqXf0hcFRpAqxE=;
        b=WMr1WddXs/ikDJicqYmwIMe+T7eQIPsvBDsTe1z+P0CZxqWL/vg9LFxdbnCU6E5cWg
         IxKLU8yMVnh6vofdNRnHvwSBHd/IVr7mTdcLZtMD1XquUG2zsgI8cywJXR1LnV1GeYvN
         mIlzmMLbMajLgBSFn8fufnLHKzoiQzft7PAMO0FLWZIwa68LBUObXzolLpxWSv0PGjhi
         4322nVpoW4RqwBssUacRdmJPJBMK5h8zDGHJzGf8TO3Ok7dvMZ8JnDMEpXGhLK1DB05O
         VPm2qmcn54cHvuC34BjHHYPHQcnWlDY8/01B6nyPdrYtzPR9VXSIHxAzaWoaGYEuxUBe
         BEMw==
X-Gm-Message-State: AOAM532QEFhBMHPoCol0Ff4Sr6IMAxb57nP4odfcBAk++qvniDEmUOcP
        8plWQ8ukC89XgZDU3eBEWNI=
X-Google-Smtp-Source: ABdhPJwgWhlPEhIVTNnjXHmbaHDpA4FHAhpOBypvmeQVF/PSjLJO8uvQOx9HZliQFiq9gIu3gpVYNw==
X-Received: by 2002:a17:907:648:: with SMTP id wq8mr50545415ejb.291.1600673979648;
        Mon, 21 Sep 2020 00:39:39 -0700 (PDT)
Received: from felia ([2001:16b8:2d52:a400:69ec:6d66:6c4c:48])
        by smtp.gmail.com with ESMTPSA id q23sm7963491edw.41.2020.09.21.00.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 00:39:38 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Mon, 21 Sep 2020 09:39:32 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Joe Perches <joe@perches.com>
cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] checkpatch: extend author Signed-off-by check for
 split From: header
In-Reply-To: <52ccb41c8922dda44ac325f2f3e09f81f1936611.camel@perches.com>
Message-ID: <alpine.DEB.2.21.2009210921520.7483@felia>
References: <20200920091706.56276-1-dwaipayanray1@gmail.com> <7958ded756c895ca614ba900aae7b830a992475e.camel@perches.com> <CABJPP5Chm2xd2PW77=Ru9t4C6Yvq3SyEmr1gKsaQGyF5AxRVfA@mail.gmail.com> <52ccb41c8922dda44ac325f2f3e09f81f1936611.camel@perches.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1237931917-1600673978=:7483"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1237931917-1600673978=:7483
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Sun, 20 Sep 2020, Joe Perches wrote:

> On Sun, 2020-09-20 at 21:52 +0530, Dwaipayan Ray wrote:
> > On Sun, Sep 20, 2020 at 8:39 PM Joe Perches <joe@perches.com> wrote:
> > > On Sun, 2020-09-20 at 14:47 +0530, Dwaipayan Ray wrote:
> > > > Checkpatch did not handle cases where the author From: header
> > > > was split into multiple lines. The author identity could not
> > > > be resolved and checkpatch generated a false NO_AUTHOR_SIGN_OFF
> > > > warning.
> > > 
> > I think there won't be any problem. Is my
> > observation correct?
> 
> Likely true, it probably doesn't matter.
> Still, I'd imagine it doesn't hurt either.
> 
> > > What I have does a bit more by saving any post-folding
> > > 
> > > "From: <name and email address>"
> > > 
> > > and comparing that to any "name and perhaps different
> > > email address" in a Signed-off-by: line.
> > > 
> > > A new message is emitted if the name matches but the
> > > email address is different.
> > > 
> > > Perhaps it's reasonable to apply your patch and then
> > > update it with something like the below:
> > > ---
> > >  scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++----
> > >  1 file changed, 28 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > > index 3e474072aa90..1ecc179e938d 100755
> > > --- a/scripts/checkpatch.pl
> > > +++ b/scripts/checkpatch.pl
> > > @@ -1240,6 +1240,15 @@ sub same_email_addresses {
> > >                $email1_address eq $email2_address;
> > >  }
> > > 
> > > +sub same_email_names {
> > > +       my ($email1, $email2) = @_;
> > > +
> > > +       my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
> > > +       my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
> > > +
> > > +       return $email1_name eq $email2_name;
> > > +}
> > > +
> > >  sub which {
> > >         my ($bin) = @_;
> > > 
> > > @@ -2679,20 +2688,32 @@ sub process {
> > >                 }
> > > 
> > >  # Check the patch for a From:
> > > -               if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> > > +               if ($line =~ /^From:\s*(.*)/i) {
> > >                         $author = $1;
> > > -                       $author = encode("utf8", $author) if ($line =~ /=\?utf-8\?/i);
> > > +                       my $curline = $linenr;
> > > +                       while (defined($rawlines[$curline]) && $rawlines[$curline++] =~ /^\s(\s+)?(.*)/) {
> > > +                               $author .= ' ' if (defined($1));
> > > +                               $author .= "$2";
> > > +                       }
> > > +                       if ($author =~ /=\?utf-8\?/i) {
> > > +                               $author = decode("MIME-Header", $author);
> > > +                               $author = encode("utf8", $author);
> > > +                       }
> > > +
> > >                         $author =~ s/"//g;
> > >                         $author = reformat_email($author);
> > >                 }
> > > 
> > >  # Check the patch for a signoff:
> > >                 if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
> > > +                       my $sig = $1;
> > >                         $signoff++;
> > >                         $in_commit_log = 0;
> > >                         if ($author ne '') {
> > > -                               if (same_email_addresses($1, $author)) {
> > > -                                       $authorsignoff = 1;
> > > +                               if (same_email_addresses($sig, $author)) {
> > > +                                       $authorsignoff = "1";
> > > +                               } elsif (same_email_names($sig, $author)) {
> > > +                                       $authorsignoff = $sig;
> > >                                 }
> > >                         }
> > >                 }
> > > @@ -6937,6 +6958,9 @@ sub process {
> > >                 } elsif (!$authorsignoff) {
> > >                         WARN("NO_AUTHOR_SIGN_OFF",
> > >                              "Missing Signed-off-by: line by nominal patch author '$author'\n");
> > > +               } elsif ($authorsignoff ne "1") {
> > > +                       WARN("NO_AUTHOR_SIGN_OFF",
> > > +                            "From:/SoB: email address mismatch: 'From: $author' != 'Signed-off-by: $authorsignoff'\n");
> > >                 }
> > >         }
> > > 
> > > 
> > 
> > Yes, this is definitely more logical !
> > I was actually hoping to talk with you on this.
> 
> Hope granted, but only via email... (smile)
> 
> > The code you sent better handles name mismatches when
> > email addresses are same. But I also have found several
> > such commits in which the author have signed off using
> > a different email address than the one which he/she used
> > to send the patch.
> > 
> > For example, Lukas checked commits between v5.4 and
> > v5.8 and he found:
> >     175 Missing Signed-off-by: line by nominal patch authorrep
> >     'Daniel Vetter <daniel.vetter@ffwll.ch>'
> > 
> > Infact in all of those commits he signed off using a different
> > mail, Daniel Vetter <daniel.vetter@intel.com>.
> > 
> > So is it possible to resolve these using perhaps .mailmap
> > entries? Or should only the name mismatch part be better
> > handled? Or perhaps both?
> 
> Dunno.  It certainly can be improved...
> Try adding some more logic and see what you come up with.
> 
> btw:
> 
> The most frequent NO_AUTHOR_SIGN_OFF messages for v5.7..v5.8 are
> 
>      98 WARNING: From:/SoB: email address mismatch: 'From: Daniel Vetter <daniel.vetter@ffwll.ch>' != 'Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>'
>      24 WARNING: From:/SoB: email address mismatch: 'From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>' != 'Signed-off-by: Thinh Nguyen <thinhn@synopsys.com>'
>      19 WARNING: From:/SoB: email address mismatch: 'From: Wolfram Sang <wsa+renesas@sang-engineering.com>' != 'Signed-off-by: Wolfram Sang <wsa@kernel.org>'
>      11 WARNING: From:/SoB: email address mismatch: 'From: Luke Nelson <lukenels@cs.washington.edu>' != 'Signed-off-by: Luke Nelson <luke.r.nels@gmail.com>'
>       8 WARNING: From:/SoB: email address mismatch: 'From: Christophe Leroy <christophe.leroy@c-s.fr>' != 'Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>'
>       6 WARNING: From:/SoB: email address mismatch: 'From: Davidlohr Bueso <dave@stgolabs.net>' != 'Signed-off-by: Davidlohr Bueso <dbueso@suse.de>'
>       5 WARNING: Missing Signed-off-by: line by nominal patch author '"Paul A. Clarke" <pc@us.ibm.com>'
>       4 WARNING: Missing Signed-off-by: line by nominal patch author 'Huang Ying <ying.huang@intel.com>'
>       3 WARNING: Missing Signed-off-by: line by nominal patch author '"Stephan Müller" <smueller@chronox.de>'
>

Great minds think alike.

I did a similar investigation on Friday after the first discussion with 
Dwaipayan:

https://lore.kernel.org/linux-kernel-mentees/alpine.DEB.2.21.2009181238230.14717@felia/T/#m1bf5f7ca876d33d4d53e492b5d8a6232437c921f

I hope Dwaipayan can come up with a '.AUTHOR_SIGN_OFF.mailmap' file that 
we can use to distinguish the known developers that knowingly and 
intentionally use different identities vs. the 'newbies' that should 
validly be warned.

We will see if Dwaipayan can come up with a good idea how to handle that.

Lukas

> For the Missing Signed-off-by: lines above,
> even after decoding, the email matches but
> the names do not.
> 
> From: "Paul A. Clarke" <pc@us.ibm.com>
> [...]
> Signed-off-by: Paul Clarke <pc@us.ibm.com>
> 
> From: Huang Ying <ying.huang@intel.com>
> [...]
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> 
> From: =?UTF-8?q?Stephan=20M=C3=BCller?= <smueller@chronox.de>
> [...]
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> 
> > Also, I would like to know if there are any more changes
> > required for the current patch or if it is good to go?
> 
> I think it's fine.
> 
> cheers, Joe
> 
> 
--8323329-1237931917-1600673978=:7483--
