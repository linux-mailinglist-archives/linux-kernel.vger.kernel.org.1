Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1664284652
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 08:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgJFGxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 02:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgJFGxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 02:53:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F734C0613A7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 23:53:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l15so1526668wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 23:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=aXzg8jiyuQTiAqmu/XuvmpavXYdKtRsp/UTQZG95Smw=;
        b=pPgf1JCfjmJPkigztvFLycNQEqLNvGaDmU8v4vDNDOiqpolMjDdoAlZCwzZ0TezAem
         96XB+H5QoLZUFzmiGUv4qpJSCrUVIwx+iNfdvku0YZm558HIKBnN2z0gypIu+70WEcRX
         BcflYfuhTXwiHO0G+nq+RVT93rOV3mzT0xnpIdzpCKcb8Y8kw3X59Sxdk+Wfdudc+GEZ
         YmWBUg8YoRgD5S6G+vYhrKqz9mdnoVB83wAnDiavTXcrhpl/10l5y+Y3US13xEc9wTfC
         xLavQGcOM6fAXnKN75j9qi7OpLSrtAkwyIqrmuv9ML+gE9eR9kHn9J++EtZ4LLvuanla
         5UYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=aXzg8jiyuQTiAqmu/XuvmpavXYdKtRsp/UTQZG95Smw=;
        b=q4BxSasmIbf2Mag2DA665XxSmptuP79g6raDs5zG+OgiwFT14XJT8OLC4tCejH+cb6
         xc1JINRDU/LTc9F2pNxT/e54e0mFQcpBcvRN9zb4vXhWA2INKQ9X6ogPviL+mJAVDvQo
         vPxpTWiQVapCk1LYTXTBzjzSYNKftHfnxEEV9wEwqCPLYSvItDccZVIYSstCEI/lrFOU
         nmZ2blFUZH7LPhzaiP8vhxkpg7MTMawaD0QodY/iKOAPE+aJZHsiqZNIcivPi/wjs624
         sc8k+uMfjCgEBEW0nN/aqASi7j6r4OjkRohxNX/Z2NHw8JDecD4cP/V9xH3LOyb2JB0D
         XcgA==
X-Gm-Message-State: AOAM531YrWtBctDLkw52++Ur0cat34xW/824ZsTKABZNdk1XL3CcnhgW
        CFL9pwmHU191ZeBDe9paeCjusw==
X-Google-Smtp-Source: ABdhPJy0df4K8D/KdPGMoFwrdfIEx8/yLi+cOlJ/BcG32LpXoy0TYcL6DFd8rywPZp9IvWXyo8eamg==
X-Received: by 2002:a05:600c:216:: with SMTP id 22mr2954681wmi.149.1601967195504;
        Mon, 05 Oct 2020 23:53:15 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id l11sm1893529wrt.54.2020.10.05.23.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 23:53:14 -0700 (PDT)
Date:   Tue, 6 Oct 2020 07:53:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Michael Brunner <Michael.Brunner@kontron.com>
Cc:     "mibru@gmx.de" <mibru@gmx.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: kempld-core: Mark kempld-acpi_table as
 __maybe_unused
Message-ID: <20201006065313.GW6148@dell>
References: <37c55c13f9042dde06fd67c829b06765286d0580.camel@kontron.com>
 <20201002070134.GR6148@dell>
 <b7fb20174aa7fd8a15132b6de679498fe0b18fd1.camel@kontron.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b7fb20174aa7fd8a15132b6de679498fe0b18fd1.camel@kontron.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Oct 2020, Michael Brunner wrote:

> On Fri, 2020-10-02 at 08:01 +0100, Lee Jones wrote:
> > On Thu, 01 Oct 2020, Michael Brunner wrote:
> > 
> > > The Intel 0-DAY CI Kernel Test Service reports an unused variable
> > > warning when compiling with clang for PowerPC:
> > > 
> > > > > drivers/mfd/kempld-core.c:556:36: warning: unused variable
> > > > > 'kempld_acpi_table' [-Wunused-const-variable]
> > >    static const struct acpi_device_id kempld_acpi_table[] = {
> > > 
> > > The issue can be fixed by marking kempld_acpi_table as
> > > __maybe_unused.
> > > 
> > > Fixes: e8299c7313af ("[PATCH] mfd: Add ACPI support to Kontron PLD
> > > driver")
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
> > > ---
> > >  drivers/mfd/kempld-core.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
> > > index 1dfe556df038..273481dfaad4 100644
> > > --- a/drivers/mfd/kempld-core.c
> > > +++ b/drivers/mfd/kempld-core.c
> > > @@ -553,7 +553,7 @@ static int kempld_remove(struct platform_device
> > > *pdev)
> > >  	return 0;
> > >  }
> > >  
> > > -static const struct acpi_device_id kempld_acpi_table[] = {
> > > +static const struct acpi_device_id __maybe_unused
> > > kempld_acpi_table[] = {
> > >  	{ "KEM0001", (kernel_ulong_t)&kempld_platform_data_generic },
> > >  	{}
> > >  };
> > 
> > This is not the right fix.  Better just to compile it out completely
> > in these circumstances.  I already have a fix for this in soak.
> 
> Ok - thank you for the other fix you submitted!
> 
> But just out of curiosity - in process/coding-style.rst is written that
> __maybe_unused should be preferred over wrapping in preprocessor
> conditionals, if a function or variable may potentially go unused in a
> particular configuration. So why is my patch not the right one here? At
> least in my tests it seemed to solve the issue.

It's a bone of contention for sure.  In these kinds of scenarios
(i.e. ACPI and OF tables) it is way more common to wrap them:

$ git grep -B3 'acpi_device_id\|of_device_id' | grep 'CONFIG_ACPI\|CONFIG_OF' | wc -l
596
$ git grep -B3 'acpi_device_id\|of_device_id' | grep __maybe_unused | wc -l
63

Parsing them out completely, also has the benefit of saving space,
reducing the size of the finalised binary.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
