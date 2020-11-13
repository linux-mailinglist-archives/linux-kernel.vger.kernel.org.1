Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAFA2B1BEE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 14:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgKMNes (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 08:34:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgKMNes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 08:34:48 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484DCC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:34:48 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id n129so9775084iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 05:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2s+IjuH8/GwNNYfXizL51ZXMfk83ORuiIPmeIRUaLZA=;
        b=MTs7KJkVWuBopP6twEClOHYZcvEgnxIZEjawBA4yTA/YulOakxrYTcvggSJJxXhU4l
         R6NFfRlcbMm2hYlCc0uf6ioM0nIXb07UlozcXenj352WkVbCytKD/zqG9GriYhMklZ5z
         d8fboUkw4ou99UNJ1KDFFfriq2fF9ghBDm+zpS820ytsoccgCjqgA3/4LSxHHZQhenzP
         mj6QYZYctSB8uwXyQC+XM8pomPoC08i1lOy2DDfWlygHTzrC0pw+bpvj0mvh+AfPykSY
         jiCyEjUrbrdM9KOX342m6OGo2eCJwO+lu8pqQLhsyDz3gKR0WngMniJ6QBMjaoUPblsF
         t83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2s+IjuH8/GwNNYfXizL51ZXMfk83ORuiIPmeIRUaLZA=;
        b=aznTdfm+xiNXQ2vOQHARg81fH44qJj3Gla3FxklOSpazy7vqI4jGpX2DDobAS8KBml
         RLzhP96+jD6uo81OTvkPrsMGmyATqueNa8Z0O6Vrlb6pUUBAkmCyqOQHZ1VwSmy1wots
         vrUg77Ov0GHJUwchKozvjbfALqEygXaeJ/tl9vJwlpO7XAeXW5JUNqExjRwkftkyDdgK
         uRy4OWlarohIhktaFhH+qQ6k9ZhPjkvwslIDToxeF7ZScXrY5yoRXHlxy3P8HbrUMOQo
         85JDh/bdZmTcxWZcKDRsk2XfZpJeTC27wPNrHaZnY4VUTWY7gu484yNA5FHSIMyWy64c
         55ZA==
X-Gm-Message-State: AOAM531KPbss1+vtHV09187hpwoY36O/WjA+j44qVbKnAcT54PIA2T+n
        FcMl5sVVwjacj2UkR6t/FXGYgeRzxwGTV+kjWSB8r+UgVC4=
X-Google-Smtp-Source: ABdhPJz3NgOUsfY/zq5hbVMi9TOEW8/MiAuKcCic5vLFO0p87B/rRrlpUw24ixNuCJgWuBOL7mT73MEinYoT9l6SFrY=
X-Received: by 2002:a05:6638:124d:: with SMTP id o13mr1937710jas.98.1605274487562;
 Fri, 13 Nov 2020 05:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20201113131037.37519-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201113131037.37519-1-dwaipayanray1@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Fri, 13 Nov 2020 14:34:36 +0100
Message-ID: <CAKXUXMwsvj6Y3dEq-eAOyCoJV3qhV7K9U_uRrtbg9u4TV0zyeA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: fix typo and remove duplicate word
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 2:11 PM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> Delete repeated word in scripts/checkpatch.pl.
> "are are" -> "are"
>
> Fix typo "commments" -> "comments"
>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Does this make checkpatch.pl pass checkpatch without any further warnings?

Nice idea to check if checkpatch.pl still fulfills the checkpatch
rules we created...

Lukas

> ---
>  scripts/checkpatch.pl | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2749f32dffe9..e7fd2d6279cf 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2841,7 +2841,7 @@ sub process {
>
>
>                                 # stable@vger.kernel.org or stable@kernel.org shouldn't
> -                               # have an email name. In addition commments should strictly
> +                               # have an email name. In addition comments should strictly
>                                 # begin with a #
>                                 if ($email =~ /^.*stable\@(?:vger\.)?kernel\.org/i) {
>                                         if (($comment ne "" && $comment !~ /^#.+/) ||
> @@ -7109,7 +7109,7 @@ sub process {
>                 exit(0);
>         }
>
> -       # This is not a patch, and we are are in 'no-patch' mode so
> +       # This is not a patch, and we are in 'no-patch' mode so
>         # just keep quiet.
>         if (!$chk_patch && !$is_patch) {
>                 exit(0);
> --
> 2.27.0
>
