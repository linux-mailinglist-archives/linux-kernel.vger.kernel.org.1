Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837D62FFB71
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 04:55:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbhAVDzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 22:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbhAVDzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 22:55:17 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B6CC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:54:36 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q7so2801292pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 19:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=jOrbIBu6GQL9pFgpjOIIqB0ulg2pJUW8VotnW9CheWI=;
        b=a+FPlrUqH07Xw7zSLfrtqPr4/oMoRYPNtUoUuQ/mhMmzhqk9sPSmwz69p8HWFTDNDk
         3QjAuNo3dt4SzvfQaCHY8nHRQrOmO7bTPd4Oo8K2G4ZVnNgJGk7ipSNXX9mJZTUi3c/A
         HZP2yQQ0MxUjPPUmKn0VGrqn4C8pMXVm5b848bUHYThYvyGd0UfZjw0rm2y7hhq0d6zX
         8b8tPZzgCdAe/pYTbh9GDq0wEdMiOaWBHMrE8W++NgUUl8lSdyi72znTSlVp0JnclMC/
         YyTUH46MPcb7X3LKHo6R74xtUaw3ftrXk9OSmR9mlJREEVc2y5sAHthkz+OlRULNEplh
         V8/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=jOrbIBu6GQL9pFgpjOIIqB0ulg2pJUW8VotnW9CheWI=;
        b=Y77kPECVV5+xt3hqs6/+zAp7FtGbY4D2WsIDqqdBqqKMPb6h4RoLnqIB/dZUszb4e+
         FTOU6JPNXGg9/fTZVOTcNQEjFVue10cM4GknGkw5YlUohtmmyHTDqkmNl2gr2kI8NdJm
         JJ7ZA30dVLoD0FAn4qFQwq6GyEtd8U7E1MpMXH/k1qfB/nBn78XB/kZKuMBskU3I9z0U
         kjnmxcAsE9q/n+ZcghfsBkJmxwdIZfuVtEX4TRRqEiqtiwIug0IkekCQ3Mk6jQDBGREC
         KFxWHzcsOZ8Vn6gkL2cZH1veUkcYKLtV0VFhNGyZwHBds7o793Kqeqtn9E1mFCMzPMfB
         YLyg==
X-Gm-Message-State: AOAM530PSDvAOtLdryT+/4hg1IG1/05S1XgyDoDQ1zHszFWNUhJaU54J
        TwZtvJEWWSzW3JrE1zuTtmsi8w==
X-Google-Smtp-Source: ABdhPJwyahO1mByKlqr7MqMrNLRMxPvHpbz4q2orBvyt6om+odZWj/zQQHqyK1i2ehWqy71Zeu7Wxw==
X-Received: by 2002:a63:5720:: with SMTP id l32mr2771710pgb.64.1611287676204;
        Thu, 21 Jan 2021 19:54:36 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p8sm7471230pjo.21.2021.01.21.19.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jan 2021 19:54:35 -0800 (PST)
Date:   Thu, 21 Jan 2021 19:54:35 -0800 (PST)
X-Google-Original-Date: Thu, 21 Jan 2021 19:54:28 PST (-0800)
Subject:     Re: [PATCH v3 0/4] initrd: Use unified initrd reserve function in ARM/RISCV
In-Reply-To: <20210115054606.124502-1-wangkefeng.wang@huawei.com>
CC:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux@armlinux.org.uk,
        Atish Patra <Atish.Patra@wdc.com>, guoren@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        wangkefeng.wang@huawei.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-a296f73e-1f6e-41de-8e6d-73d21049acfc@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jan 2021 21:46:02 PST (-0800), wangkefeng.wang@huawei.com wrote:
> Use the same implementation of initrd reserve to avoid duplication.
>
> v3:
> - split into four patches, suggested-by Palmer Dabbelt
> v2:
> - fix build error found by kernel test robot
>
> Kefeng Wang (4):
>   initrd: Add the preprocessor guard in initrd.h
>   initramfs: Provide a common initrd reserve function
>   ARM: Covert to reserve_initrd_mem()
>   riscv: Covert to reserve_initrd_mem()
>
>  arch/arm/mm/init.c     | 43 +--------------------------------
>  arch/riscv/mm/init.c   | 54 +-----------------------------------------
>  include/linux/initrd.h | 11 +++++++++
>  init/initramfs.c       | 45 +++++++++++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+), 95 deletions(-)

Thanks. I have a shared tag with the first two on top of 5.11-rc2 (the start of
my for-next), which I just merged into the riscv/for-next.

git://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git -b shared-lib-reserve_initrd_mem

I'm happy to take the ARM patch if that's easier on your end, but for now I'm
dropping it.
