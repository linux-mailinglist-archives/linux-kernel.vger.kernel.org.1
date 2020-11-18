Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFD62B7ABD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 10:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgKRJx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 04:53:28 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36199 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbgKRJx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 04:53:27 -0500
Received: by mail-ed1-f68.google.com with SMTP id m16so1326344edr.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 01:53:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4VZV4JODEANV43Do31vFuPevs/t9w5drfDVPU3kOfDk=;
        b=SEr9x3gGp9oxQXZ5uF1x5MNOQyVscv0OYJM6OIODSvKFPDM45nqGr3U3F4oUtzZ0VG
         5qOKcdAeejc94hOF80q/SVKmCJuOGI9ESYY10xXyizd1UAyDnIogmdMfjlQ1fVNwCUF/
         vtDjCKM/4wrmY/uM+YzrinbWaBiVTsFNC1TdheF9gYQaTxj8Tn5+LwOv7bfua6fn/XAf
         dvMOkrTtfCUYy7+As0QoTv3IeRR4QUPBfVpsEO5mSh4Axb2vm/jkYe5JM0oxG92ocVet
         knT/mSnnJaN24Unu05OkR0LU1SxeeE2db2jI/xucWQZiwvZLF0Grhl344tofULyuVYKU
         7RQQ==
X-Gm-Message-State: AOAM530L8+1p89vT6crXVkNpMIM5puGhgegmRq5tVdIvn9JExK36JWql
        f5XkMYgds1ErR0WH02IS/cI=
X-Google-Smtp-Source: ABdhPJzZN+jj9QnXp4Kegr2WMONRC2atTpBVRxWKfqSGhIg2aRqhDJi8n3Rxr+I9G/yhqUl0Uk4zGA==
X-Received: by 2002:a50:9fc5:: with SMTP id c63mr4650558edf.224.1605693205466;
        Wed, 18 Nov 2020 01:53:25 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id u2sm716842edo.65.2020.11.18.01.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 01:53:24 -0800 (PST)
Date:   Wed, 18 Nov 2020 10:53:22 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Olivier Moysan <olivier.moysan@st.com>
Cc:     linux@armlinux.org.uk, shawnguo@kernel.org, olof@lixom.net,
        alexandre.torgue@st.com, geert+renesas@glider.be,
        amelie.delaunay@st.com, aisheng.dong@nxp.com,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        christian.gmeiner@gmail.com, enric.balletbo@collabora.com,
        lionel.debieve@st.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: enable spdifrx support
Message-ID: <20201118095322.GA17075@kozik-lap>
References: <20201118095013.16094-1-olivier.moysan@st.com>
 <20201118095013.16094-2-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201118095013.16094-2-olivier.moysan@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:50:12AM +0100, Olivier Moysan wrote:
> Add STM32 SPDIFRX support by enabling CONFIG_SND_SOC_STM32_SPDIFRX
> as module.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  arch/arm/configs/multi_v7_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
