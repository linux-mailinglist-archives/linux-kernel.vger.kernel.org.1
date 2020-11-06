Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5272A910F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgKFIL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgKFILz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:11:55 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8C5C0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 00:11:54 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id 10so613631pfp.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 00:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=nl2gOQJsn3R5FlGmFMYIhkURcmKqqMa3zHkLCq1t0Aw=;
        b=xEpk9Oeh7f3I+9/gTukNIEnoWwbjWmLjU4TDeWnSzvQ1A0cupFlA2T16UYK+zxbIus
         4y2maE0uVaNwxdV4MBk6k5bde8rAirUprLpzlLPXq5UJckG5DaR0oHYXGd9JRj0Ip2Ic
         XsSeHOdu8+580ytgr9XB4BhlYuvBHdrPPW7St81aqo44K98Qc0yzzyW5hDhsS5H6F+4d
         OPNlN8jrWd7gnEI9DNNlBMXpoYCLPAAC4kD77Y/9iCRfXY8qgQYNZK9YhWSke0Rtac4X
         S4CZIN1WiJfsA3ZkC/JUk9cnD/XySA5k/Jr1iUBzT3uXsAbr4gaV3rkDSTEAFSirsxdw
         vpFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=nl2gOQJsn3R5FlGmFMYIhkURcmKqqMa3zHkLCq1t0Aw=;
        b=CC30sp8N4hrUCK7UfOizGHbeUX63rXLpU2gAT10YgqJWUr3fzer/bScSxx5tUJ5VT1
         MOpbBVWGPXauE2UWWSrzaM9QONRf5Up119Oh7wo9yXdwjS0jUiXSa6XTKf4AhpvzOQHB
         /jLOKa52Prg8UgAPgTQv0pm9ZM04yvKqCGwxO4boWBVeZXs/hcoDjjdAYOLJaTm4RqUB
         2rv1vA2dmniWyje13cz9CHcX+CvIrrKvCNI8DiyTolieHNUq+ykVGFS2WzJ8qIv2sdTS
         5dvNUDvV+EKOgmcNw8bacQaY30hNeMSAqPwqWtCHIsb5Zk/hbRteD8SyyGtstABhn9aR
         U9Mg==
X-Gm-Message-State: AOAM530bl1O5zK0gycSp/7neFkAU207A8c2km8t8MaTSMyhN9E4kgB+1
        TUXl+wAVwVJvxKw5jU+J0Q07eA==
X-Google-Smtp-Source: ABdhPJxo1RjiXlb6GUZrxagqr8RXpC5+1TbkUZrlXDd0OeSammEjxunDGz18YSh3pIvPN5PbT7NENw==
X-Received: by 2002:a17:90a:bb0e:: with SMTP id u14mr1240572pjr.112.1604650314068;
        Fri, 06 Nov 2020 00:11:54 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a22sm1062947pfk.29.2020.11.06.00.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2020 00:11:53 -0800 (PST)
Date:   Fri, 06 Nov 2020 00:11:53 -0800 (PST)
X-Google-Original-Date: Fri, 06 Nov 2020 00:11:50 PST (-0800)
Subject:     Re: [RFC PATCH 0/3] Add Microchip PolarFire Soc Support
In-Reply-To: <CAOnJCUJUmzVon3BWH6Du08mpgLu_rHJEhdOkCXUK4N+ZftkCRw@mail.gmail.com>
CC:     Atish Patra <Atish.Patra@wdc.com>, devicetree@vger.kernel.org,
        aou@eecs.berkeley.edu, Cyril.Jean@microchip.com,
        daire.mcnamara@microchip.com, Anup Patel <Anup.Patel@wdc.com>,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, padmarao.begari@microchip.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     atishp@atishpatra.org
Message-ID: <mhng-484134d1-59a4-48ca-84da-9569d5f70ad7@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Nov 2020 23:37:45 PST (-0800), atishp@atishpatra.org wrote:
> On Thu, Nov 5, 2020 at 11:14 PM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Wed, 28 Oct 2020 16:27:56 PDT (-0700), Atish Patra wrote:
>> > This series adds minimal support for Microchip Polar Fire Soc Icicle kit.
>> > It is rebased on v5.10-rc1 and depends on clock support.
>> > Only MMC and ethernet drivers are enabled via this series.
>> > The idea here is to add the foundational patches so that other drivers
>> > can be added to on top of this.
>> >
>> > This series has been tested on Qemu and Polar Fire Soc Icicle kit.
>> > The following qemu series is necessary to test it on Qemu.
>> >
>> > The series can also be found at the following github repo.
>> >
>> > I noticed the latest version of mmc driver[2] hangs on the board with
>> > the latest clock driver. That's why, I have tested with the old clock
>> > driver available in the above github repo.
>>
>> OK, I guess that's why it's an RFC?
>>
>
> Yes. The latest clock/pcie driver did not work for me. I might have
> missed something in DT.
> The idea for RFC is so that anybody who wants to try the latest kernel
> on a polarfire board
> has a meaningful way to test it.
>
>> > [1] https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg08582.html
>> > [2] https://www.spinics.net/lists/devicetree/msg383626.html
>>
>> Looks like this one hasn't been merged yet.  IDK if something is broken with my
>> mail client but I'm not seeing any github repos.  If this depends on
>> not-yet-merged drivers then it's certainly RFC material, but aside from the DT
>> stuff (which should be straight-forward) it seems fine to me.
>>
>
> I think it makes sense to take this series once the clock driver is
> merged at least.
>
>> Since you posted this an an RFC I'm going to assume you're going to re-spin it.
>>
>
> Yes. There are some feedbacks on DT which I will fix in v2.

Thanks!

>
>> Thanks!
>>
>> >
>> > Atish Patra (3):
>> > RISC-V: Add Microchip PolarFire SoC kconfig option
>> > RISC-V: Initial DTS for Microchip ICICLE board
>> > RISC-V: Enable Microchip PolarFire ICICLE SoC
>> >
>> > arch/riscv/Kconfig.socs                       |   7 +
>> > arch/riscv/boot/dts/Makefile                  |   1 +
>> > arch/riscv/boot/dts/microchip/Makefile        |   2 +
>> > .../microchip/microchip-icicle-kit-a000.dts   | 313 ++++++++++++++++++
>> > arch/riscv/configs/defconfig                  |   4 +
>> > 5 files changed, 327 insertions(+)
>> > create mode 100644 arch/riscv/boot/dts/microchip/Makefile
>> > create mode 100644 arch/riscv/boot/dts/microchip/microchip-icicle-kit-a000.dts
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
