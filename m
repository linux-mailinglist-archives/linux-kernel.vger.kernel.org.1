Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3717C2F5A21
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 06:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbhANFBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 00:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbhANFBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 00:01:47 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D12C06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:01:01 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id b5so2548480pjk.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 21:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=gdO0WTSyKWA1CQWh1+Ms9mCRHiJwmYIbRxyUnFoqJbg=;
        b=yqUJsNuQvhJwtek4cII9glL+VwLRVnrFOPIRqRs6YdXrtpfm/7JXl/j9KNtk422wZq
         PESK/HebDRDwAy4R90sIqGYW3YkUbuh31Nf/ldw3M1wFXVV/lqkHwvaEIJz0DVWtlU1+
         eEskoM+msdxRd4juvrvkjwBe9ml4NKM7nNwU5Yi7TW86MximiFYj1B07J3pinLzRcukJ
         Xwgb7N7NXskG5iR8L5EBj3ARX835VoyDRVREWi5rMj+6dEnIeOWhGm8v8uMqa86rK/Lp
         36VioJww4YzNLHAE6LAsX8eDloV1UAlxbwpJTkjEL6ClVy49Aa/GjHgdwzIoIas9VKka
         SeTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=gdO0WTSyKWA1CQWh1+Ms9mCRHiJwmYIbRxyUnFoqJbg=;
        b=pi7Ycq5NhK1KZpgXBBLmRRUSk5ws1Y3ooJ9KbFueHAAPRVovuCk1eVjEfZfToucil8
         tCwx6Q0I7JLy3VCx0ywWmfzM0IxjNcGc5liROHR9S1+Oop30Tzkvu6GLjcv6+1xvHhqS
         zLs0uPP/Zkwi3oH8CC1JvvNoRqbbvj30qGiKygcJaTf/AyDvmlLnOdwhhP2Z0Rdy1On+
         17q/IQsRxIKvJjXgEqPbzm7mNW6MVjeqHMKyWWoAzKwkIMZqW2Ep8W949OKxQn4BpUl8
         SefLJzcwJ5TAHSV17tNF59SKo42JTy67r4WiD07yczvdYoti3R5k6yDoYAGaFok813aY
         kvCQ==
X-Gm-Message-State: AOAM533Owgi+xUAJ4LR1PLc4GrnDX8IpRfHfxKiDRXHKAvq8M1LL+o27
        oN8DVAOYP9lqTLtErBkQeSanEDw7xoBorQ==
X-Google-Smtp-Source: ABdhPJw/KjwzxMrzkLg64ELSAlY5MYh64l6TXiHKqd631a6TQBCTeucap9fzUW/vz4QqeYnG6FGkfw==
X-Received: by 2002:a17:902:ee0b:b029:db:c808:ccef with SMTP id z11-20020a170902ee0bb02900dbc808ccefmr5909294plb.85.1610600461055;
        Wed, 13 Jan 2021 21:01:01 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id ft9sm104201pjb.17.2021.01.13.21.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 21:01:00 -0800 (PST)
Date:   Wed, 13 Jan 2021 21:01:00 -0800 (PST)
X-Google-Original-Date: Wed, 13 Jan 2021 21:00:58 PST (-0800)
Subject:     Re: [PATCH v2 0/3] fix macb phy probe failure if phy-reset is not handled
In-Reply-To: <1605021732-268521-1-git-send-email-sagar.kadam@sifive.com>
CC:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, kernel@esmil.dk,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, yash.shah@sifive.com, aou@eecs.berkeley.edu,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        sagar.kadam@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     sagar.kadam@sifive.com
Message-ID: <mhng-40b3307c-6849-46f4-83c3-ffa1ab92baef@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020 07:22:09 PST (-0800), sagar.kadam@sifive.com wrote:
> HiFive Unleashed is having VSC8541-01 ethernet phy device and requires a
> specific reset sequence of 0-1-0-1 in order to use it in unmanaged mode.
> This series addresses a corner case where phy reset is not handled by boot
> stages prior to linux.
> Somewhat similar unreliable phy probe failure was reported and discussed
> here [1].
> The macb driver fails to detect the ethernet phy device if the bootloader
> doesn't provide a proper reset sequence to the phy device or the phy itself
> is in some invalid state. Currently, the FSBL or u-boot-spl is resetting
> the phy device, and so there is no issue observed in the linux network
> setup.
>
> The series is based on linux-5.10-rc5.
> Patch 1: Add the OUI to the phy dt node to fix issue of missing mdio device
> Patch 2 and 3:
> 	Resetting phy needs GPIO support so add to dt and defconfig.
>
> [1] https://lkml.org/lkml/2018/11/29/154
>
> To reproduce the issue:
> Using FSBL:
> 1. Comment out VSC8541 reset sequence in fsbl/main.c
>    from within the freedom-u540-c000-bootloader.
> 2. Build and flash fsbl.bin to micro sdcard.
>
> Using u-boot:
> 1. Comment out VSC8541 reset sequence in board/sifive/fu540/spl.c
>    from mainline u-boot source code.
> 2. Build and flash u-boot binaries to micro sdcard.
>
> Boot the board and bootlog will show network setup failure messages as:
>
> [  1.069474] libphy: MACB_mii_bus: probed
> [  1.073092] mdio_bus 10090000.ethernet-ffffffff: MDIO device at address 0
> 	       is missing
> .....
> [  1.979252] macb 10090000.ethernet eth0: Could not attach PHY (-19)
>
> 3. Now apply the series build, and boot kernel.
> 4. MACB and VSC8541 driver get successfully probed and the network is set
>    without any failure.
>
>
> So irrespective of whether the prior stages handle the phy reset sequence,
> the probing is successful in both the cases of cold boot and warm boot.
>
> Change History:
> ===============================
> V2:
> -Rebased v1 on linux kernel v5.10-rc3.
>
> V1:
> -Ignore 4th patch as suggested and so removed it from the series.
> -Verified this series on 5.7-rc5.
>
> V0: Base RFC patch. Verified on 5.7-rc2
>
> Sagar Shrikant Kadam (3):
>   dts: phy: fix missing mdio device and probe failure of vsc8541-01
>     device
>   dts: phy: add GPIO number and active state used for phy reset
>   riscv: defconfig: enable gpio support for HiFive Unleashed
>
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 2 ++
>  arch/riscv/configs/defconfig                        | 2 ++
>  2 files changed, 4 insertions(+)

David pointed out I missed these, they're on fixes.  Thanks!
