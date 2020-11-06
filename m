Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE602A9015
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 08:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgKFHOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 02:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFHOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 02:14:33 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D746C0613D2
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 23:14:33 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id r186so266560pgr.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 23:14:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=s6YH0eSX/RwKBuEX1w8IFmHtUiOjP/eJyOwuklXDjTY=;
        b=aIFAyjg+EyzWOA841bpmazYcgV0AEulGrJoP7hNS4+EvMG+RSK1jTROG3a5pH/GI+K
         DkTA6VDl4j7/iESdcTK0dpUFAWWF9yaZ/LSzXIYSivrxbEuxmhmF8kMrG0eDpUWYt0Yr
         WwChrkAa/SYesmZ96R97diB/kOp3JEj8SR1QQI+4iBl4eOMdMlGzaIWfdIIwA/sHwpmN
         gTuSeVR4J5gm6xa1nT5gg6/Q7KX3v8BS3wBOiS3Zun/d6+JTj2YlJ/VRV3GJicCjOzwx
         LwluV5esuaGx+mc228szbCmDrUNatBJ9QnvWfAEOIkEvPWA5b6OAicG+lUmBdYsfdnhx
         fL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=s6YH0eSX/RwKBuEX1w8IFmHtUiOjP/eJyOwuklXDjTY=;
        b=KAomY3vPAoFp6HpoU+mok+D18w7F6orqvzRF0kAWDs+gatjalpzpa83r2T3hYRV37X
         sbSoCN0mK5bwqBQwdtHTKQ41oy+4VMuGtRHEJDc8PRx6RLHDf6mxS8kjURtY6LSu0SND
         I94T7Z/KcGjXZ4iFgxyPoTo1aZH/EzG1tZ4UfL802We4s7p8q/OhteS4StYymQaqs64L
         c2SOt2fcdbX64Yeg3lNsiPFRZgMOMhPUiDElSiYpFtF0eABXD+LHIubsEf9N2yDNB2ak
         FOfO63ELzMz/IRzFIag60PUGR6J0I6/fuEu4wNkeb5TE6WoJDk6YFHD6QGCI1JK7ZRiR
         UE/w==
X-Gm-Message-State: AOAM53010Sx2nxVodR1d90Jm21Um2Jrw4Z7YVHzXCBZuyc+ADUbkvNDG
        SuQPStSvrjIGdF4M/1aUWhCv1rQfCNCTugQC
X-Google-Smtp-Source: ABdhPJwO5bd7mi+tpUBxCMN/fsu4RTpUPPzVVz7lSqd3QdBGhSN0bUat6hJsfWe7wtQ9bgwt6mCPPw==
X-Received: by 2002:a17:90b:707:: with SMTP id s7mr1034437pjz.104.1604646872545;
        Thu, 05 Nov 2020 23:14:32 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s18sm632539pgh.60.2020.11.05.23.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 23:14:32 -0800 (PST)
Date:   Thu, 05 Nov 2020 23:14:32 -0800 (PST)
X-Google-Original-Date: Thu, 05 Nov 2020 22:54:57 PST (-0800)
Subject:     Re: [RFC PATCH 1/3] RISC-V: Add Microchip PolarFire SoC kconfig option
In-Reply-To: <20201028232759.1928479-2-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        aou@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, robh+dt@kernel.org,
        padmarao.begari@microchip.com, daire.mcnamara@microchip.com,
        Cyril.Jean@microchip.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-849d17e7-0bff-4d49-b7d9-28909d199dfb@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Oct 2020 16:27:57 PDT (-0700), Atish Patra wrote:
> Add Microchip PolarFire kconfig option which selects SoC specific
> and common drivers that is required for this SoC.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  arch/riscv/Kconfig.socs | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/riscv/Kconfig.socs b/arch/riscv/Kconfig.socs
> index 8a55f6156661..74d07250ecc5 100644
> --- a/arch/riscv/Kconfig.socs
> +++ b/arch/riscv/Kconfig.socs
> @@ -22,6 +22,13 @@ config SOC_VIRT
>  	help
>  	  This enables support for QEMU Virt Machine.
>
> +config SOC_MICROCHIP_POLARFIRE
> +	bool "Microchip PolarFire SoCs"
> +	select MCHP_CLK_PFSOC
> +	select SIFIVE_PLIC
> +	help
> +	  This enables support for Microchip PolarFire SoC platforms.
> +
>  config SOC_KENDRYTE
>  	bool "Kendryte K210 SoC"
>  	depends on !MMU

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
