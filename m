Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA882CAE4E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 22:22:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgLAVV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 16:21:26 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45207 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgLAVV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 16:21:26 -0500
Received: by mail-ed1-f66.google.com with SMTP id r5so2232379eda.12
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 13:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eJ0wb6xnXrJobv0CqBcs/xjzvsOoM4mG3SkfXYuB3W8=;
        b=R9iZV6nyUcl4g411dPXRuw7Cz73uuVU8BeLpNSNBskR234e4IZ9Z4MjxbhdQlJlz3K
         F7pyZiF9FgCXM6IWLzmGaYQNHtvNCX6PFVfqzMl8YwBOC6x9qAi3z0Ey2c6V9r/8nUoa
         L1cRN9hT2I600QyHNnfWLPBPfVPqwvX7wbOMcjQLD9dEk30atVzVs9Fu0EHCI1p87Dbq
         QPUGRMon7aqDDiUdQ677jqChqrU+6byvjJlq4vQYV+OAdgxE4cUe9G6BsKZSqfL+Bitz
         DadBpsmH1ytWVqYua2We9zxuigllmr99en5jYKYR4SgWyxT0PAGQNxEs1qSywdMtNLBY
         NBoQ==
X-Gm-Message-State: AOAM530EueKDwqFRX9/VHC8ZZg0PwEvW014wJUnAGY3rnfI0fCo1GQYt
        d24MBbHP5h7Qxy7YDVsLgC0=
X-Google-Smtp-Source: ABdhPJxzslphSfUsv8Kk92K2o1vbUwxh4il0VxCnEPq9zbo6TLitC7qhTUdgERRFyKENJaqFHstDqQ==
X-Received: by 2002:a50:a6c9:: with SMTP id f9mr5074768edc.158.1606857643806;
        Tue, 01 Dec 2020 13:20:43 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id ot18sm417255ejb.54.2020.12.01.13.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 13:20:42 -0800 (PST)
Date:   Tue, 1 Dec 2020 23:20:41 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>, arm@kernel.org
Subject: Re: [RFC 2/2] MAINTAINERS: add a limited ARM and ARM64 SoC entry
Message-ID: <20201201212041.GB23379@kozik-lap>
References: <20201201211516.24921-1-krzk@kernel.org>
 <20201201211516.24921-2-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201211516.24921-2-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 11:15:16PM +0200, Krzysztof Kozlowski wrote:
> It is expected for ARM and ARM64 SoC related code to go through
> sub-architecture maintainers.  Their addresses were therefore not

I reshaped my message last moment and missed that it does not make
sense anymore... It should be:
"The ARM and ARM64 SoC maintainers addresses were therefore not..."

Best regards,
Krzysztof

> documented to push patch traffic through sub-architecture maintainers.
> 
> However when patches touch generic code, e.g. multi_v7_defconfig, the
> patch might not be picked up by them and instead should go to the SoC
> maintainers - Arnd and Olof.
> 
> Add a minimal maintainer's entry for SoC covering only Makefile, so it
> will not appear on most of submissions (except new devicetree boards).
> It will though serve as a documentation and reference for cases when
> submitter does not know where to send his SoC-related patches.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  MAINTAINERS | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6149066a545e..f302983645bd 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1491,6 +1491,16 @@ F:	Documentation/devicetree/bindings/iommu/arm,smmu*
>  F:	drivers/iommu/arm/
>  F:	drivers/iommu/io-pgtable-arm*
>  
> +ARM AND ARM64 SoC SUB-ARCHITECTURES (COMMON PARTS)
> +M:	Arnd Bergmann <arnd@arndb.de>
> +M:	Olof Johansson <olof@lixom.net>
> +M:	soc@kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Maintained
> +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git
> +F:	arch/arm/boot/dts/Makefile
> +F:	arch/arm64/boot/dts/Makefile
> +
>  ARM SUB-ARCHITECTURES
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>  S:	Maintained
> -- 
> 2.25.1
> 
