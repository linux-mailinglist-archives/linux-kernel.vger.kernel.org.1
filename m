Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42024303831
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 09:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbhAZIkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 03:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbhAYSnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:43:50 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03398C06178B
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:42:53 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id c132so9533482pga.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 10:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6+a5l+MHwQBa21XqyxCXJOWx8+uque/2sWIhUuEvdHM=;
        b=Uv+wHPW7kVoaHkazL1hk85E8YoDvld15GB0FzibaO90qRHEWAX1tWppViF/qg7fmbC
         bX2AdICESTgm+vJIIL1h1k+CEOtpMqS+BUjglvWzlhA2y309VcsBnM7e6CMqXZoMsWfY
         +BGIjF8Y9bYcosl+lPaH/1+3EDfv4lWZ4Pv4cWxC2lRqhLWx2q8K/oH9ejldcQaRdN43
         Yue0PDP0ojXUZSVYh167hMUAvUC0p3BdjAavpqgilKhHjO5Pt0liNsEI1Jffc5Vkw8lz
         kH3UcOe2fIK2cpNaKAafWSeOEb2fQGMSB199i9VFjaPyDbz7u7dzj4A//mdXrvVY3kik
         NkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6+a5l+MHwQBa21XqyxCXJOWx8+uque/2sWIhUuEvdHM=;
        b=igHJEJ7ovkHrXIdUrYIgy9Xk6SJodNzZI2TdePJH3ZKTmCS1HD872nTKe7nnlSxGsZ
         FfzeDRxfZ2o1TMeR7pJdACfEfhFPyXOARZF2otWMQSM4visExO9zhupUul0bf5P8utt3
         LMgi2R8Ou+HO3hRPHtMP82D/GDBEx3Zx7Jgv3OEGesOC6hh98dExs+ZyCyIG485JvvM+
         vNbbidLkHYYVsSrTBdeF5QlW6X07l+ch+L3tOQU+6acM81ZM/XzvdgNmtSjRJ2SzC312
         k+BQKQ+wqyDg1R4rWDvpzLGV2+PnXyfw0NJ6dK7ptC7BViKgqxC0aN4KZCOx/e48rKd9
         7kug==
X-Gm-Message-State: AOAM531kjMJbMZtgZQ5K+9z5lCdagFyJryWPdoUYCDQam288k/2Scuw9
        TkNuyuS9DLcY3j+nRVNkSXKnlg==
X-Google-Smtp-Source: ABdhPJzf3X+ZF6e5T6iDOQmfoV7UwzlEJ43QgI3ZTGCEZZT+T6VTx7i8WsMJpjCqqRl+43vpYIF+qA==
X-Received: by 2002:a63:d42:: with SMTP id 2mr1957133pgn.236.1611600172532;
        Mon, 25 Jan 2021 10:42:52 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id np7sm96686pjb.10.2021.01.25.10.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 10:42:51 -0800 (PST)
Date:   Mon, 25 Jan 2021 11:42:49 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        anshuman.khandual@arm.com, mike.leach@linaro.org,
        leo.yan@linaro.org, linux-kernel@vger.kernel.org,
        jonathan.zhouwen@huawei.com, catalin.marinas@arm.com
Subject: Re: [PATCH v7 03/28] coresight: Introduce device access abstraction
Message-ID: <20210125184249.GB894394@xps15>
References: <20210110224850.1880240-1-suzuki.poulose@arm.com>
 <20210110224850.1880240-4-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210110224850.1880240-4-suzuki.poulose@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 10:48:25PM +0000, Suzuki K Poulose wrote:
> We are about to introduce support for sysreg access to ETMv4.4+
> component. Since there are generic routines that access the
> registers (e.g, CS_LOCK/UNLOCK , claim/disclaim operations, timeout)
> and in order to preserve the logic of these operations at a
> single place we introduce an abstraction layer for the accesses
> to a given device.
> 
> Cc: Mike Leach <mike.leach@linaro.org>
> Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
> Change since v6:
>  - Fix code indentation in coresight.h (Mathieu Poirier)
> Change since v3
>  - Dropped csa argument to read()/write().
>  - Addressed comments on spacing and adding labels for the #if #else #endifs.
>    (Mathieu)
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  |   1 +
>  drivers/hwtracing/coresight/coresight-core.c  |  43 ++++
>  .../hwtracing/coresight/coresight-cti-core.c  |   1 +
>  drivers/hwtracing/coresight/coresight-etb10.c |   1 +
>  .../coresight/coresight-etm3x-core.c          |   1 +
>  .../coresight/coresight-etm4x-core.c          |   1 +
>  .../hwtracing/coresight/coresight-funnel.c    |   1 +
>  .../coresight/coresight-replicator.c          |   1 +
>  drivers/hwtracing/coresight/coresight-stm.c   |   1 +
>  .../hwtracing/coresight/coresight-tmc-core.c  |   1 +
>  drivers/hwtracing/coresight/coresight-tpiu.c  |   1 +
>  include/linux/coresight.h                     | 193 +++++++++++++++++-
>  12 files changed, 243 insertions(+), 3 deletions(-)

[...]

> +u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset);
> +u32 coresight_read32(struct coresight_device *csdev, u32 offset);
> +void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset);
> +void coresight_relaxed_write32(struct coresight_device *csdev,
> +			       u32 val,
> +			       u32 offset);

More stacking - I fixed it.

> +u64 coresight_relaxed_read64(struct coresight_device *csdev, u32 offset);
> +u64 coresight_read64(struct coresight_device *csdev, u32 offset);
> +void coresight_relaxed_write64(struct coresight_device *csdev,
> +			       u64 val, u32 offset);
> +void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
> +
> +
>  #else
>  static inline struct coresight_device *
>  coresight_register(struct coresight_desc *desc) { return NULL; }
> @@ -369,10 +512,54 @@ static inline bool coresight_loses_context_with_cpu(struct device *dev)
>  {
>  	return false;
>  }
> -#endif
> +
> +static inline u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline u32 coresight_read32(struct coresight_device *csdev, u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
> +{
> +}
> +
> +static inline void coresight_relaxed_write32(struct coresight_device *csdev,
> +					     u32 val, u32 offset)
> +{
> +}
> +
> +static inline u64 coresight_relaxed_read64(struct coresight_device *csdev,
> +					   u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline u64 coresight_read64(struct coresight_device *csdev, u32 offset)
> +{
> +	WARN_ON_ONCE(1);
> +	return 0;
> +}
> +
> +static inline void coresight_relaxed_write64(struct coresight_device *csdev,
> +					     u64 val, u32 offset)
> +{
> +}
> +
> +static inline void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
> +{
> +}
> +
> +#endif		/* IS_ENABLED(CONFIG_CORESIGHT) */
>  
>  extern int coresight_get_cpu(struct device *dev);
>  
>  struct coresight_platform_data *coresight_get_platform_data(struct device *dev);
>  
> -#endif
> +#endif		/* _LINUX_COREISGHT_H */
> -- 
> 2.24.1
> 
