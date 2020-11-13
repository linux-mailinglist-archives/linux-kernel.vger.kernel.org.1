Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A412B1BFA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgKMNh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMNh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:37:56 -0500
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85861C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:37:38 -0800 (PST)
Received: by mail-il1-x143.google.com with SMTP id h6so4850397ilj.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2AEhHlPj/3At4rCVZ3doELq0KCFho2fq+gmKFWZRtOg=;
        b=dgQlXiQwvn49c1XSyh36l4vM9pZju2BOLbscdwSdOal0jGc6FTarv0JsEF4lkjNQIF
         FcjPPyGdDnsVLEuqAaXMQKVs9PKiTr5lHNJuWKZzxehWH9v8alk5Ot0DAweMMu0yOY8T
         RvbLxGBKqCJED7/XwYaxAy0/bAMW/aUTHMtVzClSNbuLF9evRzag+Mr0rgWYQ+QS0myX
         DwcUsUOZ5z81bN+SWKNA/4lkZkeo7j/uaZdhyYFVlSNpxQDH1LzHVI3w+OS6UseCSvTl
         +F5iGivDimiNzDohAAsgGeP5LBMg7lY4nrjyzsIVrCpyTB/0nXkzCAxSV4xhvHMBrOdK
         QXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2AEhHlPj/3At4rCVZ3doELq0KCFho2fq+gmKFWZRtOg=;
        b=jg2dky82eHfmpK9jym6YeQuSU1kNB+g+5HlwlOjf5gAvx6NmjbtommPxZfD2jV89K7
         HunV0zop2mT54+3rNj69RqxwtcduWCEtrKn2Zc95x5/RlhwOhwwF2OLJ1Z55RULbtTkk
         ct0ddvlXsK7wp35+CTJrSLJXXL2RPn6NbL+nJbtC5V2URyoLAbXfxHxTpxALUZ3XGUjv
         agR3KHv+/IlHz03900guQ4YpX0+DjOSSus9KWEbEspMjC4RGkX9d1HgBd0z2RGH9bJi7
         kKtmxCNC8Ij6KedCKHBKXxDM+Q9Pc+wwaOXdf3SSf2No7Ged5MLjyIOAmXd1fQ0sdwYJ
         xNzQ==
X-Gm-Message-State: AOAM532g8AHfY2bPf587gGQrIiqHSNkvO+VFTkpoux8WDecDdqdgp4mb
        of6OSyAfTs/v/VaFCRwiDbNFPrf+L+/dVe3NHPc=
X-Google-Smtp-Source: ABdhPJzQCeJxUjqNl8C6r8N8AYjiWiZWZGbj/CHsMl1PkqvObWlxXUxlDHxCG18m57Wf03t9oPyqdQPKIUi2krUTaP8=
X-Received: by 2002:a92:600e:: with SMTP id u14mr1734328ilb.221.1605274657789;
 Fri, 13 Nov 2020 05:37:37 -0800 (PST)
MIME-Version: 1.0
References: <20201113123101.29057-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201113123101.29057-1-dwaipayanray1@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 13 Nov 2020 14:37:27 +0100
Message-ID: <CAKXUXMxS-hF=j8wbwzc4d3x_guaUPs+WH=pK_QAJPEHmxg=5vA@mail.gmail.com>
Subject: Re: [PATCH RFC] checkpatch: add new cases to commit handling
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 1:31 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> Commit extraction in checkpatch fails in some cases.
> One of the most common false positives is a split line
> between "commit" and the git SHA of the commit.
>
> Improve commit handling to reduce false positives.
>
> Improvements:
> - handle split line between commit and git SHA of commit.
> - fix handling of split commit description.
>
> A quick evaluation of 50k commits from v5.4 showed that
> the GIT_COMMIT_ID errors dropped from 1032 to 897. Most
> of these were split lines between commit and its hash.
>

Can you send me the file of the evaluation, e.g., all contexts (two
lines above and two lines below) around the warned line in the commits
where the GIT_COMMIT_ID dropped?

Then, I can do a quick sanity check as well.

Lukas

> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 024514946bed..f5ba2beac008 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2990,6 +2990,16 @@ sub process {
>                         if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
>                                 $orig_desc = $1;
>                                 $hasparens = 1;
> +                       } elsif ($line =~ /^\s*[0-9a-f]{5,}\s+\("([^"]+)"\)/i &&
> +                                defined $rawlines[$linenr-2] &&
> +                                $rawlines[$linenr-2] =~ /\bcommit\s*$/i) {
> +                               $line =~ /^\s*[0-9a-f]{5,}\s+\("([^"]+)"\)/i;
> +                               $orig_desc = $1;
> +                               $hasparens = 1;
> +                               $space = 0;
> +                               $short = 0 if ($line =~ /\b[0-9a-f]{12,40}/i);
> +                               $long = 1 if ($line =~ /\b[0-9a-f]{41,}/i);
> +                               $case = 0 if ($line =~ /\b[0-9a-f]{5,40}[^A-F]/ && $rawlines[$linenr-2] =~ /\b[Cc]ommit\s*$/);
>                         } elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
>                                  defined $rawlines[$linenr] &&
>                                  $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
> @@ -3001,7 +3011,9 @@ sub process {
>                                 $line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
>                                 $orig_desc = $1;
>                                 $rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
> -                               $orig_desc .= " " . $1;
> +                               my $split_desc = $1;
> +                               $split_desc = " $split_desc" if ($line =~ /[\w\,\.]$/);
> +                               $orig_desc .= $split_desc;
>                                 $hasparens = 1;
>                         }
>
> --
> 2.27.0
>
