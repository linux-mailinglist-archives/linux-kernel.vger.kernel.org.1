Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD642CC75B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389827AbgLBUBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389621AbgLBUBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:01:32 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792CEC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 12:00:52 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id f18so5218865ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 12:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zsx3zkwwHEFHc2ZqwiwShQ6Q9mkkL7TrgiVkNITirw0=;
        b=VRb2YXjb/uGI6m8amqVXlZvc4Z/qToReryNEMQP81G4BPNKMZhAT/oDKwZKl90cpO3
         +8EtTpFPAOezMTrbgvTftu/hrO2TJ7szYjW5cUDcfWgTsQqfU8YFdXoSXEK/ynzlZLGQ
         f+Hvf0hX0kHjnSe9BmWOik7JERkLWFaeyjiVw9NfdiTL126U4Lf8/PaXyYbfMWxMAJS7
         s5m07net2UoO7keFDh3bzg6tLnEgQqQTqnaqCGRiyT4TEhlwkWEwAlozkkB19JFYEb/F
         jcaVfKpkDUKZaYBgNOu6g3zJgpSPelJK9PuegWMiKWSFriBV+D1f0R3yKDHjuJT3mcOz
         lqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zsx3zkwwHEFHc2ZqwiwShQ6Q9mkkL7TrgiVkNITirw0=;
        b=b0KsSjEnzb7yONVDjrf78zDOqumWv3mPjz9rQsnJRAx7qHCrnLLi+Ye5uTDRqynv/F
         lAr3n7obQ1gyp2sxp7WoDljc+yvH/N8sxfxhmduTIm7VQFAGMTLgUcHOiqTpYXkmjnhN
         CGQWt27zBYrpt2lquzsnPcI0F7HuDQIPJ7yeSRWdQ0mfr2UOEp8zXvq6yCvw114kWoL+
         LmnAny9H6CcYY8CXBr+x7p2Nil2TRYo8BsWJe+KWcCR18RiSCvPHwB9sshHh7ZLZNYjE
         G3gozsxhi0zoSOTuIV7UfB0/IGJ8SA2Xw/vOZ5pNsmHvG+cRqRQCwhvx///0//iJ8jwr
         Qcmg==
X-Gm-Message-State: AOAM530o0DxzCqFAUqtwe/uqPsZWBiL6/ftmwV8R3yFFH4GHwt1dxRYM
        K1rLtBJvmUyWM2/n2Osu/SlQgOLY597czC864BU=
X-Google-Smtp-Source: ABdhPJw/Coroj1JS2bEBOE0eyRmria5NjN2KoFfvTq16hjK/y5AEHWSEdYl4eI/kKpcJcTlLiUAeJskMAYy2+88iYj4=
X-Received: by 2002:a05:651c:cb:: with SMTP id 11mr2025398ljr.159.1606939250839;
 Wed, 02 Dec 2020 12:00:50 -0800 (PST)
MIME-Version: 1.0
References: <20201202101448.8494-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201202101448.8494-1-dwaipayanray1@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 3 Dec 2020 01:30:23 +0530
Message-ID: <CABJPP5DSEb5G6G1O1Gvga_E3bT0DftTp6qcgh4RPSKL8cfus-Q@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: add warning for lines starting with a '#' in
 commit log
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 2, 2020 at 3:45 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> Commit log lines starting with a '#' can be dropped by git if
> the corresponding commit message is reworded by a maintainer.
> This minor error can be easily avoided if checkpatch warns
> for the same.
>
> Add a new check which emits a warning on finding lines starting
> with a '#'. Also add a quick fix by adding a tab in front of
> such lines.
>
> Suggested-by: Peilin Ye <yepeilin.cs@gmail.com>
> Tested-by: Peilin Ye <yepeilin.cs@gmail.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e8c1ed0b1fad..a12edcf4f63a 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2966,6 +2966,15 @@ sub process {
>                         $commit_log_possible_stack_dump = 0;
>                 }
>
> +# Check for lines starting with a #
> +               if ($in_commit_log && $line =~ /^#/) {
> +                       if (WARN("POSSIBLE_IGNORED_LINE",
> +                                "Commit log lines starting with a '#' might be dropped by git.\n" . $herecurr)
> +                           && $fix) {
> +                               $fixed[$fixlinenr] =~ s/^#/\t#/;
> +                       }
> +               }
> +
>  # Check for git id commit length and improperly formed commit descriptions
>                 if ($in_commit_log && !$commit_log_possible_stack_dump &&
>                     $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
> --
> 2.27.0
>
Hi,
This patch may seem trivial but I wanted to send it to you for review
nevertheless.

Peilin had earlier faced this problem in one of his patches which was
mainlined. There were some '#define' lines in the commit log. Due to
some reason the Maintainer had to reword the commit message, and
ultimately those '#define' lines were lost in the tree that was merged.

I am not sure if it would be exactly helpful for regular committers but for
new contributers it might be nice to avoid such a mistake. Do you think
it deserves inclusion in checkpatch?

Thank you,
Dwaipayan.
