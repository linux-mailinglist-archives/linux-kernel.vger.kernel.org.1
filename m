Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2951F832A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFMMNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 08:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgFMMNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 08:13:50 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4433C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 05:13:49 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id d15so8247947edm.10
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 05:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6j42CgAA1zuwbhj1x63uUihlXyZlEqbyky8xm+loZJg=;
        b=bYY5c/uCehsR+bJd6UwB00QFMWXh9AtxkLl1bweNVi6iNTrGEVASciZeie5AS2vzF2
         zhXqXlU6dyHgbAJ3AY9RsWYzRoWngzQ3GhJC3LZyZEkML3dT1dUqFdlLarEuUEpuqQaG
         JIJHO4qxIFUypQYkdso13bsD9VvOUEl7h0LxmkgKv4YATvBMVmfil75n8MyOt2ZHfler
         hVgCW0MNX//qHVp+btbc0d6/Xy6M6RX7xxjMKyFj7k7q13sDBV7P3tll9A4hnbU2Ikb3
         kbHFd0E4jmwXwkDldS3Fu2jB4ugka2nWxlK01wE2xpbdUn08SHNNmNZY70p3XrBG4p1G
         AgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6j42CgAA1zuwbhj1x63uUihlXyZlEqbyky8xm+loZJg=;
        b=GN1lcHGf7oIU2RGElWyF1QS2YxJmuVl8SVoR0XJjtD1M9tmVziroMBfw/Lq3MWpIl6
         vq5wJ+A643dl49CT6Uz3BIH2QGw6ZEtcAgz8DFyrcwRK/s2TjpgSO20XmBSl5cxhapqY
         360BO5yBvJK8ez1ufwNtdaGRrQzb5rYRYUB2PudylcXmRmN0gcj96RfOCjINi4usFuML
         ChtMHKUnLZEiLyeRxqPsji+adTDavVZJGf0iRDOWAR21SYSIhpCtWUCsl9H6WaG+eWYB
         o0eEOn8+xZye9ImPMYw62iXhbj1Rx9zZsO2pJ8fTmHT20TQGoEJACHOQzE9gFO0rEE/S
         yAgg==
X-Gm-Message-State: AOAM532lY05DmBRGdld8K6mD1ko36Gj18yhZJPdbsK1KN5NUOdD3lWtj
        /H2p887H/EL9Ux3/U+yeXcXrnjTTXFOjcg==
X-Google-Smtp-Source: ABdhPJzgx4x/rgHRDsOrx96v43XWabkyotdf92vTdNMeyJfsnrDG3SQEmcOa8EbRoqW6XkZ8qFtNzw==
X-Received: by 2002:aa7:c2c7:: with SMTP id m7mr15740628edp.148.1592050428159;
        Sat, 13 Jun 2020 05:13:48 -0700 (PDT)
Received: from [192.168.1.3] (212-5-158-38.ip.btc-net.bg. [212.5.158.38])
        by smtp.googlemail.com with ESMTPSA id o12sm4759317edq.7.2020.06.13.05.13.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 05:13:47 -0700 (PDT)
Subject: Re: [PATCH] venus: core: add shutdown callback for venus
To:     Mansur Alisha Shaik <mansur@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, saiprakash.ranjan@codeaurora.org
References: <1592044386-15654-1-git-send-email-mansur@codeaurora.org>
From:   Stanimir Varbanov <stanimir.varbanov@linaro.org>
Message-ID: <6748ea90-15d6-a34d-e436-00771b165a60@linaro.org>
Date:   Sat, 13 Jun 2020 15:13:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1592044386-15654-1-git-send-email-mansur@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mansur,

Thanks for the patch!

How you test this? Is it enough to start playback and issue reboot (did
you test with reboot -f) ?

On 6/13/20 1:33 PM, Mansur Alisha Shaik wrote:
> After the SMMU translation is disabled in the
> arm-smmu shutdown callback during reboot, if
> any subsystem are still alive then IOVAs they
> are using will become PAs on bus, which may
> lead to crash.
> 
> Below are the consumers of smmu from venus
> arm-smmu: consumer: aa00000.video-codec supplier=15000000.iommu
> arm-smmu: consumer: video-firmware.0 supplier=15000000.iommu
> 
> So implemented shutdown callback, which detach iommu maps.
> 
> Change-Id: I0f0f331056e0b84b92f1d86f66618d4b1caaa24a
> Signed-off-by: Mansur Alisha Shaik <mansur@codeaurora.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 30d4b9e..acf798c 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -371,6 +371,14 @@ static int venus_remove(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void venus_core_shutdown(struct platform_device *pdev)
> +{
> +	int ret;
> +
> +	ret = venus_remove(pdev);
> +	WARN_ON(ret < 0);
> +}
> +
>  static __maybe_unused int venus_runtime_suspend(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> @@ -628,6 +636,7 @@ static struct platform_driver qcom_venus_driver = {
>  		.of_match_table = venus_dt_match,
>  		.pm = &venus_pm_ops,
>  	},
> +	.shutdown = venus_core_shutdown,
>  };
>  module_platform_driver(qcom_venus_driver);
>  
> 

-- 
regards,
Stan
