Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547142C0200
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 10:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgKWJFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 04:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgKWJFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 04:05:23 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ADE9C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 01:05:21 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id y10so1683810ljc.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 01:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8XaBqDDPJL3HLBnms0Ixvz/F1NwF3Bgl8gVECLmIQiI=;
        b=Dprj/NYgpo2wGwvJcQ/Ukf6Nzb/3auYXGzfjUbwtgMzxL9zR9LzOO3UCG7vh+0yiJN
         Of2JW+1mupBMXSy0EZXfPJMw8j+ZWtaK4EDToqoPxoa87s9s9rTDYxu3qnqHpCB+aFP5
         wHCdhvby2pWZxW2KNCj5PaweJhcrTdfSGcJTNFgCERpq8CX9lo0QViSvQfxkLXuyFO+l
         TPb2IREt3oZeWZmYCfisjuyrRQ6zJ5T8V6/aSni22BARZr049BLKvMQVBRERIOzH6QUO
         ntTP2Mv859iNRdEmfaHIQ7+LejNAKNfDFyinrlQ2XQWjceLdtfnBB96DAhPti52GMLG2
         Bz1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8XaBqDDPJL3HLBnms0Ixvz/F1NwF3Bgl8gVECLmIQiI=;
        b=o+Seb0WKAjUvs5ao/9tJLY6NY4tJZg13Embiarve33bLUpLmYl/MKz/D/9OvKx6BYG
         gdLSF40kr0CnHmAXYFEV3p+dpTG/iPvAwqNuY2HNN2eNxVcyD2Hhkaxs9UnDkQjYxOl2
         4KM+d9ZF+KRh1tkWGClfG8ytR9hmFo9HG/a4ZtVoqUzhXEF58vLReBR8oXy2i/hra9WJ
         UrF2vkNpKXPbG1cXzMYxriBxOY6eoFKbxpuB6j+zVz3EhMuPX4htNLDXK7KEPTqn0GzJ
         Vb52ugYxKQOlD4zc+M2iWkqoFc869Wz48o5jsg7S1y8Oj3U+vWJaDJoS2fPqRew6qgIv
         b2WQ==
X-Gm-Message-State: AOAM531TJRtY75ENUdbZFMCiTJKt0WuvypZrp35KV4t9PuHvKGSopZZX
        pvubi6zX8BIqHpJIPTELBi5WQe/aH24yAEsOVzUBhg8yQKnzmA==
X-Google-Smtp-Source: ABdhPJxUl6QJbAo3mZz/mFi7DkaXpyrgX8fJfx+qo+dg1t23qvjkhTnp+OvGKTc71ZorK7COmj5OsEtbaia8UJfGvV8=
X-Received: by 2002:a2e:8143:: with SMTP id t3mr12002350ljg.269.1606122319731;
 Mon, 23 Nov 2020 01:05:19 -0800 (PST)
MIME-Version: 1.0
References: <20201121212414.170840-1-dwaipayanray1@gmail.com>
In-Reply-To: <20201121212414.170840-1-dwaipayanray1@gmail.com>
From:   Dwaipayan Ray <dwaipayanray1@gmail.com>
Date:   Mon, 23 Nov 2020 14:34:49 +0530
Message-ID: <CABJPP5Bg_Ewgsu_J+Bz-VGaa+D3W-wRg-_2f-590HZWLL-K=5g@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: add --fix option for INCLUDE_LINUX
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 22, 2020 at 2:54 AM Dwaipayan Ray <dwaipayanray1@gmail.com> wrote:
>
> Provide fix option to INCLUDE_LINUX check to replace asm
> includes.
>
> Macros of type:
>  #include <asm/percpu.h>
>
> are corrected to:
>  #include <linux/percpu.h>
>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>

Hello Joe,
Could I get some review on this if you are not too busy.

Thank you,
Dwaipayan.

> Changes in v2:
> - Use \Q..\E quoting
> - Use @ as regex delimiter
>
>  scripts/checkpatch.pl | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 0da6422cd0fd..e4feb91a0fe4 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5468,8 +5468,11 @@ sub process {
>                                                 CHK("ARCH_INCLUDE_LINUX",
>                                                     "Consider using #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
>                                         } else {
> -                                               WARN("INCLUDE_LINUX",
> -                                                    "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr);
> +                                               if (WARN("INCLUDE_LINUX",
> +                                                        "Use #include <linux/$file> instead of <asm/$file>\n" . $herecurr) &&
> +                                                   $fix) {
> +                                                       $fixed[$fixlinenr] =~ s@\Q<asm/$file>\E@<linux/$file>@;
> +                                               }
>                                         }
>                                 }
>                         }
> --
> 2.27.0
>
