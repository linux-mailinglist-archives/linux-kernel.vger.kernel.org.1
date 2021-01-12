Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6F32F3F86
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 01:46:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394815AbhALWu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 17:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbhALWuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:50:23 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DADCDC061786
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:49:42 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id f132so50824oib.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 14:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RhKx420vQ4UbpwX8arpl4l0ukeJ7mPXSin8/0kZSiAA=;
        b=kBC4lM9lVj1WKCiRwj4NuLcKEpR0DbrVl6crzM3KrBkG+hrxO4U92U2UHJnnYHwfJf
         XsSF1B/Ks0BQFPDsMk9Ml+TwcMF0+9hdcHRqVUGqNa4TtWMquYijqD0fbWSSMT/tFGWx
         qaKyQU67w9InBDjUdpZhkFhNYqhW86T3/moZ2tV0BQsIDk9HEw8M5/vFJKaT6ocf4IsA
         DeKyuuZfzDTNwUTDKso0u2NgiPMJBdBbojoIBIL8baz57D6mzHPMx9YCp2b2eL2oBGEw
         Tc/7vepSDlW277wx0vbPF7uNHn/CnIWuMyIjUH/P5i34WgVhJsxGO4LCEb4o+Di7k3UB
         Q/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RhKx420vQ4UbpwX8arpl4l0ukeJ7mPXSin8/0kZSiAA=;
        b=fyGtRQNTjDD54ePG6n79nfI5h1CkRzYHXAR5p3g1tyJAGBRPijA074hHm6KuXVVWpS
         cMG/OqMxYbWUwODuie5jEjhuaGIACvpXqPjQNJO3BE+4qPqfcz/h4/GUoDHqAKiTAnBu
         iPkGFqrlAynQ3dDfxFW233gTlFPRP6zjahRP9m0JxRJEea/To2d0f3TUWxexSuVcDSY2
         KrWcZLdseppzyxpJLmYpsLIFBzyG5Xyrx1URsbjvz1YvxPpFCwK1slXM9bPyt/kv3whH
         4Ve/MwShO1GLE5G/kaB8d/gbrMjXsr59WN4C/8KN9HmLVjb3M22hAicvUUe2aZ9D33mb
         MCeA==
X-Gm-Message-State: AOAM533GOZEY0JwBLafHz4nu+TP3V38maOFRT7EAcFkEvGaMbnnqafYt
        tZPi3EuawtZem1eX9YbN7wDbOQ==
X-Google-Smtp-Source: ABdhPJy7GEaaqKDaeByFMXWUqejs0wCgQPyBMTn9fwT+W/KSsn/WjnVLs51yGEsMgWE/6rJ1r4b/fg==
X-Received: by 2002:a54:4d98:: with SMTP id y24mr880539oix.52.1610491782277;
        Tue, 12 Jan 2021 14:49:42 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id a14sm37602oie.12.2021.01.12.14.49.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 14:49:41 -0800 (PST)
Date:   Tue, 12 Jan 2021 16:49:39 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org,
        rdunlap@infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipa: add config dependency on QCOM_SMEM
Message-ID: <X/4ng/dXcIUB1ZQv@builder.lan>
References: <20210112192134.493-1-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112192134.493-1-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Jan 13:21 CST 2021, Alex Elder wrote:

> The IPA driver depends on some SMEM functionality (qcom_smem_init(),
> qcom_smem_alloc(), and qcom_smem_virt_to_phys()), but this is not
> reflected in the configuration dependencies.  Add a dependency on
> QCOM_SMEM to avoid attempts to build the IPA driver without SMEM.
> This avoids a link error for certain configurations.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Fixes: 38a4066f593c5 ("net: ipa: support COMPILE_TEST")
> Signed-off-by: Alex Elder <elder@linaro.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  drivers/net/ipa/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ipa/Kconfig b/drivers/net/ipa/Kconfig
> index 10a0e041ee775..b68f1289b89ef 100644
> --- a/drivers/net/ipa/Kconfig
> +++ b/drivers/net/ipa/Kconfig
> @@ -1,6 +1,6 @@
>  config QCOM_IPA
>  	tristate "Qualcomm IPA support"
> -	depends on 64BIT && NET
> +	depends on 64BIT && NET && QCOM_SMEM
>  	depends on ARCH_QCOM || COMPILE_TEST
>  	depends on QCOM_RPROC_COMMON || (QCOM_RPROC_COMMON=n && COMPILE_TEST)
>  	select QCOM_MDT_LOADER if ARCH_QCOM
> -- 
> 2.20.1
> 
