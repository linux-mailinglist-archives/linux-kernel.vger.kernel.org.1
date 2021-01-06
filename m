Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9984D2EC376
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 19:50:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbhAFSs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 13:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbhAFSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 13:48:27 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53F0C06135B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 10:47:46 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id x13so3899380oto.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 10:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J0CKR6Kvio5VLoFKyFYozSwJdmAW6MNkG97LTeNyQO4=;
        b=x6ZtD3djxA3EXsoZpK5TZ+kc00ltci4hhEOW+Qm8RiGoDpGdXgYKaBiGQf0bqdlpbK
         /Gim9u2G9fgMa1d7p2dh4I/c6WYS/CdSXiiuLCxIiFop2eCT68Kis+3bmRsr38KmgBX9
         gyT5vKfZa+OTfdP/DsMFUgcJb9YELqdc6vppwxfubmcG4TbOs/uBZthCBeXtJgnrDAbG
         /dTym/N7szfEWbh+khzEFJmXYFoO/D+81+77Utbl+6E7Dw0HY1zirbP9gLf/V8aZ0BI+
         PwDx2P1i+KBzjByczxnU9pdpbKbA6zCFZv+5tgNFDrdbtrw5Khp28Xg1WWL1qDAzm5v/
         dHeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J0CKR6Kvio5VLoFKyFYozSwJdmAW6MNkG97LTeNyQO4=;
        b=DJrOMZflsT5bNQUbibZHnE80e0L4NaH7LGACrqgwczUtQVpZEHPOzggBlxir9Q/5su
         iWDEVPlJOm+OQJ8ujN44kMaxDc8VV3xGkp/j4jKkz2u+zjA9VQ47rYIX4IS7XdHF4uj8
         LCWbGx+HVFBNYzYhzSdscmTEhS7df4DeNbJ33jD3I9GEWAg/sS7s55JzWBeTTXqmj/xY
         yxz/Kt79GkC3RzYpD7nT5Vw3TIgFHDeY3qTz2WKiNFnGEsGaHPJ30NOd0PDN6uig6wLq
         lTs2w0YIIIsEku6W7QF0togL7GCp74ISb7KIX2GvgVBq86eF5guU/lb5BU1f+u5xmX6E
         Hi7A==
X-Gm-Message-State: AOAM533i88lkaeawD2iazO9T2Ni3v7h2rpF28Jro3uS/9In1MZHcSLna
        BR1ypUcxfqWwxJPVivaEzLNttw==
X-Google-Smtp-Source: ABdhPJx1RKYVVyX0rPMoRSLuDstfkFwfSI1CmVBfV/H5xwF4Pl9d36cFHlDBFyLG7qY8igqtQCicOw==
X-Received: by 2002:a05:6830:19da:: with SMTP id p26mr4102160otp.80.1609958866345;
        Wed, 06 Jan 2021 10:47:46 -0800 (PST)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id r13sm662109oti.49.2021.01.06.10.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 10:47:45 -0800 (PST)
Date:   Wed, 6 Jan 2021 12:47:43 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Alex Elder <elder@linaro.org>
Cc:     agross@kernel.org, davem@davemloft.net, kuba@kernel.org,
        ohad@wizery.com, evgreen@chromium.org, cpratapa@codeaurora.org,
        subashab@codeaurora.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] soc: qcom: mdt_loader: define stubs for
 COMPILE_TEST
Message-ID: <X/YFzz1FCWUJn8lN@builder.lan>
References: <20210106023812.2542-1-elder@linaro.org>
 <20210106023812.2542-3-elder@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106023812.2542-3-elder@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 05 Jan 20:38 CST 2021, Alex Elder wrote:

> Define stub functions for the exposed MDT functions in case
> QCOM_MDT_LOADER is not configured.  This allows users of these
> functions to link correctly for COMPILE_TEST builds without
> QCOM_SCM enabled.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

@Jakub, @Dave, as with patch 1, please take this through your tree as
well.

Regards,
Bjorn

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>  include/linux/soc/qcom/mdt_loader.h | 35 +++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/include/linux/soc/qcom/mdt_loader.h b/include/linux/soc/qcom/mdt_loader.h
> index e600baec68253..afd47217996b0 100644
> --- a/include/linux/soc/qcom/mdt_loader.h
> +++ b/include/linux/soc/qcom/mdt_loader.h
> @@ -11,6 +11,8 @@
>  struct device;
>  struct firmware;
>  
> +#if IS_ENABLED(CONFIG_QCOM_MDT_LOADER)
> +
>  ssize_t qcom_mdt_get_size(const struct firmware *fw);
>  int qcom_mdt_load(struct device *dev, const struct firmware *fw,
>  		  const char *fw_name, int pas_id, void *mem_region,
> @@ -23,4 +25,37 @@ int qcom_mdt_load_no_init(struct device *dev, const struct firmware *fw,
>  			  phys_addr_t *reloc_base);
>  void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len);
>  
> +#else /* !IS_ENABLED(CONFIG_QCOM_MDT_LOADER) */
> +
> +static inline ssize_t qcom_mdt_get_size(const struct firmware *fw)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int qcom_mdt_load(struct device *dev, const struct firmware *fw,
> +				const char *fw_name, int pas_id,
> +				void *mem_region, phys_addr_t mem_phys,
> +				size_t mem_size, phys_addr_t *reloc_base)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int qcom_mdt_load_no_init(struct device *dev,
> +					const struct firmware *fw,
> +					const char *fw_name, int pas_id,
> +					void *mem_region, phys_addr_t mem_phys,
> +					size_t mem_size,
> +					phys_addr_t *reloc_base)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline void *qcom_mdt_read_metadata(const struct firmware *fw,
> +					   size_t *data_len)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
> +#endif /* !IS_ENABLED(CONFIG_QCOM_MDT_LOADER) */
> +
>  #endif
> -- 
> 2.20.1
> 
