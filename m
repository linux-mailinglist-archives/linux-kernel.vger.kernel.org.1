Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6B8F2E0613
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 07:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbgLVGfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 01:35:50 -0500
Received: from conssluserg-03.nifty.com ([210.131.2.82]:34326 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVGfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 01:35:50 -0500
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 0BM6YbD7006778
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:34:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 0BM6YbD7006778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1608618877;
        bh=fcWPiycUMYEZvg5xTDlQrU/QzmMQoGbU9q5Hj80KmkE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DjNLHAKtl0GUcyHQMFYpgj7G2I7JahTPveWcelwIOt6w9unHcxMD2uW1LdfQn36Oz
         UuS7eOjTDyZ2nPUe95drK+taPKM7LtgSqi0s9GlW3uJ2OlrW/nRQEmMnmppZnYsw5H
         pi68Bhz5kp6EeGva5zW5jT+a8sWY0G5rZEWIF0xduDCslvq6o37hw6w4Gl+INXSOXy
         8s97/tJiQc5qSjh5XigGuqsY3Nm+Qo+Ytzveq+FqJf9elaEZFpsYJGqZZQKEx1b813
         4UYQfy7FweAODdwFXlaJ7legfIf0e2xY0uHtVld0oQpiQYQmrZoryVhBb5L2n7Kc3u
         WGA5XXm7AKiSw==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id x12so6901613plr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 22:34:37 -0800 (PST)
X-Gm-Message-State: AOAM5326Rfurpv5JeQqcF0b+mNWt+9s25Jbgeutr1dO1iSuNySV995m4
        RBuBeGibQOIq3Ajodg7Vda8egSSf7DIe/6DmKyQ=
X-Google-Smtp-Source: ABdhPJxmSLvlNRX7lmhEqGm+zyQSpGmhZhXx/5EOUzb2pTZvI0QAFZzlfaKqi1UeQ0+uN4ys1Vd51YkBKjjx31oVLos=
X-Received: by 2002:a17:90a:fa0c:: with SMTP id cm12mr21001610pjb.87.1608618876748;
 Mon, 21 Dec 2020 22:34:36 -0800 (PST)
MIME-Version: 1.0
References: <20201222061805.462460-1-joel@jms.id.au>
In-Reply-To: <20201222061805.462460-1-joel@jms.id.au>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 22 Dec 2020 15:34:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNATHTT2=e0VxxunLhAGP5yDeGcdunxgp2Ne_P1kRAifecg@mail.gmail.com>
Message-ID: <CAK7LNATHTT2=e0VxxunLhAGP5yDeGcdunxgp2Ne_P1kRAifecg@mail.gmail.com>
Subject: Re: [PATCH] openrisc: Add vmlinux.bin target
To:     Joel Stanley <joel@jms.id.au>
Cc:     Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Karol Gugala <kgugala@antmicro.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 3:18 PM Joel Stanley <joel@jms.id.au> wrote:
>
> Build it by default. This is commonly used by fpga targets.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/openrisc/Makefile      | 7 +++++++
>  arch/openrisc/boot/Makefile | 8 ++++++++
>  2 files changed, 15 insertions(+)
>  create mode 100644 arch/openrisc/boot/Makefile
>
> diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
> index bf10141c7426..239bca2d1925 100644
> --- a/arch/openrisc/Makefile
> +++ b/arch/openrisc/Makefile
> @@ -24,6 +24,10 @@ LIBGCC               := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
>
>  KBUILD_CFLAGS  += -pipe -ffixed-r10 -D__linux__
>
> +all: vmlinux.bin
> +
> +boot := arch/$(ARCH)/boot
> +
>  ifeq ($(CONFIG_OPENRISC_HAVE_INST_MUL),y)
>         KBUILD_CFLAGS += $(call cc-option,-mhard-mul)
>  else
> @@ -49,3 +53,6 @@ else
>  BUILTIN_DTB := n
>  endif
>  core-$(BUILTIN_DTB) += arch/openrisc/boot/dts/
> +

Since vmlinux.bin is a phony target, you need this:

PHONY += vmlinux.bin


> +vmlinux.bin: vmlinux
> +       $(Q)$(MAKE) $(build)=$(boot) $(patsubst %,$(boot)/%,$@)


This is simpler:

          $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@



For clean-up, you need this:

archclean:
        $(Q)$(MAKE) $(clean)=$(boot)






> diff --git a/arch/openrisc/boot/Makefile b/arch/openrisc/boot/Makefile
> new file mode 100644
> index 000000000000..0e71e8f78bb2
> --- /dev/null
> +++ b/arch/openrisc/boot/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for bootable kernel images
> +#
> +
> +OBJCOPYFLAGS_vmlinux.bin := -O binary
> +$(obj)/vmlinux.bin: vmlinux FORCE
> +       $(call if_changed,objcopy)

Please add

targets += vmlinux.bin




Also, you need to add arch/openrisc/boot/.gitignore




> --
> 2.29.2
>


-- 
Best Regards
Masahiro Yamada
