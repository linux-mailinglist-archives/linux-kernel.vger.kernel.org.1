Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08CA32AEEC8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 11:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbgKKKbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 05:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726229AbgKKKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 05:31:08 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8345C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:31:07 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id k1so1496810ilc.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 02:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBSaTVNMPfPGHhUMYI+hLxMazSzPKmRe0TGeaaYm9k0=;
        b=NBf76nxF8SYIXnF1uxIp6uEJk1vKHazjN5TMSYYJlKXeCPRNA3pnhuMtd0P1ZNSpME
         3mja89cGywM7iTDWtb3OdMU2Avz9uX7px03SspZYe5GkejHSzqHKxGmfn4g8tOPegQtx
         SbhG9IPeQNhP7TITrcAw7vLteIANRbifk1YnO3ewF9yVMk9Hx7HnLY9m1bPiSYVZReZ3
         ZcULoQDJ5pn8p8nr8hQAAqiEwzy5eV2D8IgC3stZ384ebbCI3jPaohUfoycuUOStnNxl
         scCt8LtnWmvreD9qMP5xUhBcXoQGW4l1SjYiT1BH6jDGIQovDaV7kqAjDVgD6cb8NKMb
         vH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBSaTVNMPfPGHhUMYI+hLxMazSzPKmRe0TGeaaYm9k0=;
        b=K3o0+SDXwZST3Je6YtR/CfACOCKGrypMtzwBvDOVXNqkE9P8hCC8TUrzKHZl9Q1qi/
         l01Fp3FyjcTDYv3M5gou7KXjc4NBp5timgNP/ORD2pWXtT3eLydnyfLH2PQod0tiHro+
         Mr7XJWTRz6IfaOFq89JCZcOSpPsZntftgqIusJ2wrqnRjUSDUILg7jwqvmRTyI4B2M2s
         VCN78LO9FasCpz3+uQQIwJpbnF35EfBsTbsV3ixf9RjqCckotiLeI+R7MqYdwJw15ROt
         gnzWeenq/dNlgCbzmolWkLhaVAr5TvmvFTAQZ5lI2F1QjNUhDjMSce8c46e136e78NDW
         fmPA==
X-Gm-Message-State: AOAM530vq4gemvT7ktz0FFgoq53yQCvdmbd37+GM28IRbuCfcAdIt9u9
        REZ6PUd9nYog+pfyEEDkzZWy/27VaEpyqPYzirXDbwvF6VMQ/Q==
X-Google-Smtp-Source: ABdhPJz4jKYLr4F43q8xNORwFZsZCagRvl3wgei5q+sYGOnSxVMPwutCYElFaUeTKeaIzpu07E2zccDIiIQQro5noPU=
X-Received: by 2002:a92:cb51:: with SMTP id f17mr17208165ilq.64.1605090667090;
 Wed, 11 Nov 2020 02:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20201111090143.9230-1-yashsri421@gmail.com>
In-Reply-To: <20201111090143.9230-1-yashsri421@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 11 Nov 2020 11:30:58 +0100
Message-ID: <CAKXUXMzg6Wg310s-N8hWOEiXFkg1ZAga+NkFQkFQ5_bS16TLnA@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add fix option for MISSING_SIGN_OFF
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 11, 2020 at 10:01 AM Aditya Srivastava <yashsri421@gmail.com> wrote:
>
> Currently checkpatch warns us if there is no 'Signed-off-by' line
> for the patch.
>
> E.g., running checkpatch on commit 9ac060a708e0 ("leaking_addresses:
> Completely remove --version flag") reports this error:
>
> ERROR: Missing Signed-off-by: line(s)
>
> Provide a fix by adding a Signed-off-by line corresponding to the author
> of the patch before the patch separator line. Also avoid this error for
> the commits where some typo is present in the sign off.
>
> E.g. for commit 8cde5d5f7361 ("bus: ti-sysc: Detect omap4 type timers
> for quirk") we get missing sign off as well as bad sign off for:
>
> Siganed-off-by: Tony Lindgren <tony@atomide.com>
>
> Here it is probably best to give BAD_SIGN_OFF warning for Non-standard
> signature and avoid MISSING_SIGN_OFF
>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> Changes in v2:
> Add space after 'if'
> Add check for $patch_separator_linenr to be greater than 0
>
>  scripts/checkpatch.pl | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index cb46288127ac..ac7e5ac80b58 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2404,6 +2404,8 @@ sub process {
>
>         my $last_blank_line = 0;
>         my $last_coalesced_string_linenr = -1;
> +       my $patch_separator_linenr = 0;
> +       my $non_standard_signature = 0;
>
>         our @report = ();
>         our $cnt_lines = 0;
> @@ -2755,6 +2757,10 @@ sub process {
>                 if ($line =~ /^---$/) {
>                         $has_patch_separator = 1;
>                         $in_commit_log = 0;
> +                       # to add missing sign off line before diff(s)
> +                       if ($patch_separator_linenr == 0) {
> +                               $patch_separator_linenr = $linenr;
> +                       }
>                 }
>
>  # Check if MAINTAINERS is being updated.  If so, there's probably no need to
> @@ -2775,6 +2781,9 @@ sub process {
>                         if ($sign_off !~ /$signature_tags/) {
>                                 WARN("BAD_SIGN_OFF",
>                                      "Non-standard signature: $sign_off\n" . $herecurr);
> +
> +                               # to avoid missing_sign_off error as it most probably is just a typo
> +                               $non_standard_signature = 1;
>                         }
>                         if (defined $space_before && $space_before ne "") {
>                                 if (WARN("BAD_SIGN_OFF",
> @@ -7118,9 +7127,12 @@ sub process {
>                       "Does not appear to be a unified-diff format patch\n");
>         }
>         if ($is_patch && $has_commit_log && $chk_signoff) {
> -               if ($signoff == 0) {
> -                       ERROR("MISSING_SIGN_OFF",
> -                             "Missing Signed-off-by: line(s)\n");
> +               if ($signoff == 0 && !$non_standard_signature) {
> +                       if (ERROR("MISSING_SIGN_OFF",
> +                                 "Missing Signed-off-by: line(s)\n") &&
> +                           $fix && $patch_separator_linenr > 0) {
> +                               fix_insert_line($patch_separator_linenr - 1, "Signed-off-by: $author");
> +                       }

Maybe I am already digging too much in the details... however:

I think it should still warn about a Missing Signed-off-by: even when
we know there is a $non_standard_signature. So, checkpatch simply
emits two warnings; that is okay in that case.

It is just that our evaluation shows that the provided fix option
should not be suggested when there is a $non_standard_signature
because we actually would predict that there is typo in the intended
Signed-off-by tag and the fix that checkpatch would suggest would not
be adequate.

Joe, what is your opinion?

Aditya, it should not be too difficult to implement the rule that way, right?


>                 } elsif ($authorsignoff != 1) {
>                         # authorsignoff values:
>                         # 0 -> missing sign off
> --
> 2.17.1
>
