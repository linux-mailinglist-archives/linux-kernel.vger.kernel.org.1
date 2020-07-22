Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CD6228D39
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 02:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731496AbgGVAxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 20:53:25 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:27157 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbgGVAxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:53:25 -0400
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 06M0qpba008736
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 09:52:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 06M0qpba008736
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1595379172;
        bh=Rmd1MC2JpL/qsW+KJXGi9dvkbRqpp67uHrZvlZPqnnQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fCuRqEo5R7tsBimcwvosMA5r7zoLn83XhCF9ewj70bkCQZBAFUtqrMHXymUzdkY4C
         sADO9gy+Kb+fylP06zV5KB40k47skKqunCe6Q+qMhwGhAt0jUefZzOPe4CfoAnj07q
         HiyNY9od0hNuVoYOuy33uo9GXO5SMqk0VBtdDi+6dR4NSv1Q9fcoCv6RqFwD3zimuk
         +rsYlUwpNvPMy/NABxgXh+mETbiAkpSfhaPgzXaTTteHMkts/ALYis51vqfz7oei3y
         lSk586KJ4N4dG0Qcbvih+fNd8BVO2BaXGFJQnHBQxHs9b4G+MLEBSKOBSRBW/YLu3u
         Vcq2JUC4F5VHg==
X-Nifty-SrcIP: [209.85.217.53]
Received: by mail-vs1-f53.google.com with SMTP id s20so257989vsq.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 17:52:51 -0700 (PDT)
X-Gm-Message-State: AOAM533trHN1d/YLRFdYkW6ZJHEyArMLaHNGf5CJE2piuwwZbjqK2YSG
        idcWtn6NsFPW992JlzButa0pLrO20/zRNiqO8FI=
X-Google-Smtp-Source: ABdhPJw4GP6sLIaLF4KWGv+V0XOy1HGvyPU1VIDRU3+GhEDAciWu7TXSOoiC1ziqZi74sSCd2CFUMjsvZFNrsxdI3cY=
X-Received: by 2002:a67:694d:: with SMTP id e74mr23382636vsc.155.1595379170484;
 Tue, 21 Jul 2020 17:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200721093748.26627-1-jcmvbkbc@gmail.com>
In-Reply-To: <20200721093748.26627-1-jcmvbkbc@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Jul 2020 09:52:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNARtTZD5x3CYLVj48dwC9n7Z4kMx1gCLq3aD2_OfQKuXnA@mail.gmail.com>
Message-ID: <CAK7LNARtTZD5x3CYLVj48dwC9n7Z4kMx1gCLq3aD2_OfQKuXnA@mail.gmail.com>
Subject: Re: [PATCH v2] xtensa: add boot subdirectories targets to extra-y
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Chris Zankel <chris@zankel.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 6:37 PM Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> The commit 8fe87a92f262 ("kbuild: always create directories of targets")
> exposed an issue in the xtensa makefiles that results in the following
> build error in a clean directory:
>   scripts/Makefile.build:374: arch/xtensa/boot/boot-elf/boot.lds] Error 1
>     arch/xtensa/boot/boot-elf/bootstrap.S:21: fatal error:
>     opening dependency file arch/xtensa/boot/boot-elf/.bootstrap.o.d:
>     No such file or directory
>
> Intermediate targets in arch/xtensa/boot/boot-elf don't get into
> 'targets' and build directory is not created for them.
> Add boot.lds and bootstrap.o to extra-y in subdirectories of
> arch/xtensa/boot.
>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - update boot-redboot/Makefile in the same manner as boot-elf/Makefile.


Oops, sorry and thanks.

But, we need to fix this in the kbuild tree
to retain the bisectability.


I will insert the following before the offending commit.
https://patchwork.kernel.org/patch/11676883/


I used 'targets' instead of 'extra-y'
because they are built on demand
while building the final boot image.




>  arch/xtensa/boot/boot-elf/Makefile     | 1 +
>  arch/xtensa/boot/boot-redboot/Makefile | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/arch/xtensa/boot/boot-elf/Makefile b/arch/xtensa/boot/boot-elf/Makefile
> index 12ae1e91cb75..ad341c0fff15 100644
> --- a/arch/xtensa/boot/boot-elf/Makefile
> +++ b/arch/xtensa/boot/boot-elf/Makefile
> @@ -15,6 +15,7 @@ export CPPFLAGS_boot.lds += -P -C
>  export KBUILD_AFLAGS += -mtext-section-literals
>
>  boot-y         := bootstrap.o
> +extra-y                := boot.lds $(boot-y)
>
>  OBJS           := $(addprefix $(obj)/,$(boot-y))
>
> diff --git a/arch/xtensa/boot/boot-redboot/Makefile b/arch/xtensa/boot/boot-redboot/Makefile
> index 8632473ad319..022a76a2282a 100644
> --- a/arch/xtensa/boot/boot-redboot/Makefile
> +++ b/arch/xtensa/boot/boot-redboot/Makefile
> @@ -13,6 +13,7 @@ endif
>  LD_ARGS        = -T $(srctree)/$(obj)/boot.ld
>
>  boot-y := bootstrap.o
> +extra-y        := $(boot-y)
>
>  OBJS   := $(addprefix $(obj)/,$(boot-y))
>  LIBS   := arch/xtensa/boot/lib/lib.a arch/xtensa/lib/lib.a
> --
> 2.20.1
>


--
Best Regards
Masahiro Yamada
