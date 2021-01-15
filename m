Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F8D2F72EF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 07:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbhAOGeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 01:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbhAOGeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 01:34:05 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CBDC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 22:33:25 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id z11so10786098qkj.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 22:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DJIz1+DmHZJuW5NER9LymtjI15s4MOz81biXerlkn9s=;
        b=TUR6gdQLaIcTz9oz0F7p++EUKXaWInJD5uSJ04u8sCbWc9CNA4anjJlNuBJ0I4Lwrv
         TXYYnUGRBNGy1dOX9NFDA4eZJfYFpAQN3dDQSWF4TlC/VfliRAM9OTmc7QolDGvXwL/g
         4htWksyDciynm2wOThymERBPYEUFqM/DAcwMWPLw9Fo4+rI1QaD8kUeuECMxG+Y9af1Y
         gnYMmbdwQ6W/gummzAJMmLx8vq8d6fJ+EQ12Us4L2gJw8WupcKYfuZuz0gVFyHHlZwaF
         AtBB30cObPXnpwjoJkXMji0UKh+8JL2HsFgUVZO8d7QQiY2M7VTOTpn6bQdcrG4QLfiU
         WG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DJIz1+DmHZJuW5NER9LymtjI15s4MOz81biXerlkn9s=;
        b=RCdWWcX7UtJDjTLNoozpguU+JZ3BlQXNSzEhrMihYfruCUdQHx9Qinl7MGtQ+PWQqE
         ynnYeNkej8+WFE/I3DW+jZbUQl7bvJXJ8XzfbiFQDvefQvx10H6Iu/g7gzGhTD5LXsFW
         u/96Btd4vhOt75mB3lbgVFnLi+Y6NxqANJXTOwwFB4Rmp3hBelBhkzKAnWGOFhK1VssP
         WYN8JMOZlsBElG6VOYtihuecCo6F0/aJnmW/4ltbF0Zo7Uht8XCNrs3a8Uz8iC2v4ldL
         qSDOKRWhiz00/AxW4esWO99ioSBdWGXum3ssw4xsrq6YdakZFqvgILDax302+iTcrmHv
         idZw==
X-Gm-Message-State: AOAM531J3j818cWYw5klyByq79CSyksswnvZREqCgBVgRwF9Ab1PnUSy
        lI9fMiy8zUJ98JgO4BDvpq3qV2STc1IeW7impZxRzFMh1RX5IzX2
X-Google-Smtp-Source: ABdhPJz3XruL3nTQ+7e+CFbCfE+iJm7xNF6TNBsMM9c6vbtOSxjhZTHFySFxPX8BUyPemO/8HK4n8Vq2Y6AF4Zurdn0=
X-Received: by 2002:a37:478e:: with SMTP id u136mr10946713qka.64.1610692404744;
 Thu, 14 Jan 2021 22:33:24 -0800 (PST)
MIME-Version: 1.0
References: <1610675453-14603-1-git-send-email-yejune.deng@gmail.com> <202101151210.n0rr01he-lkp@intel.com>
In-Reply-To: <202101151210.n0rr01he-lkp@intel.com>
From:   Yejune Deng <yejune.deng@gmail.com>
Date:   Fri, 15 Jan 2021 14:33:13 +0800
Message-ID: <CABWKuGV_Ep99iGwMe3P66yNUaHHTR6q_cr7yr=VHfz=dgJDFbA@mail.gmail.com>
Subject: Re: [PATCH] lib: dynamic_queue_limits: use memset and offsetof init
To:     kernel test robot <lkp@intel.com>
Cc:     rdunlap@infradead.org, akpm@linux-foundation.org,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My patch is applied to linux-next/master tree.I also built in arch
arm64 and x86_64,is OK.Is something wrong with that?

On Fri, Jan 15, 2021 at 12:45 PM kernel test robot <lkp@intel.com> wrote:
>
> Hi Yejune,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.11-rc3 next-20210114]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/Yejune-Deng/lib-dynamic_queue_limits-use-memset-and-offsetof-init/20210115-112707
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 146620506274bd24d52fb1c589110a30eed8240b
> config: nds32-randconfig-m031-20210115 (attached as .config)
> compiler: nds32le-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/0day-ci/linux/commit/9be25b076f67d15d29016cb613b95d2ae190a9b4
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review Yejune-Deng/lib-dynamic_queue_limits-use-memset-and-offsetof-init/20210115-112707
>         git checkout 9be25b076f67d15d29016cb613b95d2ae190a9b4
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All error/warnings (new ones prefixed by >>):
>
>    lib/dynamic_queue_limits.c: In function 'dql_reset':
> >> lib/dynamic_queue_limits.c:119:2: error: implicit declaration of function 'memset' [-Werror=implicit-function-declaration]
>      119 |  memset(dql, 0, offsetof(struct dql, lowest_slack));
>          |  ^~~~~~
> >> lib/dynamic_queue_limits.c:119:2: warning: incompatible implicit declaration of built-in function 'memset'
>    lib/dynamic_queue_limits.c:11:1: note: include '<string.h>' or provide a declaration of 'memset'
>       10 | #include <linux/dynamic_queue_limits.h>
>      +++ |+#include <string.h>
>       11 | #include <linux/compiler.h>
>    cc1: some warnings being treated as errors
>
>
> vim +/memset +119 lib/dynamic_queue_limits.c
>
>    115
>    116  void dql_reset(struct dql *dql)
>    117  {
>    118          /* Reset all dynamic values */
>  > 119          memset(dql, 0, offsetof(struct dql, lowest_slack));
>    120          dql->lowest_slack = UINT_MAX;
>    121          dql->slack_start_time = jiffies;
>    122  }
>    123  EXPORT_SYMBOL(dql_reset);
>    124
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
