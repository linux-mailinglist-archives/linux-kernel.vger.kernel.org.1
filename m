Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB5632858C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 08:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgJGGjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 02:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJGGjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 02:39:05 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4485C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 23:39:05 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 60so1270319otw.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 23:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=65wdk22RjIWoWBAAwwVf87Vz5k90m0lNrkyZZlukbas=;
        b=AC3ZS5wjwlkpoaJpEXgLXDYSjewMbryGkPvbrTzGb0hkzoK50+4TazN6AmjZzX8/Ik
         GkcirNPR6kOV9Q37ivs+uN55UgoZkADZs/r2oQqgbrUS/UI8ZcIhdf5yDPIcBFaZM2Hx
         F1OAndoWfG9nfoT/1RyJkxET4i/bfqW5fDwYL085hvGW8NPcVZmXlzH0jUFFzYD3Ebh0
         eAiLXuT530DKDxRLkdLS8c9RKUXBwc3AYAxGqKkgAQPI4Ib2wILvBUHR9HQ9mhwHyAeR
         HmoBOaj1BSVbiyechD2Yrtujn2nWcotr0ghc3sHttsWKVWFvM1HcQ5voyqGrFKjnQ2r2
         21Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=65wdk22RjIWoWBAAwwVf87Vz5k90m0lNrkyZZlukbas=;
        b=MBuQmYHaQ0F+Bgf+o9PRgGMWyyWzBRrhH9LL4/EN6oLb19fCZX2TxuXlYIjYLmw6/X
         8KFZ1GdsMyIokWqwm9xM5KWKEDcddNleDqbAVtSnTZN3vLPveSKfH9CRkcnWoDKbBAXE
         njz6zjD636YcpwClh0co8h6kS4rVNDjnhwnkDwKt0sa4/dpJ4a1xm5iSnT8jOHpSSmV3
         DyF06KNPWJq0rxgDBSN5gJnUzDKSH1qCjmnAL22Yf1lBHPsM//T1Q4E6Pbc+jgKMiSW5
         impKajrsraqUEcMzhhxf7oBfDsT6NM/urHJXxrKokDS1Kkui0rfeBRIduguHScYsdij5
         lBAg==
X-Gm-Message-State: AOAM531r5TNrNGivMD+oMVabdYO003dPFP8h9Mhcmd/TUQ2XBwABIxJg
        wagQubtgkJqrwoPwpDVq3NrzRhaSXv2FuMylvEc=
X-Google-Smtp-Source: ABdhPJx7bBjdXGYknoGBdkdYHAQ9Fhfp8QfvR5RRX5bvxUp4jahS00i77Lx6HV9Z3zHbCEWo7EvFz9PJYTirXDQczwk=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr924413oth.215.1602052744828;
 Tue, 06 Oct 2020 23:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20201007063315.41585-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201007063315.41585-1-dwaipayanray1@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Wed, 7 Oct 2020 12:08:42 +0530
Message-ID: <CABJPP5AEELQz0t2+34xYQOJ5e5nQzTUUU6UT8ZH0fqm-tacOmg@mail.gmail.com>
Subject: Re: [PATCH v5] checkpatch: add new warnings to author signoff checks.
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 12:03 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> The author signed-off-by checks are currently very vague.
> Cases like same name or same address are not handled separately.
>
> For example, running checkpatch on commit be6577af0cef
> ("parisc: Add atomic64_set_release() define to avoid CPU soft lockups"),
> gives:
>
> WARNING: Missing Signed-off-by: line by nominal patch author
> 'John David Anglin <dave.anglin@bell.net>'
>
> The signoff line was:
> "Signed-off-by: Dave Anglin <dave.anglin@bell.net>"
>
> Clearly the author has signed off but with a slightly different version
> of his name. A more appropriate warning would have been to point out
> at the name mismatch instead.
>
> Previously, the values assumed by $authorsignoff were either 0 or 1
> to indicate whether a proper sign off by author is present.
> Extended the checks to handle four new cases.
>
> $authorsignoff values now denote the following:
>
> 0: Missing sign off by patch author.
>
> 1: Sign off present and identical.
>
> 2: Addresses and names match, but comments differ.
>    "James Watson(JW) <james@gmail.com>", "James Watson <james@gmail.com>"
>
> 3: Addresses match, but names are different.
>    "James Watson <james@gmail.com>", "James <james@gmail.com>"
>
> 4: Names match, but addresses are different.
>    "James Watson <james@watson.com>", "James Watson <james@gmail.com>"
>
> 5: Names match, addresses excluding subaddress details (RFC 5233) match.
>    "James Watson <james@gmail.com>", "James Watson <james+a@gmail.com>"
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 93 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 77 insertions(+), 16 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 31624bbb342e..6e0a0d4603d0 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1163,10 +1163,10 @@ sub parse_email {
>                 }
>         }
>
> +       $comment = trim($comment);
>         $name = trim($name);
>         $name =~ s/^\"|\"$//g;
> -       $name =~ s/(\s*\([^\)]+\))\s*//;
> -       if (defined($1)) {
> +       if ($name =~ s/(\s*\([^\)]+\))\s*//) {
>                 $name_comment = trim($1);
>         }
>         $address = trim($address);
> @@ -1181,10 +1181,12 @@ sub parse_email {
>  }
>
>  sub format_email {
> -       my ($name, $address) = @_;
> +       my ($name, $name_comment, $address, $comment) = @_;
>
>         my $formatted_email;
>
> +       $name_comment = trim($name_comment);
> +       $comment = trim($comment);
>         $name = trim($name);
>         $name =~ s/^\"|\"$//g;
>         $address = trim($address);
> @@ -1197,9 +1199,9 @@ sub format_email {
>         if ("$name" eq "") {
>                 $formatted_email = "$address";
>         } else {
> -               $formatted_email = "$name <$address>";
> +               $formatted_email = "$name$name_comment <$address>";
>         }
> -
> +       $formatted_email .= "$comment";
>         return $formatted_email;
>  }
>
> @@ -1207,17 +1209,23 @@ sub reformat_email {
>         my ($email) = @_;
>
>         my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
> -       return format_email($email_name, $email_address);
> +       return format_email($email_name, $name_comment, $email_address, $comment);
>  }
>
>  sub same_email_addresses {
> -       my ($email1, $email2) = @_;
> +       my ($email1, $email2, $match_comment) = @_;
>
>         my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
>         my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
>
> +       if ($match_comment != 1) {
> +               return $email1_name eq $email2_name &&
> +                      $email1_address eq $email2_address;
> +       }
>         return $email1_name eq $email2_name &&
> -              $email1_address eq $email2_address;
> +              $email1_address eq $email2_address &&
> +              $name1_comment eq $name2_comment &&
> +              $comment1 eq $comment2;
>  }
>
>  sub which {
> @@ -2347,6 +2355,7 @@ sub process {
>         my $signoff = 0;
>         my $author = '';
>         my $authorsignoff = 0;
> +       my $author_sob = '';
>         my $is_patch = 0;
>         my $is_binding_patch = -1;
>         my $in_header_lines = $file ? 0 : 1;
> @@ -2674,9 +2683,37 @@ sub process {
>                 if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
>                         $signoff++;
>                         $in_commit_log = 0;
> -                       if ($author ne '') {
> -                               if (same_email_addresses($1, $author)) {
> +                       if ($author ne ''  && $authorsignoff != 1) {
> +                               if (same_email_addresses($1, $author, 1)) {
>                                         $authorsignoff = 1;
> +                               } else {
> +                                       my $ctx = $1;
> +                                       my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
> +                                       my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
> +
> +                                       if ($email_address eq $author_address && $email_name eq $author_name) {
> +                                               $author_sob = $ctx;
> +                                               $authorsignoff = 2;
> +                                       } elsif ($email_address eq $author_address) {
> +                                               $author_sob = $ctx;
> +                                               $authorsignoff = 3;
> +                                       } elsif ($email_name eq $author_name) {
> +                                               $author_sob = $ctx;
> +                                               $authorsignoff = 4;
> +
> +                                               my $address1 = $email_address;
> +                                               my $address2 = $author_address;
> +
> +                                               if ($address1 =~ /(\S+)\+\S+(\@.*)/) {
> +                                                       $address1 = "$1$2";
> +                                               }
> +                                               if ($address2 =~ /(\S+)\+\S+(\@.*)/) {
> +                                                       $address2 = "$1$2";
> +                                               }
> +                                               if ($address1 eq $address2) {
> +                                                       $authorsignoff = 5;
> +                                               }
> +                                       }
>                                 }
>                         }
>                 }
> @@ -2733,7 +2770,7 @@ sub process {
>                         }
>
>                         my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
> -                       my $suggested_email = format_email(($email_name, $email_address));
> +                       my $suggested_email = format_email(($email_name, $name_comment, $email_address, $comment));
>                         if ($suggested_email eq "") {
>                                 ERROR("BAD_SIGN_OFF",
>                                       "Unrecognized email address: '$email'\n" . $herecurr);
> @@ -2743,9 +2780,9 @@ sub process {
>                                 $dequoted =~ s/" </ </;
>                                 # Don't force email to have quotes
>                                 # Allow just an angle bracketed address
> -                               if (!same_email_addresses($email, $suggested_email)) {
> +                               if (!same_email_addresses($email, $suggested_email, 0)) {
>                                         WARN("BAD_SIGN_OFF",
> -                                            "email address '$email' might be better as '$suggested_email$comment'\n" . $herecurr);
> +                                            "email address '$email' might be better as '$suggested_email'\n" . $herecurr);
>                                 }
>                         }
>
> @@ -6891,9 +6928,33 @@ sub process {
>                 if ($signoff == 0) {
>                         ERROR("MISSING_SIGN_OFF",
>                               "Missing Signed-off-by: line(s)\n");
> -               } elsif (!$authorsignoff) {
> -                       WARN("NO_AUTHOR_SIGN_OFF",
> -                            "Missing Signed-off-by: line by nominal patch author '$author'\n");
> +               } elsif ($authorsignoff != 1) {
> +                       # authorsignoff values:
> +                       # 0 -> missing sign off
> +                       # 1 -> sign off identical
> +                       # 2 -> names and addresses match, comments mismatch
> +                       # 3 -> addresses match, names different
> +                       # 4 -> names match, addresses different
> +                       # 5 -> names match, addresses excluding subaddress details (refer RFC 5233) match
> +
> +                       my $sob_msg = "'From: $author' != 'Signed-off-by: $author_sob'";
> +
> +                       if ($authorsignoff == 0) {
> +                               ERROR("NO_AUTHOR_SIGN_OFF",
> +                                     "Missing Signed-off-by: line by nominal patch author '$author'\n");
> +                       } elsif ($authorsignoff == 2) {
> +                               CHK("NO_AUTHOR_SIGN_OFF",
> +                                   "From:/Signed-off-by: email comments mismatch: $sob_msg\n");
> +                       } elsif ($authorsignoff == 3) {
> +                               WARN("NO_AUTHOR_SIGN_OFF",
> +                                    "From:/Signed-off-by: email name mismatch: $sob_msg\n");
> +                       } elsif ($authorsignoff == 4) {
> +                               WARN("NO_AUTHOR_SIGN_OFF",
> +                                    "From:/Signed-off-by: email address mismatch: $sob_msg\n");
> +                       } elsif ($authorsignoff == 5) {
> +                               WARN("NO_AUTHOR_SIGN_OFF",
> +                                    "From:/Signed-off-by: email subaddress mismatch: $sob_msg\n");
> +                       }
>                 }
>         }
>
> --
> 2.27.0
>

Hi,
I needed to change a bit in a few subroutines which trimmed off
the comments. Comments now appear in the formatted email.
The usage is also refactored so that it doesn't cause any undesired
effects.

Coming back to the signoff check, now email comments are also
compared.

Cases like:
"Dwaipayan Ray(Dwai) <dwaipayanray1@gmail.com>" and
"Dwaipayan Ray <dwaipayanray1@gmail.com>", now generate
a --strict CHK.

Thanks,
Dwaipayan.
