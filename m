Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18402F8A13
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 01:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbhAPAx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 19:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbhAPAxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 19:53:55 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04CCC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:53:15 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id r9so7392278qtp.11
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 16:53:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yyi8IWdFsxg6H1AnQ+ng6K1xkf6+CLJWG5374hc1nyQ=;
        b=U3RXaFtM2o4boR1xgF5nlryYCFTrSV6xwF9d5qlIXf550eYPVXjZ7PXyzZdbRhsltJ
         58kReuNxDNqeOMquMY1yqFoCtq1C6LjeDDbOQIrnIzYQriine2it/N/f998N8pHv4r5r
         KOdlTzJG46qAbnuoPtXOKsvFzEupoyJdfIdb+xFlu01hxOK4GuP+N1EZy/y66xiywQaS
         oojFK8i/9eIh/0QuLDdgf+DenclV/ktV6fVyU4KklfkkRbYYGtnN+bT/72t1JWG2LbGW
         oRUCoFAHTOgu8p5B0YR2HhvUH52MOfRVcf/uc6zEvfzlP6dZSp5rXAMEYCdeBgsDrucD
         khwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yyi8IWdFsxg6H1AnQ+ng6K1xkf6+CLJWG5374hc1nyQ=;
        b=W81TXszY30LlQZPclkWL9dtEGo5nTKaSZjbWeW3KvAZ5qKoaC1AjJ342qBwOcHTuys
         qJt68m/YSmpN31S7dWQxKHsezrcXLXDhd3kjXMzlbvA7JIPftGaJeBdi5wkXKPYzgkdf
         +GJ3EVbxaAErbLtJWkyJ9myTXDZC3d+OQpskKPZ7MLPiLV5g/IesrtCWF/GOpCdZq11b
         Um2H1d2CK9Nv1wpqDVSnYb7TJ16qgTq4VZX0VG5QprJedWoFfJ5HStN0J1L8BDSEeRqH
         p2s04dG1C28PZFVpKZA5rABdDQdwNTlESxyvqy6A+HnQawToesckxRVoFSWlYapkMTzt
         663A==
X-Gm-Message-State: AOAM532aONat18hhydHIrsLbsA7+s9UOOhjLwiY4I3oEbxIB8jszmuUt
        JOKfVjbB4WBbMSX7jAyvP5e0I5dE45yPpyf6bAU=
X-Google-Smtp-Source: ABdhPJx/yjTJA55C+8tme0DAtD7wVzKj+C5I9vpyVjfPi1q0P1RjcDvg11AQRky39olOdtLW75EgMI+OwM1fNKbx+/0=
X-Received: by 2002:ac8:4c99:: with SMTP id j25mr14526264qtv.390.1610758394934;
 Fri, 15 Jan 2021 16:53:14 -0800 (PST)
MIME-Version: 1.0
References: <1610675453-14603-1-git-send-email-yejune.deng@gmail.com>
 <202101151210.n0rr01he-lkp@intel.com> <CABWKuGV_Ep99iGwMe3P66yNUaHHTR6q_cr7yr=VHfz=dgJDFbA@mail.gmail.com>
In-Reply-To: <CABWKuGV_Ep99iGwMe3P66yNUaHHTR6q_cr7yr=VHfz=dgJDFbA@mail.gmail.com>
From:   Yejune Deng <yejune.deng@gmail.com>
Date:   Sat, 16 Jan 2021 08:53:03 +0800
Message-ID: <CABWKuGVG8tnvvmWSOgzg2XBTxwuTz2X45CJKxN6H7jLE+cf0ew@mail.gmail.com>
Subject: Re: [PATCH] lib: dynamic_queue_limits: use memset and offsetof init
To:     kernel test robot <lkp@intel.com>
Cc:     rdunlap@infradead.org, akpm@linux-foundation.org,
        kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry.It failed in ARCH nds32,I will fix it in the next submit.


On Fri, Jan 15, 2021 at 2:33 PM Yejune Deng <yejune.deng@gmail.com> wrote:
>
> My patch is applied to linux-next/master tree.I also built in arch
> arm64 and x86_64,is OK.Is something wrong with that?
>
> On Fri, Jan 15, 2021 at 12:45 PM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Yejune,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on linus/master]
> > [also build test ERROR on v5.11-rc3 next-20210114]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/Yejune-Deng/lib-dynamic_queue_limits-use-memset-and-offsetof-init/20210115-112707
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 146620506274bd24d52fb1c589110a30eed8240b
> > config: nds32-randconfig-m031-20210115 (attached as .config)
> > compiler: nds32le-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/9be25b076f67d15d29016cb613b95d2ae190a9b4
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Yejune-Deng/lib-dynamic_queue_limits-use-memset-and-offsetof-init/20210115-112707
> >         git checkout 9be25b076f67d15d29016cb613b95d2ae190a9b4
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=nds32
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All error/warnings (new ones prefixed by >>):
> >
> >    lib/dynamic_queue_limits.c: In function 'dql_reset':
> > >> lib/dynamic_queue_limits.c:119:2: error: implicit declaration of function 'memset' [-Werror=implicit-function-declaration]
> >      119 |  memset(dql, 0, offsetof(struct dql, lowest_slack));
> >          |  ^~~~~~
> > >> lib/dynamic_queue_limits.c:119:2: warning: incompatible implicit declaration of built-in function 'memset'
> >    lib/dynamic_queue_limits.c:11:1: note: include '<string.h>' or provide a declaration of 'memset'
> >       10 | #include <linux/dynamic_queue_limits.h>
> >      +++ |+#include <string.h>
> >       11 | #include <linux/compiler.h>
> >    cc1: some warnings being treated as errors
> >
> >
> > vim +/memset +119 lib/dynamic_queue_limits.c
> >
> >    115
> >    116  void dql_reset(struct dql *dql)
> >    117  {
> >    118          /* Reset all dynamic values */
> >  > 119          memset(dql, 0, offsetof(struct dql, lowest_slack));
> >    120          dql->lowest_slack = UINT_MAX;
> >    121          dql->slack_start_time = jiffies;
> >    122  }
> >    123  EXPORT_SYMBOL(dql_reset);
> >    124
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
