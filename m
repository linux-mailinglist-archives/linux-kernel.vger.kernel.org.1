Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6A752C712B
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391457AbgK1Vyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387466AbgK1TKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:10:10 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CF7C0613D2
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 11:04:53 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id s30so12102936lfc.4
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 11:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KNduoI8qKkOaqH9OplqR6gXUvNyU96HOmEaMo4UKo28=;
        b=Fw4VjAK0k2f45/RyAk2L6rCTO70B40EJ4WLuGHfpk+S9nr7lGeetJhQoNpM/MM+Qfl
         xgy9F1GB6aSvrPTSWlh6mxHQSpaYn2wJodn3RNDEbkS3WtwLNltmvKXYjpuAx48dXwYq
         v8t+OSNz4LWPKAYf1OUS04kUV4SitUoIbQ36p4POV3m9j9/S1tpj+t9z9HRT1+LRkX23
         p07a9KqESn7T0K093YAZf0JZyjSQh39yKHa6w4Bfnkngo0C89SiBdrbpYDgCO/1+1mXY
         2BYLTWgP+oX90p9BbyYVUHalhlt/Ioph1gXtq/L2obhvYukSdfoo144SvYkQ7yswXV9m
         g+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KNduoI8qKkOaqH9OplqR6gXUvNyU96HOmEaMo4UKo28=;
        b=dKyNDlUhXKxcz3t+en18kzxNtDLJ5ZdbOWtm4q9LuhX7ptFL5sY1JQL99LsIolvxcO
         sSdomDn/RUgJRDbZCqZyTgUtQRxdJPjvHujweiiKC8ES5hBBjSjGm0CNMvEDN2UmKn4A
         TB4DzckEv9z3ZHpPqvfMna2tWeHs9Obp009eczLAL2uJB+P8wSVwPGo1Th257jL+6MK8
         w47BdpAdcXqVxIr+eLfPjTXbIlfHyu9GPbu2/+5GJL7959h4sCXJW6h+TrXMWIeMZQRg
         wUrrlrmaY5bEDI/io3aBF8R86e2j/MvaaimIFTpb9LI41URcH7zkqZtlD0Ailnuamx3j
         jJyA==
X-Gm-Message-State: AOAM530p5k6xOXJpE5XOlZsGs4RUrbcD7dl6VryuwF5akmgwQBZiDjgh
        hw99orPwAnod6oSpVuD0Y2buUvXKUTXlsx99Ebbjl1Q7vJ+liQ==
X-Google-Smtp-Source: ABdhPJwT9+uvMLE6epWApcdZ1uhE14NXm3aK/qKbLRVPvaGFy3VqUEOPbnSZ2ZV642WtZIxrVQ7fuAps1M2gqjpK48Y=
X-Received: by 2002:ac2:4199:: with SMTP id z25mr5985287lfh.148.1606590292006;
 Sat, 28 Nov 2020 11:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20201128173850.66509-1-dwaipayanray1@gmail.com> <55d38c770a3316a3c67f5380ffb8ed37540900da.camel@perches.com>
In-Reply-To: <55d38c770a3316a3c67f5380ffb8ed37540900da.camel@perches.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Sun, 29 Nov 2020 00:34:40 +0530
Message-ID: <CABJPP5AodovE61WiEup_191pVwptEzg8sVuG6QxeMVbM94wpNw@mail.gmail.com>
Subject: Re: [PATCH v3] checkpatch: add warning for unnecessary use of
 %h[xudi] and %hh[xudi]
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Here was what I tried:
>
> There are uses like %#06hh", so # was addedto the format block
> and multiple line uses were also inspected.
>
>
>  scripts/checkpatch.pl | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 7dc094445d83..b985b6b37ba8 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -6027,6 +6027,29 @@ sub process {
>                              "Avoid logging continuation uses where feasible\n" . $herecurr);
>                 }
>
> +# check for unnecessary use of %h[xudi] and %hh[xudi] in logging functions
> +               if (defined $stat &&
> +                   $line =~ /\b$logFunctions\s*\(/ &&
> +                   index($stat, '"') >= 0) {
> +                       my $lc = $stat =~ tr@\n@@;
> +                       $lc = $lc + $linenr;
> +                       my $stat_real = get_stat_real($linenr, $lc);
> +                       pos($stat_real) = index($stat_real, '"');
> +                       my $lineoff = substr($stat_real, 0, pos($stat_real)) =~ tr/\n//;
> +                       while ($stat_real =~ /[^"%]*(%[#\d\.\*\-]*(h+)[idux])/g) {
> +                               my $pspec = $1;
> +                               my $h = $2;
> +                               if (WARN("UNNECESSARY_MODIFIER",
> +                                        "Integer promotion: '$h' use in '$pspec' is unnecessary\n" . "$here\n$stat_real\n") &&
> +                                   $fix &&
> +                                   $fixed[$fixlinenr + $lineoff] =~ /^\+/) {
> +                                       my $nspec = $pspec;
> +                                       $nspec =~ s/h//g;
> +                                       $fixed[$fixlinenr + $lineoff] =~ s/\Q$pspec\E/$nspec/;
> +                               }
> +                       }
> +               }
> +
>  # check for mask then right shift without a parentheses
>                 if ($perl_version_ok &&
>                     $line =~ /$LvalOrFunc\s*\&\s*($LvalOrFunc)\s*>>/ &&
>

Thanks, I will modify the block according to this and send it back to you.
