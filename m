Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 813A1300F09
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbhAVVjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:39:24 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:35784 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbhAVVgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:36:42 -0500
Received: by mail-ed1-f46.google.com with SMTP id j13so8203896edp.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:36:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SkMtSllHFpUQ8QORRPXzW7+ePTF0623ZPgLmVHJs6Fo=;
        b=JJGD22uq7L/hV9/eYLkdQUU53X/Uk6leUeFVBbZWtI0nrCbYPUNWUwpGPdR3Cj5eyk
         HxoknqQ9xf5IA642jF7tZPnDurcZTmNcq7z2KMRj7o2MGX0lfK9yamFIQaKVWZAemGpF
         U7VfFB06/A5iwoMhf1+9XBYeFLGMZe3miocmXnVAxBo/GNYYwbBg0iRYdpHJX60KyAAL
         BEuSzJpmz2zSq6y+MwtW3m+83VYcjfKKDuuhLp+26cMfdmAB0H6AeBzgRVONburPiUlz
         3l/AuMyjV0gOoSMUcVfjAnmni1bnqHnmVnLIT3nnvYyx3KPiduZq6mQ1Q/b4xyFA+6nX
         X91A==
X-Gm-Message-State: AOAM532huOZKzGekbQfQtlquJycZVWhwR1VqYVPX2WaJKJU004de++jl
        V4tpBo1/YJkUWI2hKvdVelQ=
X-Google-Smtp-Source: ABdhPJzyOg235kQhejoZjjhHYiWr6Bp7npq1HcrfeqLsMBqDf51BuMXEE+Y4urYHbsd/eXktSLe02A==
X-Received: by 2002:a05:6402:1ad0:: with SMTP id ba16mr7963edb.287.1611351360723;
        Fri, 22 Jan 2021 13:36:00 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id z1sm6442231edm.89.2021.01.22.13.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 13:35:59 -0800 (PST)
Date:   Fri, 22 Jan 2021 22:35:58 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Joerg Roedel <joro@8bytes.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>, Tomasz Figa <tfiga@google.com>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        Nicolas Boichat <drinkcat@chromium.org>, anan.sun@mediatek.com,
        yi.kuo@mediatek.com
Subject: Re: [PATCH 3/3] memory: mtk-smi: Switch MTK_SMI to tristate
Message-ID: <20210122213558.qnboqc4obdmipxs4@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-4-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121062429.26504-4-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:24:29PM +0800, Yong Wu wrote:
> This patch switches MTK_SMI to tristate. Support it could be 'm'.
> 
> Meanwhile, Fix a build issue while MTK_SMI is built as module.

s/Fix/fix.

What error is being fixed here? How can I reproduce it? Aren't you just
adjusting it to being buildable by module?

Best regards,
Krzysztof


> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
> This patch has a little conflict with the mt8192 iommu patch which
> delete the MTK_LARB_NR_MAX in smi.h(It's still reviewing).
> This patch rebase on the clean v5.11-rc1.
> ---
>  drivers/memory/Kconfig     | 2 +-
>  include/soc/mediatek/smi.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
> index 3ea6913df176..d5f0f4680880 100644
> --- a/drivers/memory/Kconfig
> +++ b/drivers/memory/Kconfig
> @@ -173,7 +173,7 @@ config JZ4780_NEMC
>  	  memory devices such as NAND and SRAM.
>  
>  config MTK_SMI
> -	bool "Mediatek SoC Memory Controller driver" if COMPILE_TEST
> +	tristate "Mediatek SoC Memory Controller driver" if COMPILE_TEST
>  	depends on ARCH_MEDIATEK || COMPILE_TEST
>  	help
>  	  This driver is for the Memory Controller module in MediaTek SoCs,
> diff --git a/include/soc/mediatek/smi.h b/include/soc/mediatek/smi.h
> index 5a34b87d89e3..29e2fb8f33d6 100644
> --- a/include/soc/mediatek/smi.h
> +++ b/include/soc/mediatek/smi.h
> @@ -9,7 +9,7 @@
>  #include <linux/bitops.h>
>  #include <linux/device.h>
>  
> -#ifdef CONFIG_MTK_SMI
> +#if IS_ENABLED(CONFIG_MTK_SMI)
