Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3292EBA48
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbhAFHAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbhAFHAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:00:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB032C061357
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 23:00:03 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id y24so3404771edt.10
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 23:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kv8nRLjsuAcXnyWTXClR33zRdQK5e2NXZzdyNIims3Q=;
        b=Ep667Y43ujaKVx164XzHCTohfcQ4r4/MKoExyrY+vNzJtIXNtMpPRkKmt82M9mFF1t
         hsU0hJErGIRaP8DdxFhpSOxFrxnvG2XBobctghB/5v7rfHexAjkPNhPerrIfrzR1EE0c
         SxEJT08IhO5ZkJIOhzQSn2bd80fOoAQvKM1wAk/hRiAppIhyydQPo1281SronJtx16n5
         KroWsfzTiWgIxJesSjTehkmgiquqZYRPNQzBkH9FOk1hMZl0QVxUKgyS+htFOaAHhzKP
         Hj3lvDT/TotGAojz8b/Z1ayD2FP7D0DJ6LB22Ejrpx/34SAq4V+2gzRWZPB64drWk6Ca
         LOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kv8nRLjsuAcXnyWTXClR33zRdQK5e2NXZzdyNIims3Q=;
        b=C7BJu3O8EXXo5wsXdiqPY0H8KRBkW2SpGAcFKRnK2JqBOSGk5ktrmbXH3oh5ZGIKDH
         ruNZWn+4NXJO/s9W0be0ZZCKxUp2C7SWSoA7+4qxa5eWZX2SLsZsTnkJ8G5UKYOvTibp
         AB8vlPGzifPTnlxKJ1yQaGlHrTa3jwN+ae0MucWNjUjMn6z02xPuS7ERoGYZd/FzA/uc
         BUKCGSPiTWNxUvUmLKuxh+pCPQkexqYCOm95G9vwxQm16J4wFAcrD9grCKeV54McOX0Y
         hs7hpjXTJyaJEyt54mJdGw7Hss4K5YkHb6iUlJJV1VGnfzO+4MEnsALxQrC7F0aaGMEU
         GAbA==
X-Gm-Message-State: AOAM530z+VdrCPJKGhR49u4u2FiwZX0JVGbmDybF9kfxao5+yEj3V7yv
        IJEMIK+2K5Jce3+2PReAKRgE5rbiHsWOibetGJ6rxQ==
X-Google-Smtp-Source: ABdhPJymhgWMXrAR6nWVrqZyrUQA9tMhZQPqDfwh0sx7t1nuxzUe+qPC7O/2f99QbynfpbcTX84SnPEjIACfBeWPUk8=
X-Received: by 2002:a05:6402:17:: with SMTP id d23mr3003595edu.341.1609916402398;
 Tue, 05 Jan 2021 23:00:02 -0800 (PST)
MIME-Version: 1.0
References: <20210105134424.30632-1-brgl@bgdev.pl> <202101061453.E7YDzBDz-lkp@intel.com>
 <CAMpxmJUxKD9-J+MESZMxMePZX4WO_QFj6FudrAKS=Tp_kW8iOQ@mail.gmail.com>
In-Reply-To: <CAMpxmJUxKD9-J+MESZMxMePZX4WO_QFj6FudrAKS=Tp_kW8iOQ@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 6 Jan 2021 07:59:51 +0100
Message-ID: <CAMpxmJXca8Wc0Fwod+mESC6cee5SEamyN6ayj1AqFQJBHVqQ3A@mail.gmail.com>
Subject: Re: [PATCH] rtc: s5m: use devm_i2c_new_dummy_device()
To:     kernel test robot <lkp@intel.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-rtc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 6, 2021 at 7:52 AM Bartosz Golaszewski
<bgolaszewski@baylibre.com> wrote:
>
> On Wed, Jan 6, 2021 at 7:47 AM kernel test robot <lkp@intel.com> wrote:
> >
> > Hi Bartosz,
> >
> > I love your patch! Perhaps something to improve:
> >
> > [auto build test WARNING on abelloni/rtc-next]
> > [also build test WARNING on v5.11-rc2 next-20210104]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/Bartosz-Golaszewski/rtc-s5m-use-devm_i2c_new_dummy_device/20210105-214736
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
> > config: x86_64-randconfig-a004-20210105 (attached as .config)
> > compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 5c951623bc8965fa1e89660f2f5f4a2944e4981a)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         # https://github.com/0day-ci/linux/commit/21651184178d1001f3bbc858c9161f1b7fd65321
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Bartosz-Golaszewski/rtc-s5m-use-devm_i2c_new_dummy_device/20210105-214736
> >         git checkout 21651184178d1001f3bbc858c9161f1b7fd65321
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>):
> >
> > >> drivers/rtc/rtc-s5m.c:773:4: warning: variable 'ret' is uninitialized when used here [-Wuninitialized]
> >                            ret);
> >                            ^~~
> >    include/linux/dev_printk.h:112:32: note: expanded from macro 'dev_err'
> >            _dev_err(dev, dev_fmt(fmt), ##__VA_ARGS__)
> >                                          ^~~~~~~~~~~
> >    drivers/rtc/rtc-s5m.c:719:9: note: initialize the variable 'ret' to silence this warning
> >            int ret, alarm_irq;
> >                   ^
> >                    = 0
> >    1 warning generated.
> >
> >
> > vim +/ret +773 drivers/rtc/rtc-s5m.c
> >
>
> This isn't caused by this patch, it seems to be an older bug. I can
> try to fix it while at it.
>
> Bart

-ETOOEARLY actually it's my bad, I'll fix that in v3.

Bartosz
