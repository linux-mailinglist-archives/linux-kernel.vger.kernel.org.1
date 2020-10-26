Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4834F298C25
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773881AbgJZLfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:35:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:54120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773874AbgJZLfU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:35:20 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2BF22265
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 11:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603712119;
        bh=zUCVQlSUHyz0braltijOZSb0AKH3UaTPB3ELignzrOQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=STLnoTw5FoyGj6LFsk1wO4fJecN1TcC0Lyem5OK+p54UUu+MVlJKlkBHiUDfWoNbq
         JUk0TbaWtZt+H6zJOga3796Lkj7k19eonVRkZBbtNRkZIA2nQVG/ISzTotMPha7AK+
         AdFyy7o996vGVqEqPyyK00mnHK+JD0oWs009PPSE=
Received: by mail-ej1-f52.google.com with SMTP id s15so8332804ejf.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Oct 2020 04:35:19 -0700 (PDT)
X-Gm-Message-State: AOAM531MheFDIJdkLqQ9B33QMujH3unk6qx6tjJOofId2kE0YWQFBYxM
        ff4i0UnRw3avjxGcyMPdAxve/Z55s7oG9ZBLj4U=
X-Google-Smtp-Source: ABdhPJyo7UQ01ZozdFZFzUS2Ix+TXXwHZoEjCWA0snDvx3802nlbfY0Ayi9Qe2zKC9t4VfBtGIvtZ4+wKmU51YEByAE=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr14780778ejx.215.1603712118127;
 Mon, 26 Oct 2020 04:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <202010261451.N9cm8bod-lkp@intel.com>
In-Reply-To: <202010261451.N9cm8bod-lkp@intel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 26 Oct 2020 12:35:05 +0100
X-Gmail-Original-Message-ID: <CAJKOXPdj2R3dQh5ZBALP_PCy5FTBVdYOtuU+dF50NAeRsDp1cw@mail.gmail.com>
Message-ID: <CAJKOXPdj2R3dQh5ZBALP_PCy5FTBVdYOtuU+dF50NAeRsDp1cw@mail.gmail.com>
Subject: Re: drivers/mmc/host/sunxi-mmc.c:1181:34: warning: unused variable 'sunxi_mmc_of_match'
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Oct 2020 at 07:01, kernel test robot <lkp@intel.com> wrote:
>
> Hi Krzysztof,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   3650b228f83adda7e5ee532e2b90429c03f7b9ec
> commit: 54d8454436a205682bd89d66d8d9eedbc8452d15 mmc: host: Enable compile testing of multiple drivers
> date:   7 weeks ago
> config: x86_64-randconfig-r036-20201026 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project f2c25c70791de95d2466e09b5b58fc37f6ccd7a4)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=54d8454436a205682bd89d66d8d9eedbc8452d15
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 54d8454436a205682bd89d66d8d9eedbc8452d15
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> drivers/mmc/host/sunxi-mmc.c:1181:34: warning: unused variable 'sunxi_mmc_of_match' [-Wunused-const-variable]
>    static const struct of_device_id sunxi_mmc_of_match[] = {

I'll send a fix.

Best regards,
Krzysztof
