Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF322C4815
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 20:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgKYTNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 14:13:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgKYTNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 14:13:53 -0500
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0063C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:13:52 -0800 (PST)
Received: by mail-ua1-x942.google.com with SMTP id t15so1052993ual.6
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 11:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+IN/5/YoLL4+4EFo1Ef1ozkW+zjATL5fFl70LvBvqLs=;
        b=qxUyE9LuSmA4t0F1YBoruhkPhTnOrZBtZbvb4JzPea8g4wxNPXLBQy2J+UfSJYg4/6
         7wds6OT5CogUOubCMsqJwIvo4FNwEOBlOm71xH9se7Y9c8M1jk5AbocSpK6r0w+J8Deg
         AcGSXDcZApCRiikoQ7gFV5ZnEunlgutYWIDN/EgmdxlN071UG35jDX8C2GpIvw4fr4hq
         /sMRNrWDw4GpAi7U7HG4i9UJGf/CRmHcwUfnhGpaCNhwjE5jVFJX85WrO5wRbLdVP1Yr
         7xuz+3mDyutIoQavAsgmVXE/ZeEMusnzoSaUrowayxT55cLLH6hV6zWRvFBbd0D8Q8/j
         dG+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+IN/5/YoLL4+4EFo1Ef1ozkW+zjATL5fFl70LvBvqLs=;
        b=P9hR+oKKWZFZAB50o0XvXlQl90H8X3LZ4qUFMTo7aMdnkIhLvNZ8MRhF9YBKxy61or
         amsNUnjH/EhPZOOsACnI2sqlU1xfuYoUsPBddqTZ8D5gRW6o76cM0+mhKyYkoQ0G777x
         oP2QLV2uEGXR3U4KoDTYSu5o0SPpzbB/Wl+NC/pssQ+Mf4tOOkqVC2u0cyvZ146AlMMI
         XtLUXRwcvoQBCs6kP6zGvcXc/M/wp0bEeAgP02HzFoW5GFJmp0Sm5bYncfaRA5cTNn7E
         KY/ugf2NSoNUGjJ0indm1Ixt3uU+tbnEe1iTPp2IrhrOVWJsT1XBvE0WIrKLKzBWkq8Z
         iPcw==
X-Gm-Message-State: AOAM5323B1yLStSlagitWvUYeckAoaio6v/XefpcRn8KZae971uYh8Wz
        +pfsLLpj/2YWL4IKl7ZV4kEeBCIifdE5p2hsa4WAp02JjSO6CA==
X-Google-Smtp-Source: ABdhPJwix6VtcxlXC6zudY+mZKXAaO15iHZ1FBtSxZi91Mg2qwPtT+PAqqctpt+1QFc+hzbVK7FxUdS7kfOxelLqtsc=
X-Received: by 2002:ab0:6cb6:: with SMTP id j22mr3713552uaa.82.1606331632174;
 Wed, 25 Nov 2020 11:13:52 -0800 (PST)
MIME-Version: 1.0
References: <202011241521.8ozmsGaX-lkp@intel.com>
In-Reply-To: <202011241521.8ozmsGaX-lkp@intel.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 26 Nov 2020 00:43:39 +0530
Message-ID: <CAFqt6zYiKP+jK_=_wmcMPYQyCxhroKkdMVy7qXhksh-V6HM=EQ@mail.gmail.com>
Subject: Re: arch/powerpc/platforms/pseries/reconfig.c:394:30: error:
 'ofdt_proc_ops' defined but not used
To:     kernel test robot <lkp@intel.com>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:40 PM kernel test robot <lkp@intel.com> wrote:
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   d5beb3140f91b1c8a3d41b14d729aefa4dcc58bc
> commit: 97a32539b9568bb653683349e5a76d02ff3c3e2c proc: convert everything to "struct proc_ops"
> date:   10 months ago
> config: powerpc-randconfig-r002-20201124 (attached as .config)
> compiler: powerpc64le-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=97a32539b9568bb653683349e5a76d02ff3c3e2c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 97a32539b9568bb653683349e5a76d02ff3c3e2c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> arch/powerpc/platforms/pseries/reconfig.c:394:30: error: 'ofdt_proc_ops' defined but not used [-Werror=unused-const-variable=]
>      394 | static const struct proc_ops ofdt_proc_ops = {
>          |                              ^~~~~~~~~~~~~
>    cc1: all warnings being treated as errors
> --
> >> arch/powerpc/platforms/pseries/lparcfg.c:701:30: error: 'lparcfg_proc_ops' defined but not used [-Werror=unused-const-variable=]
>      701 | static const struct proc_ops lparcfg_proc_ops = {
>          |                              ^~~~~~~~~~~~~~~~
>    cc1: all warnings being treated as errors

Both ofdt_proc_ops & lparcfg_proc_ops are used by proc_create().
Not sure why it is throwing warnings.

>
> vim +/ofdt_proc_ops +394 arch/powerpc/platforms/pseries/reconfig.c
>
>    393
>  > 394  static const struct proc_ops ofdt_proc_ops = {
>    395          .proc_write     = ofdt_write,
>    396          .proc_lseek     = noop_llseek,
>    397  };
>    398
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
