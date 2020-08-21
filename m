Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07EE24CAFB
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 04:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgHUCtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 22:49:11 -0400
Received: from conssluserg-04.nifty.com ([210.131.2.83]:41955 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgHUCtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 22:49:07 -0400
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 07L2miiI008430
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 11:48:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 07L2miiI008430
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1597978125;
        bh=ASVoDxPVaHEphvEWRnO7mYJc+Au9FF54c7QJWbl4ee0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V+YPuOsQkInKZN376aTj+f2rVfneOSHqbB2VjV+e25gFzYQn437FXxpmHjU9obNkI
         Bgk2DHeXR3r6fuAXyTAll3D2WOiJ0Ay+JrWNuySu0z9JN+keM5hzvopGzfgndqP7DZ
         GqwGYKIkUrsP0ERxVMhR226tpG6nxbhn8xKceJOxUKEZ/w0XYJi+TDlImg8awdeJyy
         sqKkcbrLv4Gq2dmRfpTzSgxISHc8jyQOJwmXFnU41skCuk06dGm8u5+ehAd5wyyhED
         7nMLr24Bv0MZMHMYtGR4kAW3QHvZ7VSCnti21huzQFMU3HxgFzVNHQLJ5iUKjo5yWG
         V8V8BgT8I49Ag==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id x17so143709uao.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 19:48:44 -0700 (PDT)
X-Gm-Message-State: AOAM533yrYwhyKyMfImB0yEHca1oUegIbhN4XXCABCr3ylq9yUC/NyHu
        QH6I6ITnVe+ZVBPvGKiJSTBNCoRmGK1F79hEQlA=
X-Google-Smtp-Source: ABdhPJxg+cikE5V+obxr8K+doH4JPFIvuWY0Z+64GR4C12XQE67sBr6z/Q4BwcGREYBB67Bh+WghnVNCT5ZrWSn/BdM=
X-Received: by 2002:ab0:108:: with SMTP id 8mr389564uak.25.1597978123729; Thu,
 20 Aug 2020 19:48:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200820063526.GA3278096@gmail.com>
In-Reply-To: <20200820063526.GA3278096@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Aug 2020 11:48:07 +0900
X-Gmail-Original-Message-ID: <CAK7LNATs3qEjTE-=FWP9Srf3Ys30T7h+PL6MLgHoBPxJLSx4VA@mail.gmail.com>
Message-ID: <CAK7LNATs3qEjTE-=FWP9Srf3Ys30T7h+PL6MLgHoBPxJLSx4VA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Run syncconfig with -s
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 3:35 PM Ingo Molnar <mingo@kernel.org> wrote:
>
> On every kernel build that runs --syncconfig, there's an output of the following line:
>
>   scripts/kconfig/conf  --syncconfig Kconfig
>
> This is the only non-platform build message the kbuild system emits that isn't
> prefixed by at least a space, or is a build warning.
>
> Run it under -s - if there's any problem it will emit messages anyway.
>
> With this change the following simple grep filter will show all build warnings
> and errors of a kernel build:
>
>    make | grep -v '^ '



I do want to see something when syncconfig is invoked.

I will apply this instead:
https://patchwork.kernel.org/patch/11727445/




> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index 9cac6fde3479..2057c92a6205 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -709,7 +709,7 @@ $(KCONFIG_CONFIG):
>  # The syncconfig should be executed only once to make all the targets.
>  # (Note: use the grouped target '&:' when we bump to GNU Make 4.3)
>  %/config/auto.conf %/config/auto.conf.cmd %/generated/autoconf.h: $(KCONFIG_CONFIG)
> -       $(Q)$(MAKE) -f $(srctree)/Makefile syncconfig
> +       $(Q)$(MAKE) -sf $(srctree)/Makefile syncconfig
>  else # !may-sync-config
>  # External modules and some install targets need include/generated/autoconf.h
>  # and include/config/auto.conf but do not care if they are up-to-date.



-- 
Best Regards
Masahiro Yamada
