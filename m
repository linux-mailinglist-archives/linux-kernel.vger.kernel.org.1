Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 576AF2B860D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 21:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgKRUzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:55:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgKRUzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:55:14 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCE1C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:55:14 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s30so5008801lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38YN59hI/1OohBo3xfkLhDrixFhCGfYbFT2uz3ZjEdk=;
        b=Ub+DrnArcqJ04o9u1w0KIxUCBF6WNqFRePnKHQ4T2uAO7hRSXJEuZ1jd3gwCZm1q46
         8ME7GT0DRdKmX+6ZDeaMDTtKyy/4JwVfAZ+GVKjBIPcSmZqvHU/IEymcudYm/CVcZKgk
         UyCdENkKKbIOO/YvZ3CdP/HPaWY+a1bsWqrqpb+iDtAOkfC7HRRb6nXZbNI/j/DE8rNy
         RYQS6bX7lgZuU1ltYrWzi+MUx9JrJ0bGqm2ou9UdG4JWe5lVYjSgIEmt8EVTricsb6ym
         1h0cKLYbjxx+pyz7JpwTBYEM1NUVNzZU2r2kFoUUdcPT7na6PGTGZhLSH8tT0LDN5HuK
         1YQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38YN59hI/1OohBo3xfkLhDrixFhCGfYbFT2uz3ZjEdk=;
        b=ghx5KnpWqCwlTxSBvm/pniYKsL+jo+PrV4UEG1abaPIn5GMH+fGLcf7h1y5rbZB3w5
         Rwc4sxneyJlRQ6jYV011QNA5WVUWuMUiHEs33HTd89Xsk0xLpK3pASGRklUFg1u8FKp2
         OO8M78WN45GFcux5MDZBFgvs9TnItLKGtDoX0ZgArLIbSDCrk398giu1j5zLkDrZsi3d
         L3n2TEHI7ds3EfSPnMsQMdFrDd2I+hrohap7GtVvlHM0KzCRmQL/VT37hMocft4vLZX1
         uCGzFI6SGUZqDKbaFiXCEqi+dN4uX/sk5+3A5FuN0esWbEplmvd/gt2HY4LhuOfM3GVj
         Aniw==
X-Gm-Message-State: AOAM5320dYfDJqfhaPAGESPb5Y5bvniY7x1u0r5r8JKV9H5I4SrqOWpD
        jo6jyb7awDKKAc2B8f20Uwebmc7s4ov26yZEFqDxTJiLCDzHlA==
X-Google-Smtp-Source: ABdhPJzgzfHqvhk3X1p7air2kTUquMMEgw76rrxDTqjVGx8mSkutsMWf5JaUeBftakTkPruFrCi0l98YaE3im55tnb8=
X-Received: by 2002:ac2:598f:: with SMTP id w15mr4105975lfn.148.1605732912583;
 Wed, 18 Nov 2020 12:55:12 -0800 (PST)
MIME-Version: 1.0
References: <20201117201305.108427-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201117201305.108427-1-dwaipayanray1@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Thu, 19 Nov 2020 02:24:41 +0530
Message-ID: <CABJPP5B8dSQ-kQaCQL1KsyJ-TcTwpAPOuOyUbpsNHFWhn6Vr0Q@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix spacing check for return with parentheses
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 1:43 AM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> The spacing check is unreachable for return statements
> followed by an opening parentheses.
> For example:
>
> int foo(int bar, int baz)
> {
>         return(bar+baz);
> }
>
> There should be an error emitted for a space between
> return and the opening parentheses but checkpatch doesn't
> emit one.
>
> Fix the spacing check. Also add --fix option to
> the check.
>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 8da6cde20c68..07feeb3321e2 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5176,10 +5176,13 @@ sub process {
>                                 if ($value =~ m/^\s*$FuncArg\s*(?:\?|$)/) {
>                                         ERROR("RETURN_PARENTHESES",
>                                               "return is not a function, parentheses are not required\n" . $herecurr);
> +                               } elsif ($spacing !~ /\s+/) {
> +                                       if (ERROR("SPACING",
> +                                                 "space required before the open parenthesis '('\n" . $herecurr) &&
> +                                           $fix) {
> +                                               $fixed[$fixlinenr] =~ s/\breturn\s*\(/return \(/;
> +                                       }
>                                 }
> -                       } elsif ($spacing !~ /\s+/) {
> -                               ERROR("SPACING",
> -                                     "space required before the open parenthesis '('\n" . $herecurr);
>                         }
>                 }
>
> --
> 2.27.0

Sorry for the ping Joe. Just wanted to know if this got missed.

Thanks,
Dwaipayan.
