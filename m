Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A80392E1E53
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbgLWPjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:39:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728043AbgLWPjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:39:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C453AC061794
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:38:22 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id g185so6501260wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 07:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=FLK03MoPTeVjiiFwNtS1OJi+2ld8fgev60+sqAPXpLo=;
        b=aC3XOqzY6SoQTeia6KLuOxot8sYnDpr+WcX5Gf8TnqSRzAGywSgSslZ3koDvjM6ib3
         Pdi8mTDstbmvSu74oQEOtEGOcaGapMdnt2guYjiyiuNyI9a0TublPIgvHTytVaRBjlZT
         P6j/dMWOfY+mTZFcmLTsQreejEnkaqN7T3glvlvOKrKRJBytjK48P5nyy1ekeQIxEJAB
         gda50nuPKtQTzYWtUjJf88582ql+s/mzHL29B5zze3o1y6CijcBcwgJuKKQ8+HjIiYYF
         PGpvC72eJLuyXVCZV+q1RrmtxpKoco3/pXOVOVNIk2k/ntzBIAeEEqbwtGUoGa90XnNF
         ZrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLK03MoPTeVjiiFwNtS1OJi+2ld8fgev60+sqAPXpLo=;
        b=BqNP2fgnkALFYWR1YWCiO0LKd36ydNsjwyruXxh0WUiN8+Q3xysw3NbqwY8tmqL6T1
         zkCzOZA5TU270FOV/Z1GOCq6XpnYp0Bu4V8pQU2kzY4+NGciupW1bMSQxg6njPjvNW4s
         ySVz2O49YAv84sTLsSoL1COAy66jcefkxOrKH/jevF8GqyR8tOTfoa4ZtPea9kmvHNYY
         8p4n8gihnaUEL+Jh8/O55blEA1I7gjS3NcLcNDQuwJWI6Hh7MASUuYSasRCMIjSflUgT
         oA0CotYlXAKPR91X+4QH1XDs6kfOvFYI2DBUbhHi802qJ/o2d4gLuxPK7x2cq1E1honl
         qBNA==
X-Gm-Message-State: AOAM530NXekBmrMJdbewgZcnR9GvYHBFt8zv1ESqJ3+gnibmoXhsGWT/
        MmjJa2ZzR6MkwNR+zBkiHtHy3Q==
X-Google-Smtp-Source: ABdhPJytXmL1Uj/jup8IDzFLZKwpMK6mZxS/1lbVrDQSOq3KCd2Df1ttM6R0Ksfu/w1e0jCslBiSlA==
X-Received: by 2002:a7b:cb93:: with SMTP id m19mr301307wmi.128.1608737901527;
        Wed, 23 Dec 2020 07:38:21 -0800 (PST)
Received: from MacBook-Pro.local ([212.45.64.13])
        by smtp.googlemail.com with ESMTPSA id y11sm212109wmi.0.2020.12.23.07.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 07:38:20 -0800 (PST)
Subject: Re: [PATCH v2 1/7] iommu/io-pgtable: Introduce dynamic io-pgtable fmt
 registration
To:     "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org
Cc:     will@kernel.org, joro@8bytes.org, pdaly@codeaurora.org,
        pratikp@codeaurora.org, kernel-team@android.com,
        robin.murphy@arm.com
References: <1608597876-32367-1-git-send-email-isaacm@codeaurora.org>
 <1608597876-32367-2-git-send-email-isaacm@codeaurora.org>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Message-ID: <65b5382c-c7a9-0f18-96da-fe49e92e3b00@linaro.org>
Date:   Wed, 23 Dec 2020 17:38:19 +0200
MIME-Version: 1.0
In-Reply-To: <1608597876-32367-2-git-send-email-isaacm@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Isaac,

On 22.12.20 2:44, Isaac J. Manjarres wrote:
> The io-pgtable code constructs an array of init functions for each
> page table format at compile time. This is not ideal, as this
> increases the footprint of the io-pgtable code, as well as prevents
> io-pgtable formats from being built as kernel modules.
> 
> In preparation for modularizing the io-pgtable formats, switch to a
> dynamic registration scheme, where each io-pgtable format can register
> their init functions with the io-pgtable code at boot or module
> insertion time.
> 
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>   drivers/iommu/io-pgtable-arm-v7s.c | 34 +++++++++++++-
>   drivers/iommu/io-pgtable-arm.c     | 90 ++++++++++++++++++++++++++----------
>   drivers/iommu/io-pgtable.c         | 94 ++++++++++++++++++++++++++++++++------
>   include/linux/io-pgtable.h         | 51 +++++++++++++--------
>   4 files changed, 209 insertions(+), 60 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 1d92ac9..89aad2f 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -28,6 +28,7 @@
[..]
> +static int __init arm_lpae_init(void)
> +{
> +	int ret, i;
> +
> +	for (i = 0; i < ARRAY_SIZE(io_pgtable_arm_lpae_init_fns); i++) {
> +		ret = io_pgtable_ops_register(&io_pgtable_arm_lpae_init_fns[i]);
> +		if (ret < 0) {
> +			pr_err("Failed to register ARM LPAE fmt: %d\n");

I guess we want to print the format here?

Thanks,
Georgi
