Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B55286E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 07:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgJHFiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 01:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgJHFiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 01:38:18 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79674C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 22:38:17 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id m13so4439221otl.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 22:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bNyi5HMoPtRD0x7CayTyLOQya/iPNAWDKxtNev5YIPo=;
        b=zExvBE4nRYuhgI4z2rHDOJuOlYFx7hF437fwixkwJlZ5ZvY56AszFkTY+UAd+bf3Mw
         4m7BobmEHIkfUh2tZGxoquxRAFH7XUMi+H7XYhj6ZgNRa/8JPiF6dqtw1MaCgzzbv5LX
         yWWztyu+V4lblFRYzdlxV58v7MTvZtoodLbs7P2B373YXyO5JeMbzyZF95j0M+fE068d
         /80VwGT7WEvULIDHF5V3MXPHttZlfQoG0oSTOTm1rt6O0PJNdLAnVu0G9cV5tkLWXtjQ
         rdBaytNrvgMTMJIr0ghTMiXoQSIyR7qrn8nSyGLcsywxmBbTib/c5rMvqVpPm50nDAy1
         vgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bNyi5HMoPtRD0x7CayTyLOQya/iPNAWDKxtNev5YIPo=;
        b=PnRuW1EQLPmNZ5JZDbxlc9jML5Im61zEEqCSeZ+/Lus6dGuGKlp20/q1KvdUYIG3EZ
         LMEnn4L4y6gtuFGhM80ISGx9W/tIbsNC7jAx4v2ppjrl+ToSK+pAt4HYh0DY31zRwMIU
         gbpc/ikOFa9Esul44zSTX1JFjzAYzoxucoTM7sE+i3YwTSoEXib9vVh1yLg7tm4RClpu
         +L71Ev6+UBqI2Qe+tHJReEqXaNGnJXFqFbry4T2+tcB86Zu3c9PqwzD9A3CDPPPHb2AI
         rv8TppK3dCyQ39HlfHJmrpbaTHj4AHUW2qVd55wEQAGAirLAxQRJdPwzkMQNLXVSLouF
         656Q==
X-Gm-Message-State: AOAM533Z/Lbm144AuKOYgTqaSZSj3dzwxCqFSoTJekdBCIc0CuSvMOqQ
        TBJUJ8YcAxQyfKA5uJPWp5VIXWEJXSdHEBrfnLEBrA==
X-Google-Smtp-Source: ABdhPJx4AuhnGkt6ubnmQPzbQLprP/8ICD0w2XfAjwKnemXdn1J5bRFGT3BBLOB0nG7uKwMhhwzCIreC4PsotSswdHM=
X-Received: by 2002:a9d:2c4:: with SMTP id 62mr4342756otl.102.1602135496869;
 Wed, 07 Oct 2020 22:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20201003040257.62768-8-john.stultz@linaro.org> <20201007074352.GP4282@kadam>
In-Reply-To: <20201007074352.GP4282@kadam>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 7 Oct 2020 22:38:03 -0700
Message-ID: <CALAqxLVdjxYB-7hNRoxAMu+qbiQ+qEfo0VMSvRNV391=ffZQwQ@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] dma-buf: system_heap: Add a system-uncached heap
 re-using the system heap
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org, lkml <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Daniel Mentz <danielmentz@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 12:44 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> Hi John,
>
> url:    https://github.com/0day-ci/linux/commits/John-Stultz/dma-buf-Performance-improvements-for-system-heap-a-system-uncached-implementation/20201003-120520
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git bcf876870b95592b52519ed4aafcf9d95999bc9c
> config: i386-randconfig-m021-20201002 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> smatch warnings:
> drivers/dma-buf/heaps/system_heap.c:496 system_heap_create() warn: passing zero to 'PTR_ERR'
>
> vim +/PTR_ERR +496 drivers/dma-buf/heaps/system_heap.c
>
> efa04fefebbd724 John Stultz     2019-12-03  478  static int system_heap_create(void)
> efa04fefebbd724 John Stultz     2019-12-03  479  {
> efa04fefebbd724 John Stultz     2019-12-03  480         struct dma_heap_export_info exp_info;
> efa04fefebbd724 John Stultz     2019-12-03  481
> 263e38f82cbb35b Andrew F. Davis 2019-12-16  482         exp_info.name = "system";
> efa04fefebbd724 John Stultz     2019-12-03  483         exp_info.ops = &system_heap_ops;
> efa04fefebbd724 John Stultz     2019-12-03  484         exp_info.priv = NULL;
> efa04fefebbd724 John Stultz     2019-12-03  485
> efa04fefebbd724 John Stultz     2019-12-03  486         sys_heap = dma_heap_add(&exp_info);
> efa04fefebbd724 John Stultz     2019-12-03  487         if (IS_ERR(sys_heap))
> a2e10cdd2e4d12a John Stultz     2020-10-03  488                 return PTR_ERR(sys_heap);
> efa04fefebbd724 John Stultz     2019-12-03  489
> 553f4e0fafc5b3b John Stultz     2020-10-03  490         exp_info.name = "system-uncached";
> 553f4e0fafc5b3b John Stultz     2020-10-03  491         exp_info.ops = &system_uncached_heap_ops;
> 553f4e0fafc5b3b John Stultz     2020-10-03  492         exp_info.priv = NULL;
> 553f4e0fafc5b3b John Stultz     2020-10-03  493
> 553f4e0fafc5b3b John Stultz     2020-10-03  494         sys_uncached_heap = dma_heap_add(&exp_info);
> 553f4e0fafc5b3b John Stultz     2020-10-03  495         if (IS_ERR(sys_uncached_heap))
> 553f4e0fafc5b3b John Stultz     2020-10-03 @496                 return PTR_ERR(sys_heap);
>                                                                        ^^^^^^^^^^^^^^^^^
> This should be return PTR_ERR(sys_uncached_heap);

Oh nice! Very impressed that the tool caught that!
Thanks so much for the report! I'll fix it up here shortly.
-john
