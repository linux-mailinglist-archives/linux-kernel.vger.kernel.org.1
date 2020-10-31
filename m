Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32C242A14C4
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726612AbgJaJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgJaJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:26:41 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E97BC0613D5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 02:26:41 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id b138so7246536yba.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Oct 2020 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QjYMR9vqRGs2pdxFL24RaI7WR1Ff9Q/dQFAYUJszicY=;
        b=daOTQPy85DyG+EuDqAHDl1V1+C+QAFTYMVQ5FxA/CbV669Sql0c5SI3JnqCcxxzDJ3
         KvhZsDmPhDRN5ZfO29Nescd2bdvMY7IVWV1tsw4+mYYeLaGqiyt4MZGZFKzDEsAhKE61
         NHZ3m9vjUqUbyAA7xdpKLHzKo/S79bJqwW5aeEBfvk13+xIeN1jl5mz6s5LQdCHZEm+J
         Vt2oUWlnP5toziK7MzfC200d113zfS+MVbqeymJK1vSFSieFKt0+t2RbdwueiCcEcjM+
         t2iAglcxUqq2E59+G8nREY/g2AfqXIuBMaVmqpaQLqlQHE85K3fLfcQqYqDhsIQAjlTz
         2zZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QjYMR9vqRGs2pdxFL24RaI7WR1Ff9Q/dQFAYUJszicY=;
        b=pJzFrOJ4MXaZ2F4N9R7poeBVaaEkDRlg9Qe16GHbDXnLfxMKl/gT03tpCc7FpONnYP
         IAUOYwEGN5MnuMsxcXgSAbNX7SVwRELOk45qNGrhBWJix8v62re/ab08bYuoPsPFAkaw
         mADTv4XZWrwGiBij9igGMYz9iB8TvVj9kDwb3sQkMg5WQIHAD9XbbN7qV+5W96/LNg1a
         5eN0ofAm4HRK80XonPO7xABke8dfa50oAPPsLNlgibujGt66Yn0Co4T3jVNEuz8E6Sc2
         cO38kK+jUepphqdmQUD6QJ6BcFynXhrDg33VcqtEso8dkzVbmbC4M6fJHOqEZ9Z3aB73
         MKJw==
X-Gm-Message-State: AOAM533P7+r38dAI7OofiSgbMz8imxG+Wg8ycGYfC7F7iSnV6uvou6yW
        4RfY3audO5HmcI/nGHuDgSMi5EaF44FU1nFvtUvNAcUnmuRnkA==
X-Google-Smtp-Source: ABdhPJyHUkDU/JfCHb0j32TDkHWnaaUxrGfq33vFLEufulgFdOJumzzCuUAwalN/HRVJs1KDMXpv0137BwuGzt/6V1Y=
X-Received: by 2002:a25:d441:: with SMTP id m62mr9304561ybf.422.1604136401012;
 Sat, 31 Oct 2020 02:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201029095231.311083-1-poeschel@lemonage.de> <20201029095731.311528-1-poeschel@lemonage.de>
In-Reply-To: <20201029095731.311528-1-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 31 Oct 2020 10:26:30 +0100
Message-ID: <CANiq72nY2aXiTcG0=OJR4JNkY7qZU1dStfMHkbFoT5cekNRkvA@mail.gmail.com>
Subject: Re: [PATCH v5 02/25] auxdisplay: Introduce hd44780_common.[ch]
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lars,

On Thu, Oct 29, 2020 at 10:57 AM <poeschel@lemonage.de> wrote:
>
> diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> index 81757eeded68..a56171d1a1ba 100644
> --- a/drivers/auxdisplay/Kconfig
> +++ b/drivers/auxdisplay/Kconfig
> @@ -14,12 +14,31 @@ menuconfig AUXDISPLAY
>
>           If you say N, all options in this submenu will be skipped and disabled.
>
> +config CHARLCD
> +       tristate "Character LCD core support" if COMPILE_TEST
> +       help
> +         This is the base system for character-based LCD displays.
> +         It makes no sense to have this alone, you select your display driver
> +         and if it needs the charlcd core, it will select it automatically.
> +         This is some character LCD core interface that multiple drivers can
> +         use.
> +
> +config HD44780_COMMON
> +       tristate "Common functions for HD44780 (and compatibles) LCD displays" if COMPILE_TEST
> +       help
> +         This is a module with the common symbols for HD44780 (and compatibles)
> +         displays. This is the code that multiple other modules use. It is not
> +         useful alone. If you have some sort of HD44780 compatible display,
> +         you very likely use this. It is selected automatically by selecting
> +         your concrete display.
> +
>  if AUXDISPLAY
>

These two should be after `if AUXDISPLAY`, no? I noticed the menu is
broken when I went to compile test this (the options appear outside
and the auxdisplay menu is empty). Perhaps you don't use menuconfig so
you didn't see it?

Sorry I missed this in previous iterations...

Cheers,
Miguel
