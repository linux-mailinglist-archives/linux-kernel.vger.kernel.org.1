Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5D2EB38E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbhAETio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:38:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbhAETio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:38:44 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B6CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 11:38:04 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id y8so268357plp.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 11:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2oCqu6lZwFBzT2yVHSFErG6jDdrfnhkGaRpmRP+AbnU=;
        b=efGnQJXLQBXr05b1JniWegytsOALrtQr85gkWNRQYpktDtfXIlXI0bqqYEEN5xKs35
         n5l/4ivY3PTmUGSZaDUfWHKtaLcHKbvdi3ToBE0ZvDALgH58p2tP0dnVPcH2uC/VKD7M
         rSoHdW/h1nNpBfhVJ70Au7o0ulQgd9PZ5D6hf3W3VeF8FyaJ6qQRBH7oN3l92+M/+SwU
         yELD/CIFzHTbb6iIYCk6I2J1FLXDLtBdcDFYn6PIeXRqkp+ZJy+smqUgriAIB3B3yZ/r
         mtpYmrr+19Mc2WM4Eq5WMXdXpN0ZxzZ70xxZWJ/81lTGm8i9Zq9tC0+EsKfiAnTa/b50
         Sb1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2oCqu6lZwFBzT2yVHSFErG6jDdrfnhkGaRpmRP+AbnU=;
        b=UOmOnz0qg5PnIQktu5BRjC3/1U4f7qysxvY3GmZH4W1HDPMLdle2DFEmSZIQWT+/gQ
         OPJfhWM/kwREzrqHHMaNBdicMnWVDwms9tnuysRdqHUbfrzxq2CGtta7HgRqkL9Tal1i
         IiTQvCFWaKC6jIKU6I91oLPux/ww0xkQtoHZD9DEAI4G6UYUp51hwsYp2H095w6du5wK
         c23VTzwcYmsOZxLdLOmF1s4g7bnUH8fmMMe31HMpVF9R/QWSKHe93a0gCFiQrqiRUXII
         Mkabr4Yw4LzBgmJT23mtVhdBmMRYzkxv7CPzwduU+t634Sq78yQM4kAb91xKNW3jt+DS
         QMEQ==
X-Gm-Message-State: AOAM531nZ3M/JXtvDVnqVHaVG/1S5ntTot9NbFC3MNIdzO3npgB9uE0y
        80LOOohzRiGvWAmy0q7v1+xsD6sosXIYiXfau6yJzA==
X-Google-Smtp-Source: ABdhPJxGa/6OvYY92ewpSjLysJTFGu3c7+BHjTYFHmuz4/Q7Q+GuiYD8+tdGbXqf9kd1WQMynJPx2sZEAXq/9tw3uxI=
X-Received: by 2002:a17:90a:6ba4:: with SMTP id w33mr785818pjj.32.1609875483392;
 Tue, 05 Jan 2021 11:38:03 -0800 (PST)
MIME-Version: 1.0
References: <202012270950.HNbQuTpw-lkp@intel.com>
In-Reply-To: <202012270950.HNbQuTpw-lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 5 Jan 2021 11:37:55 -0800
Message-ID: <CAKwvOdn978FV_FmikQXjMwKYZi_OUXw_f3t56NnMXHiawXDOzw@mail.gmail.com>
Subject: Re: drivers/i3c/master/mipi-i3c-hci/core.c:780:21: warning: attribute
 declaration must precede definition
To:     kernel test robot <lkp@intel.com>
Cc:     Nicolas Pitre <npitre@baylibre.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Boris Brezillon <bbrezillon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix already applied:
https://lore.kernel.org/lkml/160943653614.132002.12499200411415721355.b4-ty@bootlin.com/

On Sat, Dec 26, 2020 at 5:29 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Nicolas,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   f838f8d2b694cf9d524dc4423e9dd2db13892f3f
> commit: 95393f3e07ab53855b91881692a4a5b52dcdc03c i3c/master/mipi-i3c-hci: quiet maybe-unused variable warning
> date:   10 days ago
> config: arm-randconfig-r011-20201220 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project cee1e7d14f4628d6174b33640d502bff3b54ae45)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95393f3e07ab53855b91881692a4a5b52dcdc03c
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 95393f3e07ab53855b91881692a4a5b52dcdc03c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/i3c/master/mipi-i3c-hci/core.c:780:21: warning: attribute declaration must precede definition [-Wignored-attributes]
>    static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
>                        ^
>    include/linux/compiler_attributes.h:267:56: note: expanded from macro '__maybe_unused'
>    #define __maybe_unused                  __attribute__((__unused__))
>                                                           ^
>    include/linux/mod_devicetable.h:262:8: note: previous definition is here
>    struct of_device_id {
>           ^
>    drivers/i3c/master/mipi-i3c-hci/core.c:780:49: warning: unused variable 'i3c_hci_of_match' [-Wunused-const-variable]
>    static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
>                                                    ^
>    2 warnings generated.
>
>
> vim +780 drivers/i3c/master/mipi-i3c-hci/core.c
>
>    779
>  > 780  static const struct __maybe_unused of_device_id i3c_hci_of_match[] = {
>    781          { .compatible = "mipi-i3c-hci", },
>    782          {},
>    783  };
>    784  MODULE_DEVICE_TABLE(of, i3c_hci_of_match);
>    785
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202012270950.HNbQuTpw-lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
