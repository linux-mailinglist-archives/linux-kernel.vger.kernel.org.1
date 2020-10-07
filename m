Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9D722858F0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 09:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgJGHBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 03:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJGHBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 03:01:05 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489ADC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 00:01:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e2so1131191wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 00:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2qXBCI2e+b/giZ/fbDsezNblcifBg39XCg3D+hIB9y0=;
        b=yJ1SgiDXaACkYrASBm0+vEF1uFvnw6hj6TdL6wlMfBGxGK60lHWWm2GFVp2ZSKM+SC
         0yNcyz0h0ECRYABG6jT94YTtynx1mx4ePIJdBfjKmq/Uv6Dwf2AERofPueNtJ2qibzO1
         lp2Pg30DAh8epIf3Ob+pwGf2IYlEtMsk+COatDSexN2pzhTjGFRnGAe3uXhoAZP34d6h
         +InIgFRTim4X4TDiOgG/sKxPwghx+n4vKnB4AK2yxmJV5R08MMp3SfWpjFADk5jsn9QF
         qUlyfFdCZGHtQu9pg1rmJziDM5j3Jo2Wua52ihqcApHMlpIkGNPSKD72dw3X4J6ehCYZ
         h2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2qXBCI2e+b/giZ/fbDsezNblcifBg39XCg3D+hIB9y0=;
        b=rB49q8skmOjEi3AytWoBxOhHoPPgH0ZSfunqmO2sJ5+RsoSIFfrvDHkPL4kuAFNSMK
         8lVxmmQiYhvsMpemeNgTBaDepv0nzhlc8Cbz3bJ6i0ghhl/d4KLEgaiXTHT8nbv529cb
         WCR+C7WQDdbYt7nvKNDAOtFxrAFrYYqBW28RLG9T61M8adfScUaT7J3iWOS0ONW0EJlh
         tkQ8X8Ygzl5c/arxJfvm8EEZZ+NUl45cBceMFY3NFB7Y8g7V7kwfsgXLRlQmO5c4yAdZ
         VukbTJx4kp5EWSFbOUWr8tjbecozsXtJ4hN58UEKz3mAOE3C3oLTYF013JE5SqdOz+3R
         OQng==
X-Gm-Message-State: AOAM532WyL6FW6SVbYr9kXMWRvP6Xn8K7WfSjqmeEd0NkINn2CfqzRvY
        HBarghgt3DS9myk/gcrAExB4Bg==
X-Google-Smtp-Source: ABdhPJwWBhy5OqM2JNVdxgjil0NRMXCJsX1dxkkKsUQr/S/ldM3Pg/UfsBvVOzS24rCrOZU8AZrhZQ==
X-Received: by 2002:a1c:3bd4:: with SMTP id i203mr1016900wma.28.1602054061897;
        Wed, 07 Oct 2020 00:01:01 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id y23sm1524512wra.55.2020.10.07.00.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 00:01:01 -0700 (PDT)
Date:   Wed, 7 Oct 2020 08:00:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v2 1/6] mfd: intel-m10-bmc: support for MAX10 BMC
 Security Engine
Message-ID: <20201007070059.GB1763265@dell>
References: <20201003012412.16831-1-russell.h.weight@intel.com>
 <20201003012412.16831-2-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201003012412.16831-2-russell.h.weight@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Oct 2020, Russ Weight wrote:

> Add macros and definitions required by the MAX10 BMC
> Security Engine driver.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> ---
> v2:
>   - These functions and macros were previously distributed among
>     the patches that needed them. They are now grouped together
>     in a single patch containing changes to the Intel MAX10 BMC
>     driver.
>   - Added DRBL_ prefix to some definitions
>   - Some address definitions were moved here from the .c files that
>     use them.
> ---
>  include/linux/mfd/intel-m10-bmc.h | 134 ++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)
> 
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> index c8ef2f1654a4..880f907302eb 100644
> --- a/include/linux/mfd/intel-m10-bmc.h
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -13,6 +13,9 @@

>   * m10bmc_raw_read - read m10bmc register per addr
> + * m10bmc_raw_bulk_read - bulk read max10 registers per addr
> + * m10bmc_raw_bulk_write - bulk write max10 registers per addr
> + * m10bmc_raw_update_bits - update max10 register per addr
>   * m10bmc_sys_read - read m10bmc system register per offset
> + * m10bmc_sys_update_bits - update max10 system register per offset
>   */

FWIW, I *hate* abstraction for the sake of abstraction.

Please just use the Regmap API in-place instead.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
