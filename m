Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3587E280DC1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 09:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgJBHBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 03:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgJBHBj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 03:01:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE83EC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 00:01:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k18so520020wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aIY+IDzICGVgAmDulZ9BdwLCyG0fzaPB1TGzf7MSUwE=;
        b=X1f5XE7ut411XXg2WdP6zDISf6h0Utz7a/CKTBREV3CDjcoLDru4bGrQ/QHXOlS9k7
         Cn0C8KgdtZiYvUrvMUwgbp+SVkz0RG5wBydPClQl2nQBNmIXZexyhIqaiWm8mDWmUAte
         3/SITEFFGcHiPVrgFxIKkvVSZwH8lhYmRlEgmhQrPlaAoriOC+YqzFlXKuwXhAgf7ahc
         Os/oPgO5g/JzEYhpCiFjNCbqQ7BGUcUvcLvVoTJg3x/OxmH7YRM7QthCqnzH+M7G+GhC
         iB7YpknoyIh5cEkY9OptbBVBI7RQUgER9oFbLhpJmTkfTbiIOMnDT9XruNP80T0TVx2P
         is9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aIY+IDzICGVgAmDulZ9BdwLCyG0fzaPB1TGzf7MSUwE=;
        b=BYehYeFAShnTsJ6k3kge9v1Jl5dZ2rPncEBEmgCEl8bIP9sIPbGiDj/2j6fr3Wvd76
         6EXFHjwFxpGpV/Y95WhazoTP0MTwvCWM3cViEmAP9raBXSRkId0szDtD+4GeZI4QvAjs
         KjhT5nNtkaH4K8HYCB3w9YLlbdBZKiLgmCXXhAPnAowUyxQHNDHunUXGT2w0a6XSFYil
         nhR0WYGNe14K3FpHRHnncVZzQRrf/QJ2GE0U0H+Y5cucamV6zWlYKYmIlWTRdtR9mTtg
         CUlB4s6bHoUg1DrJBMlCCNJN3sP676Mbborpi+5cK63A/9p23ICu5eVt3XrIjUgd8SKg
         0NQw==
X-Gm-Message-State: AOAM532jfy/CIsbI30RhYNe/YxDk1mnlinHBvPt1H7QqdPUNckVUIYAh
        kFRpjVaRSUpqRxK/5olKQ0x+J1dNOzrXeg==
X-Google-Smtp-Source: ABdhPJzhM/FUD/Nr6ynJ3U6oOeCOR6mw+KpVdIuGPROgWNHWPaBV8jILF9yIsNl/d0uB7UjjSFaHTQ==
X-Received: by 2002:a05:600c:22c5:: with SMTP id 5mr1159532wmg.34.1601622097238;
        Fri, 02 Oct 2020 00:01:37 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id v4sm661245wmg.35.2020.10.02.00.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 00:01:36 -0700 (PDT)
Date:   Fri, 2 Oct 2020 08:01:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: kempld-core: Mark kempld-acpi_table as
 __maybe_unused
Message-ID: <20201002070134.GR6148@dell>
References: <37c55c13f9042dde06fd67c829b06765286d0580.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37c55c13f9042dde06fd67c829b06765286d0580.camel@kontron.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Oct 2020, Michael Brunner wrote:

> The Intel 0-DAY CI Kernel Test Service reports an unused variable
> warning when compiling with clang for PowerPC:
> 
> >> drivers/mfd/kempld-core.c:556:36: warning: unused variable 'kempld_acpi_table' [-Wunused-const-variable]
>    static const struct acpi_device_id kempld_acpi_table[] = {
> 
> The issue can be fixed by marking kempld_acpi_table as __maybe_unused.
> 
> Fixes: e8299c7313af ("[PATCH] mfd: Add ACPI support to Kontron PLD driver")
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> ---
>  drivers/mfd/kempld-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> index 1dfe556df038..273481dfaad4 100644
> --- a/drivers/mfd/kempld-core.c
> +++ b/drivers/mfd/kempld-core.c
> @@ -553,7 +553,7 @@ static int kempld_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static const struct acpi_device_id kempld_acpi_table[] = {
> +static const struct acpi_device_id __maybe_unused kempld_acpi_table[] = {
>  	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
>  	{}
>  };

This is not the right fix.  Better just to compile it out completely
in these circumstances.  I already have a fix for this in soak.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
