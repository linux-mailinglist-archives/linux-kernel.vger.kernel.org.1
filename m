Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A859C300F0B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 22:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730587AbhAVVip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 16:38:45 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42]:42106 "EHLO
        mail-ej1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbhAVVfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 16:35:12 -0500
Received: by mail-ej1-f42.google.com with SMTP id r12so9670460ejb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jan 2021 13:34:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UUV29RpxjVNGedVCZG35UzFCrYjLETYa/Rl1PkWj6Ks=;
        b=EZPzchUldIstNpzC3QAbbOchihX6D46ip6qRYTkASp2Rwb8tZT6YhRQ9FcG439Hmhf
         bUKzVyAiKFfsqmAZgySN6Z4f8uSDjnVMOCUC7Xk6gnR6zNVT22UMgMrJ7l56vm26lwqc
         9diM+cGKbW4CNKpFfOqG/EoTbFbNElfy1CkZJhmpWydtTdkM3tFSA0kj7p4kyH+uuWKW
         0oJvlYeHkch2e3FeF+4qkg6HkX054VdrqmlcDGk+GQ3Y2C4qtihf/BWHXf97fXnWDjTC
         l6myndN1oxKZ7kP4jLsHUElNXeNi/HPnOVXKOaYKvLzbd2g3bGecLB0G20BZpuT8Y1Zy
         yNhQ==
X-Gm-Message-State: AOAM532Mqsgm5C6ecTNkU+oehd70Fgn+1312N8wfQufcQkeKkaUtka/f
        qyG8BJFi1k5EucKY69YGc7Y=
X-Google-Smtp-Source: ABdhPJxHt80Jvb/lOspEpWGHk4RR9X1vDlMGLNUVWPiSLSr9iaYR9oS1vVzvVNzhfl428fLAzdYDOQ==
X-Received: by 2002:a17:907:932:: with SMTP id au18mr4214890ejc.91.1611351269791;
        Fri, 22 Jan 2021 13:34:29 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id i15sm5321214ejj.28.2021.01.22.13.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 13:34:28 -0800 (PST)
Date:   Fri, 22 Jan 2021 22:34:27 +0100
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
Subject: Re: [PATCH 2/3] memory: mtk-smi: Add module_exit and module_license
Message-ID: <20210122213427.mwjyjn2wsgnko7mk@kozik-lap>
References: <20210121062429.26504-1-yong.wu@mediatek.com>
 <20210121062429.26504-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210121062429.26504-3-yong.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 21, 2021 at 02:24:28PM +0800, Yong Wu wrote:
> The config MTK_SMI always depends on MTK_IOMMU which is built-in
> currently. Thus we don't have module_exit before. This patch adds
> module_exit and module_license. It is a preparing patch for supporting
> MTK_SMI could been built as a module.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/memory/mtk-smi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
> index e2aebd2bfa8e..aa2a25abf04f 100644
> --- a/drivers/memory/mtk-smi.c
> +++ b/drivers/memory/mtk-smi.c
> @@ -597,3 +597,13 @@ static int __init mtk_smi_init(void)
>  	return platform_register_drivers(smidrivers, ARRAY_SIZE(smidrivers));
>  }
>  module_init(mtk_smi_init);
> +
> +static void __exit mtk_smi_exit(void)
> +{
> +	platform_unregister_drivers(smidrivers, ARRAY_SIZE(smidrivers));
> +}
> +module_exit(mtk_smi_exit);
> +
> +MODULE_DESCRIPTION("MediaTek SMI driver");
> +MODULE_ALIAS("platform:MediaTek-SMI");

Drivers do not use capital letters, so I have doubts whether this alias
is correct.

Adding all these should be squashed with changing Kconfig into tristate.
It does not have sense on its own.

Best regards,
Krzysztof
