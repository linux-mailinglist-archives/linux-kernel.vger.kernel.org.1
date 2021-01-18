Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767912F9DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390140AbhARLTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:19:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388850AbhARKq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:46:28 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C879C061757
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:45:47 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c5so15955345wrp.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ow55d6LzwMEPUhR78ZuflOoHyEx/z5dU6rwj1FAIirg=;
        b=oBJjhldxvXE2c3C5Ry7neQRcHv3QjMVVyKItrfK+q8fWbdiTV7OLbjjYY+a7feVqDU
         3fdUa1x1lmgeRbh/wjCIoUx5w99rpsTldLZADSHMt8XfhZMDXze6OW/cJWisAzuK2TJq
         NkNCzGXoy8f+H7yQQPotYTvgYaW00L645Ux5yzmQk002QzL2+qjrAWNaDxk1C0oFvPKI
         7KdO84vTVbvLxKkr5XcKJT96svxP41VKOGtuwOqvdIMJPLavwqquFRbQ4minhjO2Kgex
         3Cxj8Ky2BEtOJB+NQQflfeuLGe6VpROYg307dFPXyyTldZK6+wWAbTFT1Quz66JMuabB
         692A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ow55d6LzwMEPUhR78ZuflOoHyEx/z5dU6rwj1FAIirg=;
        b=EX0TNwPadolK7wHJLtyMHGbXCHkoFWcH6cruOSbpmAX+5baO1egbfFeKORzJTeMaVa
         v7BFwpyi4MQLSSxj7A4EKmm+108ZiQ5BVZL4K6qiZ5fGavAgnZGuwswzkqcoOgOvO0YQ
         SrRdWhAYN/OLLbgrycSBprOtGqT643AXfCpoS4UHhlPqkymdLgWOtc5cR4q/yIgbnEpc
         UtxDjvbucdNKXZqV5ekJ5ZQ+Id+9x0Er3shSNuvNKOvAZvkZWNw+q3Ek5eWbG5FrU52k
         Yzjj08Yo6qU0lJ9EwO/CVtNzz7ggdctsjtBo77VdTubCoCJHIwHd8NtMu014gnwH6yRD
         FWGQ==
X-Gm-Message-State: AOAM5325jvgtf15TmoKD+KLehkxulOSKoNhLbyCACWLFxKEWFQ3jcLN8
        4s6Uar3Q0lqXZkfZUO0p3/9jvn7kdeC6fVct
X-Google-Smtp-Source: ABdhPJz6Grq3IHYdvqQqi/eLGWR3eV5bCC2m+LCOOGh1wMuU6fgaYiih3fyla63iuwJxCNTHLcwuZg==
X-Received: by 2002:a5d:5005:: with SMTP id e5mr24622445wrt.279.1610966746374;
        Mon, 18 Jan 2021 02:45:46 -0800 (PST)
Received: from dell ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id v65sm26599261wme.23.2021.01.18.02.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 02:45:45 -0800 (PST)
Date:   Mon, 18 Jan 2021 10:45:44 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1] mfd: intel-lpss: Add Intel Alder Lake PCH-S PCI IDs
Message-ID: <20210118104543.GB4903@dell>
References: <20201027104616.49098-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201027104616.49098-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Oct 2020, Andy Shevchenko wrote:

> From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> 
> Add Intel Alder Lake LPSS PCI IDs.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel-lpss-pci.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
