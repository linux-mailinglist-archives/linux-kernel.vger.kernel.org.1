Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE51A27AF6E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 15:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgI1Nxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 09:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgI1Nxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 09:53:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5D6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:53:39 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so1461035wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 06:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=BoiDxj+kmre+AncyzQpw2WTpn5vHYwP0ngcsFvj+7wo=;
        b=ZIMyWMgQFsaTujLz7X1+KCMgCH9YV3nmMonVsxkVtjr2DwZb8b2KRlOyw+8rOIhenu
         clJ0d08SIDg85R5eMgo0RDSJbPNz8vlEx3BAygCleC+yVCIQxBgqr7fMOqnsTs3YgsY+
         /SwBO/2OeFahTapIPQ71JVtrJA6qr9moSaL1i5xQcpJRMQD2C439eN07y6Hkdn6oDZ7L
         Mz/yTYsfnS+ezxQ1scclN5pjOqJXOXI7cJEcVVXrOncQyAyK/AmIcw7mvPLg5D+pxu6T
         VJAPKtXNc1MosZgsy27DFBxibrnv2nABbtMBenuEwC4w2WuCdi53WZQstS+GNC/b++2T
         QSFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=BoiDxj+kmre+AncyzQpw2WTpn5vHYwP0ngcsFvj+7wo=;
        b=J+G7Pad3ImuUv/ofFsYRalrCLDay0g6C6MY3DuseQonm4XAhY+oC/jHLG4IVMHpqVg
         u/LZ91mSclYwliGi05WKF2v48FPoBTw47EIrkf/q3abh32XHY7h3NOQcp2Xhy32jAqud
         wyjT7plZtTRjj1e3sz1xhtJuy5m6nmtJ4/kH619u7rr7EQZBvMVAZ6TEXQbLAsFbdc25
         X+gU2OlqE2eICzCabZISohkN6JdaMv3ikQBt6L2L2aDv/vD0HnJxdEsJj3Ft38XeDe61
         kSZwGEuXUbfG+Q7/kwFNUK3XQuwULss1BhCt2Ugi3CqrFPHJRWe+xmgxkNwlWRwGfr4S
         ixjA==
X-Gm-Message-State: AOAM533BBnllycrIqlV4JXKSMpY1eY5yWIUegzTg/0y6RHc8B8cYU8i1
        SSQeHX5YGKHXXXYUJgYZy1U4c8ZWXW4k9w==
X-Google-Smtp-Source: ABdhPJwxgVcdE/TUHM5Vw8mYnuAMluQ/fluiFYoM8BHmVkyg2WYiyMdoDEivte8vPpjCppqPrub92w==
X-Received: by 2002:adf:f808:: with SMTP id s8mr1863701wrp.268.1601301217983;
        Mon, 28 Sep 2020 06:53:37 -0700 (PDT)
Received: from dell ([91.110.221.154])
        by smtp.gmail.com with ESMTPSA id 92sm1773204wra.19.2020.09.28.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 06:53:37 -0700 (PDT)
Date:   Mon, 28 Sep 2020 14:53:35 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, broonie@kernel.org, hao.wu@intel.com,
        mdf@kernel.org
Subject: Re: [PATCH v6] mfd: intel-m10-bmc: add Intel MAX 10 BMC chip support
 for Intel FPGA PAC
Message-ID: <20200928135335.GA6148@dell>
References: <1600141461-12999-1-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1600141461-12999-1-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Sep 2020, Xu Yilun wrote:

> This patch implements the basic functions of the BMC chip for some Intel
> FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
> Intel MAX 10 CPLD.
> 
> This BMC chip is connected to the FPGA by a SPI bus. To provide direct
> register access from the FPGA, the "SPI slave to Avalon Master Bridge"
> (spi-avmm) IP is integrated in the chip. It converts encoded streams of
> bytes from the host to the internal register read/write on the Avalon
> bus. So This driver uses the regmap-spi-avmm for register accessing.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: Split out the regmap-spi-avmm part.
>     Rename the file intel-m10-bmc-main.c to intel-m10-bmc.c, cause
>      there is only one source file left for this module now.
> v3: Add the sub devices in mfd_cell.
>     Some minor fixes.
> v4: No change.
> v5: Changes the names of mfd_cell.
>     Use ATTRIBUTE_GROUPS() to simplify the code.
>     Use the generic 'ddata' for the instance of struct intel_m10bmc.
>     More comments to clarify the function check_m10bmc_version().
>     Some minor fixes.
> v6: Defines macro for invalid legacy bmc version value to make the
>      version check more clear.
>     Add comments for the purpose of abstraction of the regmap ops.
> ---
>  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 ++
>  drivers/mfd/Kconfig                                |  13 ++
>  drivers/mfd/Makefile                               |   2 +
>  drivers/mfd/intel-m10-bmc.c                        | 164 +++++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h                  |  65 ++++++++
>  5 files changed, 259 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>  create mode 100644 drivers/mfd/intel-m10-bmc.c
>  create mode 100644 include/linux/mfd/intel-m10-bmc.h

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
