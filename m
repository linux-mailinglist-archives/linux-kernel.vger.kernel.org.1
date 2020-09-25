Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2B2785EC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 13:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbgIYLci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 07:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728155AbgIYLcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 07:32:14 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A6C0613D5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:32:13 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id z46so802249uac.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 04:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fKb1AhxRafAK9/ZvzZmKgGvwAcRONq6KI4tp+0pa55g=;
        b=Lp2vK2rgvpWvUpT/qvMTj1q6Nb80s5zm7xYBXsTTSVhB4tYw8DUICnSNbYD5B9oCiz
         BmHbP997FptOq23sH7/xgL5+xc9U/iMgcMyf/gMJE4+cemGs7Qftb9SPxOUsolGjR03K
         3IyXbjuy7zEAXiOX/u9kMqrc3LeGHppr7ZSp1JHidUC946QrrNIYdUQQ3UlIQOa/V0cO
         3Fa0/1J4MItO5kQQvn+hZFh99DdobR/IYZGrPKk0mqZL/K/+kAsJPu9IPocpNGMRhkWD
         4f1KJSDmKO2pXa3m0m+NG+0UECU1Odz14T/ce2ir+kDCDlJQd5jTNNoVMqjUs9FlfsFA
         OI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fKb1AhxRafAK9/ZvzZmKgGvwAcRONq6KI4tp+0pa55g=;
        b=JwUCnYgb7LYxIQRbdrfgdZBCPoWCDziuZLMScecLgV/JIP5u/26CW9QQm/IWr7BVUR
         doIPx2yUEHK8Ln597Dcrb/6bK5gTOC6ii8JRQ3O+JeuHsumppg7cZd82yXSonxZ3LEKs
         Rg0u3g7V9WFVfVJUK6hoBVYRxdjnVyS+YGw9/hswNLXUDQfnUs31L7+zBFhTgRF4Z09I
         0wxA/zu/mKFowZnuNA5giq/guEB5+GpkCqksplN+fxKioRJQJWEt9nGgYKsuI9qa15Xi
         cZuqZtscXTf66emd/p0JCcjl/knt/F9gA6uqDEMrgmufrONPY84CkrtsMrn7WBH95IwO
         +I4w==
X-Gm-Message-State: AOAM532RNFb3XIaTw9AbwE1NJY6tbP7W0rtpJUdvQr01qZqV/piySOP7
        FOE8jpG2VhZlcddcN2Bx0LUgHybAGmx2Jb1uGQry3g==
X-Google-Smtp-Source: ABdhPJy57tzdEGMq3fNcmnFTrHDV66YOIuZyatIjb2SogNYaGuvqYzFZlJC9kK38xQHuhaTgMNtcgakO2/rdoL40j0Q=
X-Received: by 2002:ab0:2904:: with SMTP id v4mr1978931uap.15.1601033532387;
 Fri, 25 Sep 2020 04:32:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200925072532.10272-1-krzk@kernel.org>
In-Reply-To: <20200925072532.10272-1-krzk@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Sep 2020 13:31:35 +0200
Message-ID: <CAPDyKFo5B5j40W2wVi6rHsrHJscg_QeER2R7vaib3mE85yEuMA@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-s3c: hide forward declaration of of_device_id
 behind CONFIG_OF
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Ben Dooks <ben-linux@fluff.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Sep 2020 at 09:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The struct of_device_id is not defined with !CONFIG_OF so its forward
> declaration should be hidden to as well.  This should address clang
> compile warning:
>
>   drivers/mmc/host/sdhci-s3c.c:464:34: warning: tentative array definition assumed to have one element
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/sdhci-s3c.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index cb5f87be7535..f48a788a9d3d 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -461,7 +461,9 @@ static int sdhci_s3c_parse_dt(struct device *dev,
>  }
>  #endif
>
> +#ifdef CONFIG_OF
>  static const struct of_device_id sdhci_s3c_dt_match[];
> +#endif
>
>  static inline struct sdhci_s3c_drv_data *sdhci_s3c_get_driver_data(
>                         struct platform_device *pdev)
> --
> 2.17.1
>
