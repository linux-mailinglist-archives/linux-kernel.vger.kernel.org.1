Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D714290F9C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 07:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436741AbgJQFtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 01:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436732AbgJQFtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 01:49:42 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9640EC05BD20
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:33:18 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id f22so1923198ots.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 21:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyIT3KDc657FTDBbPllL5gNl/9qPglQwQSgiFUmTmhQ=;
        b=n2KJOrItLONyucDgNwFYobyDFs+b1ckgNXl7VW6UicOXTWsHj4WlMojIBI8GjDuXUd
         dWaRkMXZ+crAOGyvKniSSTRXa4B/fR6HDfFjXaBr64MtGomUiqZycIaGThuD/OH9/KfC
         aCD90YLR1yYkXLpLtA2IQenlyiJSoggpORClX35oxO6TufDvF1ivvltx3E4CormVde3G
         QK91RM94BoA4sjbPldMNGdVGjWdYHkszL4ufG7KZysaQbRO8y9A8jTLt9ZVSF3r0dkfF
         kudkS3O1kSBOpwkaQv3ClJjJYTJLEkdfYLoM2IBFJ9Gzn74zA7c96k5mxF7Vos8bcFdr
         IrUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyIT3KDc657FTDBbPllL5gNl/9qPglQwQSgiFUmTmhQ=;
        b=Fp6WdWB3+Lnfjl/3rM/RKWiMtHbDUPCTHGQVWhEzUMg1CJcdPSbVDIpzRMk8ElELkI
         nv/iMl6XtzoZhlEsnUYWx0Y5Zyjhne8+bf2xvVgzyLgX63OMiOCYoncAAl8AcEHFizu3
         xKKUnwMC4Oxvsl6m02b3HdJRJ5jOUkCGeQr1Kig30Y0ENrqoRrFt8cuu/degjquFkdq0
         jCrcMpTQnr+4Xm0goivRxXszgJbZNesClBIqLUaVJnv+UCn5W0sARWTy9t8pVckNBT5W
         WBXzT7lwzOo45m9Lfqpo8jXEqNLMqHX8oAVd76L69UDwS80WDhgjFBDUPUqHkbG3f9xK
         UuEA==
X-Gm-Message-State: AOAM532/JU4eC7A9XZa+1Z+TY8Ld6jWQnSbZuBRZj5Eglj/X6e0hgeAe
        9MHZvp7cqSIn2CBiteQmu4iZg1dfJyqPgt9y0Wg=
X-Google-Smtp-Source: ABdhPJx8xcFVIZjN/KaRIv7WT3MHFAHET8yuV8lcDte3eCZ+pmCVMZSbMAQsl1HKfTHIveyLvYG46KW2kxUqO61TOlQ=
X-Received: by 2002:a9d:53cc:: with SMTP id i12mr4772542oth.215.1602909197796;
 Fri, 16 Oct 2020 21:33:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201014163738.117332-1-dwaipayanray1@gmail.com>
 <ea011df1e30ce445d51e128287e2c6c38de20949.camel@perches.com>
 <CABJPP5DrSL7GoZUWc7P02CfLHfTBmfpLxrVOVQ08KH3pPontoA@mail.gmail.com>
 <7d8c7d80aa7b0524cca49a6dfe24e878bea6ab12.camel@perches.com> <81b6a0bb2c7b9256361573f7a13201ebcd4876f1.camel@perches.com>
In-Reply-To: <81b6a0bb2c7b9256361573f7a13201ebcd4876f1.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sat, 17 Oct 2020 10:02:51 +0530
Message-ID: <CABJPP5DjmY8N18XOhikHymiwkF9h213Rwi-ffQiBvKSrw2WqyA@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add new exception to repeated word check
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 8:26 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-10-14 at 11:35 -0700, Joe Perches wrote:
> > On Wed, 2020-10-14 at 23:42 +0530, Dwaipayan Ray wrote:
> > > On Wed, Oct 14, 2020 at 11:33 PM Joe Perches <joe@perches.com> wrote:
> > > > On Wed, 2020-10-14 at 22:07 +0530, Dwaipayan Ray wrote:
> > > > > Recently, commit 4f6ad8aa1eac ("checkpatch: move repeated word test")
> > > > > moved the repeated word test to check for more file types. But after
> > > > > this, if checkpatch.pl is run on MAINTAINERS, it generates several
> > > > > new warnings of the type:
> > > >
> > > > Perhaps instead of adding more content checks so that
> > > > word boundaries are not something like \S but also
> > > > not punctuation so that content like
> > > >
> > > >         git git://
> > > >         @size size
> > > >
> > > > does not match?
> > > >
> > > >
> > > Hi,
> > > So currently the words are trimmed of non alphabets before the check:
> > >
> > > while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
> > > my $first = $1;
> > > my $second = $2;
> > >
> > > where, the word_pattern is:
> > > my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
> >
> > I'm familiar.
> >
> > > So do you perhaps recommend modifying this word pattern to
> > > include the punctuation as well rather than trimming them off?
> >
> > Not really, perhaps use the capture group position
> > markers @- @+ or $-[1] $+[1] and $-[2] $+[2] with the
> > substr could be used to see what characters are
> > before and after the word matches.
>
> Perhaps something like:
> ---
>  scripts/checkpatch.pl | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fab38b493cef..a65eb40a5539 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3054,15 +3054,25 @@ sub process {
>
>                                 my $first = $1;
>                                 my $second = $2;
> +                               my $start_pos = $-[1];
> +                               my $end_pos = $+[2];
>
>                                 if ($first =~ /(?:struct|union|enum)/) {
>                                         pos($rawline) += length($first) + length($second) + 1;
>                                         next;
>                                 }
>
> -                               next if ($first ne $second);
> +                               next if (lc($first) ne lc($second));
>                                 next if ($first eq 'long');
>
> +                               my $start_char = "";
> +                               my $end_char = "";
> +                               $start_char = substr($rawline, $start_pos - 1, 1) if ($start_pos > 0);
> +                               $end_char = substr($rawline, $end_pos, 1) if (length($rawline) > $end_pos);
> +
> +                               next if ($start_char =~ /^\S$/);
> +                               next if ($end_char !~ /^[\.\,\s]?$/);
> +
>                                 if (WARN("REPEATED_WORD",
>                                          "Possible repeated word: '$first'\n" . $herecurr) &&
>                                     $fix) {
>
>

Hi Joe,
Thank you for the insight. I was also doing something similar:

---
 scripts/checkpatch.pl | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f1a4e61917eb..82497a71ac96 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -595,6 +595,7 @@ our @mode_permission_funcs = (
 );

 my $word_pattern = '\b[A-Z]?[a-z]{2,}\b';
+my $punctuation_chars = '[,:;@\.\-]';

 #Create a search pattern for all these functions to speed up a loop below
 our $mode_perms_search = "";
@@ -3065,6 +3066,21 @@ sub process {
  next if ($first ne $second);
  next if ($first eq 'long');

+ # check for character before and after the word matches
+ my $ca_first = substr($rawline, $-[1]-1, 1);
+ my $cb_first = substr($rawline, $+[1], 1);
+ my $ca_second = substr($rawline, $-[2]-1, 1);
+ my $cb_second = substr($rawline, $+[2], 1);
+
+ if ($ca_first ne $ca_second || $cb_first ne $cb_second) {
+ if ($ca_first =~ /$punctuation_chars/ ||
+     $ca_second =~ /$punctuation_chars/ ||
+     $cb_first =~ /$punctuation_chars/ ||
+     $cb_second =~ /$punctuation_chars/) {
+ next;
+ }
+ }
+
  if (WARN("REPEATED_WORD",
  "Possible repeated word: '$first'\n" . $herecurr) &&
      $fix) {

Does it look okay to you??

Thanks,
Dwaipayan.
