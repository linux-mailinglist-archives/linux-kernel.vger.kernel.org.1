Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666E32C4DA0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 04:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgKZDFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 22:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732425AbgKZDFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 22:05:03 -0500
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808EEC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:05:02 -0800 (PST)
Received: by mail-oo1-xc41.google.com with SMTP id h10so96367ooi.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 19:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ia7D6bExbGpst+sPe9IYyFsCKYnhwQ5YD1Ag6MqNa9Q=;
        b=QeTQ5iJEWt0cMw5dqYxHgFZVxroA73afTnZTUKin+4nghfef6B5yrxcFNPvegT8qBf
         YTefi635NXQkqTOruqoPH96n8Rx/WcMPI9Bt0KQGDGR/xgC/CjCqw8rov//5y2bYgMWA
         OHGf0ZH9xck3Y+FCvyCpunR1x18dZW2hPvQv7FiRqlnXS+VebnXMvYVFoZMjoW/lTXm/
         N34gqQikhzSAdBnbJaeqvCJQCksT3a4GZiFLQXB8cxO4Cv+iPqR053/SVkxnZv0vfou2
         9nsUUYFeJqWgspU+YFMLtB/DKtqU5WjjzifukOe1l36AM/AsXb/Ftw8un1Z9feEdbfu5
         6d+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ia7D6bExbGpst+sPe9IYyFsCKYnhwQ5YD1Ag6MqNa9Q=;
        b=dRx0OJkazWfFnin/qb3yNSGLYOEHBbK9w4EtXf1C/5ZqgApki6U4E2AxRF1zYcQsj1
         r0TBfCK/OJjPNnc2KSVEZuJOJURwOP8yGa2uidYZtxaF1x5TrBRydNbrl4yO+TBH5mOE
         NloFlwNBzLtaFeJ3947dAWHPAg2jIFSTM6t8NomzZW8jV9YKV7pmIfzLnOVGQ6TBYjSc
         65B+Y7B8ieT7SFBaCEuOR/+m8EkopyvCGvP/pxWYFfF1gzIokCXva7jZnFRiO7msQfeV
         r4rtxI8nEuoHkhwRfLVATmXCPn/cTpN4ePUHpQAQkyWXGIzc+tpAFYvxf8Sit+uSSE8L
         4bKw==
X-Gm-Message-State: AOAM530q0eEUXbCgWExLlewsLAkDQrfmiCGM1+8XI/FHmyaRDE3nwnQT
        4KXT2Ty8AQitR4XyZTFsXf7TL4XI/o+aLTpoS+cPeg==
X-Google-Smtp-Source: ABdhPJzEQJKg3GtGD4nIFKKsjIIVXwsdLRt5qMtGdVulnYTH6c76BbtnO7sKZ1nNwOktpYnj4U+GEioYklOycxeSWDs=
X-Received: by 2002:a4a:de19:: with SMTP id y25mr638218oot.33.1606359901824;
 Wed, 25 Nov 2020 19:05:01 -0800 (PST)
MIME-Version: 1.0
References: <20201111100608.108842-2-zong.li@sifive.com> <202011250226.TqdPflR5-lkp@intel.com>
In-Reply-To: <202011250226.TqdPflR5-lkp@intel.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 26 Nov 2020 11:04:51 +0800
Message-ID: <CANXhq0o-k0JwavOR9S=Wvjn9v5tkOSX1QYnoiGH1LRWeFaKaww@mail.gmail.com>
Subject: Re: [PATCH v4 1/4] clk: sifive: Extract prci core to common base
To:     kernel test robot <lkp@intel.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Pragnesh Patel <pragnesh.patel@openfive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Yash Shah <yash.shah@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, kbuild-all@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 2:43 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Zong,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on clk/clk-next]
> [also build test ERROR on robh/for-next linus/master linux/master v5.10-rc5 next-20201124]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Zong-Li/clk-add-driver-for-the-SiFive-FU740/20201111-180900
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
> config: riscv-randconfig-r003-20201124 (attached as .config)
> compiler: riscv32-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/f08e191181ee40e21d9c1d63cfa4d894bc86ff27
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Zong-Li/clk-add-driver-for-the-SiFive-FU740/20201111-180900
>         git checkout f08e191181ee40e21d9c1d63cfa4d894bc86ff27
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    riscv32-linux-ld: drivers/clk/sifive/sifive-prci.o: in function `sifive_prci_wrpll_recalc_rate':
> >> sifive-prci.c:(.text+0x398): undefined reference to `wrpll_calc_output_rate'
>    riscv32-linux-ld: drivers/clk/sifive/sifive-prci.o: in function `sifive_prci_wrpll_round_rate':
> >> sifive-prci.c:(.text+0x41a): undefined reference to `wrpll_configure_for_rate'
> >> riscv32-linux-ld: sifive-prci.c:(.text+0x428): undefined reference to `wrpll_calc_output_rate'
>    riscv32-linux-ld: drivers/clk/sifive/sifive-prci.o: in function `sifive_prci_wrpll_set_rate':
>    sifive-prci.c:(.text+0x480): undefined reference to `wrpll_configure_for_rate'
> >> riscv32-linux-ld: sifive-prci.c:(.text+0x4ee): undefined reference to `wrpll_calc_max_lock_us'
> >> riscv32-linux-ld: drivers/clk/sifive/sifive-prci.o:(.srodata+0x0): undefined reference to `__prci_init_clocks_fu540'
>

Fix the dependency of sifive-prci.c in the next version patch set by
following, only build core code if CONFIG_CLK_SIFIVE_PRCI is selected.

- obj-y  += sifive-prci.o
+ obj-$(CONFIG_CLK_SIFIVE_PRCI)   += sifive-prci.o

> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
