Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE54E260D07
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 10:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgIHIFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 04:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729940AbgIHIFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:05:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864C5C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 01:05:31 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so18106367wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9xS1qxTrk5w2leSEAb55AaGpZPSKhkXCh3kYqDPUYtY=;
        b=h/h4OwcLP26KVA/9s8DbQLUkvMl4Nru0AIGX2uQjdP9XlF6hFhcYVwbCW4MnKyISRG
         lMFa6h5GEcyeCgUlgLZq2R89hjknmHA5V1jRy9ZcRCwgZyV/XcXyvodv7+luZlrMd/9Y
         Jw3RYtP8l+MAH6l3Pr5qZ1aQYH8TPvxcsoCfw8PMY47XmBCPWOL31DTcEyfW1rSmyUPK
         00rIwqQsNzuGuxyHUGm8KsABKzetoxUaUMCkAsIBqIASpSjn4lO9USQOM1EAfH99E4n4
         6f2Cl1gmBS/XpzD+wSXEBcjbgQj86rJ1CBydBP3UqfazBWm1Veayp/VdMVgViiqWAXRi
         gJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9xS1qxTrk5w2leSEAb55AaGpZPSKhkXCh3kYqDPUYtY=;
        b=rZIbbtx9/bBfI2D5W1BKE5BHmgoFgJWrVY6bOrg9RVjIZ4yRcwZsl+lgAGxKIEBiIG
         gSqqwgVQzl1Mwh/S3GuQdGNjYrM0uta+z0LamjRvffHZwBYkOYI/hyJt8wlbonV8AzQ3
         McvOSyh8mQQBI6HR8ZByrYQJMWVIesZOuNdKMYOKiFF75C20h7cJGOvqM2H28f9dQ+Mw
         ywLxo//bI0AycuAxOt0TBPsdDFGQcZAEKeCzdG3x6ARsLuem3P2IKjYphmNzkn1lM0GS
         k6lVKngjmAAZ8GGCzI4nW09mRnWT1taz5WfKuTbQ5HNqRTp8Y1dSOr0kYpIz0xw+b/+F
         Ii5w==
X-Gm-Message-State: AOAM5324JIgodmIZZzQcpWfIgb0Obbz6qe0qP7L3JJpqwgwhbRsx8J6U
        xGPAfydrVcZaCZ4nZGoRFbSoEQ==
X-Google-Smtp-Source: ABdhPJy7iT+aXYQS5Qv/0d1oAB6vhdudjmRSMbjy/usOabwtMe6jTUIQB1OeUGYM3RMIMaRTqbhzlA==
X-Received: by 2002:a5d:6946:: with SMTP id r6mr26188827wrw.308.1599552329975;
        Tue, 08 Sep 2020 01:05:29 -0700 (PDT)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id s11sm33312005wrt.43.2020.09.08.01.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:05:29 -0700 (PDT)
Date:   Tue, 8 Sep 2020 09:05:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Russ Weight <russell.h.weight@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com, matthew.gerlach@intel.com
Subject: Re: [PATCH v1 06/12] fpga: add max10 secure update functions
Message-ID: <20200908080527.GB4400@dell>
References: <20200904235305.6254-1-russell.h.weight@intel.com>
 <20200904235305.6254-7-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200904235305.6254-7-russell.h.weight@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 Sep 2020, Russ Weight wrote:

> Extend the MAX10 BMC Security Engine driver to include
> the functions that enable secure updates of BMC images,
> FPGA images, etc.
> 
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Wu Hao <hao.wu@intel.com>
> ---
>  drivers/fpga/intel-m10-bmc-secure.c | 272 +++++++++++++++++++++++++++-
>  include/linux/mfd/intel-m10-bmc.h   | 101 +++++++++++
>  2 files changed, 372 insertions(+), 1 deletion(-)

>  /**
>   * struct intel_m10bmc_retimer_pdata - subdev retimer platform data
>   *
> @@ -64,7 +131,10 @@ struct intel_m10bmc {
>   *
>   * m10bmc_raw_read - read m10bmc register per addr
>   * m10bmc_raw_bulk_read - bulk_read max10 registers per addr
> + * m10bmc_raw_bulk_write - bulk_write max10 registers per addr
> + * m10bmc_raw_update_bits - update max10 register per addr
>   * m10bmc_sys_read - read m10bmc system register per offset
> + * m10bmc_sys_update_bits - update max10 system register per offset
>   */
>  static inline int
>  m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> @@ -94,7 +164,38 @@ m10bmc_raw_bulk_read(struct intel_m10bmc *m10bmc, unsigned int addr,
>  	return ret;
>  }
>  
> +static inline int
> +m10bmc_raw_bulk_write(struct intel_m10bmc *m10bmc, unsigned int addr,
> +		      void *val, size_t cnt)
> +{
> +	int ret;
> +
> +	ret = regmap_bulk_write(m10bmc->regmap, addr, val, cnt);
> +	if (ret)
> +		dev_err(m10bmc->dev, "fail to write raw reg %x cnt %zx: %d\n",
> +			addr, cnt, ret);
> +
> +	return ret;
> +}
> +
> +static inline int
> +m10bmc_raw_update_bits(struct intel_m10bmc *m10bmc, unsigned int addr,
> +		       unsigned int msk, unsigned int val)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(m10bmc->regmap, addr, msk, val);
> +	if (ret)
> +		dev_err(m10bmc->dev, "fail to update raw reg %x: %d\n",
> +			addr, ret);
> +
> +	return ret;
> +}
> +

I really do dislike abstraction for abstraction's sake.

What's stopping you from just using the Regmap API in-place?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
