Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 144B32917B1
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgJRODa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 10:03:30 -0400
Received: from mail-oo1-f66.google.com ([209.85.161.66]:42451 "EHLO
        mail-oo1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgJROD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 10:03:27 -0400
Received: by mail-oo1-f66.google.com with SMTP id l18so2169934ooa.9
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 07:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdYTigja8ZWEG3eKOvDG5jgCOVY9eahGaE3L6tasC3w=;
        b=tPUhsBCRedsoDEADviAbVDyiU2+CK1V/nYWvxN9c4QJu0/dqmnrxcpgFhvgN1f+9ht
         tpeW0iw+Apmej2qwHVj636Ylg82P9lukbC3jnUmeFxWuCSo9Ytotq+aX/y3i+s+vW0pm
         SX04McoPBkbPiHw6aiC7+q6GX/kJxK1Re5IXNCHsnuNuZxK6DZmjX98HPiBFsq5Vk9KW
         A1LX38DaXwyRgWbzPhttfadZ1s+Aw+XHJlg2eu00prjionVJucO9cNioBZfxWuQyejg4
         O/+hRBQGWiOfS0QoYhJTDzhkiJbm9VByIhnFXX2lqTulEsp10dM3ZGvLOrFKhdhwIguB
         3ksg==
X-Gm-Message-State: AOAM531FdWrzESjkhl+K2/ur66qrB7KsOsjBrpQ0vMG4s1LdhilncchX
        EVvrMRisnjcdCKcybHYH3EyokPSTJtSj7HJrIqeheDPqJEc=
X-Google-Smtp-Source: ABdhPJzdaDi1+Q/OVfT5rGZHhOTdQ3r3UQIgRBV1wkt1ZoQNmurLWXzyfEQ0YMj5CkR1Z481aUmxKXZWAJRV2+KD/bs=
X-Received: by 2002:a4a:dbd3:: with SMTP id t19mr9447968oou.40.1603029806402;
 Sun, 18 Oct 2020 07:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
In-Reply-To: <45b81a48e1568bd0126a96f5046eb7aaae9b83c9.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 18 Oct 2020 16:03:15 +0200
Message-ID: <CAMuHMdV8FEPhTp653RN00LK4UcQZHkuLByJzqiM85r2qoqhDvQ@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Allow not using -f with files that are in git
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@shadowen.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Aug 25, 2020 at 2:12 AM Joe Perches <joe@perches.com> wrote:
> If a file exists in git and checkpatch is used without the -f
> flag for scanning a file, then checkpatch will scan the file
> assuming it's a patch and emit:
>
> ERROR: Does not appear to be a unified-diff format patch
>
> Change the behavior to assume the -f flag if the file exists
> in git.
>
> Signed-off-by: Joe Perches <joe@perches.com>

Thanks for your patch!

> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -976,6 +976,16 @@ sub seed_camelcase_includes {
>         }
>  }
>
> +sub git_is_single_file {
> +       my ($filename) = @_;
> +
> +       return 0 if ((which("git") eq "") || !(-e "$gitroot"));
> +
> +       my $output = `${git_command} ls-files -- $filename`;
> +       my $count = $output =~ tr/\n//;
> +       return $count eq 1 && $output =~ m{^${filename}$};
> +}
> +
>  sub git_commit_info {
>         my ($commit, $id, $desc) = @_;
>

This is now commit f5f613259f3fea81 ("checkpatch: allow not using -f
with files that are in git"), causing:

    Global symbol "$gitroot" requires explicit package name (did you
forget to declare "my $gitroot"?) at scripts/checkpatch.pl line 980.
    Execution of scripts/checkpatch.pl aborted due to compilation errors.

FWIW, host system is running Ubuntu 18.04.5 LTS (upgrade to 20.04 LTS
planned soon ;-).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
