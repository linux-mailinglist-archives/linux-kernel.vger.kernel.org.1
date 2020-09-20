Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B332715E8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Sep 2020 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgITQWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 12:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgITQWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 12:22:55 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB54C061755
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 09:22:55 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id u25so10204329otq.6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Sep 2020 09:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xZMsjHES2JkQppfh78+nVAA/YCyJVWwIWXmUSZhXQdk=;
        b=Aj5JogNyXXtVg46wjnTYgsXewq0ZEjknre7fyHM2dCA86IR0/sSX/kqE46Z3rXx1Y5
         yYpFPzEaCgnrMXQPyHZ70ctNe5Qf1dY9FJj0YeFqmLyqsJs2IXmDnvrbKCZ7oLOTv61l
         w0aTaVWK+AK5hW54gEHnMvLMOQBDvWMcFtT5Z8Eq16vZNvjscz7wSidKmh74eiENIy6J
         smK2mC8kgOO0BO/5N7dxcHiWrbHXJm8u0qa7+OtId584vGkO9wqis0hUZUFwnR++0Vdq
         PEXR+kd1f6oIwTA/PO2KQyW4djgoAOedyKhESWp6xqaTdpkq+l2jPeOBXxyOdcgzfCQX
         t8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xZMsjHES2JkQppfh78+nVAA/YCyJVWwIWXmUSZhXQdk=;
        b=eiaCSq7STt84Ym1wic5m0MuwkeK6bTTCe6n1Q3/7wFHX2VZ55Zh5UB88Zm8wpqnuj2
         BMoeUcXcGyWGGl/eBGRpb4AuEYNIh+09G9K7BMkEZknkpProjp/JKSTzWvJQRHeHasgr
         UGK7hig3X5hmLsXL4WFchOkhI452/eFo8+hDFfeJs75k7LCdo+e4dj8pi7MzdbqdhXMB
         J+9J6Ivvr5bxiyj7CGK0Y3ICMc1b+QcVudxAAQFXTKTbGjHHX1pn9MgW1a4x/No8dx4C
         QcIwUCULfzrq6lxmKdEwAKVo/NZ0tF4StEKRLE8n5aLkETVyMi4S15TgG4+JoZA6LJUk
         O8Dg==
X-Gm-Message-State: AOAM530t5FcW7PQ7sGX00E79rhUvhOXFYf8bSZlFCcRsJplx1vRRkL/7
        q9qbLOtEx1k06DyvZ5Sk+A6lpUUHd/lOSeIYRS8=
X-Google-Smtp-Source: ABdhPJxeBoTOuKwgDtBt7N8FHrvLPmcVHy0o1Py6yok9SDfNlZ/Rb44Ck8nNx0bK6KXPY959C9CscGa1/NdGZ1TZRWQ=
X-Received: by 2002:a9d:4b18:: with SMTP id q24mr28075180otf.265.1600618974319;
 Sun, 20 Sep 2020 09:22:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200920091706.56276-1-dwaipayanray1@gmail.com> <7958ded756c895ca614ba900aae7b830a992475e.camel@perches.com>
In-Reply-To: <7958ded756c895ca614ba900aae7b830a992475e.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 20 Sep 2020 21:52:34 +0530
Message-ID: <CABJPP5Chm2xd2PW77=Ru9t4C6Yvq3SyEmr1gKsaQGyF5AxRVfA@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: extend author Signed-off-by check for
 split From: header
To:     Joe Perches <joe@perches.com>
Cc:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org, apw@canonical.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 8:39 PM Joe Perches <joe@perches.com> wrote:
>
> On Sun, 2020-09-20 at 14:47 +0530, Dwaipayan Ray wrote:
> > Checkpatch did not handle cases where the author From: header
> > was split into multiple lines. The author identity could not
> > be resolved and checkpatch generated a false NO_AUTHOR_SIGN_OFF
> > warning.
>
> Hi Dwaipayan.
>
> > A typical example is Commit e33bcbab16d1 ("tee: add support for
> > session's client UUID generation"). When checkpatch was run on
> > this commit, it displayed:
> >
> > "WARNING:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal
> > patch author ''"
> >
> > This was due to split header lines not being handled properly and
> > the author himself wrote in Commit cd2614967d8b ("checkpatch: warn
> > if missing author Signed-off-by"):
> >
> > "Split From: headers are not fully handled: only the first part
> > is compared."
> >
> > Support split From: headers by correctly parsing the header
> > extension lines. RFC 2822, Section-2.2.3 stated that each extended
> > line must start with a WSP character (a space or htab). The solution
> > was therefore to concatenate the lines which start with a WSP to
> > get the correct long header.
>
> This is a good commit message, though I believe the
> latest rfc is 5322.  I'm not sure there is any real
> difference in the referenced section though.
>
> While your patch seems to work for git format-email,
> other emailers seem to set headers that have multiple
> whitespace chars that should be collapsed into a
> single space.
>
> I think you'll find that the eliding all whitespace
> after header folding causes mismatches for emails.
>
> For instance:
>
> From:   "=3D?UTF-8?q?Christian=3D20K=3DC3=3DB6nig?=3D"
>         <ckoenig.leichtzumerken@gmail.com>
>
> Always inserting a single space if there is any
> whitespace after the folding WSP might be better
> otherwise this is decoded as
>
> From: "Christian K=C3=B6nig"<ckoenig.leichtzumerken@gmail.com>
>

Hi,
I think eliding all whitespaces shouldn't cause an issue
because at the end of the From: header parser block,
there is a call to reformat_email($author).

   $author =3D~ s/"//g;
   $author =3D reformat_email($author);

The subroutine reformat_email reparses the author string such
that the correct name <address> format is maintainined.

In revision b3b33d3c43bb,
line 1206:
sub reformat_email {
    my ($email) =3D @_;
    my ($email_name, $name_comment, $email_address,
$comment) =3D parse_email($email);
    return format_email($email_name, $email_address);
}

And I also checked the format_email subroutine:
line 1997:
if ("$name" eq "") {
    $formatted_email =3D "$address";
} else {
    $formatted_email =3D "$name <$address>";
}
return $formatted_email;

So I think the author string is basically reconstructed to
maintain the correct format.

As you pointed out, at first the author string might be:
  "Christian K=C3=B6nig"<ckoenig.leichtzumerken@gmail.com>

But after reformat_email is called, $author should be:
  Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>

So, I think there won't be any problem. Is my
observation correct?


> What I have does a bit more by saving any post-folding
>
> "From: <name and email address>"
>
> and comparing that to any "name and perhaps different
> email address" in a Signed-off-by: line.
>
> A new message is emitted if the name matches but the
> email address is different.
>
> Perhaps it's reasonable to apply your patch and then
> update it with something like the below:
> ---
>  scripts/checkpatch.pl | 32 ++++++++++++++++++++++++++++----
>  1 file changed, 28 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 3e474072aa90..1ecc179e938d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1240,6 +1240,15 @@ sub same_email_addresses {
>                $email1_address eq $email2_address;
>  }
>
> +sub same_email_names {
> +       my ($email1, $email2) =3D @_;
> +
> +       my ($email1_name, $name1_comment, $email1_address, $comment1) =3D=
 parse_email($email1);
> +       my ($email2_name, $name2_comment, $email2_address, $comment2) =3D=
 parse_email($email2);
> +
> +       return $email1_name eq $email2_name;
> +}
> +
>  sub which {
>         my ($bin) =3D @_;
>
> @@ -2679,20 +2688,32 @@ sub process {
>                 }
>
>  # Check the patch for a From:
> -               if (decode("MIME-Header", $line) =3D~ /^From:\s*(.*)/) {
> +               if ($line =3D~ /^From:\s*(.*)/i) {
>                         $author =3D $1;
> -                       $author =3D encode("utf8", $author) if ($line =3D=
~ /=3D\?utf-8\?/i);
> +                       my $curline =3D $linenr;
> +                       while (defined($rawlines[$curline]) && $rawlines[=
$curline++] =3D~ /^\s(\s+)?(.*)/) {
> +                               $author .=3D ' ' if (defined($1));
> +                               $author .=3D "$2";
> +                       }
> +                       if ($author =3D~ /=3D\?utf-8\?/i) {
> +                               $author =3D decode("MIME-Header", $author=
);
> +                               $author =3D encode("utf8", $author);
> +                       }
> +
>                         $author =3D~ s/"//g;
>                         $author =3D reformat_email($author);
>                 }
>
>  # Check the patch for a signoff:
>                 if ($line =3D~ /^\s*signed-off-by:\s*(.*)/i) {
> +                       my $sig =3D $1;
>                         $signoff++;
>                         $in_commit_log =3D 0;
>                         if ($author ne '') {
> -                               if (same_email_addresses($1, $author)) {
> -                                       $authorsignoff =3D 1;
> +                               if (same_email_addresses($sig, $author)) =
{
> +                                       $authorsignoff =3D "1";
> +                               } elsif (same_email_names($sig, $author))=
 {
> +                                       $authorsignoff =3D $sig;
>                                 }
>                         }
>                 }
> @@ -6937,6 +6958,9 @@ sub process {
>                 } elsif (!$authorsignoff) {
>                         WARN("NO_AUTHOR_SIGN_OFF",
>                              "Missing Signed-off-by: line by nominal patc=
h author '$author'\n");
> +               } elsif ($authorsignoff ne "1") {
> +                       WARN("NO_AUTHOR_SIGN_OFF",
> +                            "From:/SoB: email address mismatch: 'From: $=
author' !=3D 'Signed-off-by: $authorsignoff'\n");
>                 }
>         }
>
>

Yes, this is definitely more logical !
I was actually hoping to talk with you on this.

The code you sent better handles name mismatches when
email addresses are same. But I also have found several
such commits in which the author have signed off using
a different email address than the one which he/she used
to send the patch.

For example, Lukas checked commits between v5.4 and
v5.8 and he found:
    175 Missing Signed-off-by: line by nominal patch author
    'Daniel Vetter <daniel.vetter@ffwll.ch>'

Infact in all of those commits he signed off using a different
mail, Daniel Vetter <daniel.vetter@intel.com>.

So is it possible to resolve these using perhaps .mailmap
entries? Or should only the name mismatch part be better
handled? Or perhaps both?

Also, I would like to know if there are any more changes
required for the current patch or if it is good to go?

Thanks,
Dwaipayan.
